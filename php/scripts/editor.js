
/* Global variables */
var selected_id = null;
var overed_id = null;
var displayed_id = null;
var start_id = null;
var added_id = 1;
var graphPadding = 50;

/* Messages */
var close_message = "Données non enregistrées. Supprimer les modifications ?"
var reset_message = "Supprimer les modifications ?"
var delete_situation_message = "Supprimer cette situation ainsi que les éventuelles transitions associées ?"
var delete_transition_message = "Supprimer cette transition ?"
var error_form = "Erreurs dans le formulaire : impossible d'enregistrer."
var error_forms = "Certains éléments n'ont pas pu être enregistrés (erreurs possibles dans les formulaires)."
var error_empty_name = "Entrez un nom pour cette situation.";
var error_taken_name = "Ce nom de situation est déjà pris.";
var error_taken_start = "Il existe une autre situation initiale.";
var error_no_start = "Il n'y a pas de situation initiale dans cette narration.";
var error_unlock_format = "Format attendu : \"mot\" \"autre mot\" \"et cætera\" (tout en minuscule)";

(function($){$.event.special.destroyed={remove:function(o){if(o.handler){o.handler()}}}})(jQuery)

/* Get narrative data */
$.ajax({
	type: 'POST',
	url: 'scripts/get_narrative_data.php',
	success: function (d)
	{
		var narrative_data = JSON.parse (d);
		$.each (narrative_data, function (i, narrative) { $('#div_narrative').append(narrative.title); });
	}
});

/* Get data from database */
var jsongraph;
$.ajax({
	async: false,
	type: 'POST',
	url: 'scripts/get_graph_data.php',
	success: function (d) { jsongraph = JSON.parse (d); }
});

/* Get css style */
var style;
$.ajax({
	async: false,
	type: 'POST',
	url: 'css/cytograph.css',
	success: function (d) { style = d; }
});

/* Create cytograph */
var i = 0;
var colayout = { name: 'cola', fit: false, padding: graphPadding };

var cytograph = cytoscape (
	{
		container: $('#div_graph'),
		elements: jsongraph,
		style: style,
		layout: colayout
	}
);

start_id = cytograph.nodes('[name="start"]').id();

setupGraph (0, cytograph);

function setupGraph (id, graph)
{
	graph.userZoomingEnabled (false);
	graph.userPanningEnabled (false);
	graph.on ('layoutstop', function (event) { graph.fit(graph.$(),graphPadding); });
	graph.on ('add remove', '*', {}, function (event) { graph.fit(graph.$(),graphPadding); graph.layout(colayout); });
	graph.on ('position', '*', {}, function (event) { graph.fit(graph.$(),graphPadding); });
	graph.on ('free', '*', {}, function (event) { graph.layout(colayout); });
}


/* Create cytograph */
// var egograph = new Object();
// cytograph.elements().each ( function (i, element) { addEgograph (element.id()); });

// function addEgograph (id)
// {
// 	var element = cytograph.getElementById (id);
	
// 	var div_egograph = $('<div>')
// 		.attr ('id', 'egograph_'+id)
// 		.addClass ('egograph');
	
// 	$('#div_egograph').append(div_egograph);

// 	var egoelements = [];

// 	if (element.data('type') == 'situation')
// 	{
// 		element.closedNeighborhood().each (
// 			function (j, element_bis)
// 			{
// 				if (element_bis.isNode())
// 					egoelements.push ({ data: { id: element_bis.id(), name: element_bis.data('name') } });

// 				if (element_bis.isEdge())
// 					egoelements.push ({ data: { id: element_bis.id(), source: element_bis.data('source'), target: element_bis.data('target') } });
// 			}
// 		);
// 	}

// 	else if (element.data('type') == 'transition')
// 	{
// 		egoelements.push ({ data: { id: element.source().id(), name: element.source().data('name') } });
// 		egoelements.push ({ data: { id: element.target().id(), name: element.target().data('name') } });
// 		egoelements.push ({ data: { id: element.id(), source: element.data('source'), target: element.data('target') } });
// 	}

// 	egograph[id] = cytoscape (
// 		{
// 			container: $('#egograph_'+id),
// 			elements: egoelements,
// 			style: style,
// 			layout: colayout
// 		}
// 	);

// 	setupGraph (id, egograph[id]);

// 	div_egograph.hide();
// }



/* Create forms */
cytograph.elements().each (
	function (i, element)
	{
		var form = getForm(element.id()).hide();
		$('#div_form').append(form);
	}
);

/* Add buttons */
var new_transtition_and_situation_button = $('<button>')
	.attr ('id', 'new_transition_and_situation_button')
	.attr ('type', 'button')
	.attr ('disabled', true)
	.append ('Ajouter situation (sur situation)')
	.click ({}, function ()
			{
				newForm ('transition', false);
				newForm ('situation', true);
			});

$('#div_buttons')
	.append (new_transtition_and_situation_button)
	.append ('<br>');

var new_transition_button = $('<button>')
	.attr ('id', 'new_transition_button')
	.attr ('type', 'button')
	.attr ('disabled', true)
	.append ('Ajouter transition (sur situation)')
	.click ({}, function () { newForm ('transition', false); });

$('#div_buttons')
	.append (new_transition_button)
	.append ('<br>');

var new_situation_button = $('<button>')
	.attr ('id', 'new_situation_button')
	.attr ('type', 'button')
	.append ('Ajouter situation (isolée)')
	.click (function () { newForm ('situation', false); });

