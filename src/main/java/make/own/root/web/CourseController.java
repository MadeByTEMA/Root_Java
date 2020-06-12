package make.own.root.web;

import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import make.own.root.service.CourseDayService;
import make.own.root.service.CoursePlaceService;
import make.own.root.service.CourseService;
import make.own.root.service.ScrapDayService;
import make.own.root.service.ScrapPlaceService;
import make.own.root.vo.Course;
import make.own.root.vo.CourseDay;
import make.own.root.vo.CoursePlace;
import make.own.root.vo.User;

@Controller
@RequestMapping("/course")
public class CourseController {

  @Autowired
  ServletContext servletContext;

  @Autowired
  CourseService courseService;

  @Autowired
  CourseDayService courseDayService;

  @Autowired
  CoursePlaceService coursePlaceService;

  @Autowired
  ScrapDayService scrapDayService;

  @Autowired
  ScrapPlaceService scrapPlaceService;

  @GetMapping("form")
  public void form(String no, HttpSession session, Model model) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("로그인이 필요합니다.");
    }
    if (!no.equals("newForm")) {
      int courseNo = Integer.parseInt(no);
      session.setAttribute("course", courseService.get(courseNo));
    } else {
      session.removeAttribute("course");
    }

    model.addAttribute("scrapDays", scrapDayService.list(user.getNo()));
    model.addAttribute("scrapPlaces", scrapPlaceService.list(user.getNo()));
  }

  @RequestMapping("add")
  public String add(//
      HttpSession session, //
      String[] titles, //
      Date dayDate, //

      String[] dayLengths, //

      String[] placeNames, //
      String[] basicAddrs, //
      String[] detailAddrs, //
      String[] etcs //
      ) throws Exception {
    User user = (User) session.getAttribute("loginUser");

    if (user == null) {
      throw new Exception("유저 번호가 유효하지 않습니다.");
    }

    System.out.println("dayDate 출력한다");
    System.out.println(dayDate);

    System.out.println("titles 출력한다");
    for (String str : titles) {
      System.out.println(str);
    }

    System.out.println("dayLengths 출력한다");
    for (String str : dayLengths) {
      System.out.println(str);
    }

    System.out.println("placeNames 출력한다");
    for (String str : placeNames) {
      System.out.println(str);
    }

    System.out.println("basicAddrs 출력한다");
    for (String str : basicAddrs) {
      System.out.println(str);
    }

    System.out.println("detailAddrs 출력한다");
    for (String str : detailAddrs) {
      System.out.println(str);
    }

    System.out.println("etcs 출력한다");
    for (String str : etcs) {
      System.out.println(str);
    }










    Course oldCourse = (Course) session.getAttribute("course");
    Course newCourse = new Course();
    if (oldCourse != null) { // Update라면,
      newCourse.setUser(user);
      newCourse.setCreatedDate(oldCourse.getCreatedDate());
      newCourse.setNo(oldCourse.getNo()); // Update할 CourseNo 전달
      List<CourseDay> coursedays = new LinkedList<>();
      int count = 0;
      for (int dayIndex = 0; dayIndex < titles.length; dayIndex++) {
        Date newDayDate = dayDate;
        newDayDate.setDate((newDayDate.getDate() + dayIndex));
        List<CourseDay> oldDays = oldCourse.getCourseDay();
        CourseDay courseday = new CourseDay(titles[dayIndex], newDayDate);
        if (dayIndex < oldDays.size() && oldDays.get(dayIndex) != null) { // 만약 Update할 CourseDayNo가 존재한다면, 전달
          courseday.setNo(oldDays.get(dayIndex).getNo());
        }
        List<CoursePlace> courseplaces = new LinkedList<>();
        for (int i = 0; i < Integer.parseInt(dayLengths[dayIndex]); i++) { // 작업해야함. 문제는 이 인덱스가 삭제, 혹은 전달할 인덱스
          // 이라는 보장이 없다 그거 감안해서 코딩 해야 함.
          CoursePlace courseplace = new CoursePlace(placeNames[i + count], basicAddrs[i + count]);
          if (detailAddrs[i + count] != null) {
            courseplace.setDetailAddr(detailAddrs[i + count]);
          }
          if (etcs[i + count] != null) {
            courseplace.setEtc(etcs[i + count]);
          }
          if (dayIndex < oldDays.size() && i < oldDays.get(dayIndex).getCoursePlace().size()
              && oldDays.get(dayIndex).getCoursePlace().get(i) != null) {
            courseplace.setNo(oldDays.get(dayIndex).getCoursePlace().get(i).getNo());
          }
          if (dayIndex < oldDays.size() && i < oldDays.get(dayIndex).getCoursePlace().size()
              && oldDays.get(dayIndex).getCoursePlace().size() > Integer.parseInt(dayLengths[dayIndex])) {
            for (int oldPlaceIndex = Integer.parseInt(dayLengths[dayIndex]); oldPlaceIndex < oldDays.get(dayIndex)
                .getCoursePlace().size(); oldPlaceIndex++) {
              coursePlaceService.delete(oldDays.get(dayIndex).getCoursePlace().get(oldPlaceIndex).getNo());
            }
          }
          courseplaces.add(courseplace);
        }
        courseday.setCoursePlace(courseplaces);
        coursedays.add(courseday);
        count += Integer.parseInt(dayLengths[dayIndex]);

        if (oldDays.size() > titles.length) { // 업데이트 전 Course에는 있지만 없어진 Day 삭제
          for (int i = titles.length; i < oldDays.size(); i++) {
            List<CoursePlace> oldCoursePlaces = oldDays.get(i).getCoursePlace();
            for (int oldPlaceIndex = 0; oldPlaceIndex < oldCoursePlaces.size(); oldPlaceIndex++) {
              coursePlaceService.delete(oldCoursePlaces.get(oldPlaceIndex).getNo());
            }
            courseDayService.delete(oldDays.get(i).getNo());
          }
        }
        newCourse.setCourseDay(coursedays);
      }
      courseService.update(newCourse);
      session.removeAttribute("course");
    } else {
      newCourse.setUser(user);
      List<CourseDay> coursedays = new LinkedList<>(); // course 안에 들어갈 dayList 생성
      int count = 0;
      for (int dayIndex = 0; dayIndex < titles.length; dayIndex++) { // dayIndex에 맞게 for문 구분
        Date newDayDate = dayDate;
        newDayDate.setDate((newDayDate.getDate() + dayIndex));
        CourseDay courseday = new CourseDay(titles[dayIndex], newDayDate);
        List<CoursePlace> courseplaces = new LinkedList<>();
        for (int i = 0; i < Integer.parseInt(dayLengths[dayIndex]); i++) { // dayIndex에 들어갈 PlaceList 생성
          CoursePlace courseplace = new CoursePlace(placeNames[i + count], basicAddrs[i + count]);
          if (detailAddrs[i + count] != null) {
            courseplace.setDetailAddr(detailAddrs[i]);
          }
          if (etcs[i + count] != null) {
            courseplace.setEtc(etcs[i + count]);
          }
          courseplaces.add(courseplace);
        }
        courseday.setCoursePlace(courseplaces);
        coursedays.add(courseday);
        count += Integer.parseInt(dayLengths[dayIndex]);
      }
      newCourse.setCourseDay(coursedays);
      courseService.add(newCourse);
    }
    return "redirect:list?userNo=" + user.getNo();
  }

  @GetMapping("list")
  public void list(HttpSession session, Model model) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("로그인이 필요합니다.");
    }
    model.addAttribute("list", courseService.list(user.getNo()));
  }

  @GetMapping("delete")
  public String delete(int no, HttpSession session) throws Exception {
    User user = (User) session.getAttribute("loginUser");
    if (user == null) {
      throw new Exception("유저 번호가 유효하지 않습니다.");
    }
    courseService.delete(no);
    return "redirect:list?userNo=" + user.getNo();
  }
}
