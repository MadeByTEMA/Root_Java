package make.own.root.dao;

import java.util.List;

import make.own.root.vo.CoursePlace;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface CoursePlaceDao {

  int insert(CoursePlace coursePlace) throws Exception;

  List<CoursePlace> findAllByCourseDayNo(int courseDayNo) throws Exception;

  CoursePlace findByNo(int no) throws Exception;

  int update(CoursePlace CoursePlace) throws Exception;

  int delete(int no) throws Exception;
}
