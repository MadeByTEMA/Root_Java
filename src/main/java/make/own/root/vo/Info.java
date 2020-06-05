package make.own.root.vo;

import java.sql.Date;

public class Info {
  int no; // info_no
  Date createdDate; // create_date
  int category; // category
  String title; // title
  String content; // content



  @Override
  public String toString() {
    return "Info [no=" + no + ", createdDate=" + createdDate + ", category=" + category + ", title=" + title
        + ", content=" + content + "]";
  }
  public int getNo() {
    return no;
  }
  public void setNo(int no) {
    this.no = no;
  }
  public Date getCreatedDate() {
    return createdDate;
  }
  public void setCreatedDate(Date createdDate) {
    this.createdDate = createdDate;
  }
  public int getCategory() {
    return category;
  }
  public void setCategory(int category) {
    this.category = category;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
}
