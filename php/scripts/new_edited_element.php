<?php

header("Content-type: text/xml; charset=utf-8");

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

if (isset($_POST['type']))
{
	if ($_POST['type'] == "situation")
	{
		if (isset($_POST['name']))
		{
			openConnection();
			$id_situation = newSituation ($_SESSION['id_narrative'], $_POST['name']);
			closeConnection();
?>
	<XML>
		<ID_ELEMENT><?php echo (is_null($id_situation)) ? "NULL" : $id_situation; ?></ID_ELEMENT>
	</XML>
	
<?php
}
}

else if ($_POST['type'] == "transition")
{
	/* if (isset($_POST['id_element']) && isset($_POST['from']) && isset($_POST['to']) && isset($_POST['choice']) && isset($_POST['text']))
	   {	
	   openConnection();
	   setElementChoiceAndText ($_SESSION['id_member'], $_POST['id_element'], $_POST['choice'], $_POST['text']);
	   $info = getElementInfo ($_POST['id_element']);
	   closeConnection();*/
?>
	<!-- <XML>
		 <ID_ELEMENT><?php echo $info['id_element']; ?></ID_ELEMENT>
		 <FROM><?php echo $info['from']; ?></FROM>
		 <TO><?php echo $info['to']; ?></TO>
		 <CHOICE><?php echo $info['choice']; ?></CHOICE>
		 <SHORT_CHOICE><?php echo formatShortText($info['choice']); ?></SHORT_CHOICE>
		 <TEXT><?php echo $info['text']; ?></TEXT>
		 <SHORT_TEXT><?php echo formatShortText($info['text']); ?></SHORT_TEXT>
		 <DATE><?php echo $info['date'] ?></DATE>
		 <AUTHOR><?php echo $info['author']; ?></AUTHOR>
		 </XML> -->

<?php
}
}


?>

