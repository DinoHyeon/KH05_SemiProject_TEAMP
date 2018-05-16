package semi.teamP.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import semi.teamP.dto.BoardDTO;

public class PhotoUpload {
   
   HttpServletRequest request = null;
   HttpServletResponse response = null;
   String savePath = null;
      
   public PhotoUpload(HttpServletRequest request, HttpServletResponse response) {
      this.request = request;
      this.response = response;
      String root = request.getSession().getServletContext().getRealPath("/");
      savePath = root + "upload";
   }

   //사진 등록
   public BoardDTO regist() {
      BoardDTO dto = new BoardDTO();
      
      //upload 폴더 없으면 만들어 준다
      File dir = new File(savePath);
      if(!dir.exists()) { //존재하냐
         dir.mkdirs();    //폴더 생성
      }
      
      //MultipartRequest 로 변환
      try {
         MultipartRequest multi = new MultipartRequest(request, savePath, 1024*1024*10, "UTF-8");
         //MultipartRequest 에서 제목, 내용, 작성자 추출해서 DTO 넣어줌
         
         dto.setMember_id((String)request.getSession().getAttribute("loginId"));
         dto.setBbs_subject(multi.getParameter("bbs_subject"));
         dto.setBbs_content(multi.getParameter("bbs_content"));
         dto.setBbs_name(multi.getParameter("bbs_name"));
         dto.setGroup_idx((int)request.getSession().getAttribute("groupNum"));
         
         //파일명 변경(업로드한 파일이 있을 경우만 실행 )
         String oriFileName = multi.getFilesystemName("photo");
         if(oriFileName != null) {
            //확장자 추출
            String ext = oriFileName.substring(oriFileName.indexOf("."));
            //새파일명 만들기(새파일명 + 확장자)
            String newFileName = System.currentTimeMillis() + ext;
            //파일명 변경
            File oldFile = new File(savePath+"/"+oriFileName);
            File newFile = new File(savePath+"/"+newFileName);
            oldFile.renameTo(newFile);
            //변경된 파일명 DTO 에 추가 
            dto.setNewFileName(newFileName);                        
         }
         
         //수정할때 필요(idx 값이 넘어올 경우만 작동)
         String idx = multi.getParameter("idx");
         System.out.println(idx);
         if(idx != null) {
            dto.setBbs_idx(Integer.parseInt(idx));
            System.out.println(dto.getBbs_idx());
         }
         
      } catch (IOException e) {            
         e.printStackTrace();
      }      
      return dto;//DTO 반환
   }

   //파일삭제
   public void del(String fileName) {
      System.out.println("삭제 주소"+ savePath);      
      File file =new File(savePath+"/"+ fileName);
      if(file.exists()) { //파일 존재 여부를 다시 한번 확인
         System.out.println("파일을 삭제  성공 ?"+ file.delete());     
      }   
   }
   
   //첨부파일 다운로드
	public void downLoad(String fileName) {
		File downFile = new File(savePath+"/"+fileName);	
		// 다운로드
	    if (downFile.exists() && downFile.isFile()) {
	    try {
            // 파일 사이즈 조사하고
            long filesize = downFile.length();

            // content타입과 해더를 셋팅하여 파일을 출력
            response.setContentType("application/x-msdownload");
            response.setContentLength((int) filesize);
            String strClient = request.getHeader("user-agent");
            if (strClient.indexOf("MSIE 5.5") != -1) {
                response.setHeader("Content-Disposition", "filename=" + fileName + ";");
            }else {
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
            }
            response.setHeader("Content-Length", String.valueOf(filesize));
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "private");
 
            byte b[] = new byte[1024];
 
            BufferedInputStream fin = new BufferedInputStream(new FileInputStream(downFile));
            BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
            int read = 0;
            
            while ((read = fin.read(b)) != -1) {outs.write(b, 0, read);}
                outs.flush();
                outs.close();
                fin.close();
            }catch (Exception e) {
                System.out.println("Download Exception : " + e.getMessage());
            }
	    }else{
	    	System.out.println("Download Error : downFile Error [" + downFile + "]");
	    }

		}
	}