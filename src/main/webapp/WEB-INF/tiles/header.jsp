<%@page import="com.keep.root.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <header id="header" class="fixed-top">
    <div class="headerOnLoginBar">
      <div class="loginBarInFrame">
        <div class="userStatusbar">
        <c:if test="${not empty loginUser}">
          <div class="displayUserInfo">
            <div class="displayUserPoint"></div>
            <div class="displayUserNickName"></div>
          </div>
          <div class="displayLogin">
            <div class="signIn"><a href="app/auth/form">마이페이지</a></div>
            <div class="signUp"><a href="app/auth/form">로그아웃</a></div>
          </div>
         </c:if>
          <c:if test="${empty loginUser}">
	          <div class="displayLogin">
	            <div class="signIn"><a href="app/auth/form">로그인</a></div>
	            <div class="signUp"><a href="app/auth/form">회원가입</a></div>
	          </div>
          </c:if>
        </div>
      </div>
    </div>
    <div class="container-fluid d-flex">

      <div class="logo mr-auto">
        <h1 class="text-light"><a href="http://localhost:9999/Root_Project"><span>Root</span></a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
       <a href="index.html"><img src="img/logo.png" alt="" class="img-fluid"></a>
      </div>

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li class="active"><a href="http://localhost:9999/Root_Project">Home</a></li>
          <li><a href="app/course/list">코스짜기</a></li>
          <li><a href="app/scrap/list">스크랩</a></li>
          <li><a href="app/review/list">후기쓰기</a></li>
          <li><a href="app/info/list">공지</a></li>
        </ul>
      </nav><!-- .nav-menu -->
    </div>
  </header><!-- End Header -->
