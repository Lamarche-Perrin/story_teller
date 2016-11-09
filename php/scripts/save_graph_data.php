<?php

include("../functions/function.php");
$GLOBALS['no_verbose'] = true;

session_start();

$json = json_decode (file_get_contents ("php://input"), true);

openConnection();

$id_member = $_SESSION['id_member'];
if ($json['type'] == 'situation')
{
	$id_element = $json['id'];
	extract ($json);

	if ($mod_type == 'new') { $type = 'create'; } else { $type = 'modify'; }
	$name = escapeSQL ($name);
	$text = escapeSQL ($text);

	// Save data
	$sql = "INSERT INTO writing (id_member, id_element, type, name, start, end, text)
				VALUES ('$id_member', '$id_element', '$type', '$name', NULL, '$end', '$text')";
	execSQL ($sql);

	// Get result
	$sql = "SELECT e.id_element AS id, e.type, w.name, w.start, w.end, COALESCE (w.text, '') AS text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	$row = $result->fetch_assoc();
	$row['save'] = $row;
	
	$data = array ('data' => $row);
}

else if ($json['type'] == 'transition')
{
	$id_element = $json['id'];
	extract ($json);

	if ($mod_type == 'new') { $type = 'create'; } else { $type = 'modify'; }
	$choice = escapeSQL ($choice);
	$unlock = escapeSQL ($unlock);
	$text = escapeSQL ($text);

	// Save data
	$sql = "INSERT INTO writing (id_member, id_element, type, id_from, id_to, choice, `unlock`, text)
				VALUES ('$id_member', '$id_element', '$type', '$source', '$target', '$choice', '$unlock', '$text')";
	execSQL ($sql);

	// Get result
	$sql = "SELECT e.id_element AS id, e.type, w.id_from AS source, w.id_to AS target, COALESCE (choice, '') AS choice, COALESCE (`unlock`, '') AS `unlock`, COALESCE (text, '') AS text, w.type AS mod_type, w.date AS mod_date, m.name AS mod_name
			FROM element e
				INNER JOIN writing w ON w.id_element = e.id_element
				INNER JOIN member m ON m.id_member = w.id_member
			WHERE e.id_element = '$id_element'
				AND w.date = (SELECT MAX(x.date) FROM writing x WHERE w.id_element = x.id_element)
				AND w.type IN ('create', 'modify')";
	$result = execSQL ($sql);

	$row = $result->fetch_assoc();
	$row['save'] = $row;
	
	$data = array ('data' => $row);
}
	
closeConnection();

echo json_encode ($data);

?>

