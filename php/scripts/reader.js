
// var current_page = null;
// var current_id = null;
// var current_text_array = null;
// var step_current = null;


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
var delay = null;
var element = null;
var step_current = null;
var next_elements = null;
var locked_elements = null;

var text_array = null;
var step = null;

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
				step_current = data.step_current;
				next_elements = data.next_elements;
				locked_elements = data.locked_elements;
			}
		});
	}

	text_array = element.text.split("[break]");
	if (stop && text_array.length == 1 && text_array[0] == '' && Object.keys(next_elements).length == 1 && !locked_elements)
	{
		$.each (next_elements, function (id, element)
				{
					setCurrentReading(id);
					initReading(null);
				}
			   );
	}

	else {
		step = 0;

		for (var s = 0; s < step_current; s++) { pursueReading (false); }
		pursueReading (stop);
	}
}

function finishedReading () { return step >= text_array.length; }

function pursueReading (stop)
{
	delay = 0;
	var text = text_array[step];
	step++;

	if (text != '') { printText (text, stop); }

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
					.click (
						function ()
						{
							setCurrentStep(step);
							$('#div_next_buttons').remove();
							pursueReading (true);
						}
					)
			);

			printButton (div_next_buttons, stop);
		}

		/* Add "next element" button else */
		else { addTransitionButtons (stop); }
	}
}


function addTransitionButtons (stop)
{
	var div_next_buttons = $('<div>').attr ('id', 'div_next_buttons')

	if (locked_elements)
	{
		var search_input = $('<input>')
			.attr ('name', 'search_input');
		
		div_next_buttons.append (search_input);

		var search_button = $('<button>')
			.attr ('type', 'button')
			.append ('Chercher')
			.click (function ()
					{
						var unlock = search_input.val();

						// Try to get new element
						$.ajax({
							async: false,
							type: 'POST',
							url: 'scripts/get_story_locked_element.php',
							data: JSON.stringify ({unlock: unlock}),
							success: function (d)
							{
								var data = JSON.parse (d);
								$.each (data.next_elements, function (id, element) { next_elements[element.id_element] = element; });
							}
						});

						$('#div_next_buttons').remove();
						delay = 0;
						addTransitionButtons(false);
					});
		
		div_next_buttons.append (search_button);
	}
	
	$.each (next_elements, function (id, element)
			{
				var choice = 'Continuer';
				if ("choice" in element && element.choice !== null && element.choice != '') { choice = element.choice; }

				var choice_button = $('<button>')
					.attr ('type', 'button')
					.append (choice)
					.click (function ()
							{
								$('#div_next_buttons').remove();
								setCurrentReading(id);
								initReading(null);
							})
				
				div_next_buttons.append (choice_button);
			}
		   );

	printButton (div_next_buttons, stop);
}

function setCurrentStep (step)
{
	$.ajax({
		async: false,
		url: 'scripts/set_story_current.php',
		type: 'POST',
		data: JSON.stringify ({step_current: step})
	});
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


function printText (text, stop)
{
	var paragraph = $('<div>')
		.addClass('story_paragraph');
	
	var div_text = $('.b-page-'+(current_page+2)+' .div_text');
	div_text.append (paragraph);

	var words = text.split(' ');

	for (var i = 0; i < words.length; i++)
	{
		if (div_text.outerHeight() > 550)
		{
			paragraph.children('.word').last().css('opacity',0);
			current_page++;
			if (i > 0) { i--; }
			
			if (current_page > page_number)
			{
				div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
				div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
			}

			paragraph = $('<div>')
				.addClass('story_paragraph');
			
			div_text = $('.b-page-'+(current_page+2)+' .div_text');
			div_text.append (paragraph);
		}

		paragraph.append (" ");
		
		var span_word = $('<span>')
			.addClass ('word')
			.append (words[i]);
		if (stop) { span_word.css ('color', 'white'); }
		paragraph.append (span_word);

		if (stop)
		{
			delay += 10;
			span_word.delay(delay).animate({color: 'black'}, 1000);
		}
	}
}



function printButton (button, stop)
{
	if (stop) { delay += 500; }
	var button2 = button.clone(true);
	var div_text = $('.b-page-'+(current_page+2)+' .div_text');
	div_text.delay(delay).queue (
		function (next)
		{
			var div_text = $(this);
			div_text.append(button);
			next();
			
			if (div_text.outerHeight() > 500)
			{
				div_text.children().last().remove();
				current_page++;
				if (current_page > page_number)
				{
					div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
					div_book.booklet ('add', (page_number++)+2, '<div class="div_text"></div>');
				}
				
				div_text = $('.b-page-'+(current_page+2)+' .div_text');
				div_text.append(button2);
			}
		});
}



/* Navigating among pages */

function goToPage (num) { div_book.booklet ('gotopage', num+2); }

div_book.bind ("bookletchange", function(event, data) { current_displayed = data.pages[0]; });

shortcut.add ("ctrl+enter",
			  function ()
			  {
				  if (current_displayed != current_page) { goToPage (current_page); }
			  }
			 );
