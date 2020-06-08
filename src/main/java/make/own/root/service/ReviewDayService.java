package make.own.root.service;

import java.util.List;

import make.own.root.vo.ReviewDay;

public interface ReviewDayService {

  int add(ReviewDay reviewDay) throws Exception;

  List<ReviewDay> list(int reviewNo) throws Exception;

  ReviewDay get(int no) throws Exception;

  int update(ReviewDay reviewDay) throws Exception;

  int delete(int no) throws Exception;

  // search day
  List<ReviewDay> search(String keyword) throws Exception;

  public ReviewDay searchDayGet(int no) throws Exception;
}
