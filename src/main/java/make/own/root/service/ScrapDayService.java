package make.own.root.service;

import java.util.List;

import make.own.root.vo.ScrapDay;

public interface ScrapDayService {
  int addReviewDay(int userNo, int reviewDayNo) throws Exception;

  List<ScrapDay> list(int userNo) throws Exception;

  int delete(int reviewDayNo) throws Exception;
}
