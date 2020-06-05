package make.own.root.dao;

import java.util.List;

import make.own.root.vo.CourseDay;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface CourseDayDao {

  int insert(CourseDay courseDay) throws Exception;

  List<CourseDay> findAllByCourseNo(int courseNo) throws Exception;

  CourseDay findByNo(int no) throws Exception;

  int update(CourseDay courseDay) throws Exception;

  int delete(int no) throws Exception;
}
