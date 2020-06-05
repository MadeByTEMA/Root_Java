package make.own.root.dao;

import java.util.List;
import java.util.Map;

import make.own.root.vo.ScrapDay;

public interface ScrapDayDao {
  int insert(Map<String, Object> scrap) throws Exception;

  List<ScrapDay> findAll(int userNo) throws Exception;

  ScrapDay findDayNo(int reviewDayNo) throws Exception;

  int delete(int reviewDayNo) throws Exception;
}
