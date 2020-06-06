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

  // UserServiceImpl add(User user)에서 호출
  int insert(User user) throws Exception;

  // UserServiceImpl get(int no)에서 호출
  User findByNo(int no) throws Exception;

  // UserServiceImpl get(String email)에서 호출
  User findByEmail(String email) throws Exception;

  // UserServiceImpl update(User user)에서 호출
  int update(User user) throws Exception;

  // UserServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;

  // UserServiceImpl updatePassword(User user)에서 호출
  int updatePassword(User user) throws Exception;

  // UserServiceImpl updateAuthStatus(User user)에서 호출
  int updateAuthStatus(User user) throws Exception;

  // UserServiceImpl search(String keyword)에서 호출
  List<User> findByKeyword(String keyword) throws Exception;

  // UserServiceImpl get(String email, String password)에서 호출
  User findByEmailAndPassword(Map<String, Object> params) throws Exception;

  // UserServiceImpl epSearch(String email, String password)에서 호출
  int epSearch(Map<String, Object> params) throws Exception;

  // UserServiceImpl enSearch(String email, String name)에서 호출
  int enSearch(HashMap<String, Object> params) throws Exception;

  // UserServiceImpl nameSearch(String name)에서 호출
  int nameSearch(String name) throws Exception;

  // UserServiceImpl nickNameSearch(String nickName)에서 호출
  int nickNameSearch(String nickName) throws Exception;

  // UserServiceImpl emailSearch(String email)에서 호출
  int emailSearch(String email) throws Exception;

  // UserServiceImpl telSearch(String tel)에서 호출
  int telSearch(String tel) throws Exception;

}
