package make.own.root.vo;

public class CoursePlace {

  int no; // place_no
  String placeName; // place_name
  String basicAddr; // place_basic_address
  String detailAddr; // place_detail_address
  String etc; // etc
  CourseDay courseDay;

  public CoursePlace() {
  }

  public CoursePlace(String placeName, String basicAddr) {
    this.placeName = placeName;
    this.basicAddr = basicAddr;
  }

  public CoursePlace(String placeName, String basicAddr, String detailAddr, String etc) {
    this(placeName, basicAddr);
    this.detailAddr = detailAddr;
    this.etc = etc;
  }

  public int getNo() {
    return no;
  }

  public void setNo(int no) {
    this.no = no;
  }

  public String getPlaceName() {
    return placeName;
  }

  public void setPlaceName(String placeName) {
    this.placeName = placeName;
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

  public String getEtc() {
    return etc;
  }

  public void setEtc(String etc) {
    this.etc = etc;
  }

  public CourseDay getCourseDay() {
    return courseDay;
  }

  public void setCourseDay(CourseDay courseDay) {
    this.courseDay = courseDay;
  }

  @Override
  public String toString() {
    return "CoursePlace [no=" + no + ", placeName=" + placeName + ", basicAddr=" + basicAddr + ", detailAddr="
        + detailAddr + ", etc=" + etc + ", courseDay=" + courseDay + "]";
  }

}
