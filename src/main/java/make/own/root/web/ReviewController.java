package make.own.root.web;

import java.io.File;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import make.own.root.service.CourseService;
import make.own.root.service.ReviewDayService;
import make.own.root.service.ReviewPlaceService;
import make.own.root.service.ReviewService;
import make.own.root.vo.Review;
import make.own.root.vo.ReviewDay;
import make.own.root.vo.ReviewPlace;
import make.own.root.vo.User;

@Controller
@RequestMapping("/review")
public class ReviewController {

  static Logger logger = LogManager.getLogger(ReviewController.class);

  @Autowired
  ServletContext servletContext;

  @Autowired
  ReviewService reviewService;

  @Autowired
  CourseService courseService;

  @Autowired
  ReviewDayService reviewDayService;

  @Autowired
  ReviewPlaceService reviewPlaceService;

  @GetMapping("form")
  public void form(String no, HttpSession session, Model model) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("로그인이 필요합니다.");
    }
    if (!no.equals("newForm")) {
      int reviewNo = Integer.parseInt(no);
      session.setAttribute("review", reviewService.get(reviewNo));
      model.addAttribute("list", courseService.list(user.getNo()));
    } else {
      session.removeAttribute("review");
      model.addAttribute("list", courseService.list(user.getNo()));
    }
  }

  @RequestMapping("add")
  public String add(//
      HttpSession session, //
      String status,

      String[] titles, //
      String[] reviewDayMainPhotos, //
      String[] mainReviews, //
      Date dayDate, //
      String[] placeLengths, //

      String[] names, //
      String[] basicAddrs, //
      String[] detailAddrs, //
      String[] placeReviews, //
      String[] reviewPlaceMainPhotos //
  ) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("유저 번호가 유효하지 않습니다.");
    }

    for (int i = 0; i < reviewDayMainPhotos.length; i++) {
      System.out.println(reviewDayMainPhotos[i]);
      System.out.println(reviewDayMainPhotos[i].indexOf("temp"));
    }
    System.out.println("===========================");
    for (int i = 0; i < reviewPlaceMainPhotos.length; i++) {
      System.out.println(reviewPlaceMainPhotos[i]);
      System.out.println(reviewPlaceMainPhotos[i].indexOf("temp"));
    }

    Review oldReview = (Review) session.getAttribute("review");
    Review newReview = new Review();
    if (oldReview != null) { // Update라면,
      newReview.setNo(oldReview.getNo());
      newReview.setUser(user);
      newReview.setCreatedDate(oldReview.getCreatedDate());
      newReview.setStatus(Integer.parseInt(status));
      List<ReviewDay> reviewdays = new LinkedList<>();
      int count = 0;
      for (int dayIndex = 0; dayIndex < titles.length; dayIndex++) {
        Date newDayDate = dayDate;
        newDayDate.setDate((newDayDate.getDate() + dayIndex));
        List<ReviewDay> oldDays = oldReview.getReviewDay();
        ReviewDay reviewday = new ReviewDay(titles[dayIndex], newDayDate, mainReviews[dayIndex],
            Integer.parseInt(status));
        if (dayIndex < oldDays.size() && oldDays.get(dayIndex) != null) { // 만약 Update할 ReviewDayNo가 존재한다면, 전달
          reviewday.setNo(oldDays.get(dayIndex).getNo());
        }
        if (reviewDayMainPhotos[dayIndex].indexOf("temp") >= 0) {
          String filePath = servletContext.getRealPath("/upload/review");
          String tempPath = servletContext.getRealPath("/upload/review/temp");
          String filename = reviewDayMainPhotos[dayIndex].split("temp")[1];
          (new File(tempPath + "//" + filename)).renameTo(new File(filePath + "//" + filename));
          reviewday.setMainPhoto(filename);
        }
        List<ReviewPlace> reviewplaces = new LinkedList<>();
        for (int i = 0; i < Integer.parseInt(placeLengths[dayIndex]); i++) {
          ReviewPlace reviewplace = new ReviewPlace(names[i + count], basicAddrs[i + count], placeReviews[i + count],
              Integer.parseInt(status));
          if (detailAddrs[i + count] != null) {
            reviewplace.setDetailAddr(detailAddrs[i + count]);
          }
          if (reviewPlaceMainPhotos[i + count].indexOf("temp") >= 0) {
            String filePath = servletContext.getRealPath("/upload/review");
            String tempPath = servletContext.getRealPath("/upload/review/temp");
            String filename = reviewPlaceMainPhotos[i + count].split("temp")[1];
            (new File(tempPath + "//" + filename)).renameTo(new File(filePath + "//" + filename));
            reviewplace.setMainPhoto(filename);
          }
          if (dayIndex < oldDays.size() && i < oldDays.get(dayIndex).getReviewPlace().size()
              && oldDays.get(dayIndex).getReviewPlace().get(i) != null) {
            reviewplace.setNo(oldDays.get(dayIndex).getReviewPlace().get(i).getNo());
          }
          if (dayIndex < oldDays.size() && i < oldDays.get(dayIndex).getReviewPlace().size()
              && oldDays.get(dayIndex).getReviewPlace().size() > Integer.parseInt(placeLengths[dayIndex])) {
            for (int oldPlaceIndex = Integer.parseInt(placeLengths[dayIndex]); oldPlaceIndex < oldDays.get(dayIndex)
                .getReviewPlace().size(); oldPlaceIndex++) {
              reviewPlaceService.delete(oldDays.get(dayIndex).getReviewPlace().get(oldPlaceIndex).getNo());
            }
          }
          reviewplaces.add(reviewplace);
        }
        reviewday.setReviewPlace(reviewplaces);
        reviewdays.add(reviewday);
        count += Integer.parseInt(placeLengths[dayIndex]);

        if (oldDays.size() > titles.length) { // 업데이트 전 Course에는 있지만 없어진 Day 삭제
          for (int i = titles.length; i < oldDays.size(); i++) {
            List<ReviewPlace> oldReviewPlaces = oldDays.get(i).getReviewPlace();
            for (int oldPlaceIndex = 0; oldPlaceIndex < oldReviewPlaces.size(); oldPlaceIndex++) {
              reviewPlaceService.delete(oldReviewPlaces.get(oldPlaceIndex).getNo());
            }
            reviewDayService.delete(oldDays.get(i).getNo());
          }
        }
        newReview.setReviewDay(reviewdays);
      }
      reviewService.update(newReview);
      session.removeAttribute("review");
    } else {
      newReview.setUser(user);
      List<ReviewDay> reviewdays = new LinkedList<>(); // review 안에 들어갈 dayList 생성
      int count = 0;
      for (int dayIndex = 0; dayIndex < titles.length; dayIndex++) { // dayIndex에 맞게 for문 구분
        Date newDayDate = dayDate;
        newDayDate.setDate((newDayDate.getDate() + dayIndex));
        ReviewDay reviewday = new ReviewDay(titles[dayIndex], newDayDate, mainReviews[dayIndex],
            Integer.parseInt(status));
        if (reviewDayMainPhotos[dayIndex].indexOf("temp") >= 0) {
          String filePath = servletContext.getRealPath("/upload/review");
          String tempPath = servletContext.getRealPath("/upload/review/temp");
          String filename = reviewDayMainPhotos[dayIndex].split("temp")[1];
          (new File(tempPath + "//" + filename)).renameTo(new File(filePath + "//" + filename));
          reviewday.setMainPhoto(filename);
        }
        List<ReviewPlace> reviewplaces = new LinkedList<>();
        for (int i = 0; i < Integer.parseInt(placeLengths[dayIndex]); i++) { // dayIndex에 들어갈 PlaceList 생성
          ReviewPlace reviewplace = new ReviewPlace(names[i + count], basicAddrs[i + count], placeReviews[i + count],
              Integer.parseInt(status));
          if (detailAddrs[i + count] != null) {
            reviewplace.setDetailAddr(detailAddrs[i + count]);
          }
          if (reviewPlaceMainPhotos[i + count].indexOf("temp") >= 0) {
            String filePath = servletContext.getRealPath("/upload/review");
            String tempPath = servletContext.getRealPath("/upload/review/temp");
            String filename = reviewPlaceMainPhotos[i + count].split("temp")[1];
            (new File(tempPath + "//" + filename)).renameTo(new File(filePath + "//" + filename));
            reviewplace.setMainPhoto(filename);
          }
          reviewplaces.add(reviewplace);
        }
        reviewday.setReviewPlace(reviewplaces);
        reviewdays.add(reviewday);
        count += Integer.parseInt(placeLengths[dayIndex]);
      }
      newReview.setReviewDay(reviewdays);
      reviewService.add(newReview);
    }
    return "redirect:list";
  }

  @GetMapping("list")
  public void list(HttpSession session, Model model) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("로그인이 필요합니다.");
    }
    model.addAttribute("list", reviewService.list(user.getNo()));
  }

  @ResponseBody
  @RequestMapping(value = "tempPhoto", method = RequestMethod.POST)
  public void tempPhoto(HttpServletResponse response, HttpSession session, MultipartFile upload) throws Exception {
    System.out.println("tempPhoto 호출 됨");
    System.out.println(upload);
    if (upload.getSize() > 0) {
      String dirPath = servletContext.getRealPath("/upload/review") + "\\temp";
      File Folder = new File(dirPath);
      if (!Folder.exists()) {
        System.out.println("폴더 없음 호출 됨");
        try {
          Folder.mkdir(); // 폴더 생성합니다.
          System.out.println("폴더가 생성되었습니다.");
        } catch (Exception e) {
          e.getStackTrace();
        }
      }
      String filename = UUID.randomUUID().toString();
      File newFile = new File(dirPath + "/" + filename);
      upload.transferTo(newFile);
      System.out.println(newFile.getName());

      ObjectMapper objectMapper = new ObjectMapper();
      response.getWriter().write(objectMapper.writeValueAsString("temp" + newFile.getName()));
    }
  }

  @ResponseBody
  @RequestMapping(value = "placePhoto", method = RequestMethod.POST)
  public void placePhoto(HttpServletResponse response, HttpSession session, MultipartFile upload) throws Exception {
    System.out.println("placePhoto 호출 됨");
    if (upload.getSize() > 0) {
      String dirPath = servletContext.getRealPath("/upload/review") + "\\place";
      File Folder = new File(dirPath);
      if (!Folder.exists()) {
        System.out.println("폴더 없음 호출 됨");
        try {
          Folder.mkdir(); // 폴더 생성합니다.
          System.out.println("폴더가 생성되었습니다.");
        } catch (Exception e) {
          e.getStackTrace();
        }
      }
      String filename = UUID.randomUUID().toString();
      File newFile = new File(dirPath + "/" + filename);
      upload.transferTo(newFile);
      ObjectMapper objectMapper = new ObjectMapper();
      response.getWriter().write(
          objectMapper.writeValueAsString("http://localhost:9999/Root_Java/upload/review/place/" + newFile.getName()));
    }
  }

  @GetMapping("delete")
  public String delete(int no, int userNo) throws Exception {
    reviewService.delete(no);
    return "redirect:list?userNo=" + userNo;
  }

  // 로그인 공개 or 모두 공개
  // 초안 : 디테일은 로그인 공개
  @GetMapping("search")
  public void search(String keyword, HttpSession session, Model model) throws Exception {
    model.addAttribute("searchDayList", reviewDayService.search(keyword));
    model.addAttribute("searchPlaceList", reviewPlaceService.search(keyword));
    logger.info(model);
    logger.debug(model);
  }

  @GetMapping("searchDayDetail")
  public void searchDayDetail(int no, HttpSession session, Model model) throws Exception {
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
      throw new Exception("로그인이 필요합니다.");
    }
    model.addAttribute("review", reviewService.get(no));
    logger.info(model);
    logger.debug(model);
  }

  @GetMapping("searchPlaceDetail")
  public void searchPlaceDetail(int no, HttpSession session, Model model) throws Exception {
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
      throw new Exception("로그인이 필요합니다.");
    }

    model.addAttribute("loginUser", loginUser);
    model.addAttribute("review", reviewService.getByPlaceNo(no));
    model.addAttribute("placeDetail", reviewPlaceService.searchPlaceGet(no));
    logger.info(model);
    logger.debug(model);
  }
}
