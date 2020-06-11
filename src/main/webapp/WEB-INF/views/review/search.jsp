<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="searchTotal">
  <div class="searchArea">
    <div id="custom-search-input">
      <div class="input-group col-md-12">
        <form action='http://localhost:9999/Root_Java/app/review/search' method='get'>
          <input type="text" name='keyword' class="search-query form-control" placeholder="Search" style="width: 926px;height:35px;float:left"/>
              <button class="btn btn-danger">
                   <i class="search icon"></i>
              </button>
          </form>
        </div>
     </div>
  </div>    
  <div class="searchSelector">
    <h2>#Day</h2>
  </div>
  <div class="daySearchArea" >
      <c:forEach items="${searchDayList}" var="searchDay" varStatus="status">
      <c:if test="${status.getIndex() < 5}">
        <div class="daySearchElement">
            <div class="dayMainPhotoArea">
              <a href='../review/searchDetail?no=${searchDay.no}'>
              <img src='${pageContext.servletContext.contextPath}/upload/review/${searchDay.mainPhoto}'  
                   height='300' width='400'>
              </a>
            </div>
            <div class="dayContentArea">
              <div class="dayContentTopArea">
	              <a href='../review/searchDetail?no=${searchDay.no}' style="color: #212529; font-size: 20px;">${searchDay.title}</a>
	            </div>
		          <div class="dayContentMainReview" style="word-break:break-all">
	            <a href='../review/searchDetail?no=${searchDay.no}' style="color: #212529; font-size: 14px;">
	            ${searchDay.mainReview}"
	            </a>
	          </div>
	          <div class="dayContentInPlaceNameArea">
	            <c:forEach items="${searchDay.reviewPlace}" var="searchPlace" varStatus="status">
	              <c:if test="${status.getIndex() < 6}">
	                <div class="dayContentInPlaceName">
	                  ${searchPlace.name}
	                </div>
	              </c:if>
	            </c:forEach>
              </div> 
            </div>
          </div>
        </c:if>
        <c:if test="${status.getIndex() == 5}">
	        <div class="moreViewArea">
		        <div class="moreView">
		          더보기
	          </div>
	        </div>
        </c:if>
      </c:forEach>
  </div>
  
  <div class="searchSelector">
    <h2>#Place</h2>
  </div>
  <div class="placeSearchArea">
    <c:forEach items="${searchPlaceList}" var="searchPlace" varStatus="status">
      <c:if test="${status.getIndex() < 5}">
	      <div class="placeSearchElement">
	        <div class="placeMainPhotoArea">
		        <a href='searchDetail?no=${searchPlace.day.no}'>
		        <img src='${pageContext.servletContext.contextPath}/upload/review/${searchPlace.mainPhoto}'
		        height='240' width='300'>
		        </a>
	        </div>
		        <div class="placeNameArea">
	            <div class="placeName">
	              ${searchPlace.name}
	            </div>
	          </div>
	        </div>
        </c:if>
        <c:if test="${status.getIndex() == 5}">
          <div class="moreViewArea">
            <div class="moreView">
              더보기
            </div>
          </div>
        </c:if>
    </c:forEach>
  </div>
</div>
<script type="text/JavaScript" src="../../js/review/search.js">  </script>


