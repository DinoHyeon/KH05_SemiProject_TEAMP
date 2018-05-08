package semi.teamP.dto;

public class TodoDTO {
	   private int to_do_idx;
	   private String todo_content;
	   private String todo_state;
	   private String member_id;
	   public int getTo_do_idx() {
	      return to_do_idx;
	   }
	   public void setTo_do_idx(int to_do_idx) {
	      this.to_do_idx = to_do_idx;
	   }
	   public String getTodo_content() {
	      return todo_content;
	   }
	   public void setTodo_content(String todo_content) {
	      this.todo_content = todo_content;
	   }
	   public String getTodo_state() {
	      return todo_state;
	   }
	   public void setTodo_state(String todo_state) {
	      this.todo_state = todo_state;
	   }
	   public String getMember_id() {
	      return member_id;
	   }
	   public void setMember_id(String member_id) {
	      this.member_id = member_id;
	   }
	   
	}