<?php

/*
 * Initiate connection to the "bibliotheque" database.
 * Don't forget to close the database after usage (see closeConnection).
 */
function openConnection ()
{
	$GLOBALS['sql_connection'] = new mysqli ("localhost", "root", "orodove", "bibliotheque");
	//$GLOBALS['sql_connection'] = new mysqli ("jeunarrackroot.mysql.db", "jeunarrackroot", "0r0d0vEE", "jeunarrackroot");
	if ($GLOBALS['sql_connection']->connect_error) { die ("Connection failed: " . $GLOBALS['sql_connection']->connect_error); }
	$GLOBALS['sql_connection']->query("SET NAMES UTF8");
	if ($GLOBALS['verbose_sql'] && !$GLOBALS['no_verbose']) { echo "<B>Connection opened</B><BR>\n"; }
}

?>
