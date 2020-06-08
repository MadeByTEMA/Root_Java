package make.own.root.dao;

import java.util.List;

import make.own.root.vo.Review;

// 데이터를 저장하고 꺼내는 방식(파일, 클라우드저장소, DB 등)에 상관없이
// DAO 사용법을 통일하기 위해
// 메서드 호출 규칙을 정의한다.
//
public interface ReviewDao {

  // ReviewServiceImpl add(Review review)에서 호출
  int insert(Review review) throws Exception;

  // ReviewServiceImpl list(int userNo)에서 호출
  List<Review> findAllByUserNo(int userNo) throws Exception;

  // ReviewServiceImpl get(int no)에서 호출
  Review findByNo(int no) throws Exception;

  // ReviewServiceImpl update(Review review)에서 호출
  int update(Review review) throws Exception;

  // ReviewServiceImpl delete(int no)에서 호출
  int delete(int no) throws Exception;

  //search
  List<Review> findAll() throws Exception;

  // ReviewServiceImpl getByPlaceNo(int placeNo)에서 호출
  Review find(int no) throws Exception;
}
