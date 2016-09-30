<?php

$GLOBALS['sql_connection'] = null; // sql connection
$GLOBALS['verbose_sql'] = true; // Set to true to print sql requests.
$GLOBALS['no_verbose'] = false; // Set to true to forbid any verbose.


/*
 * Print error message.
 */
function printError ($text, $sql="")
{
    echo "<B><FONT COLOR=#FF0000>ERROR:</FONT> $text</B><BR>\n";
    echo $sql."<BR>\n";
}


/*
 * Check if at least one row is returned by an sql request.
 */
function checkExists ($sql, $result)
{
	if ($result->num_rows == 0) { printError("object not found", $sql); return false; }
	return true;
}


/*
 * Check if exactly one row is returned by an sql request.
 */
function checkUnique ($sql, $result)
{
	if ($result->num_rows == 0) { printError("object not found", $sql); return false; }	
	if ($result->num_rows > 1) { printError("multiple objects", $sql); return false; }
	return true;
}


/*
 * Initiate connection to the "bibliotheque" database.
 * Don't forget to close the database after usage (see closeConnection).
 */
function openConnection ()
{
	$GLOBALS['sql_connection'] = new mysqli ("localhost", "root", "orodove", "bibliotheque");
	if ($GLOBALS['sql_connection']->connect_error) { die ("Connection failed: " . $GLOBALS['sql_connection']->connect_error); }
	$GLOBALS['sql_connection']->query("SET NAMES UTF8");
	if ($GLOBALS['verbose_sql'] && !$GLOBALS['no_verbose']) { echo "<B>Connection opened</B><BR>\n"; }
}

/*
 * Close connection previously opened by openConnection.
 */
function closeConnection ()
{
	$GLOBALS['sql_connection']->close();
	if ($GLOBALS['verbose_sql'] && !$GLOBALS['no_verbose']) { echo "<B>Connection closed</B><BR>\n"; }
}


/*
 * Print an sql request (only if $GLOBALS['verbose_sql'] is set to true).
 */
function printSQL ($sql)
{
	if ($GLOBALS['verbose_sql'] && !$GLOBALS['no_verbose']) { echo $sql."<BR>\n"; }
}


/*
 * Execute an sql query.
 */
function execSQL ($sql)
{
	printSQL ($sql);
	$result = $GLOBALS['sql_connection']->query($sql) or trigger_error($GLOBALS['sql_connection']->error." [$sql]");

	#$sql2 = "INSERT INTO log (`sql`) VALUES ('" . escapeSQL($sql) . "')";
	#$GLOBALS['sql_connection']->query($sql2) or trigger_error($GLOBALS['sql_connection']->error." [$sql2]");
	
	return $result;
}


/*
 * Get inserted id
 */
function getIdSQL () { return $GLOBALS['sql_connection']->insert_id; }


/*
 * Escape a string to insert it in the sql database.
 */
function escapeSQL ($var) { return $GLOBALS['sql_connection']->real_escape_string($var); }


