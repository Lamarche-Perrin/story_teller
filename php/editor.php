<?php

session_start();

if (isset($_GET) && isset($_GET['id_narrative'])) { $_SESSION['id_narrative'] = $_GET['id_narrative']; }

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<link rel="stylesheet" href="css/editor.css" />

		<script type="text/javascript" src="lib/shortcut.js"></script>
		<script type="text/javascript" src="lib/jquery-3.1.1.js"></script>
		<script type="text/javascript" src="scripts/editor.js"></script>

		<title>La Bibliothèque Générale : Écrire</title>
    </head>

    <body>
		<div id="div_wrapper">
			<header>
				Header
			</header>

			<section>
				<div id="div_selector">
					<div id="div_graph">
						Graph
					</div>

					<div id="div_list">
						<ul id="list">
						</ul>
					</div>

					<div id="div_search">
						Search
					</div>
				</div>

				<div id="div_editor">
					<div id="div_tabs"></div>
					<hr>
					<div id="div_form"></div>
				</div>
			</section>

			<footer>
				Footer
			</footer>
		</div>
	</body>
</html>
