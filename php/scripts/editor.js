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
	/* Create HTML objects */
	var div_form = document.getElementById("div_form");
	var list = document.getElementById("list");

	/* Create list elements */
	for (var i in data)
	{
		var element = data[i];
		var id_element = element['id_element'];
		var type = element['type'];
	
		var label = null;
		if (type == 'situation') { label = '<span class="name_'+id_element+'">'+element['name']+'</span>'; }
		if (type == 'transition')
		{
			label = '<span class="name_'+data[element['id_from']]['id_element']+'">'+data[element['id_from']]['name']+'</span>'
				+ ' -> '
				+ '<span class="name_'+data[element['id_to']]['id_element']+'">'+data[element['id_to']]['name']+'</span>';
		}
		
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
				.append ($('<div>').addClass('name_'+id_element).append(element['name']))
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
			var id_from = element['id_from'];
			var id_to = element['id_to'];

			/* To tab */
			var tab_down = $('#tab_group_'+id_from+' .tab_down');
			
			var tab = $('<div>')
				.addClass ('tab')
				.addClass ('tab_'+id_element)
				.hide ();

			tab_down.append (tab);

			var displayButton = $('<button>')
				.attr ('type', 'button')
				.append ('-> '+data[element['id_to']]['name'])
				.click ({id_element: id_element}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButton);

			var closeButton = $('<button>')
				.attr ('type', 'button')
				.append ("X")
				.click ({id_element: id_element}, function (event) { safeCloseForm (event.data.id_element); } );

			tab.append (closeButton);

			/* From tab */
			var tab_up = $('#tab_group_'+id_to+' .tab_up');
			
			var tab = $('<div>')
				.addClass ('tab')
				.addClass ('tab_'+id_element)
				.hide ();

			tab_up.append (tab);

			var displayButton = $('<button>')
				.attr ('type', 'button')
				.append (data[element['id_from']]['name']+' ->')
				.click ({id_element: id_element}, function (event) { displayForm (event.data.id_element); } );
			
			tab.append (displayButton);

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
		.attr ('value', element['name'])
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );
		
	form.append (getFormInput ('Nom de la situation', name_object, type == 'situation'));

	var id_from_object = $('<select>')
		.attr ('name', 'id_from')
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );

	if (type == 'transition')
	{
		for (var i in data)
		{
			var element2 = data[i];
			if (element2['type'] == 'transition') continue;
			
			var option_object = $('<option>')
				.attr ('value', element2['id_element'])
				.text (element2['name']);

			if (element2['id_element'] == element['id_from']) { option_object.attr ('selected', 'selected'); }
			
			id_from_object.append (option_object);
		}
	}

	form.append (getFormInput ('Situation de départ', id_from_object, type == 'transition'))

	var id_to_object = $('<select>')
		.attr ('name', 'id_to')
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );

	if (type == 'transition')
	{
		for (var i in data)
		{
			var element2 = data[i];
			if (element2['type'] == 'transition') continue;
			
			var option_object = $('<option>')
				.attr ('value', element2['id_element'])
				.text (element2['name']);

			if (element2['id_element'] == element['id_to']) { option_object.attr ('selected', 'selected'); }
			
			id_to_object.append (option_object);
		}
	}

	form.append (getFormInput ('Situation d\'arrivée', id_to_object, type == 'transition'))

	var start_object = $('<input>')
		.attr ('name', 'start')
		.attr ('type', 'checkbox')
		.on ("input", {id_element: id_element}, function (event) { checkForm (event.data.id_element); } );

	if (element['start'] == 1) { start_object.attr ('checked', ''); }
	
	form.append (getFormInput ('Situation initiale', start_object, type == 'situation'));

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

		var element = data[id_element];

		if (element['type'] == 'transition')
		{
			openForm (element['id_from']);
			openForm (element['id_to']);
		}

		if (element['type'] == 'situation')
		{
			for (var i in data)
			{
				var element2 = data[i];
				if (element2['type'] == 'transition')
				{
					if (element2['id_from'] == id_element && $('.tab_'+element2['id_to']).is(":visible")) { openForm (element2['id_element']); }
					if (element2['id_to'] == id_element && $('.tab_'+element2['id_from']).is(":visible")) { openForm (element2['id_element']); }
				}
			}
		}
	}
}


