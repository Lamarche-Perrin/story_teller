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
		<link type="text/css" href="css/tablesorter.css" rel="stylesheet" media="print, projection, screen"/>
    </head>
    
    <body>
		
		<!-- List of existing situations -->
		<div>
			<div style="float: left;">
				
				<div class="editorlist">
					<table id="situation_table" class="tablesorter">
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
								<tr id="situation_<?php echo $situation['id_element']; ?>" data-id_element="<?php echo $situation['id_element']; ?>" data-name="<?php echo $situation['name']; ?>" data-text="<?php echo htmlspecialchars($situation['text']); ?>" data-date="<?php echo $situation['date']; ?>" data-author="<?php echo $situation['author']; ?>" >
									<td class="situation_name">
										<?php echo $situation['name']; ?>
									</td>
									
									<td class="situation_shortText">
										<?php echo formatShortText($situation['text']); ?>
									</td>
									
									<td class="situation_date">
										<?php echo $situation['date']; ?>
									</td>
									
									<td class="situation_author">
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
					<form id="situation_form" style="visibility: hidden;">
						<input type="hidden" class="situation_id_element">
						ID:<br>
						<input type="text" class="situation_name"><br>
						Texte:<br>
						<textarea rows=10 cols=80 class="situation_text"></textarea><br>
						<div class="situation_author"></div>
						<input type="button" value="Enregistrer" onClick="saveSituation();">
					</form>
				</p>
			</div>
		</div>


		<!-- List of existing transitions -->
		<div>
			<div style="float: left;">

				<div class="editorlist">
					<table id="transition_table" class="tablesorter">
						<thead>
							<tr>
								<th>From</th>
								<th>To</th>
								<th>Choice</th>
								<th>Texte</th>
								<th>Date</th>
								<th>Auteur</th>
							</tr>
						</thead>
						<tbody>
							<?php
							foreach ($info['transitions'] as $id_transition => $transition)
							{
							?>
								<tr id="transition_<?php echo $transition['id_element']; ?>" data-id_element="<?php echo $transition['id_element']; ?>" data-from="<?php echo $transition['from']; ?>" data-to="<?php echo $transition['to']; ?>" data-text="<?php echo htmlspecialchars($transition['text']); ?>" data-choice="<?php echo htmlspecialchars($transition['choice']); ?>" data-date="<?php echo $transition['date']; ?>" data-author="<?php echo $transition['author']; ?>" >
									<td class="transition_from">
										<?php echo $transition['from']; ?>
									</td>

									<td class="transition_to">
										<?php echo $transition['to']; ?>
									</td>
									
									<td class="transition_shortChoice">
										<?php echo formatShortText($transition['choice']); ?>
									</td>

									<td class="transition_shortText">
										<?php echo formatShortText($transition['text']); ?>
									</td>
									
									<td class="transition_date">
										<?php echo $transition['date']; ?>
									</td>
									
									<td class="transition_author">
										<?php echo $transition['author']; ?>
									</td>
								</tr>
							<?php
							}				
							?>
						</tbody>
					</table>
				</div>
			</div>
			
			<div>
				<p>
					<form id="transition_form" style="visibility: hidden;">
						<input type="hidden" class="transition_id_element">
						Source:<br>
						<input type="text" class="transition_from"><br>
						Destination:<br>
						<input type="text" class="transition_to"><br>
						Choix:<br>
						<textarea rows=4 cols=80 class="transition_choice"></textarea><br>
						Texte:<br>
						<textarea rows=10 cols=80 class="transition_text"></textarea><br>
						<div class="transition_author"></div>
						<input type="button" value="Enregistrer" onClick="saveTransition();">
					</form>
				</p>
			</div>
		</div>
			
		<script type="text/javascript">

		 //SCRIPTS FOR SITUATION EDITOR
		 $(function() { $("#situation_table").tablesorter(); });

		 var selectedSituation = null;

		 // Select a situation with the "search" option
		 function selectSituation (selector)
		 {
			 if (selectedSituation !== null) { selectedSituation.classList.remove("selectedRow"); }
			 
			 var table = document.getElementById("situation_table");
			 var situations = table.getElementsByTagName("tr");

			 var found = false;
			 for (i = 0; i < situations.length && !found; i++) {
				 var currentSituation = situations[i];

				 if (currentSituation.getAttribute("data-name") == selector.value)
				 {
					 currentSituation.classList.add("selectedRow");
					 selectedSituation = currentSituation;
					 found = true;
					 updateSituationForm();
				 }
			 }
		 }

		 // Display and fill the edition form with the selected situation data
		 function updateSituationForm ()
		 {
			 var form = document.getElementById("situation_form");
			 if (selectedSituation === null) { form.style.visibility = "hidden"; }
			 else {
				 form.style.visibility = "visible";

				 var idElement = form.getElementsByClassName("situation_id_element")[0];
				 idElement.value = selectedSituation.getAttribute('data-id_element');

				 var nameElement = form.getElementsByClassName("situation_name")[0];
				 nameElement.value = selectedSituation.getAttribute('data-name');

				 var textElement = form.getElementsByClassName("situation_text")[0];
				 textElement.value = selectedSituation.getAttribute('data-text');

				 var authorElement = form.getElementsByClassName("situation_author")[0];
				 authorElement.innerHTML = "dernière modification le " + selectedSituation.getAttribute('data-date') + " par " + selectedSituation.getAttribute('data-author');
			 }
		 }


		 // Add handler to select and unselect rows of the situation table
		 var table = document.getElementById("situation_table");
		 var situations = table.getElementsByTagName("tr");

		 for (i = 0; i < situations.length; i++) {
			 var currentSituation = situations[i];

			 var createOnClickHandler = function (situation) 
			 {
				 return function () {
					 if (selectedSituation !== null) { selectedSituation.classList.remove("selectedRow"); }
					 if (situation != selectedSituation) { situation.classList.add("selectedRow"); selectedSituation = situation; } else { selectedSituation = null; }
					 updateSituationForm();
				 };
			 };

		 	 var createOnMouseOverHandler = function (situation) 
			 {
				 return function () { situation.classList.add("overedRow"); };
			 };

		 	 var createOnMouseOutHandler = function (situation) 
			 {
				 return function () { situation.classList.remove("overedRow"); };
			 };

			 currentSituation.onclick = createOnClickHandler (currentSituation);
			 currentSituation.onmouseover = createOnMouseOverHandler (currentSituation);
			 currentSituation.onmouseout = createOnMouseOutHandler (currentSituation);
		 }


		 // Call PHP script to save the situation form into the database
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

					 
					 var situation = document.getElementById("situation_" + id_element);
					 situation.setAttribute("data-text", text);
					 situation.setAttribute("data-date", date);
					 situation.setAttribute("data-author", author);

					 situation.getElementsByClassName("situation_shortText")[0].innerHTML = shortText;
					 situation.getElementsByClassName("situation_date")[0].innerHTML = date;
					 situation.getElementsByClassName("situation_author")[0].innerHTML = author;

					 updateSituationForm();
				 }
			 };

			 xhttp.open ("POST", "scripts/save_edited_element.php", true);
			 xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

			 var sendStr = "";
			 var form = document.getElementById("situation_form");
			 sendStr += "type=situation";
			 sendStr += "&";
			 sendStr += "id_element=" + form.getElementsByClassName("situation_id_element")[0].value;
			 sendStr += "&";
			 sendStr += "name=" + form.getElementsByClassName("situation_name")[0].value;
			 sendStr += "&";
			 sendStr += "text=" + form.getElementsByClassName("situation_text")[0].value;

			 xhttp.send(sendStr);
		 }


		 
		 //SCRIPTS FOR TRANSITION EDITOR
		 $(function() { $("#transition_table").tablesorter(); });

		 var selectedTransition = null;

		 // Display and fill the edition form with the selected transition data
		 function updateTransitionForm ()
		 {
			 var form = document.getElementById("transition_form");
			 if (selectedTransition === null) { form.style.visibility = "hidden"; }
			 else {
				 form.style.visibility = "visible";

				 var idElement = form.getElementsByClassName("transition_id_element")[0];
				 idElement.value = selectedTransition.getAttribute('data-id_element');

				 var fromElement = form.getElementsByClassName("transition_from")[0];
				 fromElement.value = selectedTransition.getAttribute('data-from');

				 var toElement = form.getElementsByClassName("transition_to")[0];
				 toElement.value = selectedTransition.getAttribute('data-to');

				 var choiceElement = form.getElementsByClassName("transition_choice")[0];
				 choiceElement.value = selectedTransition.getAttribute('data-choice');

				 var textElement = form.getElementsByClassName("transition_text")[0];
				 textElement.value = selectedTransition.getAttribute('data-text');

				 var authorElement = form.getElementsByClassName("transition_author")[0];
				 authorElement.innerHTML = "dernière modification le " + selectedTransition.getAttribute('data-date') + " par " + selectedTransition.getAttribute('data-author');
			 }
		 }

		 // Add handler to select and unselect rows of the transition table
		 var table = document.getElementById("transition_table");
		 var transitions = table.getElementsByTagName("tr");

		 for (i = 0; i < transitions.length; i++) {
			 var currentTransition = transitions[i];

			 var createOnClickHandler = function (transition) 
			 {
				 return function () {
					 if (selectedTransition !== null) { selectedTransition.classList.remove("selectedRow"); }
					 if (transition != selectedTransition) { transition.classList.add("selectedRow"); selectedTransition = transition; } else { selectedTransition = null; }
					 updateTransitionForm();
				 };
			 };

		 	 var createOnMouseOverHandler = function (transition) 
			 {
				 return function () { transition.classList.add("overedRow"); };
			 };

		 	 var createOnMouseOutHandler = function (transition) 
			 {
				 return function () { transition.classList.remove("overedRow"); };
			 };

			 currentTransition.onclick = createOnClickHandler (currentTransition);
			 currentTransition.onmouseover = createOnMouseOverHandler (currentTransition);
			 currentTransition.onmouseout = createOnMouseOutHandler (currentTransition);
		 }


		 // Call PHP script to save the transition form into the database
		 function saveTransition ()
		 {
			 var xhttp = new XMLHttpRequest();
			 xhttp.onreadystatechange = function ()
			 {
				 if (xhttp.readyState == 4 && xhttp.status == 200)
				 {
					 var xml = xhttp.responseXML;
					 var id_element = xml.getElementsByTagName("ID_ELEMENT")[0].childNodes[0].nodeValue;

					 var choice = "";
					 var choiceNode = xml.getElementsByTagName("CHOICE")[0].childNodes;
					 if (choiceNode.length == 1) { var choice = choiceNode[0].nodeValue; }

					 var shortChoice = "";
					 var shortChoiceNode = xml.getElementsByTagName("SHORT_CHOICE")[0].childNodes;
					 if (shortChoiceNode.length == 1) { var shortChoice = shortChoiceNode[0].nodeValue; }

					 var text = "";
					 var textNode = xml.getElementsByTagName("TEXT")[0].childNodes;
					 if (textNode.length == 1) { var text = textNode[0].nodeValue; }
					 
					 var shortText = "";
					 var shortTextNode = xml.getElementsByTagName("SHORT_TEXT")[0].childNodes;
					 if (shortTextNode.length == 1) { var shortText = shortTextNode[0].nodeValue; }

					 var date = xml.getElementsByTagName("DATE")[0].childNodes[0].nodeValue;
					 var author = xml.getElementsByTagName("AUTHOR")[0].childNodes[0].nodeValue;

					 
					 var transition = document.getElementById("transition_" + id_element);
					 transition.setAttribute("data-choice", choice);
					 transition.setAttribute("data-text", text);
					 transition.setAttribute("data-date", date);
					 transition.setAttribute("data-author", author);

					 transition.getElementsByClassName("transition_shortChoice")[0].innerHTML = shortChoice;
					 transition.getElementsByClassName("transition_shortText")[0].innerHTML = shortText;
					 transition.getElementsByClassName("transition_date")[0].innerHTML = date;
					 transition.getElementsByClassName("transition_author")[0].innerHTML = author;

					 updateTransitionForm();
				 }
			 };

			 xhttp.open ("POST", "scripts/save_edited_element.php", true);
			 xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

			 var sendStr = "";
			 var form = document.getElementById("transition_form");
			 sendStr += "type=transition";
			 sendStr += "&";
			 sendStr += "id_element=" + form.getElementsByClassName("transition_id_element")[0].value;
			 sendStr += "&";
			 sendStr += "from=" + form.getElementsByClassName("transition_from")[0].value;
			 sendStr += "&";
			 sendStr += "to=" + form.getElementsByClassName("transition_to")[0].value;
			 sendStr += "&";
			 sendStr += "choice=" + form.getElementsByClassName("transition_choice")[0].value;
			 sendStr += "&";
			 sendStr += "text=" + form.getElementsByClassName("transition_text")[0].value;

			 xhttp.send(sendStr);
		 }

		</script>
	</body>
</html>