function formatDate ($date)
{
	$frMonth = Array("", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre");
	$strDate = strtotime ($date);
	$formatDate = date('j',$strDate) . " " . $frMonth[date('n',$strDate)] . " " . date('Y',$strDate);
	return $formatDate;
}

/*
 * Create a new narrative (along with its corresponding 'narrative' element and its 'start' situation).
 * The database has first to be connected.
 */
function newNarrative ($id_member, $name, $title, $abstract)
{	
	$sql = "INSERT INTO narrative (title, abstract) VALUES ('$title', '$abstract')";
	execSQL ($sql);

	$id_narrative = getIdSQL();

	$sql = "INSERT INTO element (id_narrative, type, name) VALUES ('$id_narrative', 'narrative', '$name')";
	execSQL ($sql);

	$id_element = getIdSQL();
	setRights ($id_member, $id_element, 'full');

	//$sql = "INSERT INTO element (id_narrative, type, name) VALUES ('$id_narrative', 'situation', 'start')";
	//execSQL ($sql);

	return $id_narrative;
}



/*
 * Get name, address, etc., of a given member (if specified, else all).
 * The database has first to be connected.
 */
function getMembersData ($id_member = NULL)
{
	$data = array();

	// Get data in member table
	if (is_null($id_member)) { $whereClause = ""; } else { $whereClause = "WHERE id_member = '$id_member'"; }
	$sql = "SELECT * FROM member $whereClause";
	$result = execSQL ($sql);
	
	while ($row = $result->fetch_assoc()) { $data[$row['id_member']] = $row; }

	return $data;
}



/*
 * Get author, title, and description of a given narrative (if specified, else all).
 * The database has first to be connected.
 */
function getNarrativesData ($id_narrative = NULL)
{
	$data = array();

	// Get data in narrative table
	if (is_null($id_narrative)) { $whereClause = ""; } else { $whereClause = "WHERE id_narrative = '$id_narrative'"; }
	$sql = "SELECT * FROM narrative $whereClause";
	$result = execSQL ($sql);
	
	while ($row = $result->fetch_assoc())
	{
		$id_narrative = $row['id_narrative'];
		$data[$id_narrative] = $row;
		$data[$id_narrative]['authors'] = array();

		// Add data regarding authors
		$sql2 = "SELECT m.id_member, m.name FROM element e
					INNER JOIN rights r ON r.id_element = e.id_element
					INNER JOIN member m ON m.id_member = r.id_member
				WHERE e.id_narrative = '$id_narrative' AND e.type = 'narrative' AND r.type IN ('add','mod','full')";
		$result2 = execSQL ($sql2);

		while ($row2 = $result2->fetch_assoc())
		{
			$author = array();
			$author['id_member'] = $row2['id_member'];
			$author['name'] = $row2['name'];
			$data[$id_narrative]['authors'][$author['id_member']] = $author;
		}
	}

	return $data;
}


/*
 * Get informations about an given element.
 * The database has first to be connected.
 */
function getElementData ($id_element)
{
	$sql = "SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	if (!checkUnique ($sql, $result)) { return null; }
	else { return $result->fetch_assoc(); }
}


/*
 * Get informations about all elements of a given narrative.
 * The database has first to be connected.
 */
function getElementsData ($id_narrative)
{
	$data = array();

	$sql = "SELECT e.id_element, e.type, e.name, e.from, e.to, w.text, w.end, w.choice, w.date, m.name AS author
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_narrative = '$id_narrative'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc()) { $data[$row['id_element']] = $row; }

	return $data;
}


/*
 * Get a json-formatted string representing the graph of a narrative.
 * The database has first to be connected.
 */
function getNarrativeGraph ($id_narrative)
{
	// String representing nodes (situations)
	$nodeStr = "\"nodes\":[";
	
	$sql = "SELECT name FROM element WHERE id_narrative = '$id_narrative' AND type = 'situation'";
	$result = execSQL ($sql);

	$nodeArray = array();
	$num = 0;
	$first = true;
	while ($row = $result->fetch_assoc())
	{
		if ($first) { $first = false; } else { $nodeStr .= ","; }
		$nodeStr .= "{\"name\":\"" . $row['name'] . "\"}";
		$nodeArray[$row['name']] = $num++;
	}

	$nodeStr .= "]";

	// String representing links (transitions)
	$linkStr = "\"links\":[";

	$sql = "SELECT `from`, `to` FROM element WHERE id_narrative = '$id_narrative' AND type = 'transition'";
	$result = execSQL ($sql);

	$first = true;
	while ($row = $result->fetch_assoc())
	{
		if ($first) { $first = false; } else { $linkStr .= ","; }
		$linkStr .= "{\"source\":" . $nodeArray[$row['from']] . ",\"target\":" . $nodeArray[$row['to']] . "}";
	}
	
	$linkStr .= "]";

	// String representing constraints
	$constraintStr = "\"constraints\":[]";

	// String representing graph (narrative)
	$graphStr = "{" . $nodeStr . "," . $linkStr . "," . $constraintStr . "}";
	return $graphStr;
}


/*
 * Delete an existing narrative (along with its corresponding elements, writings, readings, etc.).
 * The database has first to be connected.
 */
