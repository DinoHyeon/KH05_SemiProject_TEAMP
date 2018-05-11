package semi.teamP.dto;

import java.sql.Date;

public class GroupInviteDTO {
	   private int invite_idx;
	   private String from_memberId;
	   private String to_memberId;
	   private int  group_idx;
	   private String group_name;
	   private String invite_content;
	   private String invite_date;
	   
	   public int getInvite_idx() {
	      return invite_idx;
	   }
	   public void setInvite_idx(int invite_idx) {
	      this.invite_idx = invite_idx;
	   }
	   public String getFrom_memberId() {
	      return from_memberId;
	   }
	   public void setFrom_memberId(String from_memberId) {
	      this.from_memberId = from_memberId;
	   }
	   public String getTo_memberId() {
		   return to_memberId;
	   }
	   public void setTo_memberId(String to_memberId) {
		   this.to_memberId = to_memberId;
		}
	   public int getGroup_idx() {
	      return group_idx;
	   }
	   public void setGroup_idx(int group_idx) {
	      this.group_idx = group_idx;
	   }
	   public String getGroup_name() {
	      return group_name;
	   }
	   public void setGroup_name(String group_name) {
	      this.group_name = group_name;
	   }
	   public String getInvite_content() {
	      return invite_content;
	   }
	   public void setInvite_content(String invite_content) {
	      this.invite_content = invite_content;
	   }
	   public String getInvite_date() {
		   return invite_date;
	   }
	   public void setInvite_date(String invite_date) {
		   this.invite_date = invite_date;
	   }
		   
		   
		   
	}