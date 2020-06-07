package make.own.root.dao;

import java.util.List;

import make.own.root.vo.ReviewPlace;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface ReviewPlaceDao {

  int insert(ReviewPlace reviewPlace) throws Exception;

  // ScrapDayServiceImpl list(int userNo)에서 호출
  List<ReviewPlace> findAllByReviewDayNo(int reviewDayNo) throws Exception;

  ReviewPlace findByNo(int no) throws Exception;

  int update(ReviewPlace reviewPlace) throws Exception;

  int delete(int no) throws Exception;

  //search
  List<ReviewPlace> findAll() throws Exception;

  ReviewPlace findReviewPlaceDataByReviewPlaceNo(int reviewPlaceNo) throws Exception;

  // searchlist
  List<ReviewPlace> findByKeyword(String keyword) throws Exception;
}
