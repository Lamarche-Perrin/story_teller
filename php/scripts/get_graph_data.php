<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

$id_narrative = $_SESSION['id_narrative'];
$data = array();

$sql = "SELECT e.id_element AS id, e.type, w.name, w.start, w.end, COALESCE (w.text, '') AS text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
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
	$data[] = array ('data' => $row);
}


$sql = "SELECT e.id_element AS id, e.type, w.id_from AS source, w.id_to AS target, COALESCE (w.choice, '') AS choice, COALESCE (w.unlock, '') AS `unlock`, COALESCE (w.text, '') AS text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
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
	$data[] = array ('data' => $row);
}

closeConnection();

echo json_encode($data);
	
?>
