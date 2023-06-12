package stt_csr;

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
public class STTController {

	@Autowired
	@Qualifier("sttservice")
	NaverService service; // 닮은 연예인

	// ai_images 파일리스트 보여주는 뷰
	@RequestMapping("/sttinput")
	public ModelAndView sttinput() {
		File f = new File(MyNaverInform.path);// 파일과 디렉토리 정보 제공
		String[] filelist = f.list();

		String file_ext[] = { "mp3", "m4a", "wav" };

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
		mv.setViewName("sttinput");
		return mv;
	}

	@RequestMapping("/sttresult")
	public ModelAndView sttresult(String audio, String lang) throws IOException {
		String sttresult = null;
		if (lang == null) {
			sttresult = service.test(audio);			
		} else {
			sttresult = ((STTServiceImpl)service).test(audio, lang);						
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("sttresult", sttresult);
		mv.setViewName("sttresult");
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String now_string = sdf.format(now);
		String filename = audio.substring(0, audio.lastIndexOf(".")) + "_" + now_string + ".txt";
		FileWriter fw = new FileWriter(MyNaverInform.path + filename, false);
		JSONObject json = new JSONObject(sttresult);
		String text = (String) json.get("text");
		fw.write(text);
		fw.close();
		return mv;
	}
}
