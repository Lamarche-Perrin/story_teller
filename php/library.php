<?php

include("functions/function.php");

session_start();

if (isset($_GET) && isset($_GET['id_member'])) { $_SESSION['id_member'] = $_GET['id_member']; }

openConnection();

$datas = getNarrativesData ();

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    </head>
    
    <body>
		<a href="index.php">Déconnexion</a>
		<h2>Lire</h2>
		<ul>
			<?php
			foreach ($datas as $data)
			{
				echo "<li><a href=\"reader.php?id_narrative=".$data['id_narrative']."\"><b>" . $data['title'] . "</a></b> (" . formatDate($data['date']);
				foreach ($data['authors'] as $author) { echo ", " . $author['name']; }
				echo ")</li>";
			}
			?>
		</ul>

		<h2>Écrire</h2>
		<ul>
			<?php
			foreach ($datas as $data)
			{
				echo "<li><a href=\"editor.php?id_narrative=".$data['id_narrative']."\"><b>" . $data['title'] . "</a></b> (" . formatDate($data['date']);
				foreach ($data['authors'] as $author) { echo ", " . $author['name']; }
				echo ")</li>";
			}
			?>
		</ul>
	</body>
</html>
