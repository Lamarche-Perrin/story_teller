
// var current_page = null;
// var current_id = null;
// var current_text_array = null;
// var current_step_array = null;


/* Get css style */
var style;

$.ajax({
	async: false,
	type: 'POST',
	url: 'css/booklet.css',
	success: function (d) { style = CSSJSON.toJSON(d).children.booklet.attributes; }
});


/* Create book */
var page_number = null;
var current_page = null;
var current_displayed = null;

var div_book = $('#div_book');
div_book.booklet (style);
div_book.booklet ('add', 2, '<div class="div_text"></div>');
div_book.booklet ('add', 3, '<div class="div_text"></div>');

page_number = 2;
current_page = 1;
current_displayed = -2;

/* Print cover */
$.ajax({
	type: 'POST',
	url: 'scripts/get_narrative_data.php',
	success: function (d)
	{
		var data = JSON.parse (d);
		var cover = $('#div_cover');

		var div_title = $('<div>')
			.attr ('id', 'div_title')
			.append (data.title);
		cover.append (div_title);

		var div_author = $('<div>')
			.attr ('id', 'div_author');
		$.each (data.members, function (id, member) { div_author.append (member.name + " ") } );
		cover.append (div_author);

		var div_date = $('<div>')
			.attr ('id', 'div_date')
			.append (data.date);
		cover.append (div_date);
	}
});


/* Print story path */
$.ajax({
	async: false,
	type: 'POST',
	url: 'scripts/get_story_path.php',
	success: function (d)
	{
		var data = JSON.parse (d);
		$.each (data.path, function (step, id)
				{
					initReading (data.elements[id]);
					while (!finishedReading()) { pursueReading (false); }
				}
			   );
	}
});



/* Read story */
var element = null;
var next_elements = null;
var text_array = null;
var step_array = null;

initReading (null);

function initReading (element)
{
	var stop = (element === null);

	if (stop)
	{		
		// Get data
		$.ajax({
			async: false,
			type: 'POST',
			url: 'scripts/get_story_element.php',
			success: function (d)
			{
				var data = JSON.parse (d);
				element = data.element;
				next_elements = data.next_elements;
			}
		});
	}

	text_array = element.text.split("[break]");
	//if (current_text_array == '') { current_text_array = []; }
	step_array = 0;

	pursueReading (stop);
}

function finishedReading () { return step_array >= text_array.length; }

function pursueReading (stop)
{
	var text = text_array[step_array];

	if (text != '')
	{
		var paragraph = $('<div>')
			.addClass('story_paragraph')
			.append(text);
		printText (paragraph);
	}
	step_array++;

	if (stop)
	{
		/* Add "pursue" boutton if break */
		if (!finishedReading())
		{
			var div_next_buttons = $('<div>').attr ('id', 'div_next_buttons')
			
			div_next_buttons.append(
				$('<button>')
					.attr ('type', 'button')
					.append ('Continuer')
					.click (function () { $('#div_next_buttons').remove(); pursueReading (true); })
			);

			printText (div_next_buttons);
		}

		/* Add "next element" button else */
		else {
			var div_next_buttons = $('<div>').attr ('id', 'div_next_buttons')
			
			$.each (next_elements, function (id, element)
					{
						var choice = 'Continuer';
						if ("choice" in element && element.choice !== null && element.choice != '') { choice = element.choice; }

						div_next_buttons.append(
							$('<button>')
								.attr ('type', 'button')
								.append (choice)
								.click (function ()
										{
											$('#div_next_buttons').remove();
											setCurrentReading(id);
											initReading(null);
										})
						);
					}
				   );

			printText (div_next_buttons);
		}
		
	}
}

function setCurrentReading (id)
{
	$.ajax({
		async: false,
		url: 'scripts/set_story_current.php',
		type: 'POST',
		data: JSON.stringify ({id_element: id})
	});
}


function printText (text)
{
	var text2 = text.clone(true);
	var div_text = $('.b-page-'+(current_page+2)+' .div_text');
	div_text.append (text);

	if (div_text.outerHeight() > 550)
	{
		div_text.children().last().remove();
		current_page++;
		if (current_page > page_number)
		{
			div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
			div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
		}
		
		printText (text2);
	}
}


function goToPage (num) { div_book.booklet ('gotopage', num+2); }

div_book.bind ("bookletchange", function(event, data) { current_displayed = data.pages[0]; });

shortcut.add ("ctrl+enter",
			  function ()
			  {
				  if (current_displayed != current_page) { goToPage (current_page); }
			  }
			 );


	// var textArray = text.split("[break]");

	// if (textArray[step] != "NULL")
	// {
	// 	//document.getElementById("book").innerHTML += textArray[step] + "<BR>\n<BR>\n";

	// 	var currentText = document.getElementById("page"+pageNb).innerHTML;
	// 	document.getElementById("page"+pageNb).innerHTML += textArray[step] + "<BR>\n<BR>\n";
	// 	var pageHeight = document.getElementById("page"+pageNb).offsetHeight;
	// 	if (pageHeight > 550)
	// 	{
	// 		document.getElementById("page"+pageNb).innerHTML = currentText;
			
	// 		pageNb = pageNb+1;
	// 		if (pageNb % 2 == 0) { nextPage = true; }
	// 		$("#div_book").booklet("add",pageNb,"<div id=\"page" + pageNb + "\" align=\"justify\">" + textArray[step] +  "<BR>\n<BR>\n" + "</div>");
	// 	}
	// 	//alert(numberOfLines);
	// 	//$("#div_book").booklet("option","width",1000);
	// }



