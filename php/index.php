<?php

include("functions/function.php");

session_start();
$_SESSION = array();

openConnection();


//deleteNarrative (33);
//$id_narrative = newNarrative (2, "choice", "Choice", "Exemple de transition avec choix.");
//importNarrative (2, $id_narrative, "../xml/examples/choice.xml");


$datas = getMembersData ();

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    </head>
    
    <body>
		<h2>Connexion</h2>
		<ul>
			<?php
			foreach ($datas as $data)
			{
				echo "<li><a href=\"library.php?id_member=".$data['id_member']."\"><b>" . $data['name'] . "</a></b></li>";
			}
			?>
		</ul>
	</body>
</html>
