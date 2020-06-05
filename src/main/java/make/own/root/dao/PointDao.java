package make.own.root.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import make.own.root.vo.Point;

public interface PointDao {
  // output add form : session
  int insert(Map<String, Object> point) throws Exception;

  // 관리자를 위한 전체 포인트 리스트
  List<Point> findAll() throws Exception;

  // 개인을 위한 포인트 리스트
  List<Point> findAllByUser(int userNo) throws Exception;

  // 입력 번호와 상대 번호를 비교하기 위함
  List<Point> findOutputByUserNo() throws Exception;

  // detail - 포인트 내부설정
  Point find(int no) throws Exception;

  // userNo
  Point findByUserNo(int userNo) throws Exception;

  // 카운딩된 상대 번호 확인하기 위함
  Point findBytraderNo(int traderNo) throws Exception;

  int update(Point point) throws Exception;

  int delete(int no) throws Exception;

  // paging
  int getTotalCount(int userNo) throws Exception;

  List<Point> listPage(HashMap<String, Object> params) throws Exception;
}
