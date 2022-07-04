<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-상품 목록</title>
<style type="text/css">
	
	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
	
	.text-shadow-1 { text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25); }
	
	.card-cover {
	  background-repeat: no-repeat;
	  background-position: center center;
	  background-size: cover;
	  color:none !important;
	  cursor: pointer;
	}	
	
	.cardComponet{
		opacity:1;
	}
	
	.cardComponet:hover{
		opacity:0.7;
	}
	
	th img{
	width: 100%;
	max-width: 144px;
	height: auto;
	}
	
</style>

</head>
<body style="background-color: #fff;">

<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold" style="padding-left: 30px;">상품 관리</h1>
			</div>
			<div class="dropdown pt-5 mb-4 col-6">		  
			<div class="float-right" style="display:flex;">
			<div class="dropdown show">
										
					
				</div>
			</div>
			<div class="float-right" style="display:flex;">
				<c:if test="${user.role == 1}">
					<button class="btn btn-primary" style="margin-right:10px;" onclick="insertProduct()">상품 등록</button>
				</c:if>
			</div>
		</div>
		</div>
		
		
		<table class="table table-hover text-center">
			<p style="text-align: right;">　</p>
			
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>썸네일</th>
					<th>상품명</th>
					<th>리뷰수</th>
					<th>가격</th>
					<th>재고</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="product" items="${list}" varStatus="status">
				<tr>
					<th>
					
					<c:if test="${!empty product.thumbnail}">
						<img src="/resources/attachments/${product.thumbnail}" style=" object-fit:cover; height: 88px; width: 144px;" alt="..." class="img-thumbnail" onerror="this.src='http://folo.co.kr/img/gm_noimage.png'">
					</c:if>
					<c:if test="${empty product.thumbnail}">
						<img src="http://folo.co.kr/img/gm_noimage.png" style="height: 81px; width: 144px;" alt="..." class="img-thumbnail">
					</c:if>
					
					</th>
					
					<th style="padding-left: 50px; text-align: left;"><div data-value="${product.productNo}" class="btn-getProduct" id="getProduct" style="cursor: pointer;">[${product.productNo}] ${product.name}</div><hr/>${product.subContent }</th>
					<th style="width: 96px;">${product.reviewCount }</th>
					<th style="width: 96px;">${product.price}</th>
					<th style="width: 96px;">${product.stock}</th>
					<th style="width: 96px;">
					<div data-value="${product.productNo}" class="btn-update" id="updateProduct" style="cursor: pointer;">수정</div>
					<hr/>
					<c:if test="${product.status == 0 }">
						<div data-value="${product.productNo}" class="btn-delete" id="deleteProduct" style="cursor: pointer;">끄기</div>
					</c:if>
					<c:if test="${product.status == 1 }">
						<div data-value="${product.productNo}" class="btn-restore" id="restoreProduct" style="cursor: pointer;">켜기</div>
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
			  		<li class="page-item"><a class="page-link" href="/product/admin/listProduct/${i}/${searchCondition}">${i}</a></li>
			  	</c:forEach>
			  </ul>
			</nav>
		</div>
	</div>	
		
<jsp:include page="../layer/footer.jsp"></jsp:include>

	</div>

<script type="text/javascript">


	
	function insertProduct(){
		window.location.href = '/product/insertProduct';
	}
	
	
	$(function(){ 
		$(".btn-getProduct").on("click",function(){
			const no =$(this).data("value");
			window.location.href = '/product/getProduct/'+no;
		})
		
		$(".btn-update").click(function(){
			const no =$(this).data("value");
			window.location.href = '/product/updateProduct/'+no;
		  });
		
		  $(".btn-delete").click(function(){
			  const no =$(this).data("value");
			window.location.href = '/product/deleteProduct/'+no;
		  });
		  
		  $(".btn-restore").click(function(){
			  const no =$(this).data("value");
			window.location.href = '/product/restoreProduct/'+no;
		  });
		  
		});
	
	
	</script>
	
</body>
</html>