function deleteNarrative ($id_narrative)
{
	$sql = "DELETE FROM rights WHERE id_element IN (SELECT id_element FROM element WHERE id_narrative = '$id_narrative')";
	execSQL ($sql);

	$sql = "DELETE FROM writing WHERE id_element IN (SELECT id_element FROM element WHERE id_narrative = '$id_narrative')";
	execSQL ($sql);

	$sql = "DELETE FROM reading WHERE id_element IN (SELECT id_element FROM element WHERE id_narrative = '$id_narrative')";
	execSQL ($sql);

	$sql = "DELETE FROM element WHERE id_narrative = '$id_narrative'";
	execSQL ($sql);

	$sql = "DELETE FROM story WHERE id_narrative = '$id_narrative'";
	execSQL ($sql);

	$sql = "DELETE FROM narrative WHERE id_narrative = '$id_narrative'";
	execSQL ($sql);
}


/*
 * Set the rights (in reading and/or writting) of a given element to a given member.
 * The database has first to be connected.
 */
function setRights ($id_member, $id_element, $type)
{
	$sql = "INSERT INTO rights (id_member, id_element, type)
				VALUES ('$id_member', '$id_element', '$type')
				ON DUPLICATE KEY UPDATE type = '$type', date = CURRENT_TIMESTAMP";
	execSQL ($sql);
}


/*
 * Create a new story (read by a given member and corresponding to a given narrative).
 * The database has first to be connected.
 */
function newStory ($id_member, $id_narrative)
{
	$sql = "INSERT INTO story (id_member, id_narrative) VALUES ('$id_member', '$id_narrative')";
	execSQL ($sql);

	return getIdSQL();
}


/*
 * Get the last / current story (read by a given member and corresponding to a given narrative).
 * The database has first to be connected.
 */
function getLastStory ($id_member, $id_narrative)
{
	$sql = "SELECT id_story FROM story
			WHERE id_member = '$id_member' AND id_narrative = '$id_narrative' AND current IS NOT NULL
				ORDER BY date DESC LIMIT 0,1";
	$result = execSQL ($sql);

	if ($result->num_rows == 0) { return null; }

	$row = $result->fetch_assoc();
	return $row['id_story'];
}


/*
 * Get all the text preceding the current state of a given story.
 * The database has first to be connected.
 */
function getStoryText ($id_story)
{
	// Get traveled path
	$sql = "SELECT id_narrative, path FROM story WHERE id_story = '$id_story'";
	$result = execSQL ($sql);
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		$id_narrative = $row['id_narrative'];
		$names = explode (";", $row['path']);

		// Loop through all situations that have been visited
		$text = "";
		foreach ($names as $name)
		{
			if ($name == "") { continue; }

			// Get text corresponding to the traveled situation
			$sql = "SELECT w.text FROM element e
						INNER JOIN writing w ON e.id_element = w.id_element
					WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.name = '$name'
						AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
			$result = execSQL ($sql);

			if (!checkUnique ($sql, $result)) { return null; }
			
			else {
				$row = $result->fetch_assoc();
				$text .= $row['text'];
			}
		}

		return $text;
	}
}


/*
 * Get current situation name of a given story.
 * The database has first to be connected.
 */
function getStoryCurrent ($id_story)
{
	$sql = "SELECT current FROM story WHERE id_story = '$id_story'";
	$result = execSQL ($sql);
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		return $row['current'];
	}
}



/*
 * Get text and transitions of a given situation (XML-formatted).
 * The database has first to be connected.
 */
