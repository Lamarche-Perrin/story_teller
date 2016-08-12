<?php

include("functions/function.php");

session_start();

$_SESSION['id_member'] = 1;
$_SESSION['id_narrative'] = 16;
$_SESSION['id_story'] = 13;



openConnection();

//deleteNarrative(18);
//$_SESSION['id_narrative'] = newNarrative ($_SESSION['id_member'], "clone.compact", "Clone", "Première narration, écrite par Régis, compressée par Robin.");
//importXML ($_SESSION['id_member'], $_SESSION['id_narrative'], "../xml/clone.compact.xml");
//$_SESSION['id_story'] = newStory ($_SESSION['id_member'], $_SESSION['id_narrative']);

//$info = getNarrativeInfo ($_SESSION['id_narrative']);
//$text = getStoryText ($_SESSION['id_story']);

//setElementText ($_SESSION['id_member'], 1059, 'test');
//setRights (1, 1044, 'full');

closeConnection();

?>

