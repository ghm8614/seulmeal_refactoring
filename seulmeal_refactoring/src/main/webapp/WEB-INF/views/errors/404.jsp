<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Kanit:200" rel="stylesheet">

<!-- Font Awesome Icon -->
<link type="text/css" rel="stylesheet" href="/resources/css/error/404/font-awesome.min.css" />

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="/resources/css/error/404/style.css" />
<title>404 PAGE</title>
</head>
<body>
	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>404</h1>
			</div>
			<h2>Oops! Nothing was found</h2>
			<p>request_uri : <c:out value="${requestScope['javax.servlet.error.request_uri']}"/></p>
		    <p>status_code : <c:out value="${requestScope['javax.servlet.error.status_code']}"/></p>
		    <p>servlet_name : <c:out value="${requestScope['javax.servlet.error.servlet_name']}"/></p>
		    <p>exception : <c:out value="${requestScope['javax.servlet.error.exception']}"/></p>
		    <p>servlet_name : <c:out value="${requestScope['javax.servlet.error.servlet_name']}"/></p>
		    <p>message : <c:out value="${requestScope['javax.servlet.error.message']}"/></p>
			<p>The page you are looking for might have been removed had its name changed or is temporarily unavailable.
			 <a href="/">Return to homepage</a></p>
			<div class="notfound-social">
				<a href="#"><i class="fa fa-facebook"></i></a>
				<a href="#"><i class="fa fa-twitter"></i></a>
				<a href="#"><i class="fa fa-pinterest"></i></a>
				<a href="#"><i class="fa fa-google-plus"></i></a>
			</div>
		</div>
	</div>	
</body>
</html>