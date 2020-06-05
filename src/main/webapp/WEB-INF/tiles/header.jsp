<%@page import="com.keep.root.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header id="header" class="fixed-top">

    <div class="container-fluid d-flex">

      <div class="logo mr-auto">
        <h1 class="text-light"><a href="http://localhost:9999/Root_Java"><span>Root</span></a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
       <a href="index.html"><img src="img/logo.png" alt="" class="img-fluid"></a>
      </div>

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li class="active"><a href="http://localhost:9999/Root_Java">Home</a></li>
          <li><a href="../course/list">코스짜기</a></li>
          <li><a href="../review/list">후기쓰기</a></li>
          <li><a href="../info/list">공지</a></li>
         
          <c:if test="${not empty loginUser}">
		       <span class='navbar-text' style="margin-top:10px">${loginUser.nickName} ${loginUser.point} Point</span>
		       <li class="get-started"><a href="../mypage/form?no=${loginUser.no}">MyPage</a>
		       <li class="get-started"><a href="../auth/logout">Logout</a>
		    </c:if>
		    <c:if test="${empty loginUser}">
          <li class="get-started"><a href="../auth/form">Login</a></li>
            </c:if>  
        </ul>
      </nav><!-- .nav-menu -->

    </div>
</header>

