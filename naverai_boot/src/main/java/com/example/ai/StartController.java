package com.example.ai;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StartController {
	@GetMapping("/")
	public String start() {
		System.out.println("akm test");
		return "start";
	}
}
