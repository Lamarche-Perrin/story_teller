<?php

include("functions/function.php");

session_start();

if (isset($_GET) && isset($_GET['id_narrative'])) { $_SESSION['id_narrative'] = $_GET['id_narrative']; }

openConnection();

$_SESSION['id_story'] = getMostRecentStory ($_SESSION['id_member'], $_SESSION['id_narrative']);
if (is_null($_SESSION['id_story'])) { $_SESSION['id_story'] = newStory ($_SESSION['id_member'], $_SESSION['id_narrative']); }

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>

		<!-- <script type="text/javascript" src="lib/shortcut.js"></script>

			 
			 <link href="lib/booklet-master/src/jquery.booklet.latest.css" type="text/css" rel="stylesheet"/>
			 <script type="text/javascript" src="lib/booklet-master/src/jquery.easing.1.3.js"></script>
			 <script type="text/javascript" src="lib/booklet-master/src/jquery.booklet.latest.min.js"></script> -->

		<script type="text/javascript" src="lib/shortcut.js"></script>
		<script type="text/javascript" src="lib/jquery-3.1.1.js"></script>
		<script type="text/javascript" src="lib/CSSJSON-master/cssjson.js"></script>

		<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
			 <script> window.jQuery || document.write('<script src="lib/booklet-master/src/jquery-2.1.0.min.js"><\/script>') </script> -->
		<!-- <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script> -->

		<link href="lib/booklet-master/src/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
		<script src="lib/booklet-master/src/jquery.easing.1.3.js"></script>
		<script src="lib/booklet-master/src/jquery.booklet.latest.min.js"></script>

		<link href="css/reader.css" type="text/css" rel="stylesheet"/>

		
		<script type="text/javascript">
		// $(function() { $('#div_book').booklet(); });
		 $(document).ready (function () { $.getScript("scripts/reader.js"); });
		</script>

		<title>La Bibliothèque générale : Lire</title>
    </head>
    
    <body>
		<div id="div_wrapper">
			<header>
			</header>
			
			<section id="main_section">
				<div id="div_book">
					<div id="div_cover"></div>
					<div id="div_after_cover"></div>
					<div id="div_before_back"></div>
					<div id="div_back"></div>
						
					<!-- <div id="front_page" class="page cover_page odd_page">
						 <div class="title"></div>
						 <div class="author"></div>
						 <div class="date"></div>
						 </div>
						 <div id="after_front_page" class="page cover_page even_page"></div>

						 <div id="page_1" class="page white_page odd_page"></div>
						 <div id="page_2" class="page white_page even_page"></div>
						 <div id="page_3" class="page white_page odd_page"></div>
						 <div id="page_4" class="page white_page even_page"></div>
						 
						 <div id="before_back_page" class="page cover_page odd_page"></div>
						 <div id="back_page" class="page cover_page even_page"></div> -->
				</div>

				<!-- <center><div id="page"></div></center> -->
			</section>

			<footer>
			</footer>
		</div>		
	</body>
</html>
