<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

$data = getStoryNextData ($_SESSION['id_story']);

closeConnection();

echo json_encode($data);

?>
