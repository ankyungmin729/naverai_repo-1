<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
canvas {
	border: 2px solid black;
}
</style>
</head>
<body>
	<canvas id="facecanvas" width="500" height="500"></canvas>
</body>
<script>
	const $mycanvas = document.querySelector("#facecanvas");
	const mycontext = $mycanvas.getContext("2d");
	
	const faceimage = new Image();
	faceimage.src = "/naverimages/${param.image}";
	faceimage.onload = () => {
		mycontext.drawImage(faceimage, 0,  0, faceimage.width, faceimage.height);
		<%
		String faceresult2 = (String) request.getAttribute("faceresult2");
		JSONObject total = new JSONObject(faceresult2);
		JSONObject info = (JSONObject) total.get("info");
		int faceCount = (Integer) info.get("faceCount");
		JSONArray faces = (JSONArray) total.get("faces");
		int x, y, width, height;
		for (int i = 0; i < faceCount; i++) {
			JSONObject oneperson = (JSONObject) faces.get(i);
			JSONObject roi = (JSONObject) oneperson.get("roi");
			x = (Integer) roi.get("x");
			y = (Integer) roi.get("y");
			width = (Integer) roi.get("width");
			height = (Integer) roi.get("height");
		%>
			mycontext.lineWidth = 3;
			mycontext.strokeStyle = "pink";
			mycontext.strokeRect(<%=x%>, <%=y%>, <%=width%>, <%=height%>);
		<%}%>
	}
	
</script>
</html>