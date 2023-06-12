package tts_voice;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Controller
public class TTSController {

	@Autowired
	@Qualifier("ttsservice")
	NaverService service; // 닮은 연예인

	// ai_images 파일리스트 보여주는 뷰
	@RequestMapping("/ttsinput")
	public ModelAndView ttsinput() {
		File f = new File(MyNaverInform.path);// 파일과 디렉토리 정보 제공
		String[] filelist = f.list();

		String file_ext[] = { "txt" };

		ArrayList<String> newfilelist = new ArrayList<>();
		for (String onefile : filelist) {
			String myext = onefile.substring(onefile.lastIndexOf(".") + 1);
			for (String imgext : file_ext) {
				if (myext.equals(imgext)) {
					newfilelist.add(onefile);
					break;
				}
			}
		}

		ModelAndView mv = new ModelAndView();
		mv.addObject("filelist", newfilelist);
		mv.setViewName("ttsinput");
		return mv;
	}

	@RequestMapping("/ttsresult")
	public ModelAndView ttsresult(String textfile, String speaker) throws IOException {
		String ttsresult = null;
		if (speaker == null) {
			ttsresult = service.test(textfile);			
		} else {
			ttsresult = ((TTSServiceImpl)service).test(textfile, speaker);						
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("ttsresult", ttsresult);
		mv.setViewName("ttsresult");
		
		return mv;
	}
}
