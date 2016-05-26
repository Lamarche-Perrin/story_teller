<?php

include("function/function.php");

session_start();

$conn = getConnection();

$_SESSION['id_member'] = 2;
$_SESSION['id_narrative'] = 2;
$_SESSION['id_story'] = 3;

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
		 function next (current)
		 {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function ()
			 {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 var xml = xhttp.responseXML;
					 var text = xml.getElementsByTagName("TEXT")[0].childNodes[0].nodeValue;
					 document.getElementById("book").innerHTML += text + "<BR>\n<BR>\n";

					 document.getElementById("page").innerHTML = "";
					 var transitions = xml.getElementsByTagName("TRANSITION");
					 for (var i = 0; i < transitions.length; i++)
					 {
						 var to = transitions[i].getElementsByTagName("TO")[0].childNodes[0].nodeValue;

						 var choice = "Continuer";
						 if (transitions[i].getElementsByTagName("CHOICE").length != 0)
						 { choice = transitions[i].getElementsByTagName("CHOICE")[0].childNodes[0].nodeValue; }
						 document.getElementById("page").innerHTML += "<BUTTON TYPE=\"button\" ONCLICK=\"next('"+to+"')\">"+choice+"</BUTTON>";
					 }
				 }
			 };

			 xhttp.open ("POST", "function/get_xml.php", true);
			 xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

			 if (current != null) { xhttp.send("current="+current); }
			 else { xhttp.send (); }
		 }

		 next(null);
		</SCRIPT>
	</BODY>
</HTML>
