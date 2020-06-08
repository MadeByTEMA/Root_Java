<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


 <div class="container">
    <div class="row">
      <!-- Post Content Column -->
      <div class="col-lg-8">
        <!-- Title -->
        <h1 class="mt-4">#장소 스크랩 상세 </h1>
        <!-- Author -->
        <p class="lead">
        </p>
        <hr>
        <!-- Date/Time -->
        <p><span>장소 : </span><strong>${placeDetail.name}</strong></p> 
            <p> 주소 : ${placeDetail.basicAddr} ${placeDetail.detailAddr}</p>
         <td><button id='place_scrop_button' style="float: right;">스크랩</button></td> <br>
        <hr>
        <!-- Preview Image -->
        <img alt="${placeDetail.mainPhoto}" src="${pageContext.servletContext.contextPath}/img/search/testimg.jpg">
        <!-- Post Content -->
          <p>${placeDetail.placeReview} <br></p>

              <input id="data-reviewPlace-no" type="hidden" value="${placeDetail.no}">
              
              <input id="data-user-no" type="hidden" value="${loginUser.no}">
              <input id="data-trader-no" type="hidden" value="${review.user.no}">
              
              <input id="data-reverse-trader-no" type="hidden" value="${loginUser.no}">
              <input id="data-reverse-user-no" type="hidden" value="${review.user.no}">
              
              <input id="data-pointType" type="hidden" value="1">
              <input id="data-content" type="hidden" value="2">
              
               <input id="data-reverse-pointType" type="hidden" value="0">
              <input id="data-reverse-content" type="hidden" value="1">
              
              <input id="data-price" type="hidden" value="30">
          <hr>
         <c:forEach items="${placePhotoDetail}" var="placePhoto">
            <img alt="${placePhoto.photo}" src="${pageContext.servletContext.contextPath}/img/search/testimg.jpg" style="width:600px; margin-left: 60px;"> 
         </c:forEach>
       </div>
 
      <!-- Sidebar Widgets Column -->
      <div class="float_sidebar col-md-4" style="width:200px; float: left">
        <!-- Search Widget -->
        <div class="card my-4">
          <h5 class="card-header">Search</h5>
          <div class="card-body">
            <div class="input-group">
              <form action='http://localhost:9999/Root_Project/app/review/search' method='get'>
              <input type="text" name="keyword" placeholder="Search for...">
              <button class="btn btn-secondary">Go!</button>
            </div>
          </div>
        </div>
        <div class="card my-4">
          <h5 class="card-header">Categories</h5>
          <div class="card-body">
            <div class="row">
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <a href="#">${placeDetail.name}</a>
                  </li>
              </div>
            </div>
          </div>
        </div>
      </div>
    <!-- /.row -->
  </div>
  <!-- /.container -->
 </div>



<script>
"use strict"
// scrap value
var pa = document.querySelector("#data-reviewPlace-no");
console.log(pa);

// point value
var a = document.querySelector("#data-user-no");
var b = document.querySelector('#data-trader-no');
var c = document.querySelector('#data-pointType');
var d = document.querySelector('#data-content');

// reverse point value
var a1 = document.querySelector("#data-reverse-user-no");
var b1 = document.querySelector("#data-reverse-trader-no");
var c1 = document.querySelector('#data-reverse-pointType');
var d1 = document.querySelector('#data-reverse-content');
console.log(a1);
console.log(b1);
console.log(c1);
console.log(d1);


// common
var e1 = document.querySelector('#data-price');

// 동일 게시물 비교
var co1 = document.querySelector("#data-reviewPlace-no");
var co2 = document.querySelector("#data-user-no");
var co3 = document.querySelector('#data-trader-no');
console.log(a);
console.log(b);
console.log(c);
console.log(d);
console.log(e1);

document.querySelector("#place_scrop_button").onclick = () => {
    if (confirm(" 해당 게시물을 스크랩을 하시겠습니까? ") == true){    
        sendScrapData();
        sendPointData();
        reverseSendPointPlaceData();
        changePlaceData();
     }else{ 
        console.log("스크랩을 취소했습니다.");
     }
}


function changePlaceData() {
    document.getElementById("place_scrop_button").innerHTML = ('<button id="place_scrop_button" style="float: right; background-color: Lime;" disabled >스크랩 완료</button>');
  }


function sendScrapData() {
     var xhr = new XMLHttpRequest();
     xhr.onreadystatechange = () => {
       if (xhr.readyState != 4 || xhr.status != 200){ 
         console.log("scarp 리턴 준비 완료()");
           }
      };       
      xhr.open("GET", 
          "http://localhost:9999/Root_Project/app/scrap/addReviewPlace?userNo=" 
          + a.value + "&reviewPlaceNo="+ pa.value , true);
      xhr.send();
  }


  function sendPointData() {
       var xhr = new XMLHttpRequest();
       xhr.onreadystatechange = () => {
         if (xhr.readyState != 4 || xhr.status != 200){  
               console.log("point 리턴 준비 완료()");
            }
        };       
        xhr.open("GET", 
            "http://localhost:9999/Root_Project/app/point/add?userNo=" + a.value 
            + "&reviewUserNo=" + b.value
            + "&pointType=" + c.value
            + "&content=" + d.value
            + "&price=" + e1.value, true);
        xhr.send();
    }
  
  function reverseSendPointPlaceData() {
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = () => {
        if (xhr.readyState != 4 || xhr.status != 200){  
                 console.log("reverseDayPoint send() 리턴함.");
        } else {
            console.log("withdraw 요청 완료");
          }
       };       
       xhr.open("GET", 
           "http://localhost:9999/Root_Project/app/point/add?userNo=" + a1.value 
           + "&reviewUserNo=" + b1.value
           + "&pointType=" + c1.value
           + "&content=" + d1.value
           + "&price=" + e1.value, true);
       xhr.send();
   }

</script>

