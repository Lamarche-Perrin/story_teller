<?php

include("functions/function.php");

session_start();

$_SESSION['id_member'] = 1;
$_SESSION['id_narrative'] = 33;

openConnection();

$graphStr = getElementsGraph($_SESSION['id_narrative']);
//echo $graphStr;

closeConnection();

?>

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
		<script src="lib/WebCola/extern/d3.v3.js"></script>
		<script src="lib/WebCola/cola.min.js"></script>
		<link type="text/css" href="css/graph.css" rel="stylesheet" media="print, projection, screen" />
    </head>

	<body>
		<script type="text/javascript">
		 var graphStr = '<?php echo json_encode($graphStr); ?>';
		 var graph = eval('(' + graphStr + ')');

		 var width = 960;
		 var height = 500;

		 var color = d3.scale.category20();

		 R=8

		 var cola = cola.d3adaptor()
						.size([width, height]);
		 
		 cola.nodes(graph.nodes)
			 .links(graph.links)
			 .symmetricDiffLinkLengths(R)
			 .start();

		 
		 var svg = d3.select("body")
					 .append("svg")
					 .attr("width", width)
					 .attr("height", height);

		
		 svg.append('svg:defs').append('svg:marker')
			.attr('id', 'end-arrow')
			.attr('viewBox', '0 -5 10 10')
			.attr('refX', 6)
			.attr('markerWidth', 3)
			.attr('markerHeight', 3)
			.attr('orient', 'auto')
			.append('svg:path')
            .attr('d', 'M0,-5L10,0L0,5')
            .attr('fill', '#CCCCCC');
		 
		 var link = svg.append("g")
					   .selectAll(".link")
					   .data(graph.links)
					   .enter()
					   .append("line")
                       .attr("class", "link")
					   .attr('d', 'M0,-5L10,0L0,5')
                       .style('marker-end', "url(#end-arrow)")
					   .style("stroke-width",4);
					   
		 var node = svg.selectAll(".node")
					   .data(graph.nodes)
					   .enter()
					   .append("circle")
					   .attr("class","node")
					   .attr("r", R)
					   .style("fill", function (d) { return color(d.group); })
					   .on("click", function (d) { d.fixed = true; })
					   .call(cola.drag);

		 node.append("title")
			 .text(function (d) { return d.name; });

		 cola.on("tick", function () {
			 link.attr("x1", function (d) { return d.source.x; })
				 .attr("y1", function (d) { return d.source.y; })
				 .attr("x2", function (d) { return d.target.x; })
				 .attr("y2", function (d) { return d.target.y; });

			 node.attr("cx", function (d) { return d.x; })
				 .attr("cy", function (d) { return d.y; });
		 });

		</script>
	</body>
</html>
