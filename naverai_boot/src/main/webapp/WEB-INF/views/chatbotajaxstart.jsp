<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
</head>
<body>
	<div>
		질문: <input type="text" id="request" />
	</div>
	<input type="button" value="답변" id="event1" />
	<input type="button" value="웰컴메시지" id="event2" />
<section>
<h3>대화 내용</h3>
<div id="response" style = "border: 2px solid aqua"></div>
</section>
</body>
<script>
	$('input:button').on('click', (e) => {
		$('#response').append("질문: " + $("#request").val() + '<br />');
		$.ajax({
			url: '/chatbotajaxprocess',
			data: {
				request: $('#request').val(),
				event: $(e.currentTarget).val(),
			},
			success(server) {
				$('#response').append("답변: " + server.bubbles[0].data.description + '<br />');
			},
			dataType: 'json',
			type: 'get',
			error() {}
		})
	})
</script>
</html>