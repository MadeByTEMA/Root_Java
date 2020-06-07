package make.own.root.dao;

import java.util.List;
import java.util.Map;

import make.own.root.vo.ScrapDay;

public interface ScrapDayDao {

  // ScrapDayServiceImpl addReviewDay(int userNo, int reviewDayNo)에서 호출
  int insert(Map<String, Object> scrap) throws Exception;

  // ScrapDayServiceImpl list(int userNo)에서 호출
  List<ScrapDay> findAll(int userNo) throws Exception;

  // ScrapDayServiceImpl delete(int reviewDayNo)에서 호출
  int delete(int reviewDayNo) throws Exception;
}