// var xml;
// var pageNb = 3;
// var closedBook = true;
// var nextPage = false;
// var nextButton = "";

// function next (id_current)
// {
// 	var xhttp = new XMLHttpRequest();
// 	xhttp.onreadystatechange = function ()
// 	{
// 		if (xhttp.readyState == 4 && xhttp.status == 200)
// 		{
// 			xml = xhttp.responseXML;
// 			print(0);
// 		}
// 	};

// 	xhttp.open ("POST", "scripts/get_next_situation.php", true);
// 	xhttp.setRequestHeader ("Content-type", "application/x-www-form-urlencoded");

// 	if (id_current != null) { xhttp.send("id_current="+id_current); }
// 	else { xhttp.send (); }
// }

// function turnPage ()
// {			 
// 	nextPage = false;
// 	closedBook = false;
// 	document.getElementById("page").innerHTML = nextButton;
// 	document.getElementById("button").focus();
// 	$("#div_book").booklet("next");
// }

// function print (step)
// {
// 	var text = xml.getElementsByTagName("TEXT")[0].childNodes[0].nodeValue;

// 	var textArray = text.split("[break]");

// 	if (textArray[step] != "NULL")
// 	{
// 		//document.getElementById("book").innerHTML += textArray[step] + "<BR>\n<BR>\n";

// 		var currentText = document.getElementById("page"+pageNb).innerHTML;
// 		document.getElementById("page"+pageNb).innerHTML += textArray[step] + "<BR>\n<BR>\n";
// 		var pageHeight = document.getElementById("page"+pageNb).offsetHeight;
// 		if (pageHeight > 550)
// 		{
// 			document.getElementById("page"+pageNb).innerHTML = currentText;
			
// 			pageNb = pageNb+1;
// 			if (pageNb % 2 == 0) { nextPage = true; }
// 			$("#div_book").booklet("add",pageNb,"<div id=\"page" + pageNb + "\" align=\"justify\">" + textArray[step] +  "<BR>\n<BR>\n" + "</div>");
// 		}
// 		//alert(numberOfLines);
// 		//$("#div_book").booklet("option","width",1000);
// 	}

// 	var button = "";
// 	step = step+1;
// 	if (step < textArray.length)
// 	{
// 		button = "<button id=\"button\" type=\"button\" onClick=\"print("+step+")\">Continuer</button>";
// 	}

// 	else {
// 		var transitions = xml.getElementsByTagName("TRANSITION");
// 		for (var i = 0; i < transitions.length; i++)
// 		{
// 			var id_to = transitions[i].getElementsByTagName("ID_TO")[0].childNodes[0].nodeValue;

// 			var choice = "Continuer";
// 			if (transitions[i].getElementsByTagName("CHOICE").length != 0)
// 			{ choice = transitions[i].getElementsByTagName("CHOICE")[0].childNodes[0].nodeValue; }
// 			button += "<button id=\"button\" type=\"button\" onClick=\"next('"+id_to+"')\">"+choice+"</button>";
// 		}
// 	}
	
// 	//if (closedBook)
// 	//{
// 	//	 nextButton = button;
// 	//	 document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Ouvrir</button>";
// 	//}
	

// 	//else
// 	if (nextPage)
// 	{
// 		nextButton = button;
// 		document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Tourner la page</button>";
// 	}

// 	else { document.getElementById("page").innerHTML = button; }

// 	document.getElementById("button").focus();
// }

// </script>

// 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
// 	<script>window.jQuery || document.write('<script src="booklet/jquery-2.1.0.min.js"><\/script>')</script>
// 	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
// 	<script>window.jQuery.ui || document.write('<script src="booklet/jquery-ui-1.10.4.min.js"><\/script>')</script>
// 	<script src="booklet/jquery.easing.1.3.js"></script>
// 	<script src="booklet/jquery.booklet.latest.js"></script>

// 	<script>
// 	$(function () {
// 		$("#div_book").booklet();
// 		$("#div_book").booklet({ closed: true, autoCenter: true, covers: true, pagePadding: 30, width:800, height:600,
// 							 tabs: true, nextControlText: "Suivant", previousControlText: "Précédent", nextControlTitle: "Page suivante",
// 							 previousControlTitle: "Page précédente", shadows: true, speed: 1500});

// 		if (closedBook)
// 		{
// 			nextButton = "<button id=\"button\" type=\"button\" onClick=\"next(null)\">Commencer</button>";
// 			document.getElementById("page").innerHTML = "<button id=\"button\" type=\"button\" onClick=\"turnPage()\">Ouvrir</button>";
// 			document.getElementById("button").focus();
// 		}
// 		else { next(null); }
		
// 	});
