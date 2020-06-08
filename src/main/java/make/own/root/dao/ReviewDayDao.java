package make.own.root.dao;

import java.util.List;

import make.own.root.vo.ReviewDay;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface ReviewDayDao {

  // ReviewServiceImpl add(Review review)에서 호출
  // ReviewDayServiceImpl add(ReviewDay reviewDay)에서 호출
  int insert(ReviewDay reviewDay) throws Exception;

  // ReviewServiceImpl list(int userNo), get(int no), delete(int no)에서 호출
  // ReviewDayServiceImpl list(int reviewNo)에서 호출
  List<ReviewDay> findAllByReviewNo(int reviewNo) throws Exception;

  // ReviewDayServiceImpl get(int no)에서 호출
  ReviewDay findByNo(int no) throws Exception;

  // ReviewServiceImpl update(Review review)에서 호출
  // ReviewDayServiceImpl update(ReviewDay reviewDay)에서 호출
  int update(ReviewDay reviewDay) throws Exception;

  // ReviewServiceImpl delete(int no)에서 호출
  // ReviewDayServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;

  //search
  List<ReviewDay> findAll() throws Exception;

  // ReviewDayServiceImpl searchDayGet(int no)에서 호출
  ReviewDay find(int no) throws Exception;

  // ReviewDayServiceImpl search(String keyword)에서 호출
  List<ReviewDay> findByKeyword(String keyword) throws Exception;
}
