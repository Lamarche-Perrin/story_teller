<?php

$GLOBALS['verbose_sql'] = false;

/*
 * Print error message.
 */
function printError ($text, $sql="")
{
    echo "<B><FONT COLOR=#FF0000>ERROR:</FONT> $text</B><BR>\n";
    echo $sql."<BR>\n";
}


function checkExists ($sql, $result)
{
	if ($result->num_rows == 0) { printError("object not found", $sql); return false; }
	return true;
}

function checkUnique ($sql, $result)
{
	if ($result->num_rows == 0) { printError("object not found", $sql); return false; }	
	if ($result->num_rows > 1) { printError("multiple objects", $sql); return false; }
	return true;
}


/*
 * Connection to the "bibliotheque" database.
 * Don't forget to close the database after usage ($conn->close()).
 */
function getConnection ()
{
    $conn = new mysqli ("localhost", "root", "", "bibliotheque");
    if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); }
    $conn->query("SET NAMES UTF8");

    return $conn;
}


function printSQL ($sql)
{
	if ($GLOBALS['verbose_sql']) { echo $sql."<BR>\n<BR>\n"; }
}



/*
 * The database has first to be connected.
 */
function newStory ($id_member, $id_narrative)
{
	global $conn;

	// Find starting situation
	$sql = "SELECT id_element FROM element
			WHERE id_narrative = '$id_narrative' AND type = 'situation' AND name = 'start'";
	printSQL($sql);

    $result = $conn->query($sql) or trigger_error($conn->error." [$sql]");

	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$id_element = $result->fetch_assoc()['id_element'];

		// Create new story
		$sql = "INSERT INTO story (id_member, id_narrative, id_element, path)
					VALUES ('$id_member', '$id_narrative', '$id_element', 'start;')";
		printSQL($sql);

		$conn->query($sql) or trigger_error($conn->error." [$sql]");

		return $conn->insert_id;
	}
}


/*
 * The database has first to be connected.
 */
function getStoryText ($id_story)
{
	global $conn;

	$sql = "SELECT id_narrative, path FROM story WHERE id_story = '$id_story'";
	printSQL($sql);

    $result = $conn->query($sql) or trigger_error($conn->error." [$sql]");
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		$id_narrative = $row['id_narrative'];
		$names = explode (";", $row['path']);

		$text = "";
		foreach ($names as $name)
		{
			if ($name == "") { continue; }

			$sql = "SELECT w.text FROM element e
						INNER JOIN writing w ON e.id_element = w.id_element
					WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.name = '$name'
						AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
			printSQL($sql);

			$result = $conn->query($sql) or trigger_error($conn->error." [$sql]");

			if (!checkExists ($sql, $result)) { return null; }
			
			else {
				$row = $result->fetch_assoc();
				$text .= $row['text'];
			}
		}

		return $text;
	}
}


/*
 * The database has first to be connected.
 */
function getStoryCurrent ($id_story)
{
	global $conn;

	$sql = "SELECT current FROM story WHERE id_story = '$id_story'";
	printSQL($sql);

    $result = $conn->query($sql) or trigger_error($conn->error." [$sql]");
	
	if (!checkUnique ($sql, $result)) { return null; }

	else {
		$row = $result->fetch_assoc();
		return $row['current'];
	}
}


/*
 * The database has first to be connected.
 */
function getSituationXML ($id_narrative, $name)
{
	global $conn;

	// Get text of current situation
	$sql = "SELECT w.text FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'situation' AND e.name = '$name'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	printSQL($sql);

	$result = $conn->query($sql) or trigger_error($conn->error." [$sql]");

	if (!checkUnique ($sql, $result)) { return null; }

	$row = $result->fetch_assoc();

	$xml = "<XML>\n";
	$xml .= "<TEXT>\n";
	$xml .= $row['text'];
	$xml .= "</TEXT>\n";

	// Get next transisions
	$sql = "SELECT w.xml FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.type = 'transition' AND e.name = '$name'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	printSQL($sql);

	$result = $conn->query($sql) or trigger_error($conn->error." [$sql]");

	while ($row = $result->fetch_assoc())
	{
		$xml .= "<TRANSITION>\n";
		$xml .= $row['xml'] . "\n";
		$xml .= "</TRANSITION>\n";
	}

	$xml .= "</XML>\n";
	
	return $xml;
}


/*
 * Get XML content of lastest elements with a given name in the database.
 * The database has first to be connected.
 */
function getXML ($id_narrative, $name)
{
    global $conn;
    
    $sql = "SELECT e.id_element, e.type, w.xml FROM element e
				INNER JOIN writing w ON e.id_element = w.id_element
			WHERE e.id_narrative = '$id_narrative' AND e.name = '$name'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)";
	printSQL($sql);
    
    $result = $conn->query($sql) or trigger_error($conn->error." [$sql]");

    if (checkExists ($sql, $result)) { return $result; } else { return null; }
}

?>
