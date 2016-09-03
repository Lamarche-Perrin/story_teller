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

$mageValue = 2;
$spellValue = 14;
$nbDice = 4;
$nbTest = 100000;
$withMagic = false;

$nbTouch = 0;
$diceArray = array();

for ($i = 0; $i < $nbTest; $i++)
{
	$sum = $mageValue;
	$min = 6;

	for ($d = 0; $d < $nbDice; $d++)
	{
		$r = rand(1,6);
		$diceArray[$d] = $r;
		$sum += $r;
		if ($r < $min) { $min = $r; }
	}

	if ($sum >= $spellValue) { $nbTouch++; }
	else if ($withMagic) {
		$sum = $sum - $min + rand(1,6);
		if ($sum >= $spellValue) { $nbTouch++; }
	}
}

echo $nbTouch/$nbTest;

?>

