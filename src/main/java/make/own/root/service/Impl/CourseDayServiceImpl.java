package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.CourseDayDao;
import make.own.root.dao.CoursePlaceDao;
import make.own.root.service.CourseDayService;
import make.own.root.vo.CourseDay;
import make.own.root.vo.CoursePlace;

@Component
public class CourseDayServiceImpl implements CourseDayService {

  TransactionTemplate transactionTemplate;
  CourseDayDao courseDayDao;
  CoursePlaceDao coursePlaceDao;

  public CourseDayServiceImpl(PlatformTransactionManager txManager, CourseDayDao courseDayDao,
      CoursePlaceDao coursePlaceDao) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.courseDayDao = courseDayDao;
    this.coursePlaceDao = coursePlaceDao;
  }

  @Transactional
  @Override
  public int add(CourseDay courseDay) throws Exception {
    int result = courseDayDao.insert(courseDay);
    if (result == 0) {
      throw new Exception("일정 추가에 실패했습니다.");
    } else {
      List<CoursePlace> coursePlaces = courseDay.getCoursePlace();
      for (CoursePlace coursePlace : coursePlaces) {
        coursePlace.setCourseDay(courseDay);
        if (coursePlaceDao.insert(coursePlace) == 0) {
          throw new Exception("장소 추가에 실패했습니다.");
        }
      }
    }
    return result;
  }

  @Override
  public List<CourseDay> list(int courseNo) throws Exception {
    List<CourseDay> courseDays = courseDayDao.findAllByCourseNo(courseNo);
    for (CourseDay courseDay : courseDays) {
      courseDay.setCoursePlace(coursePlaceDao.findAllByCourseDayNo(courseDay.getNo()));
    }
    return courseDays;
  }

  @Transactional
  @Override
  public CourseDay get(int no) throws Exception {
    CourseDay courseDay = courseDayDao.findByNo(no);
    courseDay.setCoursePlace(coursePlaceDao.findAllByCourseDayNo(courseDay.getNo()));
    return courseDay;
  }

  @Transactional
  @Override
  public int update(CourseDay courseDay) throws Exception {
    int result = courseDayDao.update(courseDay);
    if (result == 0) {
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
    return result;
  }

  // CourseController add()에서 호출
  @Transactional
  @Override
  public int delete(int no) throws Exception {
    List<CoursePlace> coursePlaces = coursePlaceDao.findAllByCourseDayNo(no);
    for (CoursePlace coursePlace : coursePlaces) {
      coursePlaceDao.delete(coursePlace.getNo());
    }
    return courseDayDao.delete(no);
  }
}
