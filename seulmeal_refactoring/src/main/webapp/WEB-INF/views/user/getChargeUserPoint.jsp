<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 #wrap{
    width:100%;
    height:100%;
}
  
#wrap .box{ 
    width:500px;
    height:300px;
    margin:0 auto;
    border: solid 1px #dadada;
    text-align: center;
    padding: 10px 10px 10px 10px;
    font-size: 18px;
} 
</style>

</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
<div id="wrap">
<div class="box">
		<h2>포인트 충전 내역</h2>
		<div class="row" style=" text-align: center !important;">
	  		<div class="col-md-3"></div>
	  		<div class="col-md-3">충전 포인트</div>
			<div class="col-md-3">${purchase.price}p</div>
		</div>
		<div class="row">
		<div class="col-md-3"></div>
	  		<div class="col-md-3">내 포인트</div>
			<div class="col-md-3">${user.totalPoint}p</div>
		</div>
</div>
</div>

<jsp:include page="../layer/footer.jsp"></jsp:include>
</body>
</html>