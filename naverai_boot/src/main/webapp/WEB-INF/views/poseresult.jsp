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
	<canvas id="posecanvas" style="border: 2px solid silver" width="500" height="500"></canvas>
</body>
<script>
	const json = JSON.parse('${poseresult}');
	const $mycanvas = document.getElementById('posecanvas');
	const mycontext = $mycanvas.getContext('2d');
	const myimage = new Image();
	myimage.src = "/naverimages/${param.image}";
	myimage.onload = () => {
		if (myimage.width > $mycanvas.width) {
			$mycanvas.width = myimage.width;
		}
		
		mycontext.drawImage(myimage, 0, 0, myimage.width, myimage.height);
		
		const body_inform = ['코', '목', '오어', '오팔', '오손', '외어', '외팔', '외손'];
		const color_inform = ['red', 'orange', 'yellow', 'green', 'navy', 'purple'];
		
		for (let j = 0; j < json.predictions.length; j++) {
			for (let i = 0; i < body_inform.length; i++) {
				if (json.predictions[j][i]) {
					const x = json.predictions[j][i].x * myimage.width;
					const y = json.predictions[j][i].y * myimage.height;
					mycontext.fillStyle = color_inform[i % color_inform.length];
					mycontext.fillText(body_inform[i], x, y);							
				}
			}			
		}
	}
</script>
</html>