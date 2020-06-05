package make.own.root.vo;

import java.sql.Date;
import java.util.List;

public class ReviewDay {
  int no; // review_day_no
  String title; // title
  Date dayDate; // day_date
  String mainReview; // day_review
  String mainPhoto; // main_photo
  int status; // status
  Review review;
  List<ReviewPlace> reviewPlace;

  public ReviewDay() {
  }

  public ReviewDay( //
      String title, //
      Date dayDate, //
      String mainReview, //
      int status //
      ) {
    this.title = title;
    this.dayDate = dayDate;
    this.mainReview = mainReview;
    this.status = status;
  }

  public ReviewDay( //
      String title, //
      Date dayDate, //
      String mainReview, //
      int status, //
      List<ReviewPlace> reviewPlace //
      ) {
    this(title, dayDate, mainReview, status);
    this.reviewPlace = reviewPlace;
  }

  public int getNo() {
    return no;
  }

  public void setNo(int no) {
    this.no = no;
  }

  public String getMainPhoto() {
    return mainPhoto;
  }

  public void setMainPhoto(String mainPhoto) {
    this.mainPhoto = mainPhoto;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public Date getDayDate() {
    return dayDate;
  }

  public void setDayDate(Date dayDate) {
    this.dayDate = dayDate;
  }

  public String getMainReview() {
    return mainReview;
  }

  public void setMainReview(String mainReview) {
    this.mainReview = mainReview;
  }

  public int getStatus() {
    return status;
  }

  public void setStatus(int status) {
    this.status = status;
  }

  public Review getReview() {
    return review;
  }

  public void setReview(Review review) {
    this.review = review;
  }

  public List<ReviewPlace> getReviewPlace() {
    return reviewPlace;
  }

  public void setReviewPlace(List<ReviewPlace> reviewPlace) {
    this.reviewPlace = reviewPlace;
  }

  @Override
  public String toString() {
    return "ReviewDay [no=" + no + ", title=" + title + ", dayDate=" + dayDate + ", mainReview=" + mainReview
        + ", mainPhoto=" + mainPhoto + ", status=" + status + "]";
  }

}
