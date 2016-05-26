<?php

include("function/function.php");

session_start();

$conn = getConnection();

$_SESSION['story_id'] = 2;

$text = getStoryText ($_SESSION['story_id']);
$conn->close();

?>


<HTML>
    <HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"/>
    </HEAD>
    
    <BODY>
		<DIV ID="book"><?php echo $text ?></DIV>
		<DIV ID="choices"></DIV>
		<!-- <BUTTON TYPE="button" ONCLICK="next()">Suite</BUTTON> -->

		<SCRIPT>
		 function next() {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function() {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 document.getElementById("book").innerHTML += "<BR>\n<BR>\n" + xhttp.responseText;
				 }
			 };
			 xhttp.open("GET", "function/get_xml.php", true);
			 xhttp.send();
		 }
		</SCRIPT>

		<?php


		?>
	</BODY>
</HTML>
