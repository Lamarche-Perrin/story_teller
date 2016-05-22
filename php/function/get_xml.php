<?php

function getConnection ()
{
    $conn = new mysqli ("localhost", "root", "", "bibliotheque");
    if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); }
    $conn->query("SET NAMES UTF8");
    return $conn;
}

function getXML ($id_narrative)
{
    global $conn;

    $sql = "SELECT * FROM ELEMENT E INNER JOIN WRITING W ON E.ID_ELEMENT = W.ID_ELEMENT WHERE ID_NARRATIVE = '$id_narrative'";
	
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc())
    {
        echo "ID: " . $row["ID_NARRATIVE"]. " - Title: " . $row["TITLE"] . "<BR>";
    }
}

?>
