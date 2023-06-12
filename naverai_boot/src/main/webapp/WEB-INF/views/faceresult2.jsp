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
	<h3>${faceresult2 }</h3>
	<%
	String faceresult2 = (String) request.getAttribute("faceresult2");
	JSONObject total = new JSONObject(faceresult2);
	JSONObject info = (JSONObject) total.get("info");
	int faceCount = (Integer) info.get("faceCount");
	
	JSONArray faces = (JSONArray) total.get("faces");
	for (int i = 0; i < faceCount; i++) {
		JSONObject oneperson = (JSONObject) faces.get(i);
		JSONObject gender = (JSONObject) oneperson.get("gender");
		String gender_value = (String) gender.get("value");
		BigDecimal gender_conf = (BigDecimal) gender.get("confidence");
		double gender_conf_double = gender_conf.doubleValue();
		JSONObject age = (JSONObject) oneperson.get("age");
		String age_value = (String) gender.get("value");
		
		out.println("<h3>" + (i+1) + " 번째 얼굴의 성별 =" + gender_value + "</h3>");
		
		if (!oneperson.get("landmark").equals(null)) {
			JSONObject landmark = (JSONObject) oneperson.get("landmark");
			JSONObject nose = (JSONObject) landmark.get("nose");
			out.println("<h3> 코위치 x = " + (Integer) nose.get("x") + "</h3>");
		} else {
			out.println("<p>눈코입을 파악할 수 없습니다.</p>");
		}
	}
	%>
	
	<h3>총 <%=faceCount %> 명의 얼굴을 찾았습니다.</h3>
</body>
</html>