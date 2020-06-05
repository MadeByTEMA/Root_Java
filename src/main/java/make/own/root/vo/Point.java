package make.own.root.vo;

import java.io.Serializable;
import java.sql.Date;

//@Alias("Point")
public class Point implements Serializable {
  private static final long serialVersionUID = 1L;

  int no; // point_no
  int userNo; // user_no
  int traderNo; // trader_no // null 가능
  int pointType; // point_type / 입출금 분류
  int content; // content / 입출금 내용
  int price; // price
  Date createdDate; // create_date
  User user;

  @Override
  public String toString() {
    return "Point [no=" + no + ", userNo=" + userNo + ", traderNo=" + traderNo + ", pointType=" + pointType
        + ", content=" + content + ", price=" + price + ", createdDate=" + createdDate + ", user=" + user + "]";
  }
  public int getNo() {
    return no;
  }
  public void setNo(int no) {
    this.no = no;
  }
  public int getUserNo() {
    return userNo;
  }
  public void setUserNo(int userNo) {
    this.userNo = userNo;
  }
  public int getTraderNo() {
    return traderNo;
  }
  public void setTraderNo(int traderNo) {
    this.traderNo = traderNo;
  }
  public int getPointType() {
    return pointType;
  }
  public void setPointType(int pointType) {
    this.pointType = pointType;
  }
  public int getContent() {
    return content;
  }
  public void setContent(int content) {
    this.content = content;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    this.price = price;
  }
  public Date getCreatedDate() {
    return createdDate;
  }
  public void setCreatedDate(Date createdDate) {
    this.createdDate = createdDate;
  }
  public User getUser() {
    return user;
  }
  public void setUser(User user) {
    this.user = user;
  }

}
