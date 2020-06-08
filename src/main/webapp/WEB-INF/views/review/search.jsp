<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
div.Search_total {
  width :1140px;
}

div.search_repeat {
  overflow : visible;
  width : 900px;
  height : 180px;
  border: 1px solid gray;
  margin-top: 10px;
  margin-bottom: 10px;
  
}

div.day_layoutCon {
  width : 1140px;
  height : 600px;
  margin-bottom: 50px;
}

div.repeat_control {
  float: left;
  position : relative;
  width : 650px;
}

div.search_repeat_place_photo {
  width : 200px;
  height : 150px;
  float: left;
  margin-top: 10px;
}

.search_repeat_place_title{
  float: left;
}

.search_repeat_place_review {
  float: left;
}

div.search_repeat_place {
  margin-top: 20px;
}

div.place_search {
  display: grid;
  height: 200px;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 15px;
  grid-template-rows: 250px 250px;
}

div.search_place_content_repeat {
  width : 250px;
  margin-left: 10px;
}

</style>
<h1>검색 리스트</h1>
<div class="Search_total">
  <div class="day_layoutCon" >
    <h3>#데이</h3>
    <div class="day_search" style="margin-left: 100px;">
      <c:forEach items="${searchDayList}" var="searchDay">
        <div class="search_repeat">
            <div class="search_repeat_place_photo">
              <a href='searchDayDetail?no=${searchDay.no}'>
              <img class="img-thumbnail" src="${pageContext.servletContext.contextPath}/img/search/testimg.jpg" alt="${searchDay.mainPhoto}" 
              style="width:170px; height: 100px; margin:30px 30px 10px 30px;">
              </a>
            </div>
            <div class="repeat_control">
              <div class="search_repeat_place">
                <ul class="list-group list-group-flush">
                  <li class="list-group-item"> <a href='searchDayDetail?no=${searchDay.no}'> <strong>${searchDay.title} </strong></a> <br></li>
                  <li class="list-group-item"> ${searchDay.mainReview} <br></li>
                  <li class="list-group-item">장소 : <c:forEach items="${searchDay.reviewPlace}" var="searchPlace">
                   <${searchPlace.name}> &nbsp; 
                </c:forEach></li>
                </ul>
              </div> 
            </div>
        </div>
      </c:forEach>
    </div>  
  </div>
  
  <div class="place_layoutCon">
    <h3>#장소</h3>
    <div class="place_search">
       <c:forEach items="${searchPlaceList}" var="searchPlace">
         <div class="shadow-lg p-3 mb-5 bg-white rounded" style="height: 250px;">
           <div class="search_place_photo_repeat" style="text-align: center;">
           <a href='searchPlaceDetail?no=${searchPlace.no}'><img class="img-thumbnail" src="${pageContext.servletContext.contextPath}/img/search/testimg.jpg" alt="${searchPlace.mainPhoto}"
                style="width:200px; height: 130px; margin:30px 30px 30px 30px;">
           </a><br>
           </div>
           <div class="search_place_content_repeat" >
             <div class="place_main_name" style="width :320px; ">
              <span><strong>${searchPlace.name}</strong></span>
             </div>
             <div style="border-bottom: 1px solid grey; width :320px;"></div>
             <div class="place_main_review">       
                    리뷰 : ${searchPlace.placeReview.substring(0,15)} ... <br>
             </div>
           </div>
          </div>
        </c:forEach>
     </div>
   </div>
</div>



