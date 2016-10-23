<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

if ($json['type'] == 'situation')
{
	setSituationGraphData ($_SESSION['id_member'], $json['id'], $json);
	$data = getSituationGraphData ($json['id']);
}

else if ($json['type'] == 'transition')
{
	setTransitionGraphData ($_SESSION['id_member'], $json['id'], $json);
	$data = getTransitionGraphData ($json['id']);
}
	
closeConnection();

echo json_encode ($data);

?>

