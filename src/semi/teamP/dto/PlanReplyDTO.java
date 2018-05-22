package semi.teamP.dto;

import java.sql.Date;

public class PlanReplyDTO {


/*CREATE TABLE Plan_comment(
   pc_num NUMBER(20) PRIMARY KEY,
   pc_content NVARCHAR2(100),
   plan_idx NUMBER(20) NOT NULL,
   member_idx NUMBER(20) NOT NULL,
   pc_date DATE,
   CONSTRAINT fk_Plan_comment_plan_idx FOREIGN KEY(plan_idx) REFERENCES Plan(plan_idx) ON DELETE CASCADE,
   CONSTRAINT fk_Plan_comment_member_idx FOREIGN KEY(member_idx) REFERENCES member_group(member_idx) ON DELETE CASCADE
);

CREATE SEQUENCE pc_idx_seq START WITH 1 MINVALUE 1;*/
	
	private int pc_num;
	private String pc_content;
	private int plan_idx;
	private String member_id;
	private String pc_date;
	public int getPc_num() {
		return pc_num;
	}
	public void setPc_num(int pc_num) {
		this.pc_num = pc_num;
	}
	public String getPc_content() {
		return pc_content;
	}
	public void setPc_content(String pc_content) {
		this.pc_content = pc_content;
	}
	public int getPlan_idx() {
		return plan_idx;
	}
	public void setPlan_idx(int plan_idx) {
		this.plan_idx = plan_idx;
	}

	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPc_date() {
		return pc_date;
	}
	public void setPc_date(String pc_date) {
		this.pc_date = pc_date;
	}

	
	
}
