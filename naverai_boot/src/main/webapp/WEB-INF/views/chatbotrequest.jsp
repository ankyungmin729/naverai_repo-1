<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/chatbotresponse">
	<div>
		질문: <input type="text" name="request" />
	</div>
	<input type="submit" value="답변" name="event" />
	<input type="submit" value="웰컴메시지" name="event" />
</form>
</body>
</html>