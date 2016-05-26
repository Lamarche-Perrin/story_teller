<?php

header("Content-type: text/xml; charset=utf-8");

include("./function.php");

session_start();

$_SESSION['id_member'] = 2;
$_SESSION['id_narrative'] = 4;
$_SESSION['id_story'] = 2;

$conn = getConnection();

$current = getStoryCurrent ($_SESSION['id_story']);

$xml = getSituationXML ($_SESSION['id_narrative'], $current);

echo $xml;

$conn->close();

?>
