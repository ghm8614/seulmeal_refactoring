
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>
</head>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold" style="padding-left: 30px;">리뷰 관리</h1>
			</div>
		</div>
		
		
		<table class="table table-hover text-center">
			<p style="text-align: right;">*</p>
			
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>리뷰제목</th>
					<th>리뷰내용</th>
					<th>생성일자</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="review" items="${review}" varStatus="status">
				<tr>
					<th style="width:260px; padding-left: 30px; text-align: left;">[${review.product.name}] ${review.title}
					<hr/>${review.user.userId}</th>
					<th style="max-width:590px; word-wrap:break-word; text-align:left;">${review.content }</th>
					<th style="width:180px;">${review.regDate }</th>
					<th  style="width:80px;">
					<c:if test="${review.status == 0 }">
						<div data-value="${review.reviewNo}" class="btn-delete" id="deleteReview" style="cursor: pointer;">
						끄기</div>
					</c:if>
					<c:if test="${review.status == 1 }">
						<div data-value="${review.reviewNo}" class="btn-restore" id="restoreReview" style="cursor: pointer;">
						켜기</div>
					</c:if>
					</th>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	<div class="container">
	<div class="row" style="justify-content : center;">
			<nav aria-label="...">
			  <ul class="pagination">
			  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
			  		<li class="page-item"><a class="page-link" href="/product/listReview/${i}/${searchCondition}">${i}</a></li>
			  	</c:forEach>
			  </ul>
			</nav>
		</div>
	</div>	
</div>
		
<jsp:include page="../layer/footer.jsp"></jsp:include>

<script> 
$(function(){ 

	  $(".btn-delete").click(function(){
		  const no =$(this).data("value");
		window.location.href = '/product/deleteReview/'+no;
	  });
	  
	  $(".btn-restore").click(function(){
		  const no =$(this).data("value");
		window.location.href = '/product/restoreReview/'+no;
	  });
	  
				
	  
	  
	  
	});
</script>
</body>
</html>