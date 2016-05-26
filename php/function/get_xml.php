<?php

header("Content-type: text/xml; charset=utf-8");

include("./function.php");

session_start();

$conn = getConnection();

if (isset($_POST['current'])) { $current = $_POST['current']; }
else { $current = getStoryCurrent ($_SESSION['id_story']); }

$xml = getSituationXML ($_SESSION['id_narrative'], $current);

echo $xml;

$conn->close();

?>
