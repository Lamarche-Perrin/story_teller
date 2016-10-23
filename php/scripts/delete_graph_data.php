<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

if (isset($json['id']))
{
	deleteElementGraphData ($_SESSION['id_member'], $json['id']);
}
	
closeConnection();

?>

