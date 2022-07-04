<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png">

<meta charset="UTF-8">
<title>찜 목록 관리</title>
</head>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold" style="padding-left: 30px;">찜 목록 관리</h1>
			</div>
		</div>
		
		
		<table class="table table-hover text-center">
			<p style="text-align: right;">*</p>
			
			<thead style="background-color: #ff4500; color: #fff;">
				<tr id="table_row">
					<th>썸네일</th>
					<th>상품명</th>
					<th>가격</th>
					<th>재고량</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="product" items="${like}" varStatus="status">
				<tr id="like_row">
					<th>
					<a href="/product/getProduct/${product.productNo }"><img src="/resources/attachments/${product.thumbnail}" style=" object-fit:cover; height: 88px; width: 144px;" alt="..." class="img-thumbnail" onerror="this.src='http://folo.co.kr/img/gm_noimage.png'"></a>
					</th>
					<th style="padding-left: 50px; text-align: left;"><a href="/product/getProduct/${product.productNo }">${product.name}</a></th>
					<th>${product.price}</th>
					<th>${product.stock}</th>
					<th>	<div data-value="${product.productNo}" onclick="updateLikeProduct(this)" class="btn-delete" id="deleteLike" style="cursor: pointer;">
						좋아요 취소</div>
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
			  		<li class="page-item"><a class="page-link" href="/product/listLike/${i}/${searchCondition}">${i}</a></li>
			  	</c:forEach>
			  </ul>
			</nav>
		</div>
	</div>	
</div>

	<jsp:include page="../layer/footer.jsp"></jsp:include>
	
	<jsp:include page="../chatBot/chatBot.jsp"></jsp:include>

<script> 
function updateLikeProduct(e){
	const no = $(e).data("value");
	///*
	$.ajax({
		url : "/product/api/updateLikeProduct/"+no,
		method : "GET",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
        success : function(data){
			$('#like_row').remove();
			alert("상품의 좋아요를 취소했습니다.");
			
        }
	})
};
</script>
</body>
</html>