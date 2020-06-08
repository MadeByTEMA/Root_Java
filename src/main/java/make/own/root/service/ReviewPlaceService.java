package make.own.root.service;

import java.util.List;

import make.own.root.vo.ReviewPlace;

public interface ReviewPlaceService {

  int add(ReviewPlace reviewPlace) throws Exception;

  List<ReviewPlace> list(int reviewDayNo) throws Exception;

  ReviewPlace get(int no) throws Exception;

  int update(ReviewPlace reviewPlace) throws Exception;

  int delete(int no) throws Exception;

  // search
  List<ReviewPlace> search(String keyword) throws Exception;

  public ReviewPlace searchPlaceGet(int no) throws Exception;
}
