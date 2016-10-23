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
	$result = $GLOBALS['sql_connection']->query($sql) or trigger_error ($GLOBALS['sql_connection']->error." [$sql]");
	if ($result === false) {
		$trace = debug_backtrace();
		echo 'in <b>' . $trace[0]['file'] . '</b> on line <b>' . $trace[0]['line'] . '</b><br>';		
	}

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

	$sql = "INSERT INTO element (id_narrative, type) VALUES ('$id_narrative', 'narrative')";
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
	$sql = "SELECT e.id_element, e.type, w.name, w.id_from, w.id_to, w.start, w.end, w.choice, w.text, w.date, m.name AS author
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

	$sql = "SELECT e.id_element, e.type, w.name, w.id_from, w.id_to, w.start, w.end, w.choice, w.text, w.date, m.name AS author
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
function getElementsGraphData ($id_narrative)
{
	$cytoGraph = array();
	
	$sql = "SELECT e.id_element AS id, e.type, w.name, w.start, w.end, w.text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc())
	{
		$row['save'] = $row;
		$cytoGraph[] = array ('data' => $row);
	}
	

	$sql = "SELECT e.id_element AS id, e.type, w.id_from AS source, w.id_to AS target, w.choice, w.text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc())
	{
		$row['save'] = $row;
		$cytoGraph[] = array ('data' => $row);
	}

	return $cytoGraph;
}


/*
 * Get a json-formatted string representing the situation in the graph of a narrative.
 * The database has first to be connected.
 */
function getSituationGraphData ($id_element)
{
	$sql = "SELECT e.id_element AS id, e.type, w.name, w.start, w.end, w.text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	$row = $result->fetch_assoc();
	$row['save'] = $row;
	return array ('data' => $row);
}	
	

/*
 * Get a json-formatted string representing the transition in the graph of a narrative.
 * The database has first to be connected.
 */
function getTransitionGraphData ($id_element)
{
	$sql = "SELECT e.id_element AS id, e.type, w.id_from AS source, w.id_to AS target, w.choice, w.text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	$row = $result->fetch_assoc();
	$row['save'] = $row;
	return array ('data' => $row);
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

	$sql = "DELETE FROM story WHERE id_narrative = '$id_narrative'";
	execSQL ($sql);

	$sql = "DELETE FROM element WHERE id_narrative = '$id_narrative'";
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
	$sql = "SELECT e.id_element FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND w.start = 1
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	if (!checkExists ($sql, $result)) { return null; }
	if (!checkUnique ($sql, $result)) { return null; }

	$row = $result->fetch_assoc();
	$id_current = $row['id_element'];

	$sql = "INSERT INTO story (id_member, id_narrative, id_current) VALUES ('$id_member', '$id_narrative', '$id_current')";
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
			WHERE id_member = '$id_member' AND id_narrative = '$id_narrative' AND id_current IS NOT NULL
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
		$ids_element = explode (";", $row['path']);

		// Loop through all situations that have been visited
		$text = "";
		foreach ($ids_element as $id_element)
		{
			if ($id_element == "") { continue; }

			// Get text corresponding to the traveled situation
			$sql = "SELECT w.text FROM element e
						INNER JOIN writing w ON e.id_element = w.id_element
					WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.id_element = '$id_element'
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
	$sql = "SELECT id_current FROM story WHERE id_story = '$id_story'";
	$result = execSQL ($sql);
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		return $row['id_current'];
	}
}



/*
 * Get text and transitions of a given situation (XML-formatted).
 * The database has first to be connected.
 */
