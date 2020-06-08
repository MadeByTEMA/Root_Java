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
          <div class="dayContentMainReview" style="word-break:break-all">
            ${scrapDay.reviewDay.mainReview}"
          </div>
          <div class="dayContentInPlaceNameArea">
 	          <c:forEach items="${scrapDay.reviewDay.reviewPlace}" var="scrapPlace" varStatus="status">
 	            <c:if test="${status.getIndex() < 6}">
		 	          <div class="dayContentInPlaceName">
		              ${scrapPlace.name}
		            </div>
	            </c:if>
	          </c:forEach>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
   <div class="scrapSelector">
     <h5>Place Scrap</h5>
   </div>
   <div class="placeScrapArea">
     <c:forEach items="${scrapPlaces}" var="scrapPlace" varStatus="status">
           <div class="placeScrapElement">
             <div class="placeMainPhotoArea">
               <img src='${pageContext.servletContext.contextPath}/upload/review/${scrapPlace.reviewPlace.mainPhoto}'
                        height='240' width='300'>
             </div>
             <div class="placeNameArea">
               <div class="placeName">
                 ${scrapPlace.reviewPlace.name}
               </div>
             </div>
           </div>
     </c:forEach>
   </div>
</div>
<script type="text/JavaScript" src="../../js/scrap/list.js">  </script>