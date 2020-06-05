package make.own.root.vo;

public class ScrapDay {
  User user;
  ReviewDay reviewDay;
  Review review;

  @Override
  public String toString() {
    return "ScrapDay [user=" + user + ", reviewDay=" + reviewDay + ", review=" + review + "]";
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public ReviewDay getReviewDay() {
    return reviewDay;
  }

  public void setReviewDay(ReviewDay reviewDay) {
    this.reviewDay = reviewDay;
  }

  public Review getReview() {
    return review;
  }

  public void setReview(Review review) {
    this.review = review;
  }


}
