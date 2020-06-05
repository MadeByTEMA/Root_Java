package make.own.root.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import make.own.root.vo.User;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface UserDao {

  int insert(User user) throws Exception;

  List<User> findAll() throws Exception;

  User findByNo(int no) throws Exception;

  User findByEmail(String email) throws Exception;

  int update(User user) throws Exception;

  int delete(int no) throws Exception;

  int updatePassword(User user) throws Exception;

  List<User> findByKeyword(String keyword) throws Exception;

  User findByEmailAndPassword(Map<String, Object> params) throws Exception;

  int epSearch(Map<String, Object> params) throws Exception;

  int enSearch(HashMap<String, Object> params) throws Exception;

  int nameSearch(String name) throws Exception;

  int nickNameSearch(String nickName) throws Exception;

  int emailSearch(String email) throws Exception;

  int telSearch(String tel) throws Exception;

  // withdraw Mapper에 없는 함수.

  //List<User> findAll(int userNo) throws Exception;

  //User findForWithdraw(Map<String, Object> params) throws Exception;


}
