package com.example.ai;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan
@ComponentScan(basePackages = { "cfr", "objectdetection", "pose", "stt_csr", "tts_voice", "mymapping", "ocr", "chatbot" })
public class NaveraiBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(NaveraiBootApplication.class, args);
	}

}