$('#div_buttons')
	.append (new_situation_button)
	.append ('<br>');

var new_end_situation_button = $('<button>')
	.attr ('id', 'new_end_situation_button')
	.attr ('type', 'button')
	.attr ('disabled', true)
	.append ('Ajouter situation (sur transition)')
	.click ({}, function () { newForm ('situation', true); });

$('#div_buttons')
	.append (new_end_situation_button)
	.append ('<br>');

var save_all_button = $('<button>')
	.attr ('id', 'save_all_button')
	.attr ('type', 'button')
	.append ('Enregistrer tout')
	.click ({},
			function ()
			{
				var error = false;

				cytograph.elements().each (
					function (i, element)
					{
						var id = element.id();
						var check = checkForm (id);
						if (check == 'error') { error = true; }
						else if (check == 'modified') { saveForm (id); }
					}
				);

				if (error) { alert (error_forms); }
			}
		   );

$('#div_buttons')
	.append (save_all_button)
	.append ('<br>');

var read_narrative_button = $('<button>')
	.attr ('id', 'read_narrative_button')
	.attr ('type', 'button')
	.append ('Lire narration')
	.click ({},
			function ()
			{
				resetStory ();
				readElement (start_id);
				selectElement (start_id);
				displayForm (start_id, true);
			}
		   );

$('#div_buttons')
	.append (read_narrative_button)
	.append ('<br>');




/* Dynamics of elements */

cytograph.on ('tap', '*', {}, function (event) { toggleElement (event.cyTarget.id()); });
cytograph.on ('tapdragover', '*', {}, function (event) { enterElement (event.cyTarget.id(), true); });
cytograph.on ('tapdragout', '*', {}, function (event) { leaveElement (event.cyTarget.id(), true); });
$('#div_graph').on ('mouseleave', function (event) { if (overed_id !== null) { leaveElement (overed_id); } });

// for (var i in egograph)
// {
// 	egograph[i].on ('tap', '*', {}, function (event) { toggleElement (event.cyTarget.id()); });
// 	egograph[i].on ('tapdragover', '*', {}, function (event) { enterElement (event.cyTarget.id(), false); });
// 	egograph[i].on ('tapdragout', '*', {}, function (event) { leaveElement (event.cyTarget.id(), false); });
// 	$('#egograph_'+i).on ('mouseleave', function (event) { if (overed_id !== null) { leaveElement (overed_id); } });
// }

function enterElement (id, main)
{
	overed_id = id;
	
	/* Make all corresponding objects overed */
	cytograph.getElementById(id).addClass('overed');
	$('.element_'+id).addClass('overed');
	// for (var i in egograph)
	// {
	// 	egograph[i].getElementById(id).addClass('overed');
	// }

	/* Display Form */
	if (selected_id !== null) { hideForm (selected_id, main); }
	displayForm (id, main);
}

function leaveElement (id, main)
{
	overed_id = null;
	
	/* Make all corresponding objects unovered */
	cytograph.getElementById(id).removeClass('overed');
	$('.element_'+id).removeClass('overed');
	// for (var i in egograph)
	// {
	// 	egograph[i].getElementById(id).removeClass('overed');
	// }

	/* Hide Form */
	hideForm (id, main);
	if (selected_id !== null) { displayForm (selected_id, main); }
}


function toggleElement (id)
{
	var element = cytograph.getElementById (id);
	if (selected_id == id) { unselectElement (id); } else { selectElement (id); }
}


function selectElement (id)
{
	if (selected_id !== null) { hideForm (selected_id, true); }
	selected_id = id;
	var element = cytograph.getElementById (id);

	/* Make all corresponding objects selected or unselected */
	cytograph.$('.selected').removeClass('selected');
	$('.link_element.selected').removeClass('selected');	

	element.addClass('selected');
	$('.element_'+id).addClass('selected');
	// for (var i in egograph)
	// {
	// 	egograph[i].$('.selected').removeClass('selected');
	// 	egograph[i].getElementById(id).addClass('selected');
	// }

	/* Enable or disable edit buttons */
	if (element.data('type') == 'situation')
	{
		$('#new_transition_button').attr('disabled',false);	
		$('#new_transition_and_situation_button').attr('disabled',false);
		$('#new_end_situation_button').attr('disabled',true);
	}
	
	else if (element.data('type') == 'transition')
	{
		$('#new_transition_button').attr('disabled',true);
		$('#new_transition_and_situation_button').attr('disabled',true);
		$('#new_end_situation_button').attr('disabled',false);
	}

	displayForm (id, true);
}


function unselectElement (id)
{
	var element = cytograph.getElementById (id);
	selected_id = null;

	/* Make corresponding objects unselected */	
	element.removeClass('selected');
	// for (var i in egograph) { egograph[i].$('.selected').removeClass('selected'); }

	$('.element_'+id).removeClass('selected');
	if (element.data('type') == 'situation')
	{
		$('#new_transition_button').attr('disabled',true);
		$('#new_transition_and_situation_button').attr('disabled',true);
		$('#new_end_situation_button').attr('disabled',true);
	}
}


