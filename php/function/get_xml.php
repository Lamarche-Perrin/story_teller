<?php

include("./function.php");

$conn = getConnection();

$result = getXML(4,"start");
while ($row = $result->fetch_assoc())
{
	echo $row["xml"];
}


$conn->close();

?>
