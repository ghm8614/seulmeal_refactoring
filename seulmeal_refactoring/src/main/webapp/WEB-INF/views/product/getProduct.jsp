<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세조회</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- css body 적용 -->
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>-->


<style> /* 리뷰등록 모달창 CSS */
.modal, .updateReviewModal	 {
	overflow: hidden; position: fixed;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	top: 0;
	left: 0;
	display: none;
}

.modal_content {
	width: 440px;
	height: 750px;
	background: #fff;
	border-radius: 10px;
	position: relative;
	top: 20%;
	left: 50%;
	margin-top: -50px;
	margin-left: -200px;
	text-align: center;
	box-sizing: border-box;
	padding: 54px 0;
	line-height: 23px;
}
</style>
<style>
@font-face {
	font-family: 'GmarketSansMedium';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'GmarketSansMedium';
}

h2 {
	text-align: center;
}

.star {
	position: relative;
	font-size: 2rem;
	color: #ddd;
}

.star input {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	opacity: 0;
	cursor: pointer;
}

.star span {
	width: 0;
	position: absolute;
	left: 0;
	color: red;
	overflow: hidden;
	pointer-events: none;
}

.inputBtn {
	
}

.inputBtnE {
	text-align: center;
	border: 1px solid #ddd;
	box-shadow: 0.5px 0.5px gray;
	cursor: pointer;
}

.inputBtn:hover {
	color: red;
}

