<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<div class="titleArea">
    <h2>Review List </h2>
</div>
  <div class="reviewArea">
    <div class="reviewPlusForm" onclick="location.href='form?no=newForm'">
      <div class="reviewPlusIcon">
	      <i class="big plus icon"></i>
      </div>
    </div>
    <c:forEach items="${list}" var="review">
    <c:forEach items="${review.reviewDay}" var="reviewday">
    <div class="reviewForm" onclick="location.href='form?no=${review.no}'" data-value="${reviewday.mainPhoto}">
      <div class="title">${reviewday.title}</div>
      <div class="reviewScrapArea">
        <div class="reviewDayScrapArea">
          <div class="displayScrapCount">DayScrap : </div>
	        <div class="dayScrap"></div>
        </div>
        <div class="reviewPlaceScrapArea">
          <div class="displayScrapCount">PlaceScrap : </div>
          <div class="placeScrap"></div>
        </div>
      </div>
      <div class="reviewStatusButtonArea">
        <div class="reviewStatusButtonLeftArea"><button class="ui inverted secondary button" style="width: 100px;margin: 0px;">게시하기</button></div>
        <div class="reviewStatusButtonRightArea"><button class="ui inverted secondary button" style="width: 100px;margin: 0px;">숨기기</button></div>
      </div>
    </div>
    </c:forEach>
    </c:forEach>
  </div>
<script type="text/JavaScript" src="../../js/review/list.js">  </script>



<!--
<a href='form?no=newForm'>새 후기 등록</a><br>
  <table class="table table-hover" >
  <thead>
  <tr align="center">
    <th>제목</th>
    <th>여행예정일</th>
    <th>코스작성일</th>
    <th>삭제</th>
  </tr>
    </thead>
  <tbody>
  
    <c:forEach items="${review.reviewDay}" var="reviewday">
      <tr align="center">
        <td><a href='form?no=${review.no}'></a></td> 
        <td>${reviewday.dayDate}</td> 
        <td>${review.createdDate}</td> 
        <td><a href='delete?no=${course.no}'>삭제</a></td>
      </tr>
   
  </c:forEach>
    </tbody>
</table>
-->

