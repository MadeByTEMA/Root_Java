package make.own.root.vo;

import java.sql.Date;
import java.util.List;

public class Review {
  int no; // review_no
  User user; //  user_no
  Date createdDate; // create_date
  int status; // status
  List<ReviewDay> reviewDay;

  public Review() {
  }

  public int getNo() {
    return no;
  }

  public void setNo(int no) {
    this.no = no;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public Date getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Date createdDate) {
    this.createdDate = createdDate;
  }

  public int getStatus() {
    return status;
  }

  public void setStatus(int status) {
    this.status = status;
  }

  public List<ReviewDay> getReviewDay() {
    return reviewDay;
  }

  public void setReviewDay(List<ReviewDay> reviewDay) {
    this.reviewDay = reviewDay;
  }

  @Override
  public String toString() {
    return "Review [no=" + no + ", createdDate=" + createdDate + ", status=" + status + "]";
  }

}
