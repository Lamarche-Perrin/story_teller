<?php

include("functions/function.php");

session_start();

$_SESSION['id_member'] = 1;
$_SESSION['id_narrative'] = 19;
//$_SESSION['id_story'] = 12;


openConnection();

$info = getElementsInfo ($_SESSION['id_narrative']);

//deleteNarrative(11);
//$_SESSION['id_narrative'] = newNarrative ("clone", "Clone", "Première narration, écrite par Régis.");
//importXML ($_SESSION['id_member'], $_SESSION['id_narrative'], "../xml/clone.xml");
//$_SESSION['id_story'] = newStory ($_SESSION['id_member'], $_SESSION['id_narrative']);

//$info = getNarrativeInfo ($_SESSION['id_narrative']);
//$text = getStoryText ($_SESSION['id_story']);

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<script type="text/javascript" src="jquery.tablesorter/jquery-latest.js"></script>
		<script type="text/javascript" src="jquery.tablesorter/jquery.tablesorter.js"></script>
		<link type="text/css" href="css/tablesorter.css" rel="stylesheet" media="print, projection, screen" />
    </head>
    
    <body>

		<!-- List of existing situations -->
		<div style="float: left;">
			<div style="width: 900px; height: 700px; overflow-y: scroll; overflow-x:hidden;">
				<table id="situation.table" class="tablesorter">
					<thead>
						<tr>
							<th>ID</th>
							<th>Texte</th>
							<th>Date</th>
							<th>Auteur</th>
						</tr>
					</thead>
					<tbody>
						<?php
						foreach ($info['situations'] as $id_situation => $situation)
						{
						?>
							<tr id="situation.<?php echo $situation['id_element']; ?>" data-id_element="<?php echo $situation['id_element']; ?>" data-name="<?php echo $situation['name']; ?>" data-text="<?php echo htmlspecialchars($situation['text']); ?>" data-date="<?php echo $situation['date']; ?>" data-author="<?php echo $situation['author']; ?>" >
								<td class="situation.name">
									<?php echo $situation['name']; ?>
								</td>
								
								<td class="situation.shortText">
									<?php echo formatShortText($situation['text']); ?>
								</td>
								
								<td class="situation.date">
									<?php echo $situation['date']; ?>
								</td>
								
								<td class="situation.author">
									<?php echo $situation['author']; ?>
								</td>
							</tr>
						<?php
						}				
						?>
					</tbody>
				</table>
			</div>

			<p>
				<form>
					Rechercher:<br>
					<input list="situations" onSelect="selectSituation(this)">
					<datalist id="situations">
						<?php
						foreach ($info['situations'] as $id_situation => $situation)
						{
							echo '<option value="' . $situation['name'] . '"/>';
						}
						?>
					</datalist>
				</form>
			</p>
		</div>

		<div>
			<p>
				<form id="situation.form" style="visibility: hidden;">
					<input type="hidden" class="situation.id_element">
					ID:<br>
					<input type="text" class="situation.name"><br>
					Texte:<br>
					<textarea rows=10 cols=80 class="situation.text"></textarea><br>
					<div class="situation.author"></div>
					<input type="button" value="Enregistrer" onClick="saveSituation();">
				</form>
			</p>
		</div>
		
		<script type="text/javascript">
		 $(function() { $("#situation.table").tablesorter(); });

		 var selectedRow = null;

		 function selectSituation (selector)
		 {
			 if (selectedRow !== null) { selectedRow.classList.remove("selectedRow"); }
			 
			 var table = document.getElementById("situation.table");
			 var rows = table.getElementsByTagName("tr");

			 var found = false;
			 for (i = 0; i < rows.length && !found; i++) {
				 var currentRow = rows[i];

				 if (currentRow.getAttribute("data-name") == selector.value)
				 {
					 currentRow.classList.add("selectedRow");
					 selectedRow = currentRow;
					 found = true;
					 updateForm();
				 }
			 }
		 }
		 
		 function updateForm ()
		 {
			 var form = document.getElementById("situation.form");
			 if (selectedRow === null) { form.style.visibility = "hidden"; }
			 else {
				 form.style.visibility = "visible";

				 var idElement = form.getElementsByClassName("situation.id_element")[0];
				 idElement.value = selectedRow.getAttribute('data-id_element');

				 var nameElement = form.getElementsByClassName("situation.name")[0];
				 nameElement.value = selectedRow.getAttribute('data-name');

				 var textElement = form.getElementsByClassName("situation.text")[0];
				 textElement.value = selectedRow.getAttribute('data-text');

				 var authorElement = form.getElementsByClassName("situation.author")[0];
				 authorElement.innerHTML = "dernière modification le " + selectedRow.getAttribute('data-date') + " par " + selectedRow.getAttribute('data-author');
			 }
		 }

		 var table = document.getElementById("situation.table");
		 var rows = table.getElementsByTagName("tr");

		 for (i = 0; i < rows.length; i++) {
			 var currentRow = rows[i];

			 var createOnClickHandler = function (row) 
			 {
				 return function () {
					 if (selectedRow !== null) { selectedRow.classList.remove("selectedRow"); }
					 if (row != selectedRow) { row.classList.add("selectedRow"); selectedRow = row; } else { selectedRow = null; }
					 updateForm();
				 };
			 };

		 	 var createOnMouseOverHandler = function (row) 
			 {
				 return function () { row.classList.add("overedRow"); };
			 };

		 	 var createOnMouseOutHandler = function (row) 
			 {
				 return function () { row.classList.remove("overedRow"); };
			 };

			 currentRow.onclick = createOnClickHandler (currentRow);
			 currentRow.onmouseover = createOnMouseOverHandler (currentRow);
			 currentRow.onmouseout = createOnMouseOutHandler (currentRow);
		 }
		</script>

		<script type="text/javascript">
		 function saveSituation ()
		 {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function ()
			 {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 var xml = xhttp.responseXML;
					 var id_element = xml.getElementsByTagName("ID_ELEMENT")[0].childNodes[0].nodeValue;

					 var text = "";
					 var textNode = xml.getElementsByTagName("TEXT")[0].childNodes;
					 if (textNode.length == 1) { var text = textNode[0].nodeValue; }
					 
					 var shortText = "";
					 var shortTextNode = xml.getElementsByTagName("SHORT_TEXT")[0].childNodes;
					 if (shortTextNode.length == 1) { var shortText = shortTextNode[0].nodeValue; }

					 var date = xml.getElementsByTagName("DATE")[0].childNodes[0].nodeValue;
					 var author = xml.getElementsByTagName("AUTHOR")[0].childNodes[0].nodeValue;

					 
					 var row = document.getElementById("situation." + id_element);
					 row.setAttribute("data-text", text);
					 row.setAttribute("data-date", date);
					 row.setAttribute("data-author", author);

					 row.getElementsByClassName("situation.shortText")[0].innerHTML = shortText;
					 row.getElementsByClassName("situation.date")[0].innerHTML = date;
					 row.getElementsByClassName("situation.author")[0].innerHTML = author;

					 updateForm();
				 }
			 };

			 xhttp.open ("POST", "scripts/save_edited_situation.php", true);
			 xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

			 var sendStr = "";
			 var form = document.getElementById("situation.form");
			 sendStr += "id_element=" + form.getElementsByClassName("situation.id_element")[0].value;
			 sendStr += "&";
			 sendStr += "name=" + form.getElementsByClassName("situation.name")[0].value;
			 sendStr += "&";
			 sendStr += "text=" + form.getElementsByClassName("situation.text")[0].value;

			 xhttp.send(sendStr);
			 //alert(sendStr);
		 }
		</script>
	</body>
</html>
