<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

$id_story = $_SESSION['id_story'];

// Get story data
$sql = "SELECT id_narrative, id_current, date FROM story WHERE id_story = $id_story";
$result = execSQL ($sql);

$row = $result->fetch_assoc();
extract ($row);

$next_elements = array();

// ...possible transitions
$unlock = $json['unlock'];

$sql = "SELECT e.id_element, COALESCE (w.choice, '') AS choice
		FROM element e
			INNER JOIN writing w ON w.id_element = e.id_element
		WHERE e.id_narrative = $id_narrative AND e.type = 'transition' AND w.id_from = $id_current AND w.unlock LIKE '%\"$unlock\"%'
			AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element AND x.date <= '$date')
			AND w.type IN ('create', 'modify')";
$result = execSQL ($sql);

while ($row = $result->fetch_assoc()) { $next_elements[$row['id_element']] = $row; }

$data = array ("next_elements" => $next_elements);

closeConnection();

echo json_encode ($data);

?>
