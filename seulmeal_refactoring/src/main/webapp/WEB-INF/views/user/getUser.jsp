<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<title>insertUser</title>
</head>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>

 <div class="container">
	
		<div class="page-header">
	       <h3 class=" text">회원정보조회</h3>
	      
	    </div>
	    
	    <br/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
			<div class="col-xs-8 col-md-4">${user1.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>이 름</strong></div>
			<div class="col-xs-8 col-md-4">${user1.userName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>최근 구매 상품</strong></div>
				<div class="col-xs-8 col-md-4"><a href="/purchase/getPurchase/${purchase.purchaseNo}">
				<c:forEach var="cpd" items="${purchase.customProduct}">
			     	 ${cpd.product.name}        
			    </c:forEach> </a> 
			   </div>
		</div>
		
		<hr/>
		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>닉네임</strong></div>
			<div class="col-xs-8 col-md-4">${user1.nickName}</div>
		</div>
		
		<hr/>

		<div class="row">
			<div class="col-xs-4 col-md-2 ">
				<strong>회원등급</strong>
			</div>
			<div class="col-xs-8 col-md-4">
				<c:choose>
					<c:when test="${user1.grade eq '0'}">슬밀프랜즈</c:when>
					<c:when test="${user1.grade eq '1'}">슬밀패밀리</c:when>
					<c:when test="${user1.grade eq '2'}">슬밀히어로</c:when>
					<c:when test="${user1.grade eq '3'}">슬밀마스터</c:when>
				</c:choose>
			</div>
		</div>

		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주소</strong></div>
			<div class="col-xs-8 col-md-4">${user1.address}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>휴대전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user1.phone ? user.phone : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>이 메 일</strong></div>
			<div class="col-xs-8 col-md-4">${user1.email}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가입일</strong></div>
			<div class="col-xs-8 col-md-4">${user1.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가용포인트</strong></div>
			<div class="col-xs-8 col-md-4">${user1.totalCount}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>차단횟수</strong></div>
			<div class="col-xs-8 col-md-4">${user1.blockCount}</div>
		</div>
		
		<hr/>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

    <jsp:include page="../layer/footer.jsp"></jsp:include>
</body>
</html>