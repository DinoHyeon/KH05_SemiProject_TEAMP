package semi.teamP.dto;

import java.sql.Date;

public class BoardDTO {
   private int bbs_idx;
   private String bbs_name;
   private String bbs_subject;
   private String bbs_content;
   private Date bbs_date;
   private int bbs_bHit;
   private int group_idx;
   private String member_id;
   private String newFileName;
   
   //페이징
   private int totalRecord;
   
   public int getTotalRecord() {
	return totalRecord;
}
   
   public void setTotalRecord(int totalRecord) {
	this.totalRecord = totalRecord;
}


public int getBbs_idx() {
      return bbs_idx;
   }
   public void setBbs_idx(int bbs_idx) {
      this.bbs_idx = bbs_idx;
   }
   public String getBbs_name() {
      return bbs_name;
   }
   public void setBbs_name(String bbs_name) {
      this.bbs_name = bbs_name;
   }
   public String getBbs_subject() {
      return bbs_subject;
   }
   public void setBbs_subject(String bbs_subject) {
      this.bbs_subject = bbs_subject;
   }
   public String getBbs_content() {
      return bbs_content;
   }
   public void setBbs_content(String bbs_content) {
      this.bbs_content = bbs_content;
   }
   public Date getBbs_date() {
      return bbs_date;
   }
   public void setBbs_date(Date bbs_date) {
      this.bbs_date = bbs_date;
   }
   public int getBbs_bHit() {
      return bbs_bHit;
   }
   public void setBbs_bHit(int bbs_bHit) {
      this.bbs_bHit = bbs_bHit;
   }
   public int getGroup_idx() {
      return group_idx;
   }
   public void setGroup_idx(int group_idx) {
      this.group_idx = group_idx;
   }
   public String getMember_id() {
      return member_id;
   }
   public void setMember_id(String member_id) {
      this.member_id = member_id;
   }
   public String getNewFileName() {
      return newFileName;
   }
   public void setNewFileName(String newFileName) {
      this.newFileName = newFileName;
   }
   
}   	
   
