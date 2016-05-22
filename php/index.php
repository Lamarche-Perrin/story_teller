<HTML>
    <HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"/>
    </HEAD>
    
    <BODY>
		<?php

		include("function/get_xml.php");

		$conn = getConnection();

		getXML(3);

		$conn->close();

		?>
	</BODY>
</HTML>
