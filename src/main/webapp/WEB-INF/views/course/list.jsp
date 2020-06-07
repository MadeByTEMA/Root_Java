<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>코스 리스트</h3>
<a href='form?no=newForm'>새 코스 등록</a><br>
  <table class="table table-hover" >
  <thead>
  <tr align="center">
    <th>제목</th>
    <th>여행예정일</th>
    <th>코스작성일</th>
    <th>삭제</th>
</tr>
  </thead>

  <c:forEach items="${list}" var="course">
  <c:set var="count" value="${status1.count}"/>
    <tr>
      <c:forEach items="${course.courseDay}" var="courseday" varStatus="status">
        <c:if test="${status.first}">
          <c:set var="startDate" value="${courseday.dayDate}"/>
          <td><a href='form?no=${course.no}'>${courseday.title}</a></td>
        </c:if>
        <c:if test="${status.last}">
          <c:set var="endDate" value="${courseday.dayDate}"/>
        </c:if>
      </c:forEach>
    <c:choose>
      <c:when test="${startDate eq endDate}"> 
        <td>${startDate}</td>
      </c:when>
      <c:otherwise>
        <td>${startDate} ~ ${endDate}</td>
      </c:otherwise>
    </c:choose>
    <td>${course.createdDate}</td> 
    <td><a href='delete?no=${course.no}'>삭제</a></td>
    </tr>
  </c:forEach>
</table>

