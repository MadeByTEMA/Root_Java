<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<div class="titleArea">
	<h2>Scrap List</h2>
	</div>
	<div class="scrapArea">
	  <div class="scrapSelector">
	    <h5>Day Scrap</h5>
	  </div>
	  <div class="dayScrapArea">
 	    <c:forEach items="${scrapDays}" var="scrapDay">
 	      <div class="dayScrapElement">
 	        <div class="dayMainPhotoArea">
 	          <img src='${pageContext.servletContext.contextPath}/upload/review/${scrapDay.reviewDay.mainPhoto}'
 	                   height='300' width='400'>
 	        </div>
 	        <div class="dayContentArea">
 	          <div class="dayContentTopArea">
 	              <a href='../review/searchDayDetail?no=${scrapDay.review.no}' style="color: #212529; font-size: 20px;">${scrapDay.reviewDay.title}</a>
 	          </div>
 	          <div class=dayContentMainReview>
 	            <input type="text" height="24px" width="540px" value="${scrapDay.reviewDay.mainReview}" readonly="readonly"/>
 	          </div>
 	        <!--
	        <td></td> 
	        <td></td> 
	        <td>${scrapDay.reviewDay.mainReview}</td> 
	        <td><button type="button" onclick="location.href='delete?no=${scrapDay.reviewDay.no}'">삭제</button></td>
	        -->
	        </div>
	      </div>
	    </c:forEach>
	  </div>
	<table class="table table-hover" >
	 <thead>
	 <tr align="center">
	    <th>장소</th>
	    <th>메인사진</th>
	    <th>리뷰</th>
	    <th>기본주소</th>
	    <th>상세주소</th>
	    <th>삭제</th>
	  </tr>
	<h5>Place Scrap</h5>
	  <c:forEach items="${place}" var="scrap">
	      <tr>
	        <td>${scrap.reviewPlace.name}</td> 
	        <td>${scrap.reviewPlace.mainPhoto}</td> 
	        <td>${scrap.reviewPlace.placeReview.substring(0,10)}</td> 
	        <td>${scrap.reviewPlace.basicAddr}</td> 
	        <td>${scrap.reviewPlace.detailAddr}</td> 
	        <td><button type="button" onclick="location.href='delete?no=${scrap.reviewPlace.no}'">삭제</button></td>
	      </tr>
	  </c:forEach>
	   </thead>
	</table>
</div>
