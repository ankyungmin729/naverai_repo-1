package mymapping;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.example.ai.NaverService;

@Service("mapservice")
public class MapServiceImpl implements NaverService {

	HashMap<String, String> map = new HashMap<>();

	public MapServiceImpl() {
		map.put("이름이 뭐니?", "클로버야.");
		map.put("무슨 일을 하니?", "인공 지능 일을 해.");
		map.put("멋진 일을 하는구나.", "고마워.");
	}

	@Override
	public String test(String request) {
		String response = map.get(request);
		if (response == null) {
			response = "죄송합니다. 모르겠습니다.";
		}
		return response;
	}
}
