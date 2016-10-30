<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

$id_narrative = $_SESSION['id_narrative'];

// Get data in narrative table
$sql = "SELECT title, abstract, date FROM narrative WHERE id_narrative = $id_narrative";
$result = execSQL ($sql);

$row = $result->fetch_assoc();
$data = $row;

$data['members'] = array();

// Add data regarding authors
$sql = "SELECT m.id_member, m.name FROM element e
			 INNER JOIN rights r ON r.id_element = e.id_element
			 INNER JOIN member m ON m.id_member = r.id_member
		 WHERE e.id_narrative = '$id_narrative' AND e.type = 'narrative' AND r.type IN ('add','mod','full')";
$result = execSQL ($sql);

while ($row = $result->fetch_assoc()) { $data['members'][$row['id_member']] = $row; }

closeConnection();

echo json_encode($data);
	
?>
