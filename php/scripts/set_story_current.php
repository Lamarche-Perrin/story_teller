<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

$id_story = $_SESSION['id_story'];

if (isset($json['id_element']))
{
	$id_element = $json['id_element'];
	$sql = "UPDATE story
				SET path = IF (path IS NULL, id_current, CONCAT (path, ';', id_current)),
				id_current = $id_element,
				step_current = 0
			WHERE id_story = $id_story";
	execSQL ($sql);
}

if (isset($json['step_current']))
{
	$step = $json['step_current'];
	$sql = "UPDATE story SET step_current = $step WHERE id_story = $id_story";
	execSQL ($sql);	
}

closeConnection();

?>

