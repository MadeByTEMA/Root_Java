<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="reviewDetailForm">
		<div class="topAreaDiv">
		  <div class="topStatusbar">
		    <div class="starIconArea">
			    <i class="big star outline icon" ></i>
			    <i class="big yellow star icon" style="display:none"></i>
		    </div>
        <div class="titleArea">
	        <input class="title" name="titles" type="text" value="${reviewDay.title}" readonly="readonly">
	        <input class="dayNo" name="dayNos"  type="text" value="${reviewDay.no}" style="display:none;">
        </div>
        <div id="dropdown" class="ui disabled dropdown">
          <input type="hidden" name="selectDate">
          <i class="dropdown icon"></i>
          <div class="default text">Day<div class="innerDate"></div></div>
            <div class="menu">
              <div class="item" draggable="true" ondragstart="courseDateDrag(event)" ondrop="courseDateDrop(event)" ondragover="allowDrop(event)" data-text="2020-05-02">
                <div class="innerline">
                  <div class="innerlineDay">Day1</div><div class="innerlineDate" onclick="displaySelectReviewDateData(this);">2020-05-04</div></div>
                <div class="minusArea">
                  <i class="minus icon"></i>
                </div>
              </div>
              <div class="datePlus">
                <i class="plus icon" onclick="addDate(this);"></i>
              </div>
          </div>
        </div>
		  </div>
		  <div class="dayReviewArea">
		    <div class="dayReviewLeftArea"> 
			    <div class="mainPhotoArea">
			      <img class="displayReviewDayMainPhoto" src='${pageContext.servletContext.contextPath}/upload/review/${reviewDay.mainPhoto}'
            height='360' width='540'>
			    </div>
		    </div>
		    <div class="dayReviewRightArea"> 
          <div class="mainReviewArea">
          <p>
           <textarea class="mainReview" name="mainReviews" rows="20" cols="10" wrap="hard">${reviewDay.mainReview}</textarea>
          </p>
          </div>
        </div>
		  </div>
		</div>
		
		<div class='courseNameDiv'>
		  <h1>Course</h1>
		</div>
		<div id="map" style="width:100%; height:600px;"></div>
		<div class="reviewPlaceNamebar">
		  <div class="showReviewPlaceNameArea"><div class="showReviewPlaceName">1</div></div>
		</div>
		
		
		<div class="mainContentArea"> 
		  <div class="reviewPlaceArea">
		  <c:forEach items="${reviewDay.reviewPlace}" var="reviewPlace" varStatus="status">
		  <div class="reviewPlace">
		    <div class="reviewPlaceLeftArea">
		      <img class="displayReviewPlaceMainPhoto" src='${pageContext.servletContext.contextPath}/upload/review/${reviewPlace.mainPhoto}'
          height='360' width='540'>
		    </div>
		    <div class="reviewPlaceRightArea">
		      <div class="reviewScrapStarArea">
		         <div class="reviewScrapStar">
		           <i class="large star outline icon"></i>
		           <i class="large yellow star icon" style="display:none"></i>
		         </div>
          </div>
          <div class="reviewPlaceNameArea">
            <input class="placeName" name="names"  type="text" value="${reviewPlace.name}" readonly="readonly">
            <input class="placeNo" name="placeNos"  type="text" value="${reviewPlace.no}" style="display:none;">
          </div>
          <div class="reviewPlaceBasicAddrArea">
            <div class="displayReviewPlaceBasicAddr">
              <input class="basicAddr" name="basicAddrs"  type="text" value="${reviewPlace.basicAddr}" readonly="readonly">
            </div>
          </div>
          <div class="reviewPlaceDetailAddrArea">
              <input class="detailAddr" name="detailAddrs"  type="text" value="${reviewPlace.detailAddr}" readonly="readonly">
          </div>
        </div> 
        <div class="reviewPlaceReview">
        <input class="placeReview" name="placeReviews" type="text" style="display:none" value="${reviewPlace.placeReview}">
	        <div id="editor" class="ckEditor">
	        </div>
	      </div>
	    </div>
	    </c:forEach>
	    </div>
		</div>
	</div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24cdf736c8b9797f29a0e35af3b6773a&libraries=services,clusterer,drawing"></script>
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src='${pageContext.getServletContext().getContextPath()}/ckeditor5/build/ckeditor.js'></script>
<script type="text/JavaScript" src="../../js/review/searchDetail.js"></script>


