package shop.seulmeal.service.attachments.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import shop.seulmeal.service.attachments.AttachmentsService;
import shop.seulmeal.service.domain.Attachments;
import shop.seulmeal.service.mapper.AttachmentsMapper;

@Service("attachmentsServiceImpl")
public class AttachmentsServiceImpl implements AttachmentsService {
	
	//private String path =System.getProperty("user.dir")+"/src/main/webapp/resources/attachments/";
	//private String path = "/home/tomcat/apache-tomcat-9.0.64/webapps/seulmeal/resources/attachments/";
	private String path ="./src/main/webapp/resources/attachments/";
//	private String path ="C:/Users/GHM/Desktop/mainPJT/";
	
	
	@Autowired
	private AttachmentsMapper attachmentsMapper;
	
	@Override
	public int insertAttachments(MultipartFile[] uploadFile, Attachments attachments) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		List<Attachments> list = new ArrayList<>();
		String origin = "";
		
		for (MultipartFile file : uploadFile) {
			System.out.println("file.getOriginalFilename() : "+file.getOriginalFilename());
			if(file.getOriginalFilename() == null ||(file.getOriginalFilename()).equals("")) {
				//origin = file.getOriginalFilename();
				break;
			}
			origin = file.getOriginalFilename();
			System.out.println(file.getOriginalFilename());
			if(!file.isEmpty()) {
				Attachments attachment = new Attachments();
				
				attachment.setProductNo(attachments.getProductNo());
				attachment.setReviewNo(attachments.getReviewNo());
				attachment.setPostNo(attachments.getPostNo());
				attachment.setCommentNo(attachments.getCommentNo());
				
				String name = UUID.randomUUID().toString()+"_"+file.getOriginalFilename();
				attachment.setAttachmentName(name);
				list.add(attachment);
				
				File newFileName = new File(path,name);
				file.transferTo(newFileName);
			}
		}
		System.out.println("sdforing"+origin);
		if(!origin.equals("")) {
			attachmentsMapper.insertListAttachments(list);
		}
		return 0;
	}

	@Override
	@Transactional
	public int deleteAttachments(String noA, String nameA) {
		// TODO Auto-generated method stub
		System.out.println(noA);
		
		if(noA !=null && !noA.isEmpty()) {
			String[] noAa = noA.split(",");
			String[] nameAa = nameA.split(",");
			
			for(int i=0; i<noAa.length; i++) {
				attachmentsMapper.deleteAttachments(new Integer(noAa[i]));
				File file = new File(path+nameAa[i]);
				file.delete();
			}
		}
		
		
		
		
		return 0;
	}
	
	@Override
	public List<Attachments> getAttachments(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		return attachmentsMapper.getListAttachments(map);
	}

	@Override
	public void summerCopy(List<String> fileList) {
		// TODO Auto-generated method stub
		Map<String,Object> result = new HashMap<String,Object>();
		System.out.println(fileList);
		
		if(fileList.size() != 0) {
			for (String fileName : fileList) {
				File file = new File(path+fileName);
				file.delete();
			}
		}		
		 
	}
}
