package make.own.root.web;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import make.own.root.service.UserService;
import make.own.root.vo.User;

@Controller
@RequestMapping("/auth")
public class AuthController {

  static Logger logger = LogManager.getLogger(AuthController.class);

  @Autowired
  UserService userService;

  @GetMapping("form")
  public void form() {}

  @GetMapping("signSuccess")
  public void signSuccess() {}

  @PostMapping("login")
  public String login(String email, String password, String saveEmail, HttpServletResponse response,
      HttpSession session, Model model) throws Exception {
    System.out.println("login 호출됨");
    Cookie cookie = new Cookie("email", email);
    if (saveEmail != null) {
      cookie.setMaxAge(60 * 60 * 24 * 30);
    } else {
      cookie.setMaxAge(0);
    }
    response.addCookie(cookie);

    User user = userService.get(email, password);
    if (user != null) {
      session.setAttribute("loginUser", user);
      model.addAttribute("refreshUrl", "2;url=../../index.html");
      // 인클루딩 되는 서블릿은 응답 헤더를 추가할 수 없다.
      // 따라서 프론트 컨트롤러에게 추가해달라고 요청해야 한다.
    } else {
      session.invalidate();
      model.addAttribute("refreshUrl", "2;url=login");
    }
    return "auth/login";
  }

  @RequestMapping("logout")
  public String logout(HttpSession session) {
    session.invalidate();
    return "redirect:../../index.html";
  }

  @SuppressWarnings("unchecked")
  @GetMapping("facebookLogin")
  public String facebookLogin(String accessToken, HttpSession session, Model model)
      throws Exception {

    RestTemplate restTemplate = new RestTemplate();
    Map<String, Object> response = restTemplate.getForObject(
        "https://graph.facebook.com/v7.0/me?access_token={1}&fields={2}", Map.class, //
        accessToken, //
        "id,name,email");

    String email = (String) response.get("email");
    String name = (String) response.get("name");
    logger.info("페이스북 로그인 사용자 이메일은: {}", email);

    if (email == null) {
      session.invalidate();
      model.addAttribute("refreshUrl", "2;url=login");
      logger.info("무효하다");
      return "auth/login";
    }

    User user = userService.get(email);
    if (user == null) {
      user = new User();
      user.setName(name);
      user.setEmail(email);
      user.setBirth("");
      user.setTel("");
      user.setGender(0);
      user.setZipCode("");
      user.setBasicAddr("");
      user.setDetailAddr("");
      user.setNickName("");
      user.setPassword(UUID.randomUUID().toString());
      user.setAuthStatus(1);
      userService.add(user);
      logger.info("페이스북 사용자를 회원으로 등록한다.");
    }

    logger.info("세션에 로그인 사용자 정보를 보관한다.");
    session.setAttribute("loginUser", user);
    model.addAttribute("refreshUrl", "2;url=../../index.html");

    return "auth/login";
  }

  @ResponseBody
  @RequestMapping(value = "epSearch", method = RequestMethod.POST)
  public int epSearch(String email, String password) throws Exception {
    int count = userService.epSearch(email, password);
    System.out.println("epSearch 리턴 값" + count);
    return count;
  }
}
