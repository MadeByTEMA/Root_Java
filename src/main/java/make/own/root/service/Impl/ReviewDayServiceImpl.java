package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.ReviewDayDao;
import make.own.root.dao.ReviewPlaceDao;
import make.own.root.service.ReviewDayService;
import make.own.root.vo.ReviewDay;
import make.own.root.vo.ReviewPlace;

@Component
public class ReviewDayServiceImpl implements ReviewDayService {

  TransactionTemplate transactionTemplate;
  ReviewDayDao reviewDayDao;
  ReviewPlaceDao reviewPlaceDao;

  public ReviewDayServiceImpl( //
      PlatformTransactionManager txManager, //
      ReviewDayDao reviewDayDao, //
      ReviewPlaceDao reviewPlaceDao //
      ) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.reviewDayDao = reviewDayDao;
    this.reviewPlaceDao = reviewPlaceDao;
  }

  @Transactional
  @Override
  public int add(ReviewDay reviewDay) throws Exception {
    int result = reviewDayDao.insert(reviewDay);
    if (result == 0) {
      throw new Exception("일정 추가에 실패했습니다.");
    } else {
      List<ReviewPlace> reviewPlaces = reviewDay.getReviewPlace();
      for (ReviewPlace reviewPlace : reviewPlaces) {
        reviewPlace.setDay(reviewDay);
        if (reviewPlaceDao.insert(reviewPlace) == 0) {
          throw new Exception("장소 추가에 실패했습니다.");
        }
      }
    }
    return result;
  }

  @Transactional
  @Override
  public List<ReviewDay> list(int reviewNo) throws Exception {
    List<ReviewDay> reviewDays = reviewDayDao.findAllByReviewNo(reviewNo);
    for (ReviewDay reviewDay : reviewDays) {
      reviewDay.setReviewPlace(reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo()));
    }
    return reviewDays;
  }

  @Transactional
  @Override
  public ReviewDay get(int no) throws Exception {
    ReviewDay reviewDay = reviewDayDao.findByNo(no);
    reviewDay.setReviewPlace(reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo()));
    return reviewDay;
  }

  @Transactional
  @Override
  public int update(ReviewDay reviewDay) throws Exception {
    return reviewDayDao.update(reviewDay);
  }

  // ReviewController add()에서 호출
  @Transactional
  @Override
  public int delete(int no) throws Exception {
    List<ReviewPlace> reviewPlaces = reviewPlaceDao.findAllByReviewDayNo(no);
    for (ReviewPlace reviewPlace : reviewPlaces) {
      reviewPlaceDao.delete(reviewPlace.getNo());
    }
    return reviewDayDao.delete(no);
  }

  // ReviewController search()에서 호출
  @Override
  public List<ReviewDay> search(String keyword) throws Exception {
    return reviewDayDao.findByKeyword(keyword);
  }

  @Override
  public ReviewDay searchDayGet(int no) throws Exception {
    return reviewDayDao.find(no);
  }
}
