package make.own.root.web;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import make.own.root.service.UserService;
import make.own.root.vo.User;

@Controller
@RequestMapping("/user")
public class UserController {
  static Logger logger = LogManager.getLogger(UserController.class);

  @Autowired
  ServletContext servletContext;

  @Autowired
  UserService userService;

  @GetMapping("form")
  public void form() {
  }

  @GetMapping("passCheck")
  public void passCheck() {
  }

  @GetMapping("findinfoform")
  public void findinfoform() {
  }

  @GetMapping("updateform")
  public void updateform() {
  }

  @RequestMapping("add")
  public String add(//
      String email, //
      String password, //
      String name, //
      String birth, //
      int gender, //
      String tel, //
      String zipCode, //
      String basicAddr, //
      String detailAddr, //
      String nickName, //
      MultipartFile photoFile) throws Exception {
    User user = new User(email, password, name, birth, gender, tel, zipCode, basicAddr, detailAddr, nickName);

    if (photoFile.getSize() > 0) {
      String dirPath = servletContext.getRealPath("/upload/user");
      String filename = UUID.randomUUID().toString();
      photoFile.transferTo(new File(dirPath + "/" + filename));
      user.setPhoto(filename);
    }

    if (userService.add(user) > 0) {
      return "redirect:../auth/form";
    } else {
      throw new Exception("회원을 추가할 수 없습니다.");
    }
  }

  @RequestMapping(value = "joinConfirm")
  public String emailConfirm(@ModelAttribute("user") User user, Model model) throws Exception {
    userService.updateAuthStatus(user);
    return "redirect:../auth/signSuccess";
  }

  @GetMapping("delete")
  public String delete(int no) throws Exception {
    if (userService.delete(no) > 0) { // 삭제했다면,
      return "redirect:list";
    } else {
      throw new Exception("삭제할 회원 번호가 유효하지 않습니다.");
    }
  }

  @GetMapping("detail")
  public void detail(int no, Model model) throws Exception {
    model.addAttribute("user", userService.get(no));
  }

  @GetMapping("search")
  public void search(String keyword, Model model) throws Exception {
    model.addAttribute("list", userService.search(keyword));
  }

  @PostMapping("update")
  public String update( //
      User updateUser, //
      MultipartFile photoFile, //
      HttpSession session //
      ) throws Exception {
    session.getAttribute("loginUser");
    if (photoFile.getSize() > 0) {
      String dirPath = servletContext.getRealPath("/upload/user");
      String filename = UUID.randomUUID().toString();
      photoFile.transferTo(new File(dirPath + "/" + filename));
      updateUser.setPhoto(filename);
    }
    if (userService.update(updateUser) > 0) {
      session.setAttribute("loginUser", updateUser);
      return "redirect:../mypage/form?no=" + updateUser.getNo();
    } else {
      throw new Exception("변경할 회원 번호가 유효하지 않습니다.");
    }
  }

  @PostMapping("findPass")
  public String findPass(User user) throws Exception {
    userService.updatePassword(user);
    return "redirect:../auth/form";
  }

  @ResponseBody
  @RequestMapping(value = "nickNameSearch", method = RequestMethod.POST)
  public int nickNameSearch(String nickName) throws Exception {
    int count = userService.nickNameSearch(nickName);
    return count;
  }

  @ResponseBody
  @RequestMapping(value = "emailSearch", method = RequestMethod.POST)
  public int emailSearch(String email) throws Exception {
    int count = userService.emailSearch(email);
    return count;
  }

  @ResponseBody
  @RequestMapping(value = "telSearch", method = RequestMethod.POST)
  public int telSearch(String tel) throws Exception {
    int count = userService.telSearch(tel);
    return count;
  }

  @ResponseBody
  @RequestMapping(value = "nameSearch", method = RequestMethod.POST)
  public int nameSearch(String name) throws Exception {
    int count = userService.nameSearch(name);
    return count;
  }

  @ResponseBody
  @RequestMapping(value = "epSearch", method = RequestMethod.POST)
  public int epSearch(String email, String password) throws Exception {
    System.out.println("email:"+email);
    System.out.println("password:" + password);
    int count = userService.epSearch(email, password);
    System.out.println("리턴 값" + count);
    return count;

  }

  @ResponseBody
  @RequestMapping(value = "enSearch", method = RequestMethod.POST)
  public int enSearch(String email, String name) throws Exception {
    int count = userService.enSearch(email, name);
    System.out.println("리턴 값" + count);
    return count;

  }

}
