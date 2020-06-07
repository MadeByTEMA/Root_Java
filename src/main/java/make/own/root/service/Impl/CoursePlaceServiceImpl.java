package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;

import make.own.root.dao.CoursePlaceDao;
import make.own.root.service.CoursePlaceService;
import make.own.root.vo.CoursePlace;

@Component
public class CoursePlaceServiceImpl implements CoursePlaceService {

  CoursePlaceDao coursePlaceDao;

  public CoursePlaceServiceImpl(CoursePlaceDao coursePlaceDao) {
    this.coursePlaceDao = coursePlaceDao;
  }

  @Override
  public int add(CoursePlace coursePlace) throws Exception {
    return coursePlaceDao.insert(coursePlace);
  }

  @Override
  public List<CoursePlace> list(int courseDayNo) throws Exception {
    return coursePlaceDao.findAllByCourseDayNo(courseDayNo);
  }

  @Override
  public CoursePlace get(int no) throws Exception {
    return coursePlaceDao.findByNo(no);
  }

  @Override
  public int update(CoursePlace coursePlace) throws Exception {
    return coursePlaceDao.update(coursePlace);
  }

  // CourseController add()에서 호출
  @Override
  public int delete(int no) throws Exception {
    return coursePlaceDao.delete(no);
  }
}
