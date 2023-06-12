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
	질문: <input type="text" id="request" />
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
				const bubbles = server.bubbles;
				for (bubble of bubbles) {
					if (bubble.type === 'text') {
						$('#response').append("답변: " + server.bubbles[0].data.description + '<br />');
						if (bubble.data.url) {
							$('#response').append('<a href=' + bubble.data.url + '>' + bubble.data.description + '</a><br />');
						}
					} else if (bubble.type === 'template') {
						if (bubble.data.cover.type === 'image') {
							$('#response').append('<img src=' + bubble.data.cover.data.imageUrl + ' width=200 height=200 /><br />');
						} else if (bubble.data.cover.type === 'text') {
							$('#response').append("멀티링크 답변: " + bubble.data.cover.data.description + '<br />');
							for (const ct of bubble.data.contentTable) {
								for (const c of ct) {
									const title = c.data.title;
									const link = c.data.data.action.data.url;
									$('#response').append('<a href=' + link + '>' + title + '</a><br />');								
								}
							}
						}
					}					
				}
			},
			dataType: 'json',
			type: 'get',
			error() {}
		})
	})
</script>
</html>