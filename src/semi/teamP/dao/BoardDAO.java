package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.BoardDTO;

public class BoardDAO {
   Connection conn = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   
   //DB접속 생성자
   public BoardDAO() {
      try {
         Context ctx = new InitialContext();
         DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
         conn = ds.getConnection();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   //자원반납
   private void resClose() {
      try {
         if(rs != null) {
            rs.close();
         }
         ps.close();
         conn.close();
         System.out.println(ps);
         System.out.println(conn);
         System.out.println(rs);
      } catch (SQLException e) {
         e.printStackTrace();
      }
   }

   //글쓰기(그룹이 있는사람)
   public int groupWrite(BoardDTO dto) {
      long idx = 0;
      String sql = "INSERT INTO Bbs(bbs_idx, bbs_name, bbs_subject, bbs_content, group_idx, member_id) "
            + "VALUES(BBS_IDX_SEQ.NEXTVAL,?,?,?,?,?)";
      try {
         ps = conn.prepareStatement(sql, new String[] {"bbs_idx"});          
         ps.setString(1, dto.getBbs_name());
         ps.setString(2, dto.getBbs_subject());
         ps.setString(3, dto.getBbs_content());
         //그룹이 있는 회원은 group_idx 가 있기때문에 값셋팅이 필요하다
         ps.setInt(4,dto.getGroup_idx());
         ps.setString(5, dto.getMember_id());      
         ps.executeUpdate();
         rs = ps.getGeneratedKeys();            
         if(rs.next()) {
            //글작성 후 detail폼으로 넘기기위한 idx 추출
            idx = rs.getLong(1);
            dto.setBbs_idx((int) idx);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return (int) idx;
   }
   
   //글쓰기(그룹이 없는사람)
   public int write(BoardDTO dto) {
      long idx = 0;
      String sql = "INSERT INTO Bbs(bbs_idx, bbs_name, bbs_subject, bbs_content, member_id) "
            + "VALUES(BBS_IDX_SEQ.NEXTVAL,?,?,?,?)";
      try {
         ps = conn.prepareStatement(sql, new String[] {"bbs_idx"});
         ps.setString(1, dto.getBbs_name());
         ps.setString(2, dto.getBbs_subject());
         ps.setString(3, dto.getBbs_content());
         ps.setString(4, dto.getMember_id());
         //그룹이 없는 회원은 group_idx 가 기본으로 null 이 들어가기 때문에 값셋팅이 필요없다
         ps.executeUpdate();
         rs = ps.getGeneratedKeys();
         if(rs.next()) {
            //글작성 후 detail폼으로 넘기기위한 idx 추출
            idx = rs.getLong(1);
            dto.setBbs_idx((int) idx);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return (int) idx;
   }


   //상세보기 및 수정폼
      public BoardDTO detail(String idx) {
         BoardDTO dto = null;
         String sql = "SELECT * FROM Bbs WHERE bbs_idx=?";
         try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, idx);
            rs = ps.executeQuery();         
            if(rs.next()) {
               upHit(idx);
               dto = new BoardDTO();
               dto.setBbs_idx(rs.getInt("bbs_idx"));
               dto.setMember_id(rs.getString("member_id"));
               dto.setBbs_content(rs.getString("bbs_content"));
               dto.setBbs_subject(rs.getString("bbs_subject"));
               dto.setBbs_date(rs.getDate("bbs_date"));
               dto.setBbs_bHit(rs.getInt("bbs_bHit"));       
               dto.setBbs_name(rs.getString("bbs_name"));
            }               
         } catch (SQLException e) {         
            e.printStackTrace();
         }finally {
            resClose();
         }
         return dto;
      }

   //수정
   public int update(BoardDTO dto) {
      int success = 0 ;
      String sql = "UPDATE Bbs SET bbs_subject = ?, bbs_content = ? WHERE bbs_idx = ?";
      try {
         ps = conn.prepareStatement(sql);
         ps.setString(1, dto.getBbs_subject());
         ps.setString(2, dto.getBbs_content());
         ps.setInt(3, dto.getBbs_idx());
         success = ps.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         resClose();
      }
      return success;
   }
   
   //조회수 올리기
   private void upHit(String idx) {
      String sql = "UPDATE Bbs SET bbs_bHit = bbs_bHit+1 WHERE bbs_idx = ?";
      try {
         ps= conn.prepareStatement(sql);
         ps.setInt(1, Integer.parseInt(idx));
         ps.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }
      
   }

   //삭제
   public int del(String idx) {
       int success = 0;
         String sql = "DELETE FROM Bbs WHERE bbs_idx=?";
         try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idx));
            success = ps.executeUpdate();         
         } catch (SQLException e) {      
            e.printStackTrace();         
         }finally {
            resClose();
         }
         return success;      
   }

   
   //리스트 불러오기
      public ArrayList<BoardDTO> list(String keyField, String keyWord, int start, int end) {
         ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
            String sql = "";
            try {
              // 검색값없이 그냥 들어갔을때            
              if(keyWord.equals(null) || keyWord.equals("")) {
                 sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                       + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='freeBbs')"
                       + " WHERE rnum BETWEEN ? AND ?";
                 ps = conn.prepareStatement(sql);
                 ps.setInt(1, start);
                 ps.setInt(2, end);
             //검색값이 있을때
              }else{
                 sql = "SELECT * FROM Bbs WHERE bbs_name = 'freeBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
                 ps = conn.prepareStatement(sql);
                 ps.setString(1, "%" + keyWord + "%");
              }      
             rs = ps.executeQuery();
              while(rs.next()) {
                   BoardDTO dto = new BoardDTO();
                   dto.setBbs_idx(rs.getInt("bbs_idx"));
                   dto.setBbs_name(rs.getString("bbs_name"));
                   dto.setBbs_subject(rs.getString("bbs_subject"));
                   dto.setBbs_date(rs.getDate("bbs_date"));
                   dto.setBbs_bHit(rs.getInt("bbs_bHit"));
                   dto.setMember_id(rs.getString("member_id"));
                   dto.setReply_cnt(rs.getInt("reply_cnt"));
                   list.add(dto);
              }
            } catch (SQLException e) {
               e.printStackTrace();
            }finally {
               resClose();
         }
            return list;
      }
   
