var data;
var orderNum = 1;
var current_id_element = null;

var close_message = "Données non enregistrées. Supprimer les modifications ?"
var reset_message = "Supprimer les modifications ?"
	
/* Get data from database */
var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function ()
{
	if (xhttp.readyState == 4 && xhttp.status == 200)
	{
		data = JSON.parse (this.responseText);
		displayData();
	}
};

xhttp.open("get", "scripts/get_editor_data.php", true);
xhttp.send();

/* Display all data */
function displayData ()
{
	var div_form = document.getElementById("div_form");
	var list = document.getElementById("list");

	/* Create list elements */
	for (var i in data)
	{
		var element = data[i];
		var id_element = element['id_element'];
		var type = element['type'];
	
		var label = null;
		if (type == 'situation') { label = element['name']; }
		if (type == 'transition') { label = element['from'] + ' -> ' + element['to']; }
		
		var a = $('<a>')
			.attr ('href', '#')
			.append (label)
			.click ({id_element: id_element},
					function (event)
					{
						openForm (event.data.id_element);
						displayForm (event.data.id_element);
					}
				   );
		
		var li = $('<li>')
			.attr ('id', 'li_'+id_element)
			.append (a);

		$('#list').append(li);
	}

	/* Create situation tabs */
	for (var i in data)
	{
		var element = data[i];
		var id_element = element['id_element'];
		var type = element['type'];

		if (type == 'situation')
		{
			var tab_group = $('<div>')
				.attr ('id', 'tab_group_'+id_element)
				.addClass ('tab_group');
			
			$('#div_tabs').append (tab_group);

			/* Tab structure */
			var tab_up = $('<div>')
				.addClass ('tab_up');

			tab_group.append (tab_up);

			var tab_middle = $('<div>')
				.addClass ('tab_middle');

			tab_group.append (tab_middle);

			var tab_down = $('<div>')
				.addClass ('tab_down');

			tab_group.append (tab_down);

			var tab = $('<div>')
				.addClass ('tab')
				.addClass ('tab_'+id_element)
				.hide ();

			tab_middle.append (tab);

			/* Situation tab */
			var displayButton = $('<button>')
				.attr ('type', 'button')
				.append (element['name'])
				.click ({id_element: id_element}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButton);

			var closeButton = $('<button>')
				.attr ('type', 'button')
				.append ("X")
				.click ({id_element: id_element}, function (event) { safeCloseForm (event.data.id_element); } );

			tab.append (closeButton);
		}
	}

	/* Create transition tabs */
	for (var i in data)
	{
		var element = data[i];
		var id_element = element['id_element'];
		var type = element['type'];

		if (type == 'transition')
		{
			var from = element['from'];
			var to = element['to'];

			/* To tab */
			var tab_down = $('#tab_group_'+from+' .tab_down');
			
			var tab = $('<div>')
				.addClass ('tab')
				.addClass ('tab_'+id_element)
				.hide ();

			tab_down.append (tab);

			var displayButtonTransition = $('<button>')
				.attr ('type', 'button')
				.append ('->')
				.click ({id_element: id_element}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButtonTransition);

			var displayButtonSituation = $('<button>')
				.attr ('type', 'button')
				.append (element['to'])
				.click ({id_element: element['to']}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButtonSituation);

			var closeButton = $('<button>')
				.attr ('type', 'button')
				.append ("X")
				.click ({id_element: id_element}, function (event) { safeCloseForm (event.data.id_element); } );

			tab.append (closeButton);

			/* From tab */
			var tab_up = $('#tab_group_'+to+' .tab_up');
			
			var tab = $('<div>')
				.addClass ('tab')
				.addClass ('tab_'+id_element)
				.hide ();

			tab_up.append (tab);

			var displayButtonSituation = $('<button>')
				.attr ('type', 'button')
				.append (element['from'])
				.click ({id_element: element['from']}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButtonSituation);

			var displayButtonTransition = $('<button>')
				.attr ('type', 'button')
				.append ('->')
				.click ({id_element: id_element}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButtonTransition);

			var closeButton = $('<button>')
				.attr ('type', 'button')
				.append ("X")
				.click ({id_element: id_element}, function (event) { safeCloseForm (event.data.id_element); } );

			tab.append (closeButton);
		}
	}

	/* Create forms */
	for (var i in data)
	{
		var element = data[i];
		var id_element = element['id_element'];
		var type = element['type'];
		
		var form = getElementForm (element);

		$('#div_form').append (form);
	}
}


