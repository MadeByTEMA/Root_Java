<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <div class="ui sidebar inverted vertical menu ">
	  <div id="accordionArea" class="ui styled accordion">
		  <div id="DayScrapArea" class="active title">
		    <i class="dropdown icon"></i>
		    DayScrap
		  </div>
	      <div class="active content">
	        <div class="accordion">
		        <c:forEach items="${scrapDays}" var="scrapDay" varStatus="status">
		          <c:if test="${status.first}">
		            <div class="active title" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                  <i class="dropdown icon"></i>
                  ${scrapDay.reviewDay.title}
                </div>
              </c:if>
		          <c:if test="${!status.first}">
		            <div class="title" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
		              <i class="dropdown icon"></i>
                  ${scrapDay.reviewDay.title}
                </div>
		          </c:if>
              <div class="active content">
                <div class="accordion">
                  <c:forEach items="${scrapDay.reviewDay.reviewPlace}" var="scrapPlace" varStatus="placeStatus">
                    <div class="title" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                      <i class="dropdown icon"></i>
                      ${scrapPlace.name}
                    </div>
                    <div class="content" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                      ${scrapPlace.basicAddr}<br>
                      ${scrapPlace.detailAddr}
                    <div class="ui red rating" data-icon="heart"></div>
                    </div>
                  </c:forEach>
                </div>
              </div>
		        </c:forEach>
	        </div>
	      </div>
		  <div id="PlaceScrapArea" class="title">
		    <i class="dropdown icon"></i>
		    PlaceScrap
		  </div>
		  <div class="content">
		    <div class="accordion">
		      <c:forEach items="${scrapPlaces}" var="scrapPlace" varStatus="status">
            <c:if test="${status.first}">
              <div class="active title" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                <i class="dropdown icon"></i>
                ${scrapPlace.reviewPlace.name}
              </div>
              <div class="content" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                ${scrapPlace.reviewPlace.basicAddr}<br>
                ${scrapPlace.reviewPlace.detailAddr}
                <div class="ui red rating" data-icon="heart"></div>
              </div>
            </c:if>
            <c:if test="${!status.first}">
                <div class="title" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                <i class="dropdown icon"></i>
                ${scrapPlace.reviewPlace.name}
              </div>
              <div class="content" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                ${scrapPlace.reviewPlace.basicAddr}<br>
                ${scrapPlace.reviewPlace.detailAddr}
                <div class="ui red rating" data-icon="heart"></div>
              </div>
            </c:if>
		      </c:forEach>
		    </div>
		  </div>
		</div>
  </div>
  

<form id="addForm" action="add" method="post">
  <div class="courseAddForm">
	  <div class="topStatusbar">
	    <div class="leftStatebar">
	      <input type="button" onClick="sidebarToggle();" id="menu" class="ui button" value="스크랩">
	    </div>
			<div class="rightStatebar">
			  <div class="selectDay">
				  <div class="ui calendar" id="button_calendar">
					  <div class="ui button">여행시작일
					  </div>
					</div>
			  </div>
			  <div id="dropdown" class="ui disabled dropdown">
				  <input type="hidden" name="selectDate">
				  <i class="dropdown icon"></i>
				  <div class="default text">Day
				    <div class="innerDate"></div>
				  </div>
					  <div class="menu" id="dropDownID">
					    <div class="item" draggable="true" ondragstart="courseDateDrag(event)" ondrop="courseDateDrop(event)" ondragover="allowDrop(event)" data-text="2020-05-02">
              	<div class="innerline">
                    <div class="innerlineDay">Day1</div><div class="innerlineDate" onclick="displaySelectCourseDateData(this);">2020-05-04</div></div>
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
		</div>
		 <div class="titlebar">
	    <h1> <input class="placeTitle" name="titles" type="text" placeholder="제목" style="width:100%;"></h1>
	  </div>
		<div class="courseMainContent">
			<div class="leftContent">
			  <div id="placeForm" class="coursePlaceArea">
			    <div class="placeArea"> 
					  <div class="placeNameArea">
					    <input class="placeName"  onchange="matchShowCoursePlaceName()" name="placeNames" type="text" value="" placeholder="장소명">
					    <div class="coursePlaceRemoveIcon" onClick="removeForm(this);">
                   <i id="placeRemoveButtonIcon" class="big minus icon"></i>
                </div>
					  </div>
					  <div class="placeBasicArea">
						    <input type="text" class="basicAddr" name="basicAddrs" value="" placeholder="기본 주소" readonly />
						    <div class="courseAddrSearchIcon" onClick="openDaumZipAddress(this);">
                   <i id="placeAddrSearchButtonIcon" class="big search icon"></i>
						  </div>
					  </div>
					  <div class="placeDetailArea">
					    <input type="text" class="detailAddr" name="detailAddrs" value="" placeholder="상세 주소">

					  </div>
					  <div class="placeEtcArea">
						   <p> 
		           <textarea class="etc" name="etcs" rows="20" cols="10" wrap="hard"  placeholder="비고"></textarea>
		          </p>
					  </div>
				  </div>
			  </div>
			  <script>
			  window.onload = function () {
			    var courseData = new Array();
			    <c:forEach items="${course.courseDay}" var="courseDay" varStatus="dayStatus">
				    var courseDays = new Array();
				    <c:forEach items="${courseDay.coursePlace}" var="coursePlace" varStatus="placeStatus">
			        var coursePlace = new Object();
			        coursePlace.no = ${coursePlace.no};
			        coursePlace.placeName = '${coursePlace.placeName}'
			        coursePlace.basicAddr = '${coursePlace.basicAddr}'
			        coursePlace.detailAddr = '${coursePlace.detailAddr}'
			        coursePlace.etc = '${coursePlace.etc}'
			        courseDays.push(coursePlace);
			      </c:forEach>
			      courseDays.no = ${courseDay.no};
			      courseDays.title = '${courseDay.title}'
			      courseDays.dayDate = '${courseDay.dayDate}'
			      courseData.push(courseDays);
			    </c:forEach>
			    courseDataInit(courseData);
			    }
			  </script>
			  <div class="coursePlacePlusArea">
	        <div class="placePlus">
	          <i id="placeAddPlusButtonIcon" class="big plus circle icon"></i>
	        </div>
					<button class="submitButtonType" type="button" onclick="submitForm()">저장하기</button>
			  </div>
			</div>
			<div class=rightContent> 
				<div id="map" style="width:100%; height:350px;"></div>
				<div id="showPlaceNameArea" ><input class="showPlaceName" id="showPlaceName" draggable="true" ondragstart="placeNameDrag(event)" ondrop="placeNameDrop(event)" ondragover="allowDrop(event)" type="text" readonly></div>
			</div>
		</div>
	</div>
</form>

<div id="submitModal" class="ui basic modal">
  <div class="ui icon header">
    <i class="archive icon"></i>
    저장하시겠습니까 ?
  </div>
  <div class="actions">
    <div class="ui red basic cancel inverted button">
      <i class="remove icon"></i>
      No
    </div>
    <div class="ui green ok inverted button">
      <i class="checkmark icon"></i>
      Yes
    </div>
  </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24cdf736c8b9797f29a0e35af3b6773a&libraries=services,clusterer,drawing"></script>
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/JavaScript" src="../../js/course/form.js">  </script>




