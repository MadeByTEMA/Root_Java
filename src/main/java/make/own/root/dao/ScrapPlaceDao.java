package make.own.root.dao;

import java.util.List;
import java.util.Map;

import make.own.root.vo.ScrapPlace;
public interface ScrapPlaceDao {
  int insert(Map<String, Object> scrap) throws Exception;

  List<ScrapPlace> findAll(int userNo) throws Exception;

  int delete(int reviewPlaceNo) throws Exception;
}
