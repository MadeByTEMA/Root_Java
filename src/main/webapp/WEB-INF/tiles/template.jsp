<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<c:if test="${not empty refreshUrl}">
<meta http-equiv="Refresh" content="${refreshUrl}">
</c:if>
<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css' integrity='sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh' crossorigin='anonymous'>
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/aos/aos.css" rel="stylesheet">
  <link href="${pageContext.getServletContext().getContextPath()}/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
  
  <!-- Template Main CSS File -->
  <link href="${pageContext.getServletContext().getContextPath()}/css/style.css" rel="stylesheet">
  <link rel='stylesheet' href='${pageContext.getServletContext().getContextPath()}/semantic/dist/semantic.min.css'>
<link rel='stylesheet' href='<tiles:getAsString name="css.common"/>'>
<link rel='stylesheet' href='<tiles:getAsString name="css.page"/>'>
  
  
  
  <!-- Vendor JS Files -->
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/php-email-form/validate.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/venobox/venobox.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="${pageContext.getServletContext().getContextPath()}/vendor/aos/aos.js"></script>

  <!-- Template Main JS File -->
  <script src="${pageContext.getServletContext().getContextPath()}/js/main.js"></script>
  <script src='${pageContext.getServletContext().getContextPath()}/semantic/dist/semantic.min.js'></script>
  
  
  
<title>나만의 루트를 만들다. 루트</title>
</head>
<body>

<div class='header'>
<tiles:insertAttribute name="header"/>
</div>

<div class='container'>
<tiles:insertAttribute name="body"/>
</div>

<div class='footer'>
<tiles:insertAttribute name="footer"/>
</div>

</body>
</html>