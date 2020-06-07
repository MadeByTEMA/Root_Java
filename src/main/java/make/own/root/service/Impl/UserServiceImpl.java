package make.own.root.service.Impl;

import java.util.HashMap;
import java.util.List;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import make.own.root.TempKey;
import make.own.root.TempPass;
import make.own.root.dao.UserDao;
import make.own.root.service.UserService;
import make.own.root.vo.User;

@Component
public class UserServiceImpl implements UserService {
  UserDao userDao;

  @Autowired
  JavaMailSender mailSender;

  public UserServiceImpl(UserDao UserDao) {
    this.userDao = UserDao;
  }

  // UserController delete()에서 호출
  @Override
  public int delete(int no) throws Exception {
    return userDao.delete(no);
  }


  // UserController add()에서 호출
  // AuthController facebookLogin()에서 호출
  @Override
  public int add(User user) throws Exception {

    // 임의의 authkey 생성
    String authKey = new TempKey().getKey(50, false);

    user.setAuthKey(authKey);

    // mail 작성 관련
    MimeMessage mail = mailSender.createMimeMessage();
    String mailContent = "<h1>[이메일 인증]</h1><br><p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>"
        + "<a href='http://localhost:9999/Root_Java/app/user/joinConfirm?email="
        + user.getEmail() + "&authKey=" + authKey + "' target='_blenk'>이메일 인증 확인</a>";

    try {
      mail.setSubject("회원가입 이메일 인증 ", "utf-8");
      mail.setText(mailContent, "utf-8", "html");
      mail.addRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
      mailSender.send(mail);
    } catch (MessagingException e) {
      e.printStackTrace();
    }
    return userDao.insert(user);
  }

  // UserController findPass()에서 호출
  @Override
  public int updatePassword(User user) throws Exception {
    String randomPass = new TempPass().getKey(8);
    user.setPassword(randomPass);
    // mail 작성 관련
    MimeMessage mail = mailSender.createMimeMessage();
    String mailContent = "<h1>[비밀번호 변경]</h1><br><p>아래의 비밀변경으로 로그인해주세요.</p> <br>" + randomPass;
    try {
      mail.setSubject("비밀번호 변경 인증 ", "utf-8");
      mail.setText(mailContent, "utf-8", "html");
      mail.addRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
      mailSender.send(mail);
    } catch (MessagingException e) {
      e.printStackTrace();
    }
    return userDao.updatePassword(user);
  }

  // UserController delete(), detail()에서 호출
  @Override
  public User get(int no) throws Exception {
    return userDao.findByNo(no);
  }

  // AuthController facebookLogin()에서 호출
  @Override
  public User get(String email) throws Exception {
    return userDao.findByEmail(email);
  }

  // AuthController login()에서 호출
  @Override
  public User get(String email, String password) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("password", password);
    return userDao.findByEmailAndPassword(params);
  }

  // UserController search()에서 호출
  @Override
  public List<User> search(String keyword) throws Exception {
    return userDao.findByKeyword(keyword);
  }

  // UserController nickNameSearch()에서 호출
  @Override
  public Integer nickNameSearch(String nickName) throws Exception {
    return userDao.nickNameSearch(nickName);
  }

  // UserController emailSearch()에서 호출
  @Override
  public Integer emailSearch(String email) throws Exception {
    return userDao.emailSearch(email);
  }

  // UserController telSearch()에서 호출
  @Override
  public Integer telSearch(String tel) throws Exception {
    return userDao.telSearch(tel);
  }

  // UserController telSearch()에서 호출
  @Override
  public Integer nameSearch(String name) throws Exception {
    return userDao.nameSearch(name);
  }

  // UserController epSearch()에서 호출
  // AuthController epSearch()에서 호출
  @Override
  public Integer epSearch(String email, String password) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("password", password);
    return userDao.epSearch(params);
  }

  // UserController enSearch()에서 호출
  @Override
  public Integer enSearch(String email, String name) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("email", email);
    params.put("name", name);
    return userDao.enSearch(params);
  }

  // UserController update()에서 호출
  @Override
  public int update(User user) throws Exception {
    return userDao.update(user);
  }

  // UserController emailConfirm()에서 호출
  @Override
  public int updateAuthStatus(User user) throws Exception{
    return userDao.updateAuthStatus(user);
  }

}