function getElementForm (element)
{
	var id_element = element['id_element'];
	var type = element['type'];
	
	var form = $('<form>')
		.attr ('id', 'form_'+id_element)
		.addClass ('form')
		.hide ();

	var id_element_object = $('<input>')
		.attr ('name', 'id_element')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', id_element);
	
	form.append (getFormInput ('ID', id_element_object, true));

	var type_object = $('<input>')
		.attr ('name', 'type')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', type);
	
	form.append (getFormInput ('Type', type_object, false));

	var name_object = $('<input>')
		.attr ('name', 'name')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', element['name']);
		
	form.append (getFormInput ('Nom de la situation', name_object, type == 'situation'));

	var from_object = $('<input>')
		.attr ('name', 'from')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', element['from']);
	
	form.append (getFormInput ('Situation de départ', from_object, type == 'transition'))

	var to_object = $('<input>')
		.attr ('name', 'to')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', element['to']);
	
	form.append (getFormInput ('Situation d\'arrivée', to_object, type == 'transition'))

	var end_object = $('<input>')
		.attr ('name', 'end')
		.attr ('type', 'checkbox')
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );

	if (element['end'] == 1) { end_object.attr ('checked', ''); }
		
	form.append (getFormInput ('Situation finale', end_object, type == 'situation'));

	var choice_object = $('<input>')
		.attr ('name', 'choice')
		.attr ('type', 'text')
		.attr ('value', element['choice'])
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );
	
	form.append (getFormInput ('Choix proposé', choice_object, type == 'transition'))

	var text_object = $('<textarea>')
		.attr ('name', 'text')
		.attr ({rows: 10, cols: 80})
		.append (element['text'])
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );
	
	form.append (getFormInput ('Texte', text_object, true))

	form.append ('dernière modification le ' + element['date'] + ' par ' + element['author'] + '<br>');
	
	var saveButton = $('<button>')
		.attr ('class', 'save_button')
		.attr ('type', 'button')
		.attr ('disabled', '')
		.append ("Enregistrer (Ctrl-Return)")
		.click ({id_element: id_element}, function (event) { saveForm (event.data.id_element); } );

	form.append (saveButton);

	var resetButton = $('<button>')
		.attr ('class', 'reset_button')
		.attr ('type', 'button')
		.attr ('disabled', '')
		.append ("Annuler")
		.click ({id_element: id_element},
				function (event) { if (window.confirm(reset_message)) { resetForm (event.data.id_element); } }
			   );

	form.append (resetButton);

	return form;
}



function getFormInput (form_label, form_object, show)
{
	var form_input = $('<div>').addClass('form_input')
		.append($('<div>').addClass('form_label').append(form_label))
		.append($('<div>').addClass ('form_object').append(form_object));

	if (!show) { form_input.hide(); }

	return form_input;
}


function openForm (id_element)
{
	if (!$('.tab_'+id_element).is(":visible")) {
		$('.tab_'+id_element)
			.css ("order", orderNum.toString())
			.show ();
		orderNum++;
	}
}


function safeCloseForm (id_element)
{
	if (!isFormModified(id_element) || window.confirm(close_message))
	{
		closeForm (id_element);
		hideForm (id_element);
	}
}


function closeForm (id_element)
{
	$('.tab_'+id_element).hide();
	$('.tab_'+id_element).removeClass('modified');
	$('#form_'+id_element).remove();
	
	var form = getElementForm (data[id_element]);
	$('#div_form').append (form);
}

function displayForm (id_element)
{
	current_id_element = id_element;
	$('.form').hide();
	$('#form_'+id_element).show();
	
	var text = $('#form_'+id_element+' [name="text"]').val();
	$('#form_'+id_element+' [name="text"]').focus().val('').val(text);	
}

function hideForm (id_element)
{
	current_id_element = null;
	$('#form_'+id_element).hide();
}

function saveForm (id_element)
{
	var form = $('#form_'+id_element);
	var values = {
		id_element: form.find('[name="id_element"]').val(),
		type: form.find('[name="type"]').val(),
		text: form.find('[name="text"]').val(),
		end: form.find('[name="end"]').is(":checked") ? 1 : 0,
		choice: form.find('[name="choice"]').val()
	};

	$.post ('scripts/save_editor_element.php',
			values,
			function (element)
			{
				data[id_element] = element;
				resetForm (id_element);
			},
			'json');
}

function resetForm (id_element)
{
	$('#form_'+id_element).remove();			 

	var form = getElementForm (data[id_element]);
	$('#div_form').append (form);
	$('#form_'+id_element).show ();
	$('.tab_'+id_element).removeClass('modified');
}

function isFormModified (id_element)
{
	var current_text = data[id_element]['text'];
	if (current_text === null) { current_text = ''; }
	
	var current_choice = data[id_element]['choice'];
	if (current_choice === null) { current_choice = ''; }

	var current_end = (data[id_element]['choice'] == 1);

	var form = $('#form_'+id_element);
	return (form.find('[name="text"]').val() != current_text)
		|| (form.find('[name="end"]').is(":checked") != current_end)
		|| (form.find('[name="choice"]').val() != current_choice);
}

function checkForm (id_element)
{
	if (isFormModified (id_element))
	{
		$('.tab_'+id_element).addClass('modified');
		$('#form_'+id_element+' .save_button').attr('disabled',false);
		$('#form_'+id_element+' .reset_button').attr('disabled',false);
	}
	else {
		$('.tab_'+id_element).removeClass('modified');
		$('#form_'+id_element+' .save_button').attr('disabled','');
		$('#form_'+id_element+' .reset_button').attr('disabled','');
	}
}

shortcut.add ("ctrl+enter",
			  function () { if (isFormModified (current_id_element)) { saveForm (current_id_element); } }
			 );
