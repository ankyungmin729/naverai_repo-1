<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
#names {
	border: 2px solid brown;
}

#boxes {
	border: 2px solid blue;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
</head>
<body>
	${objectresult }
	<div id="count"></div>
	<div id="names"></div>
	<div id="boxes"></div>

	<canvas id="objectcanvas" width="500" height="500"></canvas>
</body>
<script>
	const json = JSON.parse('${objectresult }');
	$('#count').html('<h3>' + json.predictions[0].num_detections + '개 탐지</h3>')
	for (const detection_name of json.predictions[0].detection_names) {
		$('#names').append('<div>' + detection_name + '</div>');
	}
	
	for (const box of json.predictions[0].detection_boxes) {
		const [x1, y1, x2, y2] = box;
		$('#boxes').append("<div>" + "x1: " + x1 + ", y1: " + y1 + "</div>");
	}
	
	const $mycanvas = document.querySelector("#objectcanvas");
	const mycontext = $mycanvas.getContext("2d");
	
	const faceimage = new Image();
	faceimage.src = "/naverimages/${param.image}";
	faceimage.onload = () => {
		mycontext.drawImage(faceimage, 0,  0, faceimage.width, faceimage.height);
		const boxes = json.predictions[0].detection_boxes;
		for (let i = 0; i < json.predictions[0].num_detections; i++) {
			// 공식 문서와 달리 y가 먼저
			const [by1, bx1, by2, bx2] = boxes[i];
			const x1 = bx1 * faceimage.width;
			const y1 = by1 * faceimage.height;
			const x2 = bx2 * faceimage.width;
			const y2 = by2 * faceimage.height;
			
			mycontext.strokeStyle = "green";
			mycontext.lineWidth = 3;
			mycontext.strokeRect(x1, y1, (x2 -x1), (y2 - y1));
			
			mycontext.fillStyle = "red";
			mycontext.font = "bold 17px batang"
			mycontext.fillText(json.predictions[0].detection_names[i], x1, y1 - 5);
			
			const colors = ['red', 'orange', 'purple'];
		}
	}
</script>
</html>