<?php

include("functions/function.php");

session_start();

if (isset($_GET) && isset($_GET['id_narrative'])) { $_SESSION['id_narrative'] = $_GET['id_narrative']; }

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<link rel="stylesheet" href="css/editor.css" />
		<!-- <link rel="stylesheet" href="css/graph.css" /> -->

		<script type="text/javascript" src="lib/shortcut.js"></script>
		<script type="text/javascript" src="lib/jquery-3.1.1.js"></script>
		<script src="lib/cytoscape.js-2.7.10/cytoscape.js"></script>
		
		<script src="lib/WebCola/cola.v3.min.js"></script>
		<script src="lib/cola.v3.min.js"></script>
		<script src="lib/cytoscape.js-cola/cytoscape-cola.js"></script>		

		<script type="text/javascript">
		 $(document).ready (function () { $.getScript("scripts/editor.js"); });
		</script>
		
		<title>La Bibliothèque générale : Écrire</title>
    </head>

    <body>
		<div id="div_wrapper">
			<header>
			</header>

			<section id="main_section">
				<div id="div_selector">
					<div id="div_test"></div>
					<div id="div_narrative"></div>
					<div id="div_graph"></div>
					<div id="div_buttons"></div>
				</div>

				<div id="div_editor">
					<div id="div_form"></div>
					<div id="div_egograph"></div>
				</div>

				<div id="div_reader">
					<div id="div_story">
						<table id="table_story"></table>
					</div>
				</div>
			</section>

			<footer>
			</footer>
		</div>
	</body>
</html>
