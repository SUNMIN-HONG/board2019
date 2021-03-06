package com.board.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.board.dao.ManagementDAO;
import com.board.domain.BoardVO;
import com.board.domain.FileManagerVO;
@Repository
@Service
public class FileUploadServiceImpl implements FileUploadService{
	// 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
		// 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
		// 따라서 workspace가 C드라이브에 있다면 C드라이브에 upload 폴더를 생성해 놓아야 한다.
	private static final String SAVE_PATH = "/fileupload";
	/* private static final String PREFIX_URL = "/upload/"; */
	private static final String PREFIX_URL = "/fileupload/";
	
	@Inject
	private ManagementDAO dao;
	
	public String restore(MultipartFile multipartFile) {
		String url = null;
		
		
		
		try {
			// // 파일 정보
			
				String originFilename = multipartFile.getOriginalFilename();
				String extName
					= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
				Long size = multipartFile.getSize();
				
				// 서버에서 저장 할 파일 이름
				String saveFileName = genSaveFileName(extName);
				
				System.out.println("originFilename : " + originFilename);
				System.out.println("extensionName : " + extName);
				System.out.println("size : " + size + "byte");
				System.out.println("saveFileName : " + saveFileName);
				
				writeFile(multipartFile, saveFileName);
				
				System.out.println("writeFile end test");
				
				url = PREFIX_URL + saveFileName;
			
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
						// 편의상 RuntimeException을 던진다.
						// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		return url;
	}
	
	
	////
	public String restore2(MultipartFile multipartFile,FileManagerVO fvo) throws Exception  {
		String url = null;
		
		
		
		try {
			// // 파일 정보
			
			
			
				String originFilename = multipartFile.getOriginalFilename();
				String extName
					= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
				Long size = multipartFile.getSize();
				
				// 서버에서 저장 할 파일 이름
				String saveFileName = genSaveFileName(extName);
				
				System.out.println("originFilename : " + originFilename);
				System.out.println("extensionName : " + extName);
				System.out.println("size : " + size + "byte");
				System.out.println("saveFileName : " + saveFileName);
				
				writeFile(multipartFile, saveFileName);
				
				System.out.println("writeFile end test");
				
				url = PREFIX_URL + saveFileName;
				
				
				fvo.setOriginFileName(originFilename);
				fvo.setSaveFileName(saveFileName);
				fvo.setExtensionFileName(extName);
				fvo.setFileSize(size);
				
				System.out.println(fvo);
				dao.fileWrite(fvo);
				
				
				
				
				
			
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
						// 편의상 RuntimeException을 던진다.
						// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		
		return url;
	}
	////
	
	
	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;
		
		return fileName;
	}
	
	
	// 파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String saveFileName)
								throws IOException{
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		System.out.println(SAVE_PATH);
		
		File dir = new File(SAVE_PATH); 
        
        if (!dir.isDirectory()) { 
            dir.mkdirs(); 
        } 



		
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
		
		return result;
	}
}