function getLinkElement (id)
{
	var element = cytograph.getElementById (id);

	var link_element = $('<span>')
		.addClass ('link_element element_'+id)
		.click (function () { toggleElement (id); })
		.on ('mouseenter', {}, function () { enterElement (id, true); })
		.on ('mouseleave', {}, function () { leaveElement (id, true); });
	link_element.bind('destroyed', function() { leaveElement (id, true); })
	
	if (element.data('type') == 'situation')
	{
		link_element
			.append ('[')
			.append (getSpanName (id))
			.append (']');
	}

	else if (element.data('type') == 'transition')
	{
		link_element
			.append ('[')
			.append (getSpanName (element.data('source')).addClass ('name_source'))
			.append (' -> ')
			.append (getSpanName (element.data('target')).addClass ('name_target'))
			.append (']');
	}

	if (element.hasClass('overed')) { link_element.addClass('overed'); }
	if (element.hasClass('selected')) { link_element.addClass('selected'); }
	
	return link_element;
}


function getSpanName (id)
{
	return $('<span>')
		.addClass('name_'+id)
		.append(cytograph.getElementById(id).data('name'));
}


function formatText (text)
{
	if (text == '') { text = '<i>[pas de texte]</i>'; }
	text = text.replace (/\[break\]/g,'<br><br><i>[break]</i><br><br>');
	text = text.replace (/(?:\r\n(\r\n)+|\r\r+|\n\n+)/g,'<br><br>');
	
	format_search = [
			/\[b\](.*?)\[\/b\]/ig,
			/\[i\](.*?)\[\/i\]/ig,
			/\[u\](.*?)\[\/u\]/ig
	];

	format_replace = [
		'<strong>$1</strong>',
		'<em>$1</em>',
		'<span style="text-decoration: underline;">$1</span>'
	];

	for (var i = 0; i < format_search.length; i++) { text = text.replace (format_search[i], format_replace[i]); }
	return text;
}


