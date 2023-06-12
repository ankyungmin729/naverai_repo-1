<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/js/jquery-3.6.4.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	String[] languages = { "Kor", "Eng", "Jpn", "Chn" };
	String[] language_names = { "한국어", "영어", "일본어", "중국어" };
	%>
	<form action="sttresult" method="GET">
		언어 선택: <br />
		<%
		for (int i = 0; i < languages.length; i++) {
		%>
		<input type="radio" name="lang" value="<%=languages[i]%>" />
		<%=language_names[i]%>
		<br />
		<%
		}
		%>
		<div>mp3 파일 선택:</div>
		<select name="audio">
			<c:forEach items="${filelist }" var="onefile">
				<option value="${onefile }">${onefile }</option>
			</c:forEach>
		</select> <input type="submit" value="제출" />
	</form>
</body>
</html>