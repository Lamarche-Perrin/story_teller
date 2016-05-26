<?php

include("function/function.php");

session_start();

$conn = getConnection();

$_SESSION['id_member'] = 2;
$_SESSION['id_narrative'] = 4;
$_SESSION['id_story'] = 2;

$text = getStoryText ($_SESSION['id_story']);

$conn->close();

?>


<HTML>
    <HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"/>
    </HEAD>
    
    <BODY>
		<DIV ID="book"><?php echo $text ?></DIV>
		<DIV ID="page"></DIV>

		<SCRIPT>
		 function next ()
		 {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function ()
			 {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 var xml = xhttp.responseXML;
					 var text = xml.getElementsByTagName("TEXT")[0].childNodes[0].nodeValue;
					 document.getElementById("book").innerHTML += text + "<BR>\n<BR>\n";
					 document.getElementById("page").innerHTML = "<BUTTON TYPE=\"button\" ONCLICK=\"next()\">Suite</BUTTON>";
				 }
			 };
			 xhttp.open("GET", "function/get_xml.php", true);
			 xhttp.send();
		 }

		 next();
		</SCRIPT>
	</BODY>
</HTML>