textarea {
	width: 100%;
	height: 500px;
	resize: none;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.img-thumbnail {
	margin: 10px;
	width: 100%;
	height: 550px;
	margin: auto;
	vertical-align: middle;
}

.box-line {
	border: 1px solid #ddd;
	padding: 20px;
}

.col-md-6 {
	/*border: 1px solid #ddd;*/
	padding: 10px;
}

.btn { &+&{
	margin: 20px;
}

}
.card-bottom {
	position: absolute;
	bottom: 0;
	width: 100%;
}

div{ -webkit-touch-callout: none;
     user-select: none;
     -moz-user-select: none;
     -ms-user-select: none;
     -webkit-user-select: none;
}

</style>

</head>



<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../layer/header.jsp"></jsp:include>
	<!-- ToolBar End /////////////////////////////////////-->
	<div class="container" style="margin-top: 20px;">
		<div style="text-align: center;">
			<p style="font-size: 42px; padding-bottom: 30px;">… ${product.name} …</p>
		</div>
		<div class="row" style="min-height: auto;">
			<div class="col-md-6" style="height: 100%; width: auto">
				<c:if test="${!empty product.thumbnail}">
					<img src="/resources/attachments/${product.thumbnail}" style="object-fit: cover;" alt="..." class="img-thumbnail" onerror="this.src='http://folo.co.kr/img/gm_noimage.png'">
				</c:if>
				<c:if test="${empty product.thumbnail}">
					<img src="http://folo.co.kr/img/gm_noimage.png" alt="..." class="img-thumbnail">
				</c:if>

			</div>
			<div class="col-md-6" style="min-height: auto;">
				<div style="display: flex; justify-content: flex-end;">
					<h7>등록일 &nbsp;</h7>
					<h7>${product.regDate}</h7>
				</div>

				<div class="box-line" style="min-height: 500px;">

					<c:if test="${!empty product.averageRating}">
						<h3>
							<div style="display: flex; justify-content: space-between;">
								<h5 style="margin-bottom: 20px;">평점</h5>

								<div class="star-ratings">
									<div class="star-ratings-fill space-x-2 text-lg" style="width: ${product.averageRating*10}%;">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
									<div class="star-ratings-base space-x-2 text-lg">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
								</div>

							</div>
					</c:if>
					<c:if test="${empty product.averageRating}">
							평가 없음
						</c:if>
					<div style="display: flex; justify-content: space-between;">
						<h5>좋아요 수</h5>
						<div class="d-flex align-items-center" style="font-size: 28px;">
							<i class="bi bi-heart" id="like-Icon" data-value="${product.productNo }" style="cursor: pointer;" onclick="updateLikeProduct(this)"></i> <small class="likeText" style="margin-left: 5px;">${product.likeCount}</small>
						</div>
					</div>
					<hr />
					<div>


						<div style="border: 1px solid #dce0e3; padding: 10px; background-color: #f7f8fa; max-height: auto;">
							<h4>한 줄 설명</h4>
							<h5>${product.subContent}</h5>
							<hr />
							<h4>들어간 재료</h4>

							<c:forEach var="parts" items="${product.parts}">
								<h5>${parts.name}</h5>
							</c:forEach>
						</div>

					</div>

					<br />
					<div style="display: flex; justify-content: flex-end;">
						<c:if test="${product.originPrice == 0}">
							<h4>가격 :</h4> &nbsp;
						<h4 id="defaultprice">${product.price}원</h4>
						</c:if>

						<c:if test="${product.originPrice != 0}">
							<h4>이벤트 할인가 :</h4> &nbsp;
						<h4 id="defaultprice" style="text-decoration: line-through;">${product.originPrice}원</h4>
							<h4 id="sale" style="color: crimson;">${product.price}원</h4>
						</c:if>


					</div>
				</div>
				<!-- -->

				<div class="col-md-12">
					<div class="row">
						<div style="margin-top: 10px; width: 100%;">
							<c:if test="${user == null }">
								<button class="btn btn-primary" disabled="disabled" style="width: 55%;">로그인 후 구매할 수 있습니다.</button>
							</c:if>
							<c:if test="${user != null }">
								<c:choose>
									<c:when test="${product.stock !=0}">
										<button class="btn btn-primary" style="width: 55%;">구매옵션 보기</button>
									</c:when>
									<c:otherwise>
										<button class="btn btn-primary" disabled="disabled">품절되었습니다.</button>
									</c:otherwise>
								</c:choose>
							</c:if>

							<button class="btn btn-primary" style="width: 43%;">관련상품</button>
						</div>
						<div style="margin-top: 10px; width: 100%;">
							<div style="display: flex; justify-content: space-between; margin-top: 10px">
								<c:if test="${user != null }">
									<button class="btn btn-primary" style="width: 55%;">문의하기</button>
									<button class="btn btn-primary" data-value="${product.productNo }" style="width: 43%;">리뷰등록</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 아코디언 헤더 -->
		<div class="card-header" id="headingOne" style="display: flex; justify-content: center; margin-top: 40px;">
			<!-- 아코디언 1번 -->
			<h2 class="mb-0">
				<a class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> 상세내용 </a>
			</h2>

			<!-- 아코디언 2번 -->
			<h2 class="mb-0">
				<a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> 배송/교환/반품 안내 </a>
			</h2>

			<!-- 아코디언 3번 -->
			<h2 class="mb-0">
				<a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"> 상품평 </a>
			</h2>
		</div>

		<!-- 아코디언 바디 -->
		<div class="container" style="margin-top: 20px;">
			<div id="accordion">
				<div class="card">
					<!-- 상품 아코디언 -->
					<div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
						<div class="card-body">${product.content }</div>
					</div>

					<!-- 안내 아코디언 -->
					<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
						<div class="card-body">
							<section class="customer_wrap2">

								<h2 class="title_style5">배송/교환/반품안내</h2>

								<dl class="info_txt">
									<p>
										<strong>배송안내</strong><br /> 출고지 : 서울특별시 ##구 물류센터 (일부 상품 제외) <br /> 결제확인된 다음날 상품이 발송됩니다. (※금요일 및 주말 결제건은 월요일에 출고됩니다.) <br /> 출고일에는 '배송준비중' 상태이며, 출고당일 오후에 택배사에서 송장번호 받은 후 입력해드리면 '배송중' 상태로 변경됩니다. <br /> 배송조회는 출고일 다음날 택배사에서 확인가능합니다. <br /> 택배사의 배송일정은 영업소별로 차이가 있을 수 있기 때문에 저희가 배송받으실 날짜를
										확답드리기 어려우니 이점 양해부탁드립니다. <br /> <br /> <strong>주문시 유의사항</strong> <br /> 무통장(가상계좌) 입금시 예금주는 #### 입니다. <br /> 은행 영업시간내 창구입금이 어려운 고객님께서는 다른은행으로 선택 후 주문해주시기 바랍니다. <br /> 모니터 사양(해상도/촬영조건)과 개인적인 견해에 따라 상품이 다르게 보일 수 있습니다. <br /> <br />
									</p>

									<dt class="dtcolor">반품/교환</dt>
									<dd>
										<span>반품 및 교환은 상품 수령 후 3일 이내에 가능합니다. </span>
									</dd>
									<br />
									<dt>반품규정</dt>
									<dd>
										1. 반드시 받으셨던 박스를 사용하여 ##택배(고객센터 1588-####)을 이용하여 반품해 주십시오.<br /> 2. 워런티 라벨, 상표 중 하나라도 없을 경우, 반품처리가 되지 않습니다. 이 점 양해 부탁 드립니다.
									</dd>
									<br />
									<dt>제품의 교환, 환불</dt>
									<dd>받으신 상품이 주문내용과 상이하는 경우, 배송 후 3일 이내에 언제든지 교환 또는 환불이 가능합니다.</dd>
									<dd>
										1. 교환 시, 교환하고자 하는 사유를 적어 제품과 함께 보내주세요. <br /> <br class="d_hidden t_hidden" /> 2. 환불 시, 환불 사유 및 환불 받으실 계좌번호, 예금주를 적어 제품과 함께 보내주세요. 제품은 되도록 처음 상태를 유지시켜 주시고, 기존의 제품박스를 사용해야 합니다.<br /> *환불은 반품 확인 후, 보내주신 계좌번호로 입금해드립니다. <br /> <br class="d_hidden t_hidden" /> 3. 다음과 같은 경우 교환, 환불이 되지 않습니다.<br />
										- 고의적 상품 훼손 (벌레 사체 등을 집어넣는 행위 등))<br /> - 기존 포장재가 제거된 경우<br /> - 워런티 라벨, 상표 중 하나라도 없을 경우<br /> <br class="d_hidden t_hidden" /> <span>*고객의 변심으로 인한 반품은 상품의 신선식품 특성상 불가합니다.</span><br />
									</dd>
									<br />
									<dt>교환/반품 절차</dt>
									<dd>
										① 교환 및 반품 신청서를 작성해주세요. (교환 시, 교환을 원하시는 상품을 적어주세요.)<br /> <br class="d_hidden t_hidden" /> ② 교환 및 반품하실 상품을 워런티카드, 파우치, 지퍼백을 받은 상태 그대로 포장해주세요.<br /> <br class="d_hidden t_hidden" /> ③ 반품처로 ## 택배를 이용하여 보내주세요. (반품처 : 서울특별시 ##구 ##동 ##-##)<br /> <br class="d_hidden t_hidden" /> ④ 고객 변심에 의한
										교환 및 반품일 경우 택배비는 고객님 부담으로 미리 선지불하여 보내주세요. 택배사는 자유롭게 이용해주세요.<br /> <br class="d_hidden t_hidden" /> ⑤ 단, 상품에 하자가 있어 교환 및 반품할 경우, 온라인 고객센터(02-####-####)로 통화하신 후, ##택배를 이용하여 보내주세요. (##택배 대표번호 : 1588-####)<br /> <br class="d_hidden t_hidden" /> ⑥ 반품 상품은 상품 확인 후, 무통장 입금 또는 카드결제 취소 처리 해드립니다.
									</dd>
								</dl>

							</section>

						</div>
					</div>

					<!-- 리뷰 아코디언 -->
					<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
						<div class="card-body">
							<c:if test="${empty review }">
								<p style="text-align: center;">등록된 리뷰가 없네요! 상품을 구매하고 첫번째 리뷰어가 되어주세요!</p>
							</c:if>

							<c:if test="${!empty review }">
								
								<table class="table table-hover text-center" id="review_row">
									<thead style="background-color: #ff4500; color: #fff;">
										<tr>
											<th colspan="1">제목 -작성자-</th>
											<th>내용</th>
											<th>별점</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="review" items="${review}">
											<tr>
												<th style="width: 220px; ; font-weight: bolder;">${review.title }<hr/>-${review.user.userId}-</th>
												<th style="text-align:left; max-width: 200px">${review.content }</th>
												<th style="width: 100px">${review.rating }</th>
												<c:if test="${review.user.userId != user.userId}">
												<th style="width: 100px;"></th>
												</c:if>
												<%-- 
											<c:if test="${review.user.userId != user.userId && !empty user.userId}">
											<th><div class="btn-ReportReview" style="cursor: pointer;" data-value="${review.reviewNo }" onclick="fncReportReview(this)">신고</div></th>
											</c:if>
											 --%>
												<c:if test="${review.user.userId == user.userId}">
													<th style="width: 100px;"><div class="btn-updateReview" style="cursor: pointer;" data-value="${review.reviewNo }" onclick="fncUpdateReview(this)">수정</div>
														<hr />
														<div class="btn-deleteReview" style="cursor: pointer;" data-value="${review.reviewNo }" onclick="deleteReview(this)">삭제</div></th>
												</c:if>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
					</div>
					
				</div>
			
			
		</div>
		</div></div>
		
	<!--<jsp:include page="../layer/upscroll.jsp"></jsp:include>-->
	<jsp:include page="../layer/footer.jsp"></jsp:include>
	

	<div class="modal">
		<!-- 리뷰 등록 모달창 -->
		<div class="modal_content">
			<form action="/product/insertReview/${product.productNo }" method="POST">
				<h2 class="text-center" style="margin-bottom:25px;">리뷰 작성</h2>
				<div class="col-md-12 form-group" style="padding-left: 20px;">
					<p class="text-left" style="padding-left: 13px;">상품명</p>
					<div class="col-md-12">
						<p class="text-left" style="padding-left: 20px;">${product.name}</p>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">작성자명</p>
					<div class="col-md-12">
						<p class="text-left"  style="padding-left: 20px;">${user.userName }</p>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">리뷰 제목</p>
					<div class="col-md-12">
						<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요 (최대 14자)" required maxlength='14' style="border: none;">
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">리뷰 내용</p>
					<div class="col-md-12">
						<textarea class="form-control" name="content" placeholder="내용을 입력하세요 (최대 96자)" required maxlength='96' style="height: 10em;    border: none;    resize: none;"></textarea>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">별점</p>
					<div class="col-md-12">
						<input type="number" class="form-control" name="rating" placeholder="1~10" required min="1" max="10" style="border: none;">
						
					</div>
				</div>
				<div class="text -right" style="margin-top: 20px; padding-right: 10px;">
					<button type="submit" class="btn btn-primary" id="insertReviewDone">등록</button>
					<button type="button" onclick="cancelBtn()" class="btn btn-primary" id="insertReviewCancel">취소</button>
				</div>
			</form>
		</div>
	</div>
	
	<div class="updateReviewModal">
		<!-- 리뷰 수정 모달창 -->
		<div class="modal_content">
			<form action="/product/updateReview/${product.productNo}" method="POST">
				<h2 class="text-center" style="margin-bottom:25px;">리뷰 수정</h2>
				<div class="col-md-12 form-group" style="padding-left: 20px;">
					<p class="text-left" style="padding-left: 13px;">상품명</p>
					<div class="col-md-12">"
						<p class="text-left" style="padding-left: 20px;">${product.name}</p>
						<input type="number" class="form-control" name="reviewNo" id="updateReviewNo" value="" required style="display: none;">
						
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">작성자명</p>
					<div class="col-md-12">
						<p class="text-left" style="padding-left: 20px;">${user.userName }</p>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">리뷰 제목</p>
					<div class="col-md-12">
						<input type="text" class="form-control" name="title" id="updateReviewTitle" value="" placeholder="제목을 입력하세요 (최대 14자)" required maxlength='14' style="border: none;">
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">리뷰 내용</p>
					<div class="col-md-12">
						<textarea class="form-control" name="content" value="" id="updateReviewContent" placeholder="내용을 입력하세요 (최대 96자)" required 	maxlength='96' style="height: 10em;    border: none;    resize: none;"></textarea>
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">별점</p>
					<div class="col-md-12">
						<input type="number" class="form-control" name="rating" value="" id="updateReviewRating" placeholder="1~10" required min="1" max="10" style="border: none;">
						
					</div>
				</div>
				<div class="text -right" style="margin-top: 20px; padding-right: 10px;">
					<button type="submit" class="btn btn-primary" id="updateReviewDone">등록</button>
					<button type="button" onclick="cancelBtn()" class="btn btn-primary" id="updateReviewCancel">취소</button>
				</div>
			</form>
		</div>
	</div>


	<script type="text/javascript">
	window.onload=function(){
		updateLikeProduct("#like-Icon");
		setTimeout(function(){
			updateLikeProduct("#like-Icon");
		},200);
	}
	
	
	$(function() {
		 // 구매 버튼
		 $(".btn-primary:contains('구매')").on("click", function(){
			 self.location = "/purchase/insertCustomProduct/${product.productNo}";
		 })
		 
		 // 나문희
		 $(".btn-primary:contains('문의하기')").on("click", function(){
			 self.location = "/operation/insertOperation/3";
		 })
		 
		 // 장바구니
		 $(".btn-primary:contains('구매옵션 보기)").on("click", function(){
			 self.location = "/purchase/insertCustomProduct/${product.productNo}";
		 })
		 
		  //관련상품
		 $(".btn-primary:contains('관련상품')").on("click", function(){
			 self.location = "/product/listProduct/1/${product.foodCategory.foodCategoryNo}";
		 })
	});
</script>

<style>
.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 1.3px;
  -webkit-text-stroke-color: #2b2a29;
}
 
