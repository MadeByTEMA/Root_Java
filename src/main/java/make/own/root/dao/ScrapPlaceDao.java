package make.own.root.dao;

import java.util.List;
import java.util.Map;

import make.own.root.vo.ScrapPlace;
public interface ScrapPlaceDao {

  // ScrapPlaceServiceImpl addReviewPlace(int userNo, int reviewPlaceNo)에서 호출
  Integer insert(Map<String, Object> scrap) throws Exception;

  // ScrapPlaceServiceImpl list(int scrapDayNo)에서 호출
  List<ScrapPlace> findAll(int userNo) throws Exception;

  // ScrapPlaceServiceImpl delete(int reviewPlaceNo)에서 호출
  int delete(int reviewPlaceNo) throws Exception;

  //ScrapPlaceServiceImpl find(int userNo, int reviewPlaceNo)에서 호출
  List<ScrapPlace> findScrapPlace(Map<String, Object> scrap) throws Exception;
}
