package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.ReviewPlaceDao;
import make.own.root.service.ReviewPlaceService;
import make.own.root.vo.ReviewPlace;

@Component
public class ReviewPlaceServiceImpl implements ReviewPlaceService {

  TransactionTemplate transactionTemplate;
  ReviewPlaceDao reviewPlaceDao;

  public ReviewPlaceServiceImpl( //
      PlatformTransactionManager txManager, //
      ReviewPlaceDao reviewPlaceDao //
      ) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.reviewPlaceDao = reviewPlaceDao;
  }

  @Transactional
  @Override
  public int add(ReviewPlace reviewPlace) throws Exception {
    int result = reviewPlaceDao.insert(reviewPlace);
    if (result == 0) {
      throw new Exception("장소 추가에 실패했습니다.");
    }
    return result;
  }

  @Transactional
  @Override
  public List<ReviewPlace> list(int reviewDayNo) throws Exception {
    return reviewPlaceDao.findAllByReviewDayNo(reviewDayNo);
  }

  @Transactional
  @Override
  public ReviewPlace get(int no) throws Exception {
    return reviewPlaceDao.findByNo(no);
  }

  @Transactional
  @Override
  public int update(ReviewPlace reviewPlace) throws Exception {
    return reviewPlaceDao.update(reviewPlace);
  }

  // ReviewController add()에서 호출
  @Transactional
  @Override
  public int delete(int no) throws Exception {
    return reviewPlaceDao.delete(no);
  }

  // ReviewController search()에서 호출
  @Override
  public List<ReviewPlace> search(String keyword) throws Exception {
    return reviewPlaceDao.findByKeyword(keyword);
  }

  // ReviewController searchPlaceDetail()에서 호출
  @Override
  public ReviewPlace searchPlaceGet(int no) throws Exception {
    return reviewPlaceDao.find(no);
  }
}
