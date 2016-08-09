<?php

$GLOBALS['sql_connection'] = null; // sql connection
$GLOBALS['verbose_sql'] = false; // Set to true to print sql requests.
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
	$GLOBALS['sql_connection'] = new mysqli ("localhost", "root", "", "bibliotheque");
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


/*
 * Create a new narrative (along with its corresponding 'narrative' element and its 'start' situation).
 * The database has first to be connected.
 */
function newNarrative ($name, $title, $abstract)
{
	$sql = "INSERT INTO narrative (title, abstract) VALUES ('$title', '$abstract')";
	execSQL ($sql);

	$id_narrative = getIdSQL();

	$sql = "INSERT INTO element (id_narrative, type, name) VALUES ('$id_narrative', 'narrative', '$name')";
	execSQL ($sql);

	$sql = "INSERT INTO element (id_narrative, type, name) VALUES ('$id_narrative', 'situation', 'start')";
	execSQL ($sql);

	return $id_narrative;
}


/*
 * Get author, title, and description of a given narrative.
 * The database has first to be connected.
 */
function getNarrativeInfo ($id_narrative)
{
	$info = array();

	// Get info in narrative table
	$sql = "SELECT title, abstract, date FROM narrative WHERE id_narrative = '$id_narrative'";
	$result = execSQL ($sql);
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		$info['title'] = $row['title'];
		$info['abstract'] = $row['abstract'];
		$info['date'] = $row['date'];
		$info['authors'] = array();

		// Add info regarding authors
		$sql = "SELECT m.name FROM element e
					INNER JOIN rights r ON r.id_element = e.id_element
					INNER JOIN member m ON m.id_member = r.id_member
				WHERE e.id_narrative = '$id_narrative' AND e.type = 'narrative' AND r.type IN ('add','mod','full')";
		$result = execSQL ($sql);

		while ($row = $result->fetch_assoc())
		{
			$author = array();
			$author['name'] = $row['name'];
			$info['authors'][] = $author;
		}

		return $info;
	}
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
	$xml .= $row['text'];
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
			if ($row['choice'] != "NULL") { $xml .= "<CHOICE>" . $row['choice'] . "</CHOICE>\n"; }
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
				if ($row["type"] == "suppress")
				{
					$type = "create";
					echo "Situation '$name' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
								VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($situationsVar[$name]["text"]) . "', '" . $situationsVar[$name]["end"] . "')";
					execSQL($sql);
				}

				elseif ($situationsVar[$name]["text"] != $row["text"] || $situationsVar[$name]["end"] != $row["end"])
				{
					$type = "modify";
					echo "Situation '$name' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
								VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($situationsVar[$name]["text"]) . "', '" . $situationsVar[$name]["end"] . "')";
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
				echo "Situation '$name' created<BR>\n";

				// Insert element
				$sql = "INSERT INTO element (id_narrative, type, name)
							VALUES ('$id_narrative', 'situation', '$name')";
				execSQL($sql);
				$id_element = getIdSql();

				// Insert writing
				$sql = "INSERT INTO writing (id_member, id_element, type, text, end)
							VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($situationVar["text"]) . "', '" . $situationVar["end"] . "')";
				execSQL($sql);
			}
		}


		// Get previous status of all transitions
		$sql = "SELECT e.id_element, e.from, e.to, w.type, w.choice FROM element e
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
				if ($row["type"] == "suppress")
				{
					$type = "create";
					echo "Transition from '$from' to '$to' re-created<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice)
								VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($transitionsVar[$from][$to]["choice"]) . "')";
					execSQL($sql);
				}

				elseif ($transitionsVar[$from][$to]["choice"] != $row["choice"])
				{
					$type = "modify";
					echo "Transition from '$from' to '$to' modified<BR>\n";

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice)
								VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($transitionsVar[$from][$to]["choice"]) . "')";
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
					$type = "create";
					$from = $transitionVar["from"];
					$to = $transitionVar["to"];
					echo "Transition from '$from' to '$to' created<BR>\n";

					// Insert element
					$sql = "INSERT INTO element (id_narrative, type, `from`, `to`) VALUES ('$id_narrative', 'transition', '$from', '$to')";
					execSQL($sql);
					$id_element = getIdSql();

					// Insert writing
					$sql = "INSERT INTO writing (id_member, id_element, type, choice)
								VALUES ('$id_member', '$id_element', '$type', '" . escapeSQL($transitionVar["choice"]) . "')";
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


?>
