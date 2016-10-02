<?php

header("Content-type: text/xml; charset=utf-8");

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

if (isset($_POST['id_current'])) { $id_current = $_POST['id_current']; }
else { $id_current = getStoryCurrent ($_SESSION['id_story']); }

$xml = getSituationXML ($_SESSION['id_narrative'], $id_current);

closeConnection();


echo $xml;

?>
