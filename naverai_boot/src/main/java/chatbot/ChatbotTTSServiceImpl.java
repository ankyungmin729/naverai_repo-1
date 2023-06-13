package chatbot;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import org.springframework.stereotype.Service;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Service("chatbotttsservice")
public class ChatbotTTSServiceImpl implements NaverService {
	@Override
	public String test(String text) {
		return test(text, "nara");
	}

	public String test(String text, String speaker) {
		String tempname = null;
		String clientId = MyNaverInform.voice_clientID;
		String clientSecret = MyNaverInform.voice_secret;
		try {
			// String text = URLEncoder.encode("지금은 네이버 플랫폼을 활용한 AI 서비스 진행 중입니다.", "UTF-8");
			// FileReader fr = new FileReader(MyNaverInform.path + textfile);
			// Scanner sc = new Scanner(fr);
			// String text = "";
//			while (sc.hasNextLine()) {
//				text += sc.nextLine();
//			}
			text = URLEncoder.encode(text, "UTF-8");
			// sc.close();

			String apiURL = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
			con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
			// post request
			String postParams = "speaker=" + speaker + "&volume=0&speed=0&pitch=0&format=mp3&text=" + text;
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				InputStream is = con.getInputStream();
				int read = 0;
				byte[] bytes = new byte[1024];
				// 랜덤한 이름으로 mp3 파일 생성
				tempname = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
				File f = new File(MyNaverInform.path + tempname + ".mp3");
				f.createNewFile();
				OutputStream outputStream = new FileOutputStream(f);
				while ((read = is.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
				is.close();
				outputStream.close();
				System.out.println("만든 파일은 " + tempname);
			} else { // 오류 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				String inputLine;
				StringBuffer response = new StringBuffer();
				while ((inputLine = br.readLine()) != null) {
					response.append(inputLine);
				}
				br.close();
				System.out.println(response.toString());
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return tempname + ".mp3";
	}
}