function getSituationXML ($id_narrative, $name)
{
	// Get text of current situation
	$sql = "SELECT w.text FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.name = '$name'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	$result = execSQL ($sql);

	if (!checkUnique ($sql, $result)) { return null; }

	$row = $result->fetch_assoc();

	$xml = "<XML>\n";
	$xml .= "<TEXT>";
	if (!is_null($row['text'])) { $xml .= $row['text']; } else { $xml .= "NULL"; }
	$xml .= "</TEXT>\n";

	// Get next transisions
	$sql = "SELECT e.to, w.choice, w.type FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition' AND e.from = '$name'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc())
	{
		if ($row["type"] != "suppress")
		{
			$xml .= "<TRANSITION>\n";
			$xml .= "<TO>" . $row['to'] . "</TO>\n";
			if (!is_null($row['choice'])) { $xml .= "<CHOICE>" . $row['choice'] . "</CHOICE>\n"; }
			$xml .= "</TRANSITION>\n";
		}
	}

	$xml .= "</XML>\n";
	
	return $xml;
}


/*
 * Get XML content of lastest elements with a given name in the database.
 * The database has first to be connected.
 */
/*
   function getXML ($id_narrative, $name)
   {
   $sql = "SELECT e.id_element, e.type, w.xml FROM element e
   INNER JOIN writing w ON e.id_element = w.id_element
   WHERE e.id_narrative = '$id_narrative' AND e.name = '$name'
   AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
   $result = execSQL ($sql);

   if (checkUnique ($sql, $result)) { return $result; } else { return null; }
   }
 */


/*
 * New situation in a narrative. Return NULL if it already exists.
 * The database has first to be connected.
 */
function newSituation ($id_narrative, $name)
{
	$sql = "SELECT id_element FROM element WHERE id_narrative = '$id_narrative' AND type='situation'";
	$result = execSQL ($sql);
	if ($result->num_rows > 0) { return NULL; }
	
	$sql = "INSERT INTO element (id_narrative, type, name) VALUES ('$id_narrative', 'situation', '$name')";
	execSQL ($sql);
	return getIdSQL();
}


/*
 * Change the values of an existing element.
 * The database has first to be connected.
 */
function setElement ($id_member, $id_element, $values)
{
	$sql = "INSERT INTO writing (id_member, id_element, type, text, end, choice)
				VALUES ('$id_member', '$id_element', 'modify', '". escapeSQL($values['text']) . "', '" . $values['end'] . "', '" . escapeSQL($values['choice']) . "')";
	execSQL ($sql);
}



/*
 * Create an empty element.
 * The database has first to be connected.
 */
function setElementBlank ($id_member, $id_element)
{
	$sql = "INSERT INTO writing (id_member, id_element, type, text)
				VALUES ('$id_member', '$id_element', 'create')";
	execSQL ($sql);
}


/*
 * Change the text of an existing element.
 * The database has first to be connected.
 */
function setElementText ($id_member, $id_element, $text)
{
	$sql = "INSERT INTO writing (id_member, id_element, type, text)
				VALUES ('$id_member', '$id_element', 'modify', '". escapeSQL($text) . "')";
	execSQL ($sql);
}


/*
 * Change the choice and text of an existing element.
 * The database has first to be connected.
 */
function setElementChoiceAndText ($id_member, $id_element, $text)
{
	$sql = "INSERT INTO writing (id_member, id_element, type, choice, text)
				VALUES ('$id_member', '$id_element', 'modify', '". escapeSQL($choice) . "', '". escapeSQL($text) . "')";
	execSQL ($sql);
}


/*
 * Import a narration in XML within the database.
 * If $id_narrative is null, a new narrative is built.
 * The database has first to be connected.
 */
