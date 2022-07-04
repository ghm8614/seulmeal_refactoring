package shop.seulmeal.service.attachments;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import shop.seulmeal.service.domain.Attachments;

public interface AttachmentsService {
	public int insertAttachments(MultipartFile[] uploadFile, Attachments attachments) throws IllegalStateException, IOException;
	public int deleteAttachments(String noA, String nameA);
	public List<Attachments> getAttachments(Map<String,Object> map);
	public void summerCopy(List<String> fileList);
}
