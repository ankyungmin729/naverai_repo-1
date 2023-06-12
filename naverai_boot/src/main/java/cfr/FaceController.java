package cfr;

import java.io.File;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Controller
public class FaceController {

	@Autowired
	@Qualifier("faceservice1")
	NaverService service; // 닮은 연예인
	
	@Autowired
	@Qualifier("faceservice2")
	NaverService service2;

	// ai_images 파일리스트 보여주는 뷰
	@RequestMapping("/faceinput")
	public ModelAndView faceinput() {		
		File f = new File(MyNaverInform.path);// 파일과 디렉토리 정보 제공
		String[] filelist = f.list();
		
		String file_ext[] = {"jpg", "gif", "png", "jfif" };
		
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
		mv.setViewName("faceinput");
		return mv;
	}

	@RequestMapping("faceresult")
	public ModelAndView faceresult(String image) {
		// "https://naveropenapi.apigw.ntruss.com/vision/v1/celebrity"; // 유명인 얼굴 인식
		String faceresult = service.test(image);
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult", faceresult);
		mv.setViewName("faceresult");
		return mv;
	}
	
	// 안면 인식 서비스 파일 리스트
	// ai_images 파일리스트 보여주는 뷰
	@RequestMapping("/faceinput2")
	public ModelAndView faceinput2() {		
		File f = new File(MyNaverInform.path);// 파일과 디렉토리 정보 제공
		String[] filelist = f.list();
		
		String file_ext[] = {"jpg", "gif", "png", "jfif" };
		
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
		mv.setViewName("faceinput2");
		return mv;
	}
	
	@RequestMapping("/faceresult2")
	public ModelAndView faceresult2(String image) {
		// "https://naveropenapi.apigw.ntruss.com/vision/v1/face";
		String faceresult2 = service2.test(image);
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult2", faceresult2);
		// mv.setViewName("faceresult2");
		mv.setViewName("faceresult3");
		return mv;
	}
}
