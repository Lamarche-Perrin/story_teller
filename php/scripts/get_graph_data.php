<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

$data = getElementsGraphData ($_SESSION['id_narrative']);

closeConnection();

echo json_encode($data);
	
?>