function safeCloseForm (id_element)
{
	if (!isFormModified(id_element) || window.confirm(close_message))
	{
		closeForm (id_element);
		hideForm (id_element);

		var element = data[id_element];

		if (element['type'] == 'situation')
		{
			for (var i in data)
			{
				var element2 = data[i];
				if (element2['type'] == 'transition')
				{
					if (element2['id_from'] == id_element && $('.tab_'+element2['id_to']).is(":visible")) { safeCloseForm (element2['id_element']); }
					if (element2['id_to'] == id_element && $('.tab_'+element2['id_from']).is(":visible")) { safeCloseForm (element2['id_element']); }
				}
			}
		}
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
	var type = data[id_element]['type'];
	
	var values = {
		'id_element': form.find('[name="id_element"]').val(),
		'type': form.find('[name="type"]').val(),
		'name' : form.find('[name="name"]').val(),
		'id_from': form.find('[name="id_from"]').val(),
		'id_to': form.find('[name="id_to"]').val(),
		'start': form.find('[name="start"]').is(":checked") ? 1 : 0,
		'end': form.find('[name="end"]').is(":checked") ? 1 : 0,
		'choice': form.find('[name="choice"]').val(),
		'text': form.find('[name="text"]').val()
	};

	values['name'] = (values['name'] == '') ? null : values['name'];
	values['choice'] = (values['choice'] == '') ? null : values['choice'];
	values['text'] = (values['text'] == '') ? null : values['text'];

	if (type == 'transition')
	{
		values['start'] = null;
		values['end'] = null;
	}

	//alert(JSON.stringify(values));

	$.ajax({
		url: 'scripts/save_editor_element.php',
		type: 'POST',
		data: JSON.stringify (values),
		contentType: "application/json",
		success: function (element)
		{
			data[id_element] = element;
			resetForm (id_element);
		}
	});
}


function resetForm (id_element)
{
	$('#form_'+id_element).remove();			 

	var form = getElementForm (data[id_element]);
	$('#div_form').append (form);
	$('#form_'+id_element).show ();
	$('.tab_'+id_element).removeClass('modified');

	if (data[id_element]['type'] == 'situation') { $('.name_'+id_element).text (data[id_element]['name']); }
}


function isFormModified (id_element)
{
	var element = data[id_element];
	var form = $('#form_'+id_element);
	var modified = false;

	var current_name = element['name'];
	if (current_name === null) { current_name = ''; }
	if (form.find('[name="name"]').val() != current_name) { form.find('[name="name"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="name"]').closest('.form_object').removeClass('modified'); }

	var current_id_from = element['id_from'];
	if (form.find('[name="id_from"]').val() != current_id_from) { form.find('[name="id_from"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="id_from"]').closest('.form_object').removeClass('modified'); }

	var current_id_to = element['id_to'];
	if (form.find('[name="id_to"]').val() != current_id_to) { form.find('[name="id_to"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="id_to"]').closest('.form_object').removeClass('modified'); }

	var current_start = (element['start'] == 1);
	if (form.find('[name="start"]').is(":checked") != current_start) { form.find('[name="start"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="start"]').closest('.form_object').removeClass('modified'); }

	var current_end = (element['end'] == 1);
	if (form.find('[name="end"]').is(":checked") != current_end) { form.find('[name="end"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="end"]').closest('.form_object').removeClass('modified'); }

	var current_choice = element['choice'];
	if (current_choice === null) { current_choice = ''; }
	if (form.find('[name="choice"]').val() != current_choice) { form.find('[name="choice"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="choice"]').closest('.form_object').removeClass('modified'); }

	var current_text = element['text'];
	if (current_text === null) { current_text = ''; }
	if (form.find('[name="text"]').val() != current_text) { form.find('[name="text"]').closest('.form_object').addClass('modified'); modified = true; }
	else { form.find('[name="text"]').closest('.form_object').removeClass('modified'); }

	return modified;
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
