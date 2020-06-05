package make.own.root.vo;

public class ReviewPlace {
  int no; // review_place_no
  String name; // place_name
  String basicAddr; // place_basic_address
  String detailAddr; // place_detail_address
  String placeReview; // place_review
  String mainPhoto; // main_photo
  int status; // status
  ReviewDay day;

  public ReviewPlace() {
  }

  public ReviewPlace( //
      String name, //
      String basicAddr, //
      String placeReview, //
      int status //
      ) {
    this.name = name;
    this.basicAddr = basicAddr;
    this.placeReview = placeReview;
    this.status = status;
  }
  public ReviewPlace( //
      String name, //
      String basicAddr, //
      String detailAddr, //
      String placeReview, //
      int status //
      ) {
    this(name, basicAddr, placeReview, status);
    this.detailAddr = detailAddr;
  }

  @Override
  public String toString() {
    return "ReviewPlace [no=" + no + ", name=" + name + ", basicAddr=" + basicAddr + ", detailAddr=" + detailAddr
        + ", placeReview=" + placeReview + ", mainPhoto=" + mainPhoto + ", status=" + status + ", day=" + day + "]";
  }

  public int getNo() {
    return no;
  }

  public void setNo(int no) {
    this.no = no;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getBasicAddr() {
    return basicAddr;
  }

  public void setBasicAddr(String basicAddr) {
    this.basicAddr = basicAddr;
  }

  public String getDetailAddr() {
    return detailAddr;
  }

  public void setDetailAddr(String detailAddr) {
    this.detailAddr = detailAddr;
  }

  public String getPlaceReview() {
    return placeReview;
  }

  public void setPlaceReview(String placeReview) {
    this.placeReview = placeReview;
  }

  public String getMainPhoto() {
    return mainPhoto;
  }

  public void setMainPhoto(String mainPhoto) {
    this.mainPhoto = mainPhoto;
  }

  public int getStatus() {
    return status;
  }

  public void setStatus(int status) {
    this.status = status;
  }

  public ReviewDay getDay() {
    return day;
  }

  public void setDay(ReviewDay day) {
    this.day = day;
  }

}
