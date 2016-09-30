<?php

header('Content-Type: application/json');

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

if (isset($_POST['type']) && isset($_POST['id_element']))
{
	openConnection();

	setElement ($_SESSION['id_member'], $_POST['id_element'], $_POST);
	$data = getElementData ($_POST['id_element']);

	closeConnection();

	echo json_encode($data);
}

?>

