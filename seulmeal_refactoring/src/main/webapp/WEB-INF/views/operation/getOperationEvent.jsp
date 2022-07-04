<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세정보</title>
<style type="text/css">
	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
	
	.text-shadow-1 { text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25); }
	
	.cardP {
		margin: 20px;
		overflow: hidden;
	}
	
	.card-cover {
	  background-repeat: no-repeat;
	  background-position: center center;
	  background-size: cover;	  
	}
	
	.card-coverP{
		transform: scale(1.1);
		cursor: pointer;
	}
	
	.card-coverP:hover{
		transform: scale(1.2);
		background-blend-mode: soft-light;
	}	
	
	#tumbCard{
		background-image: url('../../../../resources/attachments/${post.thumnail}');
		background-size: contain;
	    background-repeat: no-repeat;
	    background-position: center;
	    background-size: cover;
	}
	
	.mb-0+.mb-0{
		margin-left: 20px;
	}
	
</style>
</head>
<body>
	<jsp:include page="../layer/header.jsp"></jsp:include>
	
	<!-- 이미지 -->
	<div class="row" style="margin-top:20px;">
		<div class="col">
			<div id="tumbCard" data-value="${post.postNo}" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg">
				<div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
					<h2 class="display-6 fw-bold">${post.title}</h2>
					<h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">${post.shortContent}</h2>
					<h2 class="endDateView">~${post.endDate}</h2>
					<div style="display:flex; justify-content:space-between;">
						<ul class="d-flex list-unstyled mt-auto">
							<li class="me-auto">
							</li>							
						</ul>
						<ul class="d-flex list-unstyled mt-auto">
							<li class="d-flex align-items-center me-3" style="font-size:1.5rem; margin-right:5px;">
								<i class="bi bi-emoji-heart-eyes"></i><br/>
								<small>&nbsp;${post.views}</small>
							</li>
							<li class="d-flex align-items-center"  style="font-size:1.5rem; margin-left:5px;">
								<i class="bi bi-calendar-date"></i>
								<small>&nbsp;${post.endDate}</small>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="card-header" id="headingOne" style="display:flex; justify-content: center; font-size: 30px; background-color: #fff;">
		<!-- 1번 -->
		<h2 class="mb-0">
			<button class="btn btn-link acodi" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				제목
			</button>
		</h2>

		<!-- 2번 -->
		<h2 class="mb-0">
			<a class="btn btn-link collapsed acodi" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
				내용
			</a>
		</h2>

		<!-- 3번 -->
		<h2 class="mb-0">
			<a class="btn btn-link collapsed acodi" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
				할인상품
			</a>
		</h2>
	</div>
		
	<div class="container" style="margin-top:20px;">
		<div id="accordion">			
			<div class="card" style="min-height: 500px;">
				<!-- 1번 -->
				<div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
					<div class="card-body">
						Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
					</div>
				</div>
		
				<!-- 2번 -->
				<div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordion">
					
					<div class="card-body">
						<div class="row justify-content-end" style="margin-right: 10px;">
				        	<div class="col-1">
				        		<c:if test="${post.attachments.size() != 0}">
					        		<div class="dropdown show">
										<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<span class="d-none d-sm-inline mx-1" style="color:black;">첨부파일</span>					
										</a>					
										<div class="dropdown-menu dropdown-menu-right dropdown-menu-dark text-small shadow" aria-labelledby="dropdownMenuLink">
											<c:forEach var="attachments" items="${post.attachments}">		          	
								            	<a class="dropdown-item" href="/download/${attachments.attachmentName}">${attachments.attachmentName }</a>
								            </c:forEach>
										</div>
									</div>
								</c:if>
				        	</div>		
				        </div>
						${post.content }						
					</div>
				</div>
		
				<!-- 3번 -->
				<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
					<div class="card-body">
						<div class="row" style="justify-content: center;">
						<c:forEach var="product" items="${post.discountProduct}">
							<c:if test="${product.productNo !=0}">
								<div class="col-md-5 cardP">
									<div class="card card-cover card-coverP h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="transaition : all 0.2s linear; background-image: url('/resources/attachments/${product.thumbnail}');">
										<div class="d-flex flex-column h-100 p-5 pb-0 text-white text-shadow-1">
											<div data-value="${product.productNo}" class="productHref" onclick="getProductIm(this)">
											<h2 class="display-6fw-bold productTarget">${product.name}</h2>
											<h4 class="pt-5 mt-5 mb-5 display-6fw-bold"></h4>
											<h5 class="productTarget" style="text-decoration: line-through;">${product.originPrice}원</h5>
											<h5 class="productTarget">${product.price}원</h5>
											<h5 class="productTarget">${product.calorie}Cal</h5>
											</div>
											<ul class="d-flex list-unstyled mt-auto" style="justify-content:flex-end;">
												<li class="me-auto">
												</li>
												<li class="d-flex align-items-center me-3">
													<i style="font-size:1.5rem; color:black;" class="bi bi-clipboard-heart-fill"></i>
													<small>&nbsp;${product.reviewCount}</small>
												</li>
												<li class="d-flex align-items-center">
													<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
													<small class="likeText">&nbsp;${product.likeCount}</small>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</c:if>							
						</c:forEach>
						</div>
					</div>
				</div>
				
			</div>		  
		</div>
	</div>
	
	<div class="row" style="border-bottom: 2px double #ff4500; border-top: 2px double #ff4500; margin-top:20px;">
		<div class="container" style="display:flex; justify-content: flex-end;">	
			<span style="margin-bottom:10px; margin-top:10px;">
				<c:if test="${user.role == 1}">
					<input class="btn btn-primary" style="margin-right:10px; width: 60px;" value="수정" onclick="updateEvent()">
					<input class="btn btn-primary" style="margin-right:10px; width: 60px;" value="삭제" onclick="deleteEvent()">
				</c:if>
				<input class="btn btn-primary" style="width: 60px;" value="목록" onclick="cancelEvent()">
			</span>
		</div>						
	</div>
				
	<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
	function updateEvent(){
		window.location.href = '/operation/updateOperation/2/${post.postNo}';
	}
	
	function cancelEvent(){
		window.location.href = '/operation/getListOperation/2';
	}

	function getProductIm(e){
		const no =$(e).data('value');
		window.location.href = '/product/getProduct/'+no;
	}
	
	function deleteEvent(){
		
		$.ajax({
			url : "/operation/api/deleteOperation",
			method : "POST",
			data : JSON.stringify({
				postNo : ${post.postNo},
				postStatus : ${post.postStatus}
			}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	window.location.href = '/operation/getListOperation/2/0/0';
	        }
		})
		
	}
</script>
</body>
</html>