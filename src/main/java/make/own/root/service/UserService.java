package make.own.root.service;

import java.util.List;

import make.own.root.vo.User;

public interface UserService {

  int delete(int no) throws Exception;

  int add(User user) throws Exception;

  User get(int no) throws Exception;

  User get(String email) throws Exception;

  User get(String email, String password) throws Exception;

  List<User> search(String keyword) throws Exception;

  int update(User user) throws Exception;

  Integer nickNameSearch(String nickName) throws Exception;

  Integer emailSearch(String email) throws Exception;

  Integer telSearch(String tel) throws Exception;

  Integer nameSearch(String name) throws Exception;

  Integer epSearch(String email, String password) throws Exception;

  Integer enSearch(String email, String name) throws Exception;

  int updateAuthStatus(User user) throws Exception;

  int updatePassword(User user) throws Exception;

  // withdraw
}
