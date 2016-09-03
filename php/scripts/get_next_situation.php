<?php

header("Content-type: text/xml; charset=utf-8");

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

openConnection();

if (isset($_POST['current'])) { $current = $_POST['current']; }
else { $current = getStoryCurrent ($_SESSION['id_story']); }

$xml = getSituationXML ($_SESSION['id_narrative'], $current);

closeConnection();


echo $xml;

?>
