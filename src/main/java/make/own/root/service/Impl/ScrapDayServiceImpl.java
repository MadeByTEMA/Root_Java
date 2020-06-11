package make.own.root.service.Impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.ReviewPlaceDao;
import make.own.root.dao.ScrapDayDao;
import make.own.root.service.ScrapDayService;
import make.own.root.vo.ReviewDay;
import make.own.root.vo.ScrapDay;

@Component
public class ScrapDayServiceImpl implements ScrapDayService {

  TransactionTemplate transactionTemplate;
  ScrapDayDao scrapDayDao;
  ReviewPlaceDao reviewPlaceDao;

  public ScrapDayServiceImpl( //
      PlatformTransactionManager txManager, //
      ScrapDayDao scrapDayDao, //
      ReviewPlaceDao reviewPlaceDao //
      ) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.scrapDayDao = scrapDayDao;
    this.reviewPlaceDao = reviewPlaceDao;
  }

  // ScrapController addReviewDay()에서 호출
  @Override
  public int addReviewDay(int userNo, int reviewDayNo) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("reviewDayNo", reviewDayNo);
    return scrapDayDao.insert(params);
  }

  // ScrapController list()에서 호출
  // CourseController form()에서 호출
  @Override
  public List<ScrapDay> list(int userNo) throws Exception {
    List<ScrapDay> scraps = scrapDayDao.findAll(userNo);
    for (ScrapDay scrapday : scraps) {
      ReviewDay reviewDay = scrapday.getReviewDay();
      reviewDay.setReviewPlace(reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo()));
      scrapday.setReviewDay(reviewDay);
    }
    return scraps;
  }

  // ScrapController delete()에서 호출
  @Override
  public int delete(int reviewDayNo) throws Exception {
    return scrapDayDao.delete(reviewDayNo);
  }

  @Override
  public List<ScrapDay> find(int userNo, int reviewDayNo) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("reviewDayNo", reviewDayNo);
    return scrapDayDao.findScrapDay(params);
  }
}