   //관리자게시판 리스트 불러오기
   public ArrayList<BoardDTO> adminList(String keyField, String keyWord, int start, int end) {
      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
         String sql = "";
         try {
           // 검색값없이 그냥 들어갔을때
           if(keyWord.equals(null) || keyWord.equals("")) {
              sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                       + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='adminBbs')"
                       + " WHERE rnum BETWEEN ? AND ?";
                 ps = conn.prepareStatement(sql);
                 ps.setInt(1, start);
                 ps.setInt(2, end);
          //검색값이 있을때
           }else{
              sql = "SELECT * FROM Bbs WHERE bbs_name = 'adminBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
              ps = conn.prepareStatement(sql);
              ps.setString(1, "%" + keyWord + "%");
           }      
          rs = ps.executeQuery();
         while(rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setBbs_idx(rs.getInt("bbs_idx"));
                dto.setBbs_name(rs.getString("bbs_name"));
                dto.setBbs_subject(rs.getString("bbs_subject"));
                dto.setBbs_date(rs.getDate("bbs_date"));
                dto.setBbs_bHit(rs.getInt("bbs_bHit"));
                dto.setMember_id(rs.getString("member_id"));
                list.add(dto);
         }
         } catch (SQLException e) {
            e.printStackTrace();
         }finally {
            resClose();
      }
         return list;
   }
   
   //그룹 리스트 불러오기(그룹장 및 그룹원)
   public ArrayList<BoardDTO> groupList(int group_idx, String keyField, String keyWord, int start, int end) {
      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
      //bbs_name 이 groupBbs 인 것만 select 해서 뿌리고 group_idx = ? 세팅
      String sql = "";
      try {
          if(keyWord.equals(null) || keyWord.equals("")) {
             sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                       + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='groupBbs' AND group_idx = ?)"
                       + " WHERE rnum BETWEEN ? AND ?";
             ps = conn.prepareStatement(sql);
             //가져온 그룹번호 세션값  group_idx 값 셋팅 -> 자신이 해당되어있는 그룹의 게시글만 볼수 있도록 하기위함
             ps.setInt(1, group_idx);
             ps.setInt(2, start);
              ps.setInt(3, end);
          }else {
             sql = "SELECT * FROM Bbs WHERE bbs_name = 'groupBbs' AND group_idx = ? AND " + keyField + " like ? ORDER BY bbs_idx DESC";
              ps = conn.prepareStatement(sql);
              ps.setInt(1, group_idx);
              ps.setString(2, "%" + keyWord + "%");
          }
             rs = ps.executeQuery();
             while(rs.next()) {
            BoardDTO dto = new BoardDTO();
            dto.setBbs_idx(rs.getInt("bbs_idx"));
            dto.setBbs_name(rs.getString("bbs_name"));
            dto.setBbs_subject(rs.getString("bbs_subject"));
            dto.setBbs_date(rs.getDate("bbs_date"));
            dto.setBbs_bHit(rs.getInt("bbs_bHit"));
            dto.setMember_id(rs.getString("member_id"));
            dto.setReply_cnt(rs.getInt("reply_cnt"));
            list.add(dto);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return list;
   }
   
   //그룹 리스트 불러오기(관리자)
   public ArrayList<BoardDTO> adminGroupBbsList(String keyField, String keyWord, int start, int end) {
      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
      //bbs_name 이 groupBbs 인 게시글 전부 불러오기 (관리자모드를 위함)
      String sql = "";
      try {
         if(keyWord.equals(null) || keyWord.equals("")) {
            sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                    + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='groupBbs')"
                    + " WHERE rnum BETWEEN ? AND ?";
              ps = conn.prepareStatement(sql);
              ps.setInt(1, start);
              ps.setInt(2, end);
         }else {
            sql = "SELECT * FROM Bbs WHERE bbs_name = 'groupBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
             ps = conn.prepareStatement(sql);
             ps.setString(1, "%" + keyWord + "%");
         }
         rs = ps.executeQuery();
         while(rs.next()) {
            BoardDTO dto = new BoardDTO();
            dto.setBbs_idx(rs.getInt("bbs_idx"));
            dto.setBbs_name(rs.getString("bbs_name"));
            dto.setBbs_subject(rs.getString("bbs_subject"));
            dto.setBbs_date(rs.getDate("bbs_date"));
            dto.setBbs_bHit(rs.getInt("bbs_bHit"));
            dto.setMember_id(rs.getString("member_id"));
            list.add(dto);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return list;
   }

   //파일 리스트 불러오기 
      public ArrayList<BoardDTO> fileList(int group_idx, String keyField, String keyWord, int start, int end) {
         ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
         String sql = "";
         try {
             if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                          + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='fileBbs' AND group_idx = ?)"
                          + " WHERE rnum BETWEEN ? AND ?";
                ps = conn.prepareStatement(sql);
                //가져온 그룹번호 세션값  group_idx 값 셋팅 -> 자신이 해당되어있는 그룹의 게시글만 볼수 있도록 하기위함
                ps.setInt(1, group_idx);
                ps.setInt(2, start);
                 ps.setInt(3, end);
             }else {
                sql = "SELECT * FROM Bbs WHERE bbs_name = 'fileBbs' AND group_idx = ? AND " + keyField + " like ? ORDER BY bbs_idx DESC";
                 ps = conn.prepareStatement(sql);
                 ps.setInt(1, group_idx);
                 ps.setString(2, "%" + keyWord + "%");
             }
                rs = ps.executeQuery();
                while(rs.next()) {
               BoardDTO dto = new BoardDTO();
               dto.setBbs_idx(rs.getInt("bbs_idx"));
               dto.setBbs_name(rs.getString("bbs_name"));
               dto.setBbs_subject(rs.getString("bbs_subject"));
               dto.setBbs_date(rs.getDate("bbs_date"));
               dto.setBbs_bHit(rs.getInt("bbs_bHit"));
               dto.setMember_id(rs.getString("member_id"));
               dto.setReply_cnt(rs.getInt("reply_cnt"));
               list.add(dto);
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }finally {
            resClose();
         }
         return list;
      }

      //파일 게시판 글쓰기
      public int fileWrite(BoardDTO dto) {
            String sql ="INSERT INTO Bbs(bbs_idx, bbs_name, bbs_subject, bbs_content, group_idx, member_id) "
                  + "VALUES(BBS_IDX_SEQ.NEXTVAL,?,?,?,?,?)";
            long fk = 0;
            try {
               //ojdbc 8 버전 이상에서 가능
               //2번째 인자 값은 값을 넣고 반환 해줄 컬럼
               //new String[] {"반환받을 컬럼명"}
               //new int[]{"반환받을 컬럼 번호"}
               ps = conn.prepareStatement(sql, new String[] {"bbs_idx"});
               ps.setString(1, dto.getBbs_name());
               ps.setString(2, dto.getBbs_subject());
               ps.setString(3, dto.getBbs_content());
               ps.setInt(4, dto.getGroup_idx());
               ps.setString(5, dto.getMember_id());
               ps.executeUpdate();         
               rs = ps.getGeneratedKeys(); //이 과정으로 원하는 컬럼을 받아 올 수 있다
               String fileName = dto.getNewFileName();
               System.out.println("fileName : " +fileName);
               if(rs.next()) {
                  fk = rs.getLong(1); //넣은 값의 idx 받아오기
                  if(fileName != null) {            
                     //idx 를 이용해서 photo 테이블에 데이터 넣기 
                     sql = "INSERT INTO Bbs_file (file_index,bbs_idx,newFileName) VALUES(file_index_seq.NEXTVAL,?,?)";
                     ps = conn.prepareStatement(sql);
                     ps.setLong(1, fk);
                     ps.setString(2, fileName);
                     ps.executeUpdate();
                  }
               }         
            } catch (SQLException e) {         
               e.printStackTrace();
               return 0;
            }finally {
               resClose();
            }
            return (int)fk;//idx 값 변환
         }

   //파일게시판 상세정보 
   public BoardDTO fileDetail(String idx) {
      BoardDTO dto = null;
      String sql = "SELECT * FROM Bbs WHERE bbs_idx = ?";
      try {
         ps = conn.prepareStatement(sql);
         ps.setInt(1, Integer.parseInt(idx));
         rs = ps.executeQuery();
         
         if(rs.next()) {
            upHit(idx);
            dto = new BoardDTO();
            dto.setBbs_idx(rs.getInt("bbs_idx"));
               dto.setMember_id(rs.getString("member_id"));
               dto.setBbs_content(rs.getString("bbs_content"));
               dto.setBbs_subject(rs.getString("bbs_subject"));
               dto.setBbs_date(rs.getDate("bbs_date"));
               dto.setBbs_bHit(rs.getInt("bbs_bHit"));       
               dto.setBbs_name(rs.getString("bbs_name"));
         }
         
         //파일명 추출
         String newFileName = fileNameCall(dto.getBbs_idx());
         
         if(newFileName != null) {
            dto.setNewFileName(newFileName);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return dto;
   }
   
   //게시글에 해당하는 파일명 추출
   public String fileNameCall(int idx) {
      String sql = "SELECT newFileName FROM Bbs_file WHERE bbs_idx = ?";
      String fileName = null;
      try {
         ps = conn.prepareStatement(sql);
         ps.setInt(1, idx);
         rs = ps.executeQuery();
         fileName = rs.next() ? rs.getString("newFileName") : null ;
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return fileName;
   }
   
   //파일 수정
   public void fileNameUpdate(int bbs_idx, String newFileName, String oldFileName) {
      String sql = "";
      try { // 기존파일이 있는경우
         if(oldFileName != null) {
            sql = "UPDATE Bbs_file SET newFileName = ? WHERE bbs_idx = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newFileName);
            ps.setInt(2, bbs_idx);
         }else { // 없는경우
            sql = "INSERT INTO Bbs_file VALUES(file_index_seq.NEXTVAL,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bbs_idx);
            ps.setString(2, "noFile");
            ps.setString(3, newFileName);
         }
         ps.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
   }
   
   //파일게시판 수정
   public int fileUpdate(BoardDTO dto) {
      int success = 0;
      String sql = "UPDATE Bbs SET bbs_subject = ?, bbs_content = ? WHERE bbs_idx = ?";
      try {
         ps = conn.prepareStatement(sql);
         ps.setString(1, dto.getBbs_subject());
         ps.setString(2, dto.getBbs_content());
         ps.setInt(3, dto.getBbs_idx());
         success = ps.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return success;
   }
   
   //파일게시판 관리자모드
   public ArrayList<BoardDTO> adminFileBbsList(String keyField, String keyWord, int start, int end) {
      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
      //bbs_name 이 groupBbs 인 게시글 전부 불러오기 (관리자모드를 위함)
      String sql = "";
      try {
         if(keyWord.equals(null) || keyWord.equals("")) {
            sql = "SELECT bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id, reply_cnt FROM"
                    + " (SELECT ROW_NUMBER() OVER(ORDER BY bbs_idx DESC) AS rnum, bbs_idx, bbs_name, bbs_subject, bbs_date, bbs_bHit, member_id,reply_cnt FROM Bbs WHERE bbs_name='fileBbs')"
                    + " WHERE rnum BETWEEN ? AND ?";
              ps = conn.prepareStatement(sql);
              ps.setInt(1, start);
              ps.setInt(2, end);
         }else {
            sql = "SELECT * FROM Bbs WHERE bbs_name = 'fileBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
             ps = conn.prepareStatement(sql);
             ps.setString(1, "%" + keyWord + "%");
         }
         rs = ps.executeQuery();
         while(rs.next()) {
            BoardDTO dto = new BoardDTO();
            dto.setBbs_idx(rs.getInt("bbs_idx"));
            dto.setBbs_name(rs.getString("bbs_name"));
            dto.setBbs_subject(rs.getString("bbs_subject"));
            dto.setBbs_date(rs.getDate("bbs_date"));
            dto.setBbs_bHit(rs.getInt("bbs_bHit"));
            dto.setMember_id(rs.getString("member_id"));
            list.add(dto);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {
         resClose();
      }
      return list;
   }
   
      public int getTotalCount(String keyField, String keyWord) {
            int totalRecord = 0;
            String sql = "";
            try {
               if(keyWord.equals(null) || keyWord.equals("")) {
                   sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'freeBbs' ORDER BY bbs_idx DESC";
                  ps = conn.prepareStatement(sql);
               }else {
                  sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'freeBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
                  ps = conn.prepareStatement(sql);
                   ps.setString(1, "%" + keyWord + "%");
               }
               rs = ps.executeQuery();
               if(rs.next()) {
                  totalRecord = (rs.getInt("COUNT(bbs_idx)"));
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            return totalRecord;
         }

   public int getAdminTotalCount(String keyField, String keyWord) {
       int totalRecord = 0;
         String sql = "";
         try {
            if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'adminBbs' ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
            }else {
               sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'adminBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyWord + "%");
            }
            rs = ps.executeQuery();
            if(rs.next()) {
               totalRecord = (rs.getInt("COUNT(bbs_idx)"));
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
         return totalRecord;
   }

   public int getFileTotalCount(int group_idx, String keyField, String keyWord) {
      int totalRecord = 0;
         String sql = "";
         try {
            if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'fileBbs' AND group_idx = ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
               ps.setInt(1, group_idx);
            }else {
               sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'fileBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyWord + "%");
            }
            rs = ps.executeQuery();
            if(rs.next()) {
               totalRecord = (rs.getInt("COUNT(bbs_idx)"));
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
         return totalRecord;
   }

   public int getAdminGroupTotalCount(String keyField, String keyWord) {
      int totalRecord = 0;
         String sql = "";
         try {
            if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'groupBbs' ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
            }else {
               sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'groupBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyWord + "%");
            }
            rs = ps.executeQuery();
            if(rs.next()) {
               totalRecord = (rs.getInt("COUNT(bbs_idx)"));
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
         return totalRecord;
   }

   public int getGroupTotalCount(int group_idx, String keyField, String keyWord) {
      int totalRecord = 0;
         String sql = "";
         try {
            if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'groupBbs' AND group_idx = ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
               ps.setInt(1, group_idx);
            }else {
               sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'groupBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyWord + "%");
            }
            rs = ps.executeQuery();
            if(rs.next()) {
               totalRecord = (rs.getInt("COUNT(bbs_idx)"));
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
         return totalRecord;
   }

   public int getAdminFileTotalCount(String keyField, String keyWord) {
      int totalRecord = 0;
         String sql = "";
         try {
            if(keyWord.equals(null) || keyWord.equals("")) {
                sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'fileBbs' ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
            }else {
               sql = "SELECT COUNT(bbs_idx) FROM Bbs WHERE bbs_name = 'fileBbs' AND " + keyField + " like ? ORDER BY bbs_idx DESC";
               ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + keyWord + "%");
            }
            rs = ps.executeQuery();
            if(rs.next()) {
               totalRecord = (rs.getInt("COUNT(bbs_idx)"));
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
         return totalRecord;
   }
}