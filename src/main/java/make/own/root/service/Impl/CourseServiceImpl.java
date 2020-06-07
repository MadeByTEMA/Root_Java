package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.CourseDao;
import make.own.root.dao.CourseDayDao;
import make.own.root.dao.CoursePlaceDao;
import make.own.root.service.CourseService;
import make.own.root.vo.Course;
import make.own.root.vo.CourseDay;
import make.own.root.vo.CoursePlace;

@Component
public class CourseServiceImpl implements CourseService {

  TransactionTemplate transactionTemplate;
  CourseDao courseDao;
  CourseDayDao courseDayDao;
  CoursePlaceDao coursePlaceDao;

  public CourseServiceImpl( //
      PlatformTransactionManager txManager, //
      CourseDao courseDao, //
      CourseDayDao courseDayDao, //
      CoursePlaceDao coursePlaceDao //
      ) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.courseDao = courseDao;
    this.courseDayDao = courseDayDao;
    this.coursePlaceDao = coursePlaceDao;
  }

  // CourseController add()에서 호출
  @Transactional
  @Override
  public int add(Course course) throws Exception {
    int result = courseDao.insert(course);
    if (result == 0) {
      throw new Exception("코스 추가에 실패했습니다.");
    } else {
      List<CourseDay> courseDays = course.getCourseDay();
      for (CourseDay courseDay : courseDays) {
        courseDay.setCourse(course);
        System.out.println(courseDay.getTitle());
        if (courseDayDao.insert(courseDay) == 0) {
          throw new Exception("일정 추가에 실패했습니다.");
        } else {
          List<CoursePlace> coursePlaces = courseDay.getCoursePlace();
          for (CoursePlace coursePlace : coursePlaces) {
            System.out.println(coursePlace.getBasicAddr());
            coursePlace.setCourseDay(courseDay);
            if (coursePlaceDao.insert(coursePlace) == 0) {
              throw new Exception("장소 추가에 실패했습니다.");
            }
          }
        }
      }
    }
    return result;
  }

  // CourseController list()에서 호출
  @Transactional
  @Override
  public List<Course> list(int userNo) throws Exception {
    List<Course> courses = courseDao.findAllByUserNo(userNo);
    for (Course course : courses) {
      List<CourseDay> courseDays = courseDayDao.findAllByCourseNo(course.getNo());
      for (CourseDay courseDay : courseDays) {
        courseDay.setCoursePlace(coursePlaceDao.findAllByCourseDayNo(courseDay.getNo()));
      }
      course.setCourseDay(courseDays);
    }
    return courses;
  }

  // CourseController form()에서 호출
  @Transactional
  @Override
  public Course get(int no) throws Exception {
    Course course = courseDao.findByNo(no);
    List<CourseDay> courseDays = courseDayDao.findAllByCourseNo(course.getNo());
    for (CourseDay courseDay : courseDays) {
      courseDay.setCoursePlace(coursePlaceDao.findAllByCourseDayNo(courseDay.getNo()));
    }
    course.setCourseDay(courseDays);
    return course;
  }

  // CourseController add()에서 호출
  @Transactional
  @Override
  public int update(Course course) throws Exception {
    int result = courseDao.update(course);
    if (result == 0) {
      throw new Exception("코스 업데이트에 실패했습니다.");
    } else {
      List<CourseDay> courseDays = course.getCourseDay();
      for (CourseDay courseDay : courseDays) {
        courseDay.setCourse(course);
        System.out.println(courseDay.getTitle());
        if (courseDay.getNo() == 0 && courseDayDao.insert(courseDay) == 0) {
          throw new Exception("일정 추가에 실패했습니다.");
        } else if (courseDayDao.update(courseDay) == 0) {
          throw new Exception("일정 업데이트에 실패했습니다.");
        } else {
          List<CoursePlace> coursePlaces = courseDay.getCoursePlace();
          for (CoursePlace coursePlace : coursePlaces) {
            System.out.println(coursePlace.getPlaceName());
            coursePlace.setCourseDay(courseDay);
            if (coursePlace.getNo() == 0 && coursePlaceDao.insert(coursePlace) == 0) {
              throw new Exception("장소 추가에 실패했습니다.");
            } else if (coursePlaceDao.update(coursePlace) == 0) {
              throw new Exception("장소 업데이트에 실패했습니다.");
            }
          }
        }
      }
    }
    return result;
  }

  // CourseController delete()에서 호출
  @Transactional
  @Override
  public int delete(int no) throws Exception {
    List<CourseDay> courseDays = courseDayDao.findAllByCourseNo(no);
    for (CourseDay courseDay : courseDays) {
      List<CoursePlace> coursePlaces = coursePlaceDao.findAllByCourseDayNo(courseDay.getNo());
      for (CoursePlace coursePlace : coursePlaces) {
        coursePlaceDao.delete(coursePlace.getNo());
      }
      courseDayDao.delete(courseDay.getNo());
    }
    return courseDao.delete(no);
  }
}
