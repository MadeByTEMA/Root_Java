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
    <c:forEach items="${review.reviewDay}" var="reviewday" varStatus="status">
    <c:if test="${status.first}"> 
    <div class="reviewForm" onclick="location.href='form?no=${review.no}'" style="background-image:url('http://localhost:9999/Root_Java/upload/review/${reviewday.mainPhoto}');">
      <div class="title">${reviewday.title}</div>
      <div class="reviewScrapArea">
        <div class="reviewDayScrapArea">
          <div class="displayScrapCount">DayScrap : </div>
	        <div class="dayScrap">57</div>
        </div>
        <div class="reviewPlaceScrapArea">
          <div class="displayScrapCount">PlaceScrap : </div>
          <div class="placeScrap">113</div>
        </div>
      </div>
      <div class="reviewStatusButtonArea">
        <div class="reviewStatusButtonLeftArea"><button class="ui inverted secondary button" style="width: 100px;margin: 0px;">게시하기</button></div>
        <div class="reviewStatusButtonRightArea"><button class="ui inverted secondary button" style="width: 100px;margin: 0px;">숨기기</button></div>
      </div>
    </div>
    </c:if>
    </c:forEach>
    </c:forEach>
  </div>
<script type="text/JavaScript" src="../../js/review/list.js">  </script>
