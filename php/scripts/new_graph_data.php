<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

if ($json['type'] == 'situation')
{
	$id_element = newSituationGraphData ($_SESSION['id_narrative']);
}

else if ($json['type'] == 'transition')
{
	$id_element = newTransitionGraphData ($_SESSION['id_narrative']);
}
	
closeConnection();

echo json_encode (array('id' => $id_element));

?>

