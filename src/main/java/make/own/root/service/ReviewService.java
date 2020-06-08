package make.own.root.service;

import java.util.List;

import make.own.root.vo.Review;

public interface ReviewService {

  int add(Review review) throws Exception;

  List<Review> list(int userNo) throws Exception;

  Review get(int no) throws Exception;

  int update(Review review) throws Exception;

  int delete(int no) throws Exception;

  public Review getByPlaceNo(int placeNo) throws Exception;
}
