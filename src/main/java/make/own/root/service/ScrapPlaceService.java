package make.own.root.service;

import java.util.List;

import make.own.root.vo.ScrapPlace;

public interface ScrapPlaceService {
  int addReviewPlace(int userNo, int reviewPlaceNo) throws Exception;

  List<ScrapPlace> list(int userNo) throws Exception;

  int delete(int reviewPlaceNo) throws Exception;

  List<ScrapPlace> find(int userNo, int reviewPlaceNo) throws Exception;
}
