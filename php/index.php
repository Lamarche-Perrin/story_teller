<?php

include("function/function.php");

session_start();

$_SESSION['id_member'] = 1;
$_SESSION['id_narrative'] = 12;
$_SESSION['id_story'] = 12;




openConnection();

//deleteNarrative(11);
//$_SESSION['id_narrative'] = newNarrative ("clone", "Clone", "Première narration, écrite par Régis.");
//importXML ($_SESSION['id_member'], $_SESSION['id_narrative'], "../xml/clone.xml");
//$_SESSION['id_story'] = newStory ($_SESSION['id_member'], $_SESSION['id_narrative']);

$info = getNarrativeInfo ($_SESSION['id_narrative']);
$text = getStoryText ($_SESSION['id_story']);

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<link href="booklet/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
		<style type="text/css">
         body {background:#000; font:normal 14px/1.25 arial, verdana, sans-serif;}
		 .booklet .b-wrap-right {background:#FCFCFC;}
		 .booklet .b-page-cover {padding:0; width:100%; height:100%; background:#AA2211;}
		 .booklet .b-page-cover .title {height:20%; padding: 50px 0 0 0; font:25px/1.25 arial, verdana, sans-serif; font-weight:bolder; text-align:center;}
		 .booklet .b-page-cover .author {height:65%; font:20px/1.25 arial, verdana, sans-serif; text-align:center;}
		 .booklet .b-page-cover .date {height:5%; font:15px/1.25 arial, verdana, sans-serif; text-align:center;}
		 .booklet .b-page-cover {padding:50; width:100%; height:100%; background:#AA2211;}
		</style>
    </head>
    
    <body>
		<div id="book">
			<div id="page1">
				<div class="title"><?php echo $info['title'] ?></div>
				<div class="author"><?php
									$first = true;
									foreach ($info['authors'] as $author)
									{
										if ($first) { $first = false; } else { echo ", "; }
										echo $author['name'];
									}
									?></div>
				<div class="date"><?php
								  $frMonth = Array("", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre");
								  $strDate = strtotime ($info['date']);
								  $formatDate = date('j',$strDate) . " " . $frMonth[date('n',$strDate)] . " " . date('Y',$strDate);
								  echo $formatDate;
								  ?></div>
			</div>
			<div id="page2" align="justify"></div>
			<div id="page3" align="justify"></div>
			<div id="page4" align="justify"></div>
		</div>

		<center><div id="page"></div></center>

		<script type="text/javascript">
		 var xml;
		 var pageNb = 3;
		 var closedBook = true;
		 var nextPage = false;
		 var nextButton = "";

		 function next (current)
		 {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function ()
			 {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 xml = xhttp.responseXML;
					 print(0);
				 }
			 };

			 xhttp.open ("POST", "function/get_xml.php", true);
			 xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

			 if (current != null) { xhttp.send("current="+current); }
			 else { xhttp.send (); }
		 }

		 function turnPage ()
		 {			 
			 nextPage = false;
			 closedBook = false;
			 document.getElementById("page").innerHTML = nextButton;
			 document.getElementById("button").focus();
			 $("#book").booklet("next");
		 }

		 function print (step)
		 {
			 var text = xml.getElementsByTagName("TEXT")[0].childNodes[0].nodeValue;

			 var textArray = text.split("[break]");

			 if (textArray[step] != "NULL")
			 {
				 //document.getElementById("book").innerHTML += textArray[step] + "<BR>\n<BR>\n";

				 var currentText = document.getElementById("page"+pageNb).innerHTML;
				 document.getElementById("page"+pageNb).innerHTML += textArray[step] + "<BR>\n<BR>\n";
				 var pageHeight = document.getElementById("page"+pageNb).offsetHeight;
				 if (pageHeight > 550)
				 {
					 document.getElementById("page"+pageNb).innerHTML = currentText;
					 
					 pageNb = pageNb+1;
					 if (pageNb % 2 == 0) { nextPage = true; }
					 $("#book").booklet("add",pageNb,"<div id=\"page" + pageNb + "\" align=\"justify\">" + textArray[step] +  "<BR>\n<BR>\n" + "</div>");
				 }
				 //alert(numberOfLines);
				 //$("#book").booklet("option","width",1000);
			 }

			 var button = "";
			 step = step+1;
			 if (step < textArray.length)
			 {
				 button = "<button id=\"button\" type=\"button\" onClick=\"print("+step+")\">Continuer</button>";
			 }

			 else {
				 var transitions = xml.getElementsByTagName("TRANSITION");
				 for (var i = 0; i < transitions.length; i++)
				 {
					 var to = transitions[i].getElementsByTagName("TO")[0].childNodes[0].nodeValue;

					 var choice = "Continuer";
					 if (transitions[i].getElementsByTagName("CHOICE").length != 0)
					 { choice = transitions[i].getElementsByTagName("CHOICE")[0].childNodes[0].nodeValue; }
					 button += "<button id=\"button\" type=\"button\" onClick=\"next('"+to+"')\">"+choice+"</button>";
				 }

			 }
			 
			 //if (closedBook)
			 //{
			 //	 nextButton = button;
			 //	 document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Ouvrir</button>";
			 //}
			 

			 //else
			 if (nextPage)
			 {
				 nextButton = button;
				 document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Tourner la page</button>";
			 }

			 else { document.getElementById("page").innerHTML = button; }

			 document.getElementById("button").focus();
		 }
		 
		</script>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
		<script>window.jQuery || document.write('<script src="booklet/jquery-2.1.0.min.js"><\/script>')</script>
		<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
		<script>window.jQuery.ui || document.write('<script src="booklet/jquery-ui-1.10.4.min.js"><\/script>')</script>
		<script src="booklet/jquery.easing.1.3.js"></script>
		<script src="booklet/jquery.booklet.latest.js"></script>
		
		<script>
		 $(function () {
			 $("#book").booklet();
			 $("#book").booklet({ closed: true, autoCenter: true, covers: true, pagePadding: 30, width:800, height:600,
								  tabs: true, nextControlText: "Suivant", previousControlText: "Précédent", nextControlTitle: "Page suivante",
								  previousControlTitle: "Page précédente", shadows: true, speed: 1500});

			 if (closedBook)
			 {
				 nextButton = "<button id=\"button\" type=\"button\" onClick=\"next(null)\">Commencer</button>";
				 document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Ouvrir</button>";
				 document.getElementById("button").focus();
			 }
			 else { next(null); }
			 
		 });
		</script>
	</body>
</html>