function getSituationXML ($id_narrative, $id_element)
{
	// Get text of current situation
	$sql = "SELECT w.text FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	$result = execSQL ($sql);

	if (!checkUnique ($sql, $result)) { return null; }

	$row = $result->fetch_assoc();

	$xml = "<XML>\n";
	$xml .= "<TEXT>";
	if (!is_null($row['text'])) { $xml .= $row['text']; } else { $xml .= "NULL"; }
	$xml .= "</TEXT>\n";

	// Get next transisions
	$sql = "SELECT w.id_to, w.choice, w.type FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition' AND w.id_from = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc())
	{
		if ($row["type"] != "delete")
		{
			$xml .= "<TRANSITION>\n";
			$xml .= "<ID_TO>" . $row['id_to'] . "</ID_TO>\n";
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
 * Create new situation.
 * The database has first to be connected.
 */
function newSituationGraphData ($id_narrative)
{
	$sql = "INSERT INTO element (id_narrative, type) VALUES ('$id_narrative', 'situation')";
	execSQL ($sql);
	return getIdSQL();
}


/*
 * Create new transition.
 * The database has first to be connected.
 */
function newTransitionGraphData ($id_narrative)
{
	$sql = "INSERT INTO element (id_narrative, type) VALUES ('$id_narrative', 'transition')";
	execSQL ($sql);
	return getIdSQL();
}


/*
 * Delete element.
 * The database has first to be connected.
 */
function deleteElementGraphData ($id_member, $id_element)
{
	$sql = "INSERT INTO writing (id_member, id_element, type) VALUES ('$id_member', '$id_element', 'delete')";
	execSQL ($sql);
}


/*
 * Change the values of an existing situation.
 * The database has first to be connected.
 */
function setSituationGraphData ($id_member, $id_element, $values)
{
	extract ($values);

	if ($mod_type == 'new') { $type = 'create'; } else { $type = 'modify'; }
	
	$sql = "INSERT INTO writing (id_member, id_element, type, name, start, end, text)
				VALUES ('$id_member', '$id_element', '$type', '$name', '$start', '$end', '$text')";
	execSQL ($sql);
}


/*
 * Change the values of an existing transition.
 * The database has first to be connected.
 */
function setTransitionGraphData ($id_member, $id_element, $values)
{
	extract ($values);

	if ($mod_type == 'new') { $type = 'create'; } else { $type = 'modify'; }

	$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to, choice, text)
				VALUES ('$id_member', '$id_element', '$type', '$source', '$target', '$choice', '$text')";
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
function importNarrative ($id_member, $id_narrative, $file)
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

		// Get start
		$startVar = 0;
		$start = $situation->attributes->getNamedItem("start");
		if (isset($start))
		{
			$startVar = $start->nodeValue;
			if ($startVar != "true" && $startVar != "false") { $error = true; printError ("'start' attribute of situation '" . $nameVar . "' has an incorrect value (only 'true' or 'false' allowed)"); }
			elseif ($startVar == "true") { $startVar = 1; }
			elseif ($startVar == "false") { $startVar = 0; }
			if ($verbose) { echo "start = '" . $startVar . "'<BR>"; }
		}
		$situationVar["start"] = $startVar;

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
		$sql = "SELECT e.id_element, w.type, w.name, w.start, w.end, w.text FROM element e
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
				$situationsVar[$name]["id_element"] = $id_element;
				
				$text = $situationsVar[$name]["text"];
				$start = $situationsVar[$name]["start"];
				$end = $situationsVar[$name]["end"];

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }
				
				if ($row["type"] == "delete")
				{
					$type = "create";
					echo "Situation '$name' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, name, start, end, text)
								VALUES ('$id_member', '$id_element', '$type', '$name', '$start', '$end', $textStr)";
					execSQL($sql);
				}

				elseif ($text != $row["text"] || $start != $row["start"] || $end != $row["end"])
				{
					$type = "modify";
					echo "Situation '$name' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, name, start, end, text)
								VALUES ('$id_member', '$id_element', '$type', '$name', '$start', '$end', $textStr)";
					execSQL($sql);
				}

				else { echo "Situation '$name' kept as it is<BR>\n"; }

				$situationsVar[$name]["handled"] = true;
			}
			
			else {
				if ($row["type"] == "delete") { echo "Situation '$name' kept deleted<BR>\n"; }
				else {
					$type = "delete";
					echo "Situation '$name' deleted<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, name) VALUES ('$id_member', '$id_element', '$type', '$name')";
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
				$start = $situationVar["start"];
				$end = $situationVar["end"];

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }

				echo "Situation '$name' created<BR>\n";

				// Insert element
				$sql = "INSERT INTO element (id_narrative, type)
							VALUES ('$id_narrative', 'situation')";
				execSQL($sql);
				
				$id_element = getIdSql();
				$situationsVar[$name]["id_element"] = $id_element;

				// Insert writing
				$sql = "INSERT INTO writing (id_member, id_element, type, name, start, end, text)
							VALUES ('$id_member', '$id_element', '$type', '$name', '$start', '$end', $textStr)";
				execSQL($sql);
			}
		}


		// Get previous status of all transitions
		$sql = "SELECT e.id_element, w.type, wf.name AS `from`, wt.name AS `to`, w.id_from, w.id_to, w.choice, w.text FROM element e
					INNER JOIN writing w ON e.id_element = w.id_element
					INNER JOIN writing wf ON w.id_from = wf.id_element
					INNER JOIN writing wt ON w.id_to = wt.id_element
				WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition'
					AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
					AND wf.date = (SELECT MAX(x.date) FROM writing x WHERE wf.id_element = x.id_element)
					AND wt.date = (SELECT MAX(x.date) FROM writing x WHERE wt.id_element = x.id_element)";
		$result = execSQL ($sql);

		while ($row = $result->fetch_assoc())
		{
			$id_element = $row["id_element"];
			$from = $row["from"];
			$to = $row["to"];

			$id_from = $row["id_from"];
			$id_to = $row["id_to"];

			if (isset($transitionsVar[$from][$to]))
			{
				$transitionsVar[$from][$to]['id_element'] = $id_element;
				
				$choice = $transitionsVar[$from][$to]["choice"];
				$text = $transitionsVar[$from][$to]["text"];

				$choiceStr = escapeSQL($choice);
				if ($choice != 'NULL') { $choiceStr = "'" . $choiceStr . "'"; }

				$textStr = escapeSQL($text);
				if ($text != 'NULL') { $textStr = "'" . $textStr . "'"; }

				if ($row["type"] == "delete")
				{
					$type = "create";
					echo "Transition from '$from' to '$to' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to, choice, text)
								VALUES ('$id_member', '$id_element', '$type', '$id_from', '$id_to', $choiceStr, $textStr)";
					execSQL($sql);
				}

				elseif ($transitionsVar[$from][$to]["choice"] != $row["choice"])
				{
					$type = "modify";
					echo "Transition from '$from' to '$to' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to, choice, text)
								VALUES ('$id_member', '$id_element', '$type', '$id_from', '$id_to', $choiceStr, $textStr)";
					execSQL($sql);
				}

				else { echo "Transition from '$from' to '$to' kept as it is<BR>\n"; }

				$transitionsVar[$from][$to]["handled"] = true;
			}
			
			else {
				if ($row["type"] == "delete") { echo "Transition from '$from' to '$to' kept deleted<BR>\n"; }
				else {
					$type = "delete";
					echo "Transition from '$from' to '$to' deleted<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to) VALUES ('$id_member', '$id_element', '$type', '$id_from', '$id_to')";
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

					$id_from = $situationsVar[$from]["id_element"];
					$id_to = $situationsVar[$to]["id_element"];
					
					// Insert element
					$sql = "INSERT INTO element (id_narrative, type) VALUES ('$id_narrative', 'transition')";
					execSQL($sql);

					$id_element = getIdSql();
					$transitionVars[$from][$to]['id_element'] = $id_element;

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to, choice, text)
								VALUES ('$id_member', '$id_element', '$type', '$id_from', '$id_to', $choiceStr, $textStr)";
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
