package make.own.root.dao;

import java.util.List;

import make.own.root.vo.Course;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface CourseDao {

  // CourseServiceImpl add(Course course)에서 호출
  int insert(Course course) throws Exception;

  // CourseServiceImpl list(int userNo)에서 호출
  List<Course> findAllByUserNo(int userNo) throws Exception;

  // CourseServiceImpl get(int no)에서 호출
  Course findByNo(int no) throws Exception;

  // CourseServiceImpl update(Course course)에서 호출
  int update(Course course) throws Exception;

  // CourseServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;
}
