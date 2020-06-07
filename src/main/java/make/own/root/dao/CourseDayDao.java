package make.own.root.dao;

import java.util.List;

import make.own.root.vo.CourseDay;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface CourseDayDao {

  // CourseServiceImpl add(Course course), update(Course course)에서 호출
  // CourseDayServiceImpl add(CourseDay courseDay, update(CourseDay courseDay에서 호출
  int insert(CourseDay courseDay) throws Exception;

  // CourseServiceImpl list(int userNo), get(int no), delete(int no)에서 호출
  // CourseDayServiceImpl list(int userNo)에서 호출
  List<CourseDay> findAllByCourseNo(int courseNo) throws Exception;

  // CourseDayServiceImpl get(int no)에서 호출
  CourseDay findByNo(int no) throws Exception;

  // CourseServiceImpl update(Course course)에서 호출
  // CourseDayServiceImpl update(CourseDay courseDay)에서 호출
  int update(CourseDay courseDay) throws Exception;

  // CourseServiceImpl delete(int no)에서 호출
  // CourseDayServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;
}
