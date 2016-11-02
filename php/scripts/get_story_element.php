<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

$id_story = $_SESSION['id_story'];

// Get story data
$sql = "SELECT id_narrative, id_current, date FROM story WHERE id_story = $id_story";
$result = execSQL ($sql);

$row = $result->fetch_assoc();
extract ($row);

// Get element data
$sql = "SELECT e.id_element, e.type, COALESCE (w.text, '') AS text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
		FROM element e
			INNER JOIN writing w ON w.id_element = e.id_element
			INNER JOIN member m ON m.id_member = w.id_member
		WHERE e.id_element = $id_current
			AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element AND x.date <= '$date')
			AND w.type IN ('create', 'modify')";
$result = execSQL ($sql);
$element = $result->fetch_assoc();

// Get next elements data
$locked_elements = false;
$next_elements = array();

// ...possible transitions
if ($element['type'] == 'situation')
{
	$sql = "SELECT e.id_element, COALESCE (w.choice, '') AS choice, COALESCE (w.unlock, '') AS `unlock`
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
			WHERE e.id_narrative = $id_narrative AND e.type = 'transition' AND w.id_from = $id_current
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element AND x.date <= '$date')
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc())
	{
		if ($row['unlock'] == '') { $next_elements[$row['id_element']] = $row; }
		else { $locked_elements = true; }
	}
}

// ...next situation
if ($element['type'] == 'transition')
{
	$sql = "SELECT w.id_to AS id_element
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
			WHERE e.id_element = $id_current
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element AND x.date <= '$date')
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	$row = $result->fetch_assoc();
	$next_elements[$row['id_element']] = $row;
}

$data = array ("element" => $element, "next_elements" => $next_elements, "locked_elements" => $locked_elements);

closeConnection();

echo json_encode ($data);

?>
