<?php

include("functions/function.php");

session_start();
$_SESSION = array();

openConnection();

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
