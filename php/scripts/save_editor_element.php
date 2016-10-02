<?php

header('Content-Type: application/json');

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

setElement ($_SESSION['id_member'], $json['id_element'], $json);
$data = getElementData ($json['id_element']);

closeConnection();

echo json_encode ($data);

?>

