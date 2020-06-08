package make.own.root.dao;

import java.util.List;

import make.own.root.vo.ReviewPlace;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface ReviewPlaceDao {

  // ReviewServiceImpl add(Review review)에서 호출
  // ReviewDayServiceImpl add(ReviewDay reviewDay)에서 호출
  // ReviewPlaceServiceImpl add(ReviewPlace reviewPlace)에서 호출
  int insert(ReviewPlace reviewPlace) throws Exception;

  // ScrapDayServiceImpl list(int userNo)에서 호출
  // ReviewServiceImpl list(int userNo), get(int no), delete(int no)에서 호출
  // ReviewDayServiceImpl list(int reviewNo), get(int no), delete(int no)에서 호출
  // ReviewPlaceServiceImpl list(int reviewDayNo)에서 호출
  List<ReviewPlace> findAllByReviewDayNo(int reviewDayNo) throws Exception;

  // ReviewPlaceServiceImpl get(int no)에서 호출
  ReviewPlace findByNo(int no) throws Exception;

  // ReviewServiceImpl update(Review review)에서 호출
  // ReviewPlaceServiceImpl update(ReviewPlace reviewPlace)에서 호출
  int update(ReviewPlace reviewPlace) throws Exception;

  // ReviewServiceImpl delete(int no)에서 호출
  // ReviewDayServiceImpl delete(int no)에서 호출
  // ReviewPlaceServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;

  //search
  List<ReviewPlace> findAll() throws Exception;

  // ReviewPlaceServiceImpl searchPlaceGet(int no)에서 호출
  ReviewPlace find(int no) throws Exception;

  // searchlist
  // ReviewPlaceServiceImpl search(String keyword)에서 호출
  List<ReviewPlace> findByKeyword(String keyword) throws Exception;
}