function importXML ($id_member, $id_narrative, $file)
{
	$error = false;
	$verbose = false;

	$xml = new DomDocument();
	$xml->load($file);
	$narrative = $xml->getElementsByTagName('narrative')->item(0);

	// Parse situations
	$situationsVar = array();
	$situations = $narrative->getElementsByTagName("situation");

	foreach ($situations as $situation)
	{
		$situationVar = array();
		if ($verbose) { echo $situation->nodeName . "<BR>"; }
		
		// Get name
		$nameVar = "";
		$name = $situation->attributes->getNamedItem("name");
		if (isset($name))
		{
			$nameVar = $name->nodeValue;
			if ($verbose) { echo "name = '" . $nameVar . "'<BR>"; }
		}
		else { $error = true; printError ("situation with no 'name' attribute"); }
		$situationVar["name"] = $nameVar;

		// Get text
		$textVar = "NULL";
		$text = $situation->getElementsByTagName("text")->item(0);
		if (isset($text))
		{
			$textVar = $text->nodeValue;
			if ($verbose) { echo "text = '" . $textVar . "'<BR>"; }
		}
		$situationVar["text"] = $textVar;

		// Get end
		$endVar = 0;
		$end = $situation->attributes->getNamedItem("end");
		if (isset($end))
		{
			$endVar = $end->nodeValue;
			if ($endVar != "true" && $endVar != "false") { $error = true; printError ("'end' attribute of situation '" . $nameVar . "' has an incorrect value (only 'true' or 'false' allowed)"); }
			elseif ($endVar == "true") { $endVar = 1; }
			elseif ($endVar == "false") { $endVar = 0; }
			if ($verbose) { echo "end = '" . $endVar . "'<BR>"; }
		}
		$situationVar["end"] = $endVar;

		$situationVar["handled"] = false;
		$situationsVar[$nameVar] = $situationVar;
	}

	// Parse transitions
	$transitionsVar = array();
	$transitions = $narrative->getElementsByTagName("transition");

	foreach ($transitions as $transition)
	{
		$transitionVar = array();
		if ($verbose) { echo $transition->nodeName . "<BR>"; }
		
		// Get from
		$fromVar = "";
		$from = $transition->attributes->getNamedItem("from");
		if (isset($from))
		{
			$fromVar = $from->nodeValue;
			if ($verbose) { echo "from = '" . $fromVar . "'<BR>"; }
		}
		else { $error = true; printError ("transition with no 'from' attribute"); }
		$transitionVar["from"] = $fromVar;
		
		// Get to
		$toVar = "";
		$to = $transition->attributes->getNamedItem("to");
		if (isset($to))
		{
			$toVar = $to->nodeValue;
			if ($verbose) { echo "to = '" . $toVar . "'<BR>"; }
		}
		else { $error = true; printError ("transition '" . $nameVar . "' has no 'to' attribute"); }
		$transitionVar["to"] = $toVar;

		// Get choice
		$choiceVar = "NULL";
		$choice = $transition->getElementsByTagName("choice")->item(0);
		if (isset($choice))
		{
			$choiceVar = $choice->nodeValue;
			if ($verbose) { echo "choice = '" . $choiceVar . "'<BR>"; }
		}
		$transitionVar["choice"] = $choiceVar;

		// Get text
		$textVar = "NULL";
		$text = $transition->getElementsByTagName("text")->item(0);
		if (isset($text))
		{
			$textVar = $text->nodeValue;
			if ($verbose) { echo "text = '" . $textVar . "'<BR>"; }
		}
		$transitionVar["text"] = $textVar;

		$transitionVar["handled"] = false;
		$transitionsVar[$fromVar][$toVar] = $transitionVar;
	}

	// Inserting into database
	if ($error) { printError ("the narrative could not be uploaded"); }

	else {

		// Get previous status of all situations
		$sql = "SELECT e.id_element, e.name, w.type, w.text, w.end FROM element e
					INNER JOIN writing w ON e.id_element = w.id_element
				WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation'
					AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
		$result = execSQL ($sql);

		while ($row = $result->fetch_assoc())
		{
			$id_element = $row["id_element"];
			$name = $row["name"];

			if (isset($situationsVar[$name]))
			{
				$text = $situationsVar[$name]["text"];
				$end = $situationsVar[$name]["end"];

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }
				
				if ($row["type"] == "suppress")
				{
					$type = "create";
					echo "Situation '$name' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
								VALUES ('$id_member', '$id_element', '$type', $textStr, '$end')";
					execSQL($sql);
				}

				elseif ($text != $row["text"] || $end != $row["end"])
				{
					$type = "modify";
					echo "Situation '$name' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
								VALUES ('$id_member', '$id_element', '$type', $textStr, '$end')";
					execSQL($sql);
				}

				else { echo "Situation '$name' kept as it is<BR>\n"; }

				$situationsVar[$name]["handled"] = true;
			}
			else {
				if ($row["type"] == "suppress") { echo "Situation '$name' kept suppressed<BR>\n"; }
				else {
					$type = "suppress";
					echo "Situation '$name' suppressed<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type) VALUES ('$id_member', '$id_element', '$type')";
					execSQL($sql);
				}
			}
		}

		// Inserting situations
		foreach ($situationsVar as $situationVar)
		{
			if (!$situationVar["handled"])
			{
				$type = "create";
				$name = $situationVar["name"];
				$text = $situationVar["text"];
				$end = $situationVar["end"];

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }

				echo "Situation '$name' created<BR>\n";

				// Insert element
				$sql = "INSERT INTO element (id_narrative, type, name)
							VALUES ('$id_narrative', 'situation', '$name')";
				execSQL($sql);
				$id_element = getIdSql();

				// Insert writing
				$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
							VALUES ('$id_member', '$id_element', '$type', $textStr, '$end')";
				execSQL($sql);
			}
		}


		// Get previous status of all transitions
		$sql = "SELECT e.id_element, e.from, e.to, w.type, w.choice, w.text FROM element e
					INNER JOIN writing w ON e.id_element = w.id_element
				WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition'
					AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
		$result = execSQL ($sql);

		while ($row = $result->fetch_assoc())
		{
			$id_element = $row["id_element"];
			$from = $row["from"];
			$to = $row["to"];

			if (isset($transitionsVar[$from][$to]))
			{
				$choice = $transitionsVar[$from][$to]["choice"];
				$text = $transitionsVar[$from][$to]["text"];

				$choiceStr = escapeSQL($choice);
				if ($choice != 'NULL') { $choiceStr = "'" . $choiceStr . "'"; }

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }

				if ($row["type"] == "suppress")
				{
					$type = "create";
					echo "Transition from '$from' to '$to' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice, text)
								VALUES ('$id_member', '$id_element', '$type', $choiceStr, $textStr)";
					execSQL($sql);
				}

				elseif ($transitionsVar[$from][$to]["choice"] != $row["choice"])
				{
					$type = "modify";
					echo "Transition from '$from' to '$to' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice, text)
								VALUES ('$id_member', '$id_element', '$type', $choiceStr, $textStr)";
					execSQL($sql);
				}

				else { echo "Transition from '$from' to '$to' kept as it is<BR>\n"; }

				$transitionsVar[$from][$to]["handled"] = true;
			}
			else {
				if ($row["type"] == "suppress") { echo "Transition from '$from' to '$to' kept suppressed<BR>\n"; }
				else {
					$type = "suppress";
					echo "Transition from '$from' to '$to' suppressed<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type) VALUES ('$id_member', '$id_element', '$type')";
					execSQL($sql);
				}
			}
		}

		// Inserting transitions
		foreach ($transitionsVar as $temp)
		{
			foreach ($temp as $transitionVar)
			{
				if (!$transitionVar["handled"])
				{
					$choice = $transitionVar["choice"];
					$text = $transitionVar["text"];

					$choiceStr = escapeSQL($choice);
					if ($choice != 'NULL') { $choiceStr = "'" . $choiceStr . "'"; }

					$textStr = escapeSQL($text);
					if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }

					$type = "create";
					$from = $transitionVar["from"];
					$to = $transitionVar["to"];
					echo "Transition from '$from' to '$to' created<BR>\n";

					// Insert element
					$sql = "INSERT INTO element (id_narrative, type, `from`, `to`) VALUES ('$id_narrative', 'transition', '$from', '$to')";
					execSQL($sql);
					$id_element = getIdSql();

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice, text)
								VALUES ('$id_member', '$id_element', '$type', $choiceStr, $textStr)";
					execSQL($sql);
				}
			}
		}
	}
}


function getLastWriting ($id_element)
{
	$sql = "SELECT * FROM writing w
			WHERE date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	$result = execSQL ($sql);

	if (!checkUnique ($sql, $result)) { return null; }
	else { return $result->fetch_assoc(); }
}


function formatShortText ($text)
{
	return substr($text,0,100);
}

?>
