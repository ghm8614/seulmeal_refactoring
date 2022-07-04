<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>
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
	}
	.card-cover:hover{
		opacity: 0.7;
		cursor: pointer;		
	}
	
</style>
</head>
<body style="background-color: #fff;">
<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container px-4 py-5" id="custom-cards">
    <h2 class="pb-2 border-bottom">이 상품 어떠세요?</h2>
    	<div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-5 py-3">
			<c:forEach var="product" items="${list}">		
				<div class="col" style="margin-top:20px;">
				
					<div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-10 shadow-lg" style="background-image: url('/resources/attachments/${product.thumbnail}');">
						<div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
							<div data-value="${product.productNo}" class="productHref">
							<h2 class="display-6fw-bold">${product.name}</h2>
							<h4 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">${product.subContent}</h4>
							<c:if test="${product.originPrice != 0}">
							<h5 class="productTarget" style="text-decoration: line-through;">${product.originPrice}원</h5>
							</c:if>		
							<h5>${product.price}원</h5>
							<h5>${product.calorie}Cal</h5>
							</div>
							<div style="display:flex; justify-content:space-between;">
								<ul class="d-flex list-unstyled mt-auto">
									<li class="d-flex align-items-center me-3">
										<i style="font-size:1.5rem; color:black;" class="bi bi-clipboard-heart-fill"></i>
										<small>&nbsp;${product.reviewCount}</small>
									</li>
									<li class="d-flex align-items-center">
										<c:if test="${product.likeStatus ==1}">
											<i style="margin-left:15px; font-size:1.5rem;" class="bi bi-heart-fill" onclick="updateLikeProduct(this)"></i>
										</c:if>
										<c:if test="${product.likeStatus !=1}">
											<i style="margin-left:15px; font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
										</c:if>
										<small>&nbsp;${product.likeCount}</small>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>			
			</c:forEach>
   		</div>
	</div>
	<div class="container">
	<div class="row" style="justify-content : center;">
			<nav aria-label="...">
			  <ul class="pagination">
			  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
			  		<li class="page-item"><a class="page-link" href="/product/listProduct/${i}/${searchCondition}">${i}</a></li>
			  	</c:forEach>
			  </ul>
			</nav>
		</div>
	</div>	
	
	<jsp:include page="../layer/footer.jsp"></jsp:include>
	
	<jsp:include page="../chatBot/chatBot.jsp"></jsp:include>
<script type="text/javascript">


$(function(){
	$(".productHref").on("click",function(){
		const no =$(this).data("value");
		window.location.href = '/product/getProduct/'+no;
	})
});

function updateLikeProduct(e){
	const no = $(e).parent().parent().parent().parent().find(".productHref").data("value");
	const cl = $(e).next("small");
	///*
	$.ajax({
		url : "/product/api/updateLikeProduct/"+no,
		method : "GET",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
        success : function(data){
        	cl.text(data.likeCount);
        	if(data.result === "Liked"){
        		$(e).attr("class","bi-heart-fill")
        	} else {
        		$(e).attr("class","bi-heart")
        	}
        	
        }
	})
	//*/
}


</script>
</body>
</html>