.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 1;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}
 
.star-ratings-base {
  z-index: 0;
  padding: 0;
}
</style>


	<!-- 리뷰 등록 모달창  JS -->
	<script>
	
$(function(){ 

  $(".btn-primary:contains('리뷰등록')").click(function(){
	  const no = $(this).data("value");
	  $.ajax({
			url : "/product/api/validationReview/"+no,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	console.log(data);
	        	if(data == true){
	        		$(".modal").fadeIn();
	        	}else{
	        		alert('상품 구매 후 이용 가능한 서비스입니다.')
	        	}
	        }
		})
    		
  });
  
  $("#insertReviewCancel").click(function(){
    $(".modal").fadeOut();
  });
  
});
$(function(){ 
	
	$(".btn-updateReview").click(function(){
	    $(".updateReviewModal").fadeIn();
	  });
		  $("#updateReviewCancel").click(function(){
	    $(".updateReviewModal").fadeOut();
	  });
	});
	
function fncUpdateReview(e){
	const no = $(e).data("value");
	console.log(no);
	
	$.ajax({
		url : "/product/api/getReview/"+no,
		method : "GET",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
        success : function(data){
        	console.log(data);
        	$('#updateReviewNo').val(data["reviewNo"]);
        	$('#updateReviewTitle').val(data["title"]);
        	$('#updateReviewContent').val(data["content"]);
        	$('#updateReviewRating').val(data["rating"]);
        }
	})
};

function deleteReview(e){
	const no = $(e).data("value");
	$.ajax({
		url : "/product/api/deleteReview/"+no,
		method : "GET",
		dataType : "false",
		contentType : "application/json; charset=utf-8",
        complete : function(data){
			alert("리뷰가 삭제되었습니다.");
			reloadDivArea();
			
        }
	})
};

function reloadDivArea() {
    $('#review_row').load(location.href+' #review_row');
}

function updateLikeProduct(e){
	const no = $(e).data("value");
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
};
</script>

	<br />
	<br />
</body>
</html>