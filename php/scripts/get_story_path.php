<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

// Get traveled path
$id_story = $_SESSION['id_story'];

$sql = "SELECT path, date FROM story WHERE id_story = $id_story";
$result = execSQL ($sql);

$row = $result->fetch_assoc();
extract ($row);

$ids_path = array();
$elements = array();

if ($path != '')
{
	$ids_path = explode (";", $path);
	$unique_ids_path = array_unique ($ids_path);
	$in_clause = "(" . implode (", ", $unique_ids_path) . ")";

	// Get data corresponding to the traveled situations
	$sql = "SELECT e.id_element, w.text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
 			FROM element e
 				INNER JOIN writing w ON w.id_element = e.id_element
 				INNER JOIN member m ON m.id_member = w.id_member
 			WHERE e.id_element IN $in_clause
 				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element AND x.date <= '$date')
 				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	while ($row = $result->fetch_assoc()) { $elements[$row['id_element']] = $row; }
}

$data = array ("path" => $ids_path, "elements" => $elements);

closeConnection();

echo json_encode ($data);

?>