function formatUnlock (unlock)
{
	var unlock_array = unlock.match(/\w+|"[^"]+"/g);
	var i = unlock_array.length;
	while (i--) { unlock_array[i] = unlock_array[i].replace(/"/g,""); }
	return '<i>[révélé par : "' + unlock_array.join('", "') + '"]</i>';
}

/* FORM FUNCTIONS */

function newForm (type, endSituation)
{
	var id;
	$.ajax({
		async: false,
		url: 'scripts/new_graph_data.php',
		type: 'POST',
		data: JSON.stringify ({type: type}),
		success: function (d)
		{
			var data = JSON.parse (d);
			id = data.id;
		}
	});

	if (type == 'situation')
	{
		while (cytograph.elements('[name=\'new_situation_' + added_id + '\']').length > 0) { added_id++; }
		var name = "new_situation_"+added_id;

		var element = {
			data: {
				id: id,
				type: "situation",
				name: name,
				start: "0",
				end: "0",
				text: "",
				mod_type: "new",
				mod_date: null,
				mod_name: null
			}
		}
		element.data.save = JSON.parse(JSON.stringify(element.data));
		// element.data.save.start = null;
		// element.data.save.end = null;
		// element.data.save.text = null;

		/* Add options in lists */
		var option_object = $('<option>')
			.attr ('value', id)
			.text (name);
		
		$('select[name="source"]').append (option_object.clone());
		$('select[name="target"]').append (option_object.clone());
	}

	if (type == 'transition')
	{
		if (selected_id === null) return;
		var situation = cytograph.getElementById (selected_id);
		if (situation.data('type') != 'situation') return;
		
		var element = {
			data: {
				id: id,
				type: "transition",
				source: situation.id(),
				target: situation.id(),
				choice: "",
				unlock: "",
				text: "",
				mod_type: "new",
				mod_date: null,
				mod_name: null
			}
		}
		element.data.save = JSON.parse(JSON.stringify(element.data));
		// element.data.save.source = null;
		// element.data.save.target = null;
		// element.data.save.choice = null;
		// element.data.save.unlock = null;
		// element.data.save.text = null;
	}

	element = cytograph.add(element);
	// addEgograph (id);
	
	if (type == 'situation' && endSituation && selected_id !== null)
	{
		var transition = cytograph.getElementById (selected_id);
		$('#form_'+transition.id()+' [name="target"]').val(id);
		checkForm (transition.id());
	}
	
	var form = getForm(element.id()).hide();
	$('#div_form').append(form);

	selectElement (element.id());
	displayForm (element.id(), true);
}


function getForm (id)
{
	var element = cytograph.getElementById (id);

	/* form */
	var form = $('<form>')
		.attr ('id', 'form_'+element.id())
		.addClass ('form');

	/* id */
	var id_object = $('<input>')
		.addClass ('input_id')
		.attr ('name', 'id')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', element.id());
	
	form.append (getFormInput ('ID', id_object).hide());

	/* type */
	var type_object = $('<input>')
		.addClass ('input_type')
		.attr ('name', 'type')
		.attr ('type', 'text')
		.attr ('disabled', '')
		.attr ('value', element.data('save').type);
	
	form.append (getFormInput ('Type', type_object).hide());

	/* name */
	if (element.data('type') == 'situation')
	{
		var name_object = $('<input>')
			.addClass ('input_name')
			.attr ('name', 'name')
			.attr ('type', 'text')
			.attr ('value', element.data('save').name)
			.on ("input", {}, function () { checkForm (id); } );
		
		form.append (getFormInput ('Nom de la situation', name_object));
	}

	/* source */
	if (element.data('type') == 'transition')
	{
		var source_object = $('<select>')
			.addClass ('input_source')
			.attr ('name', 'source')
			.on ("input", {}, function () { checkForm (id); } );

		cytograph.nodes().each ( // COULD BE IMPROVED!
			function (i, element_bis)
			{
				var option_object = $('<option>')
					.attr ('value', element_bis.id())
					.text (element_bis.data('name')); // COULD BE PROBLEMATIC IF NOT ALL SITUATIONS IN DATA?
				
				if (element_bis.id() == element.data('save').source) { option_object.attr ('selected', 'selected'); }
				
				source_object.append (option_object);
			}
		);

		form.append (getFormInput ('Situation de départ', source_object));
	}

	/* target */
	if (element.data('type') == 'transition')
	{
		var target_object = $('<select>')
			.addClass ('input_target')
			.attr ('name', 'target')
			.on ("input", {}, function () { checkForm (id); } );

		cytograph.nodes().each ( // COULD BE IMPROVED!
			function (i, element_bis)
			{
				var option_object = $('<option>')
					.attr ('value', element_bis.id())
					.text (element_bis.data('name')); // COULD BE PROBLEMATIC IF NOT ALL SITUATIONS IN DATA?
				
				if (element_bis.id() == element.data('save').target) { option_object.attr ('selected', 'selected'); }
				
				target_object.append (option_object);
			}
		);

		form.append (getFormInput ('Situation d\'arrivée', target_object));
	}

	/* end */
	if (element.data('type') == 'situation')
	{
		var end_object = $('<input>')
			.addClass ('input_end')
			.attr ('name', 'end')
			.attr ('type', 'checkbox')
			.on ("input", {}, function () { checkForm (id); } );

		if (element.data('save').end == 1) { end_object.attr ('checked', ''); }
		
		form.append (getFormInput ('Situation finale', end_object));
	}

	/* choice */
	if (element.data('type') == 'transition')
	{
		var choice_object = $('<input>')
			.addClass ('input_choice')
			.attr ('name', 'choice')
			.attr ('type', 'text')
			.attr ('value', element.data('save').choice)
			.on ("input", {}, function () { checkForm (id); } );
		
		form.append (getFormInput ('Choix proposé', choice_object))
	}

	/* unlock */
	if (element.data('type') == 'transition')
	{
		var unlock_object = $('<input>')
			.addClass ('input_unlock')
			.attr ('name', 'unlock')
			.attr ('type', 'text')
			.attr ('value', element.data('save').unlock)
			.on ("input", {}, function () { checkForm (id); } );
		
		form.append (getFormInput ('Mots-clés pour débloquer', unlock_object))
	}

	/* text */
	var text_object = $('<textarea>')
		.addClass ('input_text')
		.attr ('name', 'text')
		.append (element.data('save').text)
		.on ("input", {}, function () { checkForm (id); } );
	
	form.append (getFormInput ('Texte', text_object))

	/* mod */
	var mod_str = null;
	if (element.data('mod_type') == 'new')
	{ form.append (element.data('type') + ' non enregistrée<br>'); }
	else {
		if (element.data('mod_type') == 'create') { mod_str = 'créé'; }
		if (element.data('mod_type') == 'modify') { mod_str = 'dernière modification'; }
		form.append (mod_str + ' le ' + element.data('mod_date') + ' par ' + element.data('mod_name') + '<br>');
	}

	/* buttons */
	var saveButton = $('<button>')
		.addClass ('save_button')
		.attr ('type', 'button')
		.attr ('disabled', true)
		.append ("Enregistrer modifications (Ctrl+S)")
		.click ({}, function () { saveForm (id); } );

	form.append (saveButton)
		.append ('<br>');

	var resetButton = $('<button>')
		.addClass ('reset_button')
		.attr ('type', 'button')
		.attr ('disabled', true)
		.append ("Annuler modifications (Ctrl+Backspace)")
		.click ({}, function () { safeResetForm (id); } );

	form.append (resetButton)
		.append ('<br>');

	var deleteButton = $('<button>')
		.addClass ('delete_button')
		.attr ('type', 'button')
		.append ("Supprimer " + element.data('type') + " (Ctrl+Delete)")
		.click ({}, function () { safeDeleteForm (id); } );

	form.append (deleteButton)
		.append ('<br>');
	
	var readButton = $('<button>')
		.addClass ('read_button')
		.attr ('type', 'button')
		.append ('Lire ' + element.data('type') + " (Ctrl+Return)")
		.click ({}, function () { resetStory (); readElement (id); } );

	form.append (readButton)
		.append ('<br>');

	return form;
}



function getFormInput (form_label, form_object)
{
	var form_input = $('<div>').addClass('form_input')
		.append($('<div>').addClass('form_label').append(form_label))
		.append($('<div>').addClass ('form_object').append(form_object))
		.append($('<div>').addClass ('form_error'));

	return form_input;
}



/* INTERACTION FUNCTIONS */


/* Dynamics of forms */

function displayForm (id, main)
{
	var element = cytograph.getElementById (id);
	displayed_id = id;
	$('#form_'+id).show();

	// if (main)
	// {
	// 	$('#egograph_'+id).show();
	// 	egograph[id].fit(egograph[id].$(),graphPadding);
	// }
	
	/* Give focus to end of text field */
	// if (element.data('type') == 'situation')
	// {
	// 	var text = $('#form_'+id+' [name="text"]').val();
	// 	$('#form_'+id+' [name="text"]').focus().val('').val(text);		
	// }
	
	checkForm (id);	
}


function hideForm (id, main)
{
	var element = cytograph.getElementById (id);
	displayed_id = null;
	$('#form_'+id).hide();
	// if (main) { $('#egograph_'+id).hide(); }
}


function checkForm (id)
{
	var element = cytograph.getElementById (id);
	var modified = false;
	var error = false;
	var important_change = false;
	var form = $('#form_'+id);

	/* Check new */
	if (element.data('mod_type') == 'new') { modified = true; }
	
	/* Check name */
	if (element.data('type') == 'situation')
	{
		var name_field = form.find('[name="name"]');
		var name_object = name_field.closest('.form_object');
		var name_error = name_object.closest('.form_input').find('.form_error');
		var name = name_field.val();
		name_error.text('');

		if (name != element.data('name'))
		{
			name_object.removeClass('error');
			
			/* Update element in graph */
			element.data('name',name);
			// for (var i in egograph) { egograph[i].getElementById(id).data('name',name); }

			/* Update options in list */
			$('select[name="source"] option[value="'+id+'"]').text(name);
			$('select[name="target"] option[value="'+id+'"]').text(name);

			/* Update names in other places */
			$('.name_'+id).text (name);

			/* Modified */
			if (element.data('name') != element.data('save').name)
			{
				name_object.addClass('modified');
				modified = true;
			}
			else { name_object.removeClass('modified'); }

			/* Empty name */
			if (element.data('name') == '')
			{
				name_error.text (error_empty_name);
				name_object.addClass('error');
				error = true;
			}

			/* Taken name */
			cytograph.nodes().each (
				function (i, element_bis)
				{
					if ($('#form_'+element_bis.id()).find('[name="name"]').val() == element.data('name') && element_bis.id() != id)
					{
						name_error.text (error_taken_name);
						name_object.addClass('error');
						error = true;
					}
				}
			);

			/* No start */
			if (element.data('name') != 'start')
			{
				var noStart = true;
				cytograph.nodes().each (function (i, element_bis) { if (element_bis.data('name') == 'start') { noStart = false; } });

				if (noStart)
				{
					name_error.text (error_no_start);
					name_object.addClass('error');
					error = true;
				}
			}
			else { start_id = id; }
		}

		if (name_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { name_object.addClass('modified'); modified = true; }

		if (name_object.hasClass('error')) { error = true; }
	}

	/* Check source */
	if (element.data('type') == 'transition')
	{
		var source_field = form.find('[name="source"]');
		var source_object = source_field.closest('.form_object');
		var source_error = source_object.closest('.form_input').find('.form_error');
		var source = source_field.val();
		source_error.text('');

		if (source != element.data('source'))
		{
			source_object.removeClass('error');

			important_change = true;
			var oldSource = element.source().id();
			var target = element.target().id();

			/* Update names in other places */
			$('.element_'+id+' .name_source.name_'+oldSource).replaceWith(getSpanName(source).addClass('name_source'));

			/* Suppress target in egograph of old source */
			// var egoOldSource = egograph[oldSource];
			
			// egoOldSource.getElementById(id).remove();
			
			// if (target != oldSource && !egoOldSource.getElementById(target).allAreNeighbors(egoOldSource.getElementById(oldSource)))
			// { egoOldSource.getElementById(target).remove(); }

			/* Change source in egograph of edge */
			// var egoedge = egograph[id];

			// if (egoedge.getElementById(source).empty())
			// {
			// 	egoedge.add({ data: {id: source, name: cytograph.getElementById(source).data('name')}});
			// 	egoedge.getElementById(source).classes(cytograph.getElementById(source).json().classes);
			// }

			// egoedge.getElementById(id).move({source: source});

			// if (target != oldSource)
			// { egoedge.getElementById(oldSource).remove(); }
			
			/* Add source in egograph of target */
			// var egotarget = egograph[target];
			
			// if (egotarget.getElementById(source).empty())
			// {
			// 	egotarget.add({ data: {id: source, name: cytograph.getElementById(source).data('name') }});
			// 	egoedge.getElementById(source).classes(cytograph.getElementById(source).json().classes);
			// }

			// if (egotarget.getElementById(id).empty())
			// {
			// 	egotarget.add({ data: {id: id, source: source, target: target }});
			// 	egoedge.getElementById(id).classes(cytograph.getElementById(id).json().classes);
			// }
			// else { egotarget.getElementById(id).move({source: source}); }
			
			// if (oldSource != target && !egotarget.getElementById(oldSource).allAreNeighbors(egotarget.getElementById(target)))
			// { egotarget.getElementById(oldSource).remove(); }

			/* Add target in egograph of new source */
			// var egosource = egograph[source];
			
			// if (egosource.getElementById(target).empty())
			// {
			// 	egosource.add({ data: {id: target, name: cytograph.getElementById(target).data('name') }});
			// 	egoedge.getElementById(target).classes(cytograph.getElementById(target).json().classes);
			// }

			// if (egosource.getElementById(id).empty())
			// {
			// 	egosource.add({ data: {id: id, source: source, target: target }});
			// 	egoedge.getElementById(id).classes(cytograph.getElementById(id).json().classes);
			// }
			// else { egosource.getElementById(id).move({source: source}); }
			
			/* Modify global graph */
			element = element.move({source: source});

			/* Modified */
			if (element.data('source') != element.data('save').source) { source_object.addClass('modified'); modified = true; }
			else { source_object.removeClass('modified'); }
		}

		if (source_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { source_object.addClass('modified'); modified = true; }

		if (source_object.hasClass('error')) { error = true; }
	}

	/* Check target */
	if (element.data('type') == 'transition')
	{
		var target_field = form.find('[name="target"]');
		var target_object = target_field.closest('.form_object');
		var target_error = target_object.closest('.form_input').find('.form_error');
		var target = target_field.val();
		target_error.text('');

		if (target != element.data('target'))
		{
			target_object.removeClass('error');

			important_change = true;
			var oldTarget = element.target().id();
			var source = element.source().id();
			
			/* Update names in other places */
			$('.element_'+id+' .name_target.name_'+oldTarget).replaceWith(getSpanName(target).addClass('name_target'));
			
			/* Suppress source in egograph of old target */
			// var egoOldTarget = egograph[oldTarget];
			
			// egoOldTarget.getElementById(id).remove();
			
			// if (source != oldTarget && !egoOldTarget.getElementById(source).allAreNeighbors(egoOldTarget.getElementById(oldTarget)))
			// { egoOldTarget.getElementById(source).remove(); }

			/* Change target in egograph of edge */
			// var egoedge = egograph[id];

			// if (egoedge.getElementById(target).empty())
			// {
			// 	egoedge.add({ data: {id: target, name: cytograph.getElementById(target).data('name')}});
			// 	egoedge.getElementById(target).classes(cytograph.getElementById(target).json().classes);
			// }

			// egoedge.getElementById(id).move({target: target});

			// if (source != oldTarget)
			// { egoedge.getElementById(oldTarget).remove(); }
			
			/* Add target in egograph of source */
			// var egosource = egograph[source];
			
			// if (egosource.getElementById(target).empty())
			// {
			// 	egosource.add({ data: {id: target, name: cytograph.getElementById(target).data('name') }});
			// 	egoedge.getElementById(target).classes(cytograph.getElementById(target).json().classes);
			// }

			// if (egosource.getElementById(id).empty())
			// {
			// 	egosource.add({ data: {id: id, target: target, source: source }});
			// 	egoedge.getElementById(id).classes(cytograph.getElementById(id).json().classes);
			// }
			// else { egosource.getElementById(id).move({target: target}); }
			
			// if (oldTarget != source && !egosource.getElementById(oldTarget).allAreNeighbors(egosource.getElementById(source)))
			// { egosource.getElementById(oldTarget).remove(); }

			/* Add source in egograph of new target */
			// var egotarget = egograph[target];
			
			// if (egotarget.getElementById(source).empty())
			// {
			// 	egotarget.add({ data: {id: source, name: cytograph.getElementById(source).data('name') }});
			// 	egoedge.getElementById(source).classes(cytograph.getElementById(source).json().classes);
			// }

			// if (egotarget.getElementById(id).empty())
			// {
			// 	egotarget.add({ data: {id: id, target: target, source: source }});
			// 	egoedge.getElementById(id).classes(cytograph.getElementById(id).json().classes);
			// }
			// else { egotarget.getElementById(id).move({target: target}); }
			
			/* Modify global graph */
			element = element.move({target: target});

			/* Modified */
			if (element.data('target') != element.data('save').target) { target_object.addClass('modified'); modified = true; }
			else { target_object.removeClass('modified'); }
		}

		if (target_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { target_object.addClass('modified'); modified = true; }

		if (target_object.hasClass('error')) { error = true; }
	}

	/* Check end */
	if (element.data('type') == 'situation')
	{
		var end_field = form.find('[name="end"]');
		var end_object = end_field.closest('.form_object');
		var end_error = end_object.closest('.form_input').find('.form_error');
		var end = end_field.is(':checked') ? 1 : 0;
		end_error.text('');

		if (end != element.data('end'))
		{
			end_object.removeClass('error');
			important_change = true;
			element.data('end',end);
			
			/* Modified */
			if (element.data('end') != element.data('save').end) { end_object.addClass('modified'); modified = true; }
			else { end_object.removeClass('modified'); }
		}

		if (end_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { end_object.addClass('modified'); modified = true; }

		if (end_object.hasClass('error')) { error = true; }
	}

	/* Check choice */
	if (element.data('type') == 'transition')
	{
		var choice_field = form.find('[name="choice"]');
		var choice_object = choice_field.closest('.form_object');
		var choice_error = choice_object.closest('.form_input').find('.form_error');
		var choice = choice_field.val();
		choice_error.text('');

		if (choice != element.data('choice'))
		{
			choice_object.removeClass('error');
			element.data('choice',choice);

			/* Update choice in other places */
			var choice = choice;
			if (choice == '') { choice = 'Continuer'; }
			$('.choice_'+id).text (choice);

			/* Modified */
			if (element.data('choice') != element.data('save').choice) { choice_object.addClass('modified'); modified = true; }
			else { choice_object.removeClass('modified'); }
		}

		if (choice_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { choice_object.addClass('modified'); modified = true; }

		if (choice_object.hasClass('error')) { error = true; }
	}
	
	/* Check unlock */
	if (element.data('type') == 'transition')
	{
		var unlock_field = form.find('[name="unlock"]');
		var unlock_object = unlock_field.closest('.form_object');
		var unlock_error = unlock_object.closest('.form_input').find('.form_error');
		var unlock = unlock_field.val();
		unlock_error.text('');

		if (unlock != element.data('unlock'))
		{
			unlock_object.removeClass('error');
			element.data('unlock',unlock);

			/* Check format */
			var local_error = false;
			var unlock_str = ' ' + unlock + ' ';
			var unlock_array = unlock_str.split('"');

			if ((unlock_array.length-1) % 2 != 0) { local_error = true; }
			else if (/[A-Z]/.test(unlock)) { local_error = true; }
			else {
				for (var i = 0; i < unlock_array.length && !local_error; i+=2)
				{ local_error = (unlock_array[i].replace(/\s+/g, '').length > 0); }
			}
			
			if (local_error)
			{
				error = true;
				unlock_object.addClass('error');			
				unlock_error.text (error_unlock_format);
			}

			/* Update unlock in other places */
			var unlock_str = unlock;
			if (unlock_str != '') { unlock_str = formatUnlock (unlock_str); }
			$('.unlock_'+id).html (unlock_str);

			/* Modified */
			if (element.data('unlock') != element.data('save').unlock) { unlock_object.addClass('modified'); modified = true; }
			else { unlock_object.removeClass('modified'); }
		}

		if (unlock_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { unlock_object.addClass('modified'); modified = true; }

		if (unlock_object.hasClass('error')) { error = true; }
	}
	
	/* Check text */
	if (element.data('type') == 'situation' || element.data('type') == 'transition')
	{
		var text_field = form.find('[name="text"]');
		var text_object = text_field.closest('.form_object');
		var text_error = text_object.closest('.form_input').find('.form_error');
		var text = text_field.val();
		text_error.text('');

		if (text != element.data('text'))
		{			
			text_object.removeClass('error');
			element.data('text',text);

			/* Update text in other places */
			var fText = formatText (text);
			$('.text_'+id).html (fText);

			/* Modified */
			if (element.data('text') != element.data('save').text) { text_object.addClass('modified'); modified = true; }
			else { text_object.removeClass('modified'); }
		}

		if (text_object.hasClass('modified')) { modified = true; }
		else if (element.data('mod_type') == 'new') { text_object.addClass('modified'); modified = true; }

		if (text_object.hasClass('error')) { error = true; }
	}

	/* Apply changes */
	if (modified)
	{
		element.addClass('modified');
		// for (var i in egograph) { egograph[i].getElementById(id).addClass('modified'); }
		
		form.find('.save_button').attr('disabled',false);
		form.find('.reset_button').attr('disabled',false);
	}
	
	else {
		element.removeClass('modified');
		// for (var i in egograph) { egograph[i].getElementById(id).removeClass('modified'); }
		
		form.find('.save_button').attr('disabled',true);
		form.find('.reset_button').attr('disabled',true);
	}

	if (error)
	{
		element.addClass('error');
		form.find('.save_button').attr('disabled',true);
		form.find('.reset_button').attr('disabled',false);
	}

	else {
		element.removeClass('error');		
	}

	/* Rewind story if significant change in the narrative structure */
	if (important_change)
	{
		if (element.data('type') == 'situation')
		{
			var previous_situation = $('#table_story .story_row_'+id+':first');
			if (previous_situation.length > 0)
			{
				var previous_id = previous_situation.attr('data-id');
				previous_situation.nextAll().addBack().remove();
				readElement(previous_id);
			}
		}

		else if (element.data('type') == 'transition')
		{
			var previous_situation = $('#table_story .story_row_'+id+':first').prev('.story_row');
			if (previous_situation.length > 0)
			{
				var previous_id = previous_situation.attr('data-id');
				previous_situation.nextAll().addBack().remove();
				readElement(previous_id);
			}
		}
	}

	if (error) { return 'error'; }
	else if (modified) { return 'modified'; }
	else { return 'ok'; }
}


function safeResetForm (id)
{
	if (checkForm (id) != 'modified' || window.confirm (close_message))
	{
		resetForm (id);
		return true;
	}

	else { return false; }
}


function resetForm (id)
{
	var visible = $('#form_'+id).is(":visible");
	
	var element = cytograph.getElementById (id);
	element.removeClass('modified');

	$('#form_'+id).remove();
	var form = getForm(id).hide();
	$('#div_form').append (form);
	checkForm(id);

	if (visible) { $('#form_'+id).show (); }

	var data = element.data('save');
	if (element.data('type') == 'transition') { element = element.move({source: data.source, target: data.target}); }

	element.data(data);
	element.data('save',data);
}


function safeDeleteForm (id)
{
	var element = cytograph.getElementById (id);
	var message = null;

	if (element.data('type') == 'situation') { message = delete_situation_message; }
	else if (element.data('type') == 'transition') { message = delete_transition_message; }

	if (element.data('mod_type') == 'new' || window.confirm (message))
	{
		deleteForm (id);
		return true;
	}
	else { return false; }
}


function deleteForm (id)
{
	var element = cytograph.getElementById (id);

	/* Remove transitions */
	if (element.data('type') == 'situation')
	{
		cytograph.edges('[source="'+id+'"]').each (function (i, element_bis) { deleteForm (element_bis.id()); });
		cytograph.edges('[target="'+id+'"]').each (function (i, element_bis) { deleteForm (element_bis.id()); });
	}
	
	/* Delete in database */
	if (element.data('mod_type') != 'new')
	{
		$.ajax({
			async: false,
			url: 'scripts/delete_graph_data.php',
			type: 'POST',
			data: JSON.stringify ({id: id}),
			success: function (d) {}
		});
	}

	/* Remove form */
	$('#form_'+id).remove();

	/* Remove options in lists */
	if (element.data('type') == 'situation')
	{
		$('select[name="source"] option[value="'+id+'"]').remove();
		$('select[name="target"] option[value="'+id+'"]').remove();
	}

	/* Remove node */
	element.remove();

	/* Unselected if selected */
	if (selected_id == id) { selected_id = null; }
	if (displayed_id == id) { displayed_id = null; }
	if (overed_id == id) { overed_id = null; }
}


function saveForm (id)
{
	var element = cytograph.getElementById (id);
	var form = $('#form_'+id);
	
	$.ajax({
		url: 'scripts/save_graph_data.php',
		type: 'POST',
		data: JSON.stringify (element.data()),
		success: function (d)
		{
			var data = JSON.parse (d);
			element.data(data.data);
			resetForm (id);
		}
	});
}



/* Story panel */

function resetStory ()
{
	$('#table_story').text('');	
}


function readElement (id)
{
	var element = cytograph.getElementById (id);

	var div_row = $('<tbody>')
		.attr('data-id',id)
		.addClass ('story_row story_row_'+id);
	$('#table_story').append(div_row);

	var row = $('<tr>');
	div_row.append(row);

	var col1 = $('<td>').addClass('story_col story_col1');
	var col2 = $('<td>').addClass('story_col story_col2');
	row.append(col1).append(col2);

	col1.append('<hr>');

	/* Link to select corresponding element */
	var story_element = getLinkElement (id);
	story_element.click (function ()
						 {
							 $(this).closest('.story_row').nextAll().addBack().remove();
							 readElement (id);
						 }
						);
	col1.append (story_element);

	/* Text of the element */
	var text = formatText (element.data('text'));
	
	var story_text = $('<span>')
		.addClass ('text_'+id)
		.html(text);

	col2.append (story_text);
	
	if (element.data('type') == 'situation' && element.data('end') == "1") { col1.append('<hr>'); }

	/* If transition, add next situation */
	if (element.data('type') == 'transition')
	{
		var div_next_row = $('<tbody>')
			.addClass ('story_row story_next_row');
		$('#table_story').append(div_next_row);

		var next_row = $('<tr>');
		div_next_row.append(next_row);

		var next_col1 = $('<td>').addClass('story_col story_col1');
		var next_col2 = $('<td>').addClass('story_col story_col2');
		next_row.append(next_col1).append(next_col2);

		next_col1.append('<hr>');

		var story_list_element = getLinkElement (element.target().id());
		story_list_element.click (
			function ()
			{
				$(this).closest('.story_row').nextAll().addBack().remove();
				readElement (element.target().id());
			});

		next_col1.append ($('<ul>').append ($('<li>') .append (story_list_element)));
	}

	/* If situation, add transition list */
	if (element.data('type') == 'situation' && element.data('end') != 1)
	{
		var div_next_row = $('<tbody>')
			.addClass ('story_row story_next_row')
			.append('<hr>');
		$('#table_story').append(div_next_row);

		cytograph.edges('[source="'+id+'"]').each (
			function (i, element_bis)
			{
				var next_row = $('<tr>');
				div_next_row.append(next_row);

				var next_col1 = $('<td>').addClass('story_col story_col1');
				var next_col2 = $('<td>').addClass('story_col story_col2');
				next_row.append(next_col1).append(next_col2);

				var story_list_element = getLinkElement (element_bis.id());
				story_list_element.click (
					function ()
					{
						$(this).closest('.story_row').nextAll().addBack().remove();
						readElement (element_bis.id());
					}
				);

				next_col1.append ($('<ul>').append ($('<li>').append (story_list_element)));

				var choice = element_bis.data('choice');
				if (choice == '') { choice = 'Continuer'; }

				var choice_span = $('<span>')
					.addClass ('choice_'+element_bis.id())
					.append(choice);

				next_col2.append (choice_span);

				var unlock = element_bis.data('unlock');
				if (unlock != '')
				{
					var unlock_span = $('<span>')
						.addClass ('unlock_'+element_bis.id())
						.append (formatUnlock (unlock));
					
					next_col2
						.append ('<br>')
						.append (unlock_span);
				}
			}
		);
	}

	$('#div_reader').stop().animate({scrollTop: $('#div_reader')[0].scrollHeight}, 1500);
}




/* Shortcuts */
shortcut.add ("Ctrl+S",
			  function ()
			  {
				  if (displayed_id === null) return;
				  
				  var check = checkForm (displayed_id);
				  if (check == 'error') { alert (error_form); }
				  if (check == 'modified') { saveForm (displayed_id); }
			  }
			 );

shortcut.add ("Ctrl+Backspace",
			  function ()
			  {
				  if (displayed_id === null) return;
				  safeResetForm (displayed_id);
			  }
			 );

shortcut.add ("Ctrl+Delete",
			  function ()
			  {
				  if (displayed_id === null) return;
				  safeDeleteForm (displayed_id);
			  }
			 );

shortcut.add ("Ctrl+Return",
			  function ()
			  {
				  if (displayed_id === null) return;
				  resetStory ();
				  readElement (displayed_id);
			  }
			 );

