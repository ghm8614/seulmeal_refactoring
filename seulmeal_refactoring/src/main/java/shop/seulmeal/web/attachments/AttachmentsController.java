package shop.seulmeal.web.attachments;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class AttachmentsController {
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	//private String path =System.getProperty("user.dir")+"/src/main/webapp/resources/attachments/";
	private String path ="/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/";
	
	public AttachmentsController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
		System.out.println(System.getProperty("user.dir"));
	}
	
	@GetMapping("/download/{fileName}")
	public ResponseEntity<Object> attachMentsDownload(@PathVariable String fileName) throws IOException{
		//String path = System.getProperty("user.dir")+"/src/main/resources/attachments/"+fileName;
		String newPath =path + fileName;
		Path filePath = Paths.get(newPath);
		Resource resource = new InputStreamResource(Files.newInputStream(filePath));
		
		File file = new File(newPath);
		
		HttpHeaders headers = new HttpHeaders();
		
		// 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지 알려주는 헤더
		headers.setContentDisposition(ContentDisposition.builder("attachment").filename(file.getName()).build());
		ResponseEntity<Object> re = new ResponseEntity<Object>(resource, headers, HttpStatus.OK);
		file = null;
		resource =null;
		
		return re;
	}
	
	@ResponseBody
	@PostMapping(value="/uploadSummernoteImgFile", produces = "application/json; charset=utf8")
	public String uploadSummernoteImgFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		
		String originalFile = multipartFile.getOriginalFilename();
		String extension = originalFile.substring(originalFile.lastIndexOf("."));
		
		// 저장될 파일명
		String savedFileName = UUID.randomUUID()+extension;
		System.out.println(extension);
		File targetFile = new File(path+savedFileName);
		
		try {
			// 파일 저장
			multipartFile.transferTo(targetFile);
	        	        
	        json.put("url", "/resources/attachments/"+savedFileName);  
	        json.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			FileUtils.deleteQuietly(targetFile);	
	        json.put("result", "fail");
	        e.printStackTrace();
		}
		
		return json.toString();
	}
}
