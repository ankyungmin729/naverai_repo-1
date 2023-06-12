package chatbot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.NaverService;

@Controller
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotservice")
	ChatbotServiceImpl service;
	
	@RequestMapping("/chatbotrequest")
	public String chatbotrequest() {
		return "chatbotrequest";
	}
	
	@RequestMapping("/chatbotresponse")
	public ModelAndView chatbotresponse(String request, String event) {
		String answer = "";
		
		if (event.equals("웰컴메시지")) {
			answer = service.test(request, "open");
		} else {
			answer = service.test(request, "send");
		}
				
		ModelAndView mv = new ModelAndView();
		mv.addObject("answer", answer);
		mv.setViewName("chatbotresponse");
		return mv;
	}
	
	// 기본 답변만 분석
	@RequestMapping("/chatbotajaxstart")
	public String chatbotajaxstart() {
		return "chatbotajaxstart";
	}
	
	// 기본 + 이미지 + 멀티링크
	@RequestMapping("/chatbotajax")
	public String chatbotajax() {
		return "chatbotajax";
	}
	
	@RequestMapping("/chatbotajaxprocess")
	@ResponseBody
	public String chatbotajaxprocess(String request, String event) {
		String answer = "";
		if (event.equals("웰컴메시지")) {
			answer = service.test(request, "open");
		} else {
			answer = service.test(request, "send");
		}
		return answer;
	}
}
