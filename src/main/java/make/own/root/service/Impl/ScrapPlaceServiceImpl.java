package make.own.root.service.Impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.ScrapPlaceDao;
import make.own.root.service.ScrapPlaceService;
import make.own.root.vo.ScrapPlace;

@Component
public class ScrapPlaceServiceImpl implements ScrapPlaceService {

  TransactionTemplate transactionTemplate;
  ScrapPlaceDao scrapPlaceDao;

  public ScrapPlaceServiceImpl(PlatformTransactionManager txManager, ScrapPlaceDao scrapPlaceDao) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.scrapPlaceDao = scrapPlaceDao;
  }

  // ScrapController addReviewPlace()에서 호출
  @Override
  public int addReviewPlace(int userNo, int reviewPlaceNo) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("reviewPlaceNo", reviewPlaceNo);
    return scrapPlaceDao.insert(params);
  }

  // ScrapController list()에서 호출
  @Override
  public List<ScrapPlace> list(int scrapDayNo) throws Exception {
    return scrapPlaceDao.findAll(scrapDayNo);
  }

  // ScrapController delete()에서 호출
  // CourseController form()에서 호출

  @Override
  public int delete(int reviewPlaceNo) throws Exception {
    return scrapPlaceDao.delete(reviewPlaceNo);
  }

  @Override
  public List<ScrapPlace> find(int userNo, int reviewPlaceNo) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);
    params.put("reviewPlaceNo", reviewPlaceNo);
    return scrapPlaceDao.findScrapPlace(params);
  }
}
