package make.own.root.service.Impl;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import make.own.root.dao.ReviewDao;
import make.own.root.dao.ReviewDayDao;
import make.own.root.dao.ReviewPlaceDao;
import make.own.root.service.ReviewService;
import make.own.root.vo.Review;
import make.own.root.vo.ReviewDay;
import make.own.root.vo.ReviewPlace;

@Component
public class ReviewServiceImpl implements ReviewService {

  TransactionTemplate transactionTemplate;
  ReviewDao reviewDao;
  ReviewDayDao reviewDayDao;
  ReviewPlaceDao reviewPlaceDao;

  public ReviewServiceImpl( //
      PlatformTransactionManager txManager, //
      ReviewDao reviewDao, //
      ReviewDayDao reviewDayDao, //
      ReviewPlaceDao reviewPlaceDao //
      ) {
    this.transactionTemplate = new TransactionTemplate(txManager);
    this.reviewDao = reviewDao;
    this.reviewDayDao = reviewDayDao;
    this.reviewPlaceDao = reviewPlaceDao;
  }

  // ReviewController add()에서 호출
  @Transactional
  @Override
  public int add(Review review) throws Exception {
    int result = reviewDao.insert(review);
    if (result == 0) {
      throw new Exception("코스 추가에 실패했습니다.");
    } else {
      List<ReviewDay> reviewDays = review.getReviewDay();
      for (ReviewDay reviewDay : reviewDays) {
        reviewDay.setReview(review);
        if (reviewDayDao.insert(reviewDay) == 0) {
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
      }
    }
    return result;
  }

  // ReviewController list()에서 호출
  @Transactional
  @Override
  public List<Review> list(int userNo) throws Exception {
    List<Review> reviews = reviewDao.findAllByUserNo(userNo);
    for (Review review : reviews) {
      List<ReviewDay> reviewDays = reviewDayDao.findAllByReviewNo(review.getNo());
      for (ReviewDay reviewDay : reviewDays) {
        reviewDay.setReviewPlace(reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo()));
      }
      review.setReviewDay(reviewDays);
    }
    return reviews;
  }

  // ReviewController form(), searchDayDetail() 에서 호출
  @Transactional
  @Override
  public Review get(int no) throws Exception {
    Review review = reviewDao.findByNo(no);
    List<ReviewDay> reviewDays = reviewDayDao.findAllByReviewNo(review.getNo());
    for (ReviewDay reviewDay : reviewDays) {
      reviewDay.setReviewPlace(reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo()));
    }
    review.setReviewDay(reviewDays);
    return review;
  }

  // ReviewController add()에서 호출
  @Transactional
  @Override
  public int update(Review review) throws Exception {
    int result = reviewDao.update(review);
    if (result == 0) {
      throw new Exception("후기 업데이트에 실패했습니다.");
    } else {
      List<ReviewDay> reviewDays = review.getReviewDay();
      for (ReviewDay reviewDay : reviewDays) {
        reviewDay.setReview(review);
        System.out.println(reviewDay.getTitle());
        if (reviewDay.getNo() == 0 && reviewDayDao.insert(reviewDay) == 0) {
          throw new Exception("일정 추가에 실패했습니다.");
        } else if (reviewDayDao.update(reviewDay) == 0) {
          throw new Exception("일정 업데이트에 실패했습니다.");
        } else {
          List<ReviewPlace> reviewPlaces = reviewDay.getReviewPlace();
          for (ReviewPlace reviewPlace : reviewPlaces) {
            System.out.println(reviewPlace.getName());
            reviewPlace.setDay(reviewDay);
            if (reviewPlace.getNo() == 0 && reviewPlaceDao.insert(reviewPlace) == 0) {
              throw new Exception("장소 추가에 실패했습니다.");
            } else if (reviewPlaceDao.update(reviewPlace) == 0) {
              throw new Exception("장소 업데이트에 실패했습니다.");
            }
          }
        }
      }
    }
    return result;
  }

  // ReviewController delete()에서 호출
  @Transactional
  @Override
  public int delete(int no) throws Exception {
    List<ReviewDay> reviewDays = reviewDayDao.findAllByReviewNo(no);
    for (ReviewDay reviewDay : reviewDays) {
      List<ReviewPlace> reviewPlaces = reviewPlaceDao.findAllByReviewDayNo(reviewDay.getNo());
      for (ReviewPlace reviewPlace : reviewPlaces) {
        reviewPlaceDao.delete(reviewPlace.getNo());
      }
      reviewDayDao.delete(reviewDay.getNo());
    }
    return reviewDao.delete(no);
  }

  // ReviewController searchPlaceDetail()에서 호출
  @Override
  public Review getByPlaceNo(int placeNo) throws Exception {
    return reviewDao.find(placeNo);
  }
}
