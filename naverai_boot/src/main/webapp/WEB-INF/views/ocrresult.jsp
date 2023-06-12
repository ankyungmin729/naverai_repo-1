<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/js/jquery-3.6.4.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="output" style="border: 2px solid orange"></div>
	<div id="output2" style="border: 2px solid green"></div>
	<canvas id="ocrcanvas" style="border: 2px solid silver" width="500" height="500"></canvas>
</body>
<script>
	const json = JSON.parse('${ocrresult}');
	const $mycanvas = document.getElementById('ocrcanvas');
	const mycontext = $mycanvas.getContext('2d');
	const myimage = new Image();
	myimage.src = "/naverimages/${param.image}";
	myimage.onload = () => {
		if (myimage.width > $mycanvas.width) {
			$mycanvas.width = myimage.width;
		}
		
		mycontext.drawImage(myimage, 0, 0, myimage.width, myimage.height);
		// 이밎 글씨 박스화
		const fields = json.images[0].fields;
		for (let field of fields) {
			if (field.lineBreak) {			
				$("#output2").append(field.inferText + "<br />");
			} else {
				$("#output2").append(field.inferText + "&nbsp;");				
			}
			
			const x = field.boundingPoly.vertices[0].x;
			const y = field.boundingPoly.vertices[0].y;
			const width = field.boundingPoly.vertices[1].x - x;
			const height = field.boundingPoly.vertices[2].y - y;
			mycontext.strokeRect(x, y, width, height);
		}
	}
</script>
</html>