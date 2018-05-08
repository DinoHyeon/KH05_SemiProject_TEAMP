package semi.teamP.dto;

import java.sql.Date;

public class ReplyDTO {
   private int comment_idx;
   private String comment_content;
   private String member_id;
   private Date comment_date;
   private int bbs_idx;
   public int getComment_idx() {
      return comment_idx;
   }
   public void setComment_idx(int comment_idx) {
      this.comment_idx = comment_idx;
   }
   public String getComment_content() {
      return comment_content;
   }
   public void setComment_content(String comment_content) {
      this.comment_content = comment_content;
   }
   public String getMember_id() {
      return member_id;
   }
   public void setMember_id(String member_id) {
      this.member_id = member_id;
   }
   public Date getComment_date() {
      return comment_date;
   }
   public void setComment_date(Date comment_date) {
      this.comment_date = comment_date;
   }
   public int getBbs_idx() {
      return bbs_idx;
   }
   public void setBbs_idx(int bbs_idx) {
      this.bbs_idx = bbs_idx;
   }
   
   
   
}