<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>${faceresult }</h3>
	<%
	String faceresult = (String) request.getAttribute("faceresult");
	JSONObject total = new JSONObject(faceresult);
	JSONObject info = (JSONObject) total.get("info");
	int faceCount = (Integer) info.get("faceCount");

	JSONArray faces = (JSONArray) total.get("faces");

	for (int i = 0; i < faces.length(); i++) {
		JSONObject oneface = (JSONObject) faces.get(i);
		JSONObject celebrity = (JSONObject) oneface.get("celebrity");
		String name = (String) celebrity.get("value");
		BigDecimal confidence = (BigDecimal) celebrity.get("confidence");
		double confidenceDouble = confidence.doubleValue();
		if (confidenceDouble >= 0.7) {
			out.println("<h3>" + name + "유명인을 " + Math.round(confidenceDouble * 100) + "%로 닮았습니다.</h3>");
		}
	}
	%>
	<h3><%=faceCount%>
		명의 얼굴을 찾았습니다.
	</h3>
</body>
</html>