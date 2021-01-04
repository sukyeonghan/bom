package com.kh.bom.ckeditor.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
public class CkeditorController {
    @RequestMapping(value = "/ckeditor/imageUpload", method = RequestMethod.POST)
    @ResponseBody
    public String imageUpload(HttpServletRequest request,
                HttpServletResponse response,MultipartFile upload, HttpSession session) throws Exception {
        	JsonObject json=new JsonObject();
        	PrintWriter printWriter=null;
        	OutputStream out =null;
        	
        	if(upload!=null) {
        		if(upload.getSize()>0 && StringUtils.isNotBlank(upload.getName())) {
        			if(upload.getContentType().toLowerCase().startsWith("image/")) {
        				try {
        					
        					String fileName = upload.getOriginalFilename();
        					String ext=fileName.substring(fileName.lastIndexOf(".")+1);
        					byte[] bytes=upload.getBytes();

        					String uploadPath= request.getServletContext().getRealPath("/resources/upload/ckeditor/");
        					File uploadFile =new File(uploadPath);
        					if(!uploadFile.exists()) {
        						uploadFile.mkdirs();
        					}
        					
        					SimpleDateFormat sdf=new SimpleDateFormat("yyMMdd_HHmmssSSS");
        					int rndValue=(int)(Math.random()*1000);
        					fileName="ck"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
        					
        					//fileName= UUID.randomUUID().toString()+"."+ext;
        					uploadPath =uploadPath + "/" + fileName;
        					
        					
        					out= new FileOutputStream(new File(uploadPath));
        					out.write(bytes);
        					
        					
        					printWriter = response.getWriter();
        					response.setContentType("text/html");
        					String fileUrl =request.getContextPath()+"/resources/upload/ckeditor/"+fileName;
        					
        					//json 데이터로 등록
//        					json.addProperty("upload", 1);
//        					json.addProperty("fileName", fileName);
//        					json.addProperty("url", fileUrl);
//        					printWriter.println(json);
        					printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");


        				}catch(IOException e) {
        					e.printStackTrace();
        				}finally {
        					if(out!=null) {
        						out.close();
        					}
        					if(printWriter != null) {
        						printWriter.close();
        					}
        				}
        			}
        		}
        	}
        	
        	return null;
        		
        }
	

}
