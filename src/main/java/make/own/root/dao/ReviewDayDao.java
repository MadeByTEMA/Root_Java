package make.own.root.dao;

import java.util.List;

import make.own.root.vo.ReviewDay;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface ReviewDayDao {

  int insert(ReviewDay reviewDay) throws Exception;

  List<ReviewDay> findAllByReviewNo(int reviewNo) throws Exception;

  ReviewDay findByNo(int no) throws Exception;

  int update(ReviewDay reviewDay) throws Exception;

  int delete(int no) throws Exception;

  //search
  List<ReviewDay> findAll() throws Exception;

  ReviewDay findReviewDayDataByReviewDayNo(int reviewDayNo) throws Exception;

  List<ReviewDay> findByKeyword(String keyword) throws Exception;
}
