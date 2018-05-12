package semi.teamP.dto;

import java.sql.Date;

public class GroupInfoDTO {
   private String member_id;
   private int group_idx;
   private String group_StrartDay;
   private String group_EndDay;
   private String group_name;
   
   public String getMember_id() {
      return member_id;
   }
   public void setMember_id(String member_id) {
      this.member_id = member_id;
   }
   public int getGroup_idx() {
      return group_idx;
   }
   public void setGroup_idx(int group_idx) {
      this.group_idx = group_idx;
   }
   public String getGroup_StrartDay() {
      return group_StrartDay;
   }
   public void setGroup_StrartDay(String group_StrartDay) {
      this.group_StrartDay = group_StrartDay;
   }
   public String getGroup_EndDay() {
      return group_EndDay;
   }
   public void setGroup_EndDay(String group_EndDay) {
      this.group_EndDay = group_EndDay;
   }
   public String getGroup_name() {
      return group_name;
   }
   public void setGroup_name(String group_name) {
      this.group_name = group_name;
   }
  
}