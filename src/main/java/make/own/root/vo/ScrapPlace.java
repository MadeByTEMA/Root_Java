package make.own.root.vo;

public class ScrapPlace {
  User user;
  ReviewPlace reviewPlace;
  
  @Override
  public String toString() {
    return "ScrapPlace [user=" + user + ", reviewPlace=" + reviewPlace + "]";
  }
  
  public User getUser() {
    return user;
  }
  public void setUser(User user) {
    this.user = user;
  }
  public ReviewPlace getReviewPlace() {
    return reviewPlace;
  }
  public void setReviewPlace(ReviewPlace reviewPlace) {
    this.reviewPlace = reviewPlace;
  }
  
  
}
