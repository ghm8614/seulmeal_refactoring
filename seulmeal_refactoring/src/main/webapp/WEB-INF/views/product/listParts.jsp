
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>재료 관리</title>
</head>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold" style="padding-left: 30px;">재료 관리</h1>
			</div>
			<div class="dropdown pt-5 mb-4 col-6">		  
			<div class="float-right" style="display:flex;">
			<c:if test="${user.role == 1}">
					<button class="btn btn-primary" style="margin-right:20px;" onclick="insertParts()">재료 등록</button>
				</c:if>
						<button class="btn btn-primary" style="margin-right:10px;"><a href="/product/listParts/1/0">판매재료 보기</a></button>
						<button class="btn btn-primary" style="margin-right:10px;"><a href="/product/listParts/1/1">판매중단 재료 보기</a></button>
			</div>
		</div>
		</div>
		
		
		<table class="table table-hover text-center">
			<p style="text-align: right;">* 단위 : 100g 또는 1알, 1개 기준</p>
			
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>재료명</th>
					<th>재료 가격</th>
					<th>재료 칼로리</th>
					<th colspan="2">상태변경</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="parts" items="${list}" varStatus="status">
				<tr>
					<th style="padding-left: 50px; text-align: left;">[${parts.partsNo}] ${parts.name}</th>
					<th>${parts.price}</th>
					<th>${parts.calorie}</th>
					<th><div class="btn-update" style="cursor: pointer;" data-value="${parts.name }" onclick="fncUpdateParts(this)">수정</div></th>
					<th>
					<c:if test="${parts.status == 0 }">
						<div data-value="${parts.partsNo}" class="btn-delete" id="deleteParts" style="cursor: pointer;">
						끄기</div>
					</c:if>
					<c:if test="${parts.status == 1 }">
						<div data-value="${parts.partsNo}" class="btn-restore" id="restoreParts" style="cursor: pointer;">
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
			  		<li class="page-item"><a class="page-link" href="/product/listParts/${i}/${searchCondition}">${i}</a></li>
			  	</c:forEach>
			  </ul>
			</nav>
		</div>
	</div>	
</div>
		
<jsp:include page="../layer/footer.jsp"></jsp:include>

	
	
<!-- 파츠 등록 모달창 -->
<div class="insertModal">
		<div class="modal_content">
			<form action="/product/insertParts" method="POST">
				<h2 class="text-center" style="margin-bottom:25px;">재료 등록</h2>
				<div class="col-md-12 form-group" style="padding-left: 20px;">
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">재료명</p>
					<div class="col-md-12">
						<input type="text" class="form-control" name="name" placeholder="재료명을 입력하세요(필수사항 최대 14자)" equired maxlength='14' style="border: none;">
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">재료 가격</p>
					<div class="col-md-12">
						<input type="number" class="form-control" name="price" placeholder="가격을 입력하세요(필수사항)" equired min="0" style="border: none;">
					</div>
				</div>
				<div class="col-md-12 form-group">
					<p class="text-left" style="padding-left: 13px;">재료 칼로리</p>
					<div class="col-md-12">
						<input type="number" class="form-control" name="calorie" placeholder="칼로리를 입력하세요(필수사항)" equired min="0" style="border: none;">
					</div>
				</div>
				<div class="text-right" style="margin-top: 20px; padding-right: 10px;">
					<button type="submit" class="btn btn-primary" id="insertPartsDone">등록</button>
					<button type="button" onclick="cancelBtn()" class="btn btn-primary" id="insertPartsCancel">취소</button>
				</div>
				</div>
			</form>
		</div>
	</div>

<div class="updateModal">
		<div class="modal_content">
			<form action="/product/updateParts" method="POST">
				<h2 class="text-center" style="margin-bottom: 25px;">재료 수정</h2>
				<div class="col-md-12 form-group" style="padding-left: 20px;">
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" name="partsNo" id="updateNo" value="" placeholder="" style="border: none; display:none;">
						
						<p class="text-left" style="padding-left: 13px;">재료명</p>
						<div class="col-md-12">
							<input type="text" class="form-control" name="name" id="updateName" value="" placeholder="재료명을 입력하세요(필수사항 최대 14자)" equired maxlength='14' style="border: none;">
						</div>
					</div>
					<div class="col-md-12 form-group">
						<p class="text-left" style="padding-left: 13px;">재료 가격</p>
						<div class="col-md-12">
							<input type="number" class="form-control" name="price" id="updatePrice" value="" placeholder="가격을 입력하세요(필수사항)" equired min="0" style="border: none;">
						</div>
					</div>
					<div class="col-md-12 form-group">
						<p class="text-left" style="padding-left: 13px;">재료 칼로리</p>
						<div class="col-md-12">
							<input type="number" class="form-control" name="calorie" id="updateCalorie" value="" placeholder="칼로리를 입력하세요(필수사항)" equired min="0" style="border: none;">
						</div>
					</div>
					<div class="text-right" style="margin-top: 20px; padding-right: 10px;">
						<button type="submit" class="btn btn-primary" id="updatePartsDone">수정</button>
						<button type="button" onclick="cancelBtn()" class="btn btn-primary" id="updatePartsCancel">취소</button>
					</div>
			</form>
		</div>
	</div>

	<!-- 파츠 등록 모달창 JS -->
<script>
$(function(){ 

  $(".btn-primary:contains('재료 등록')").click(function(){
    $(".insertModal").fadeIn();
  });
  
  $("#insertPartsCancel").click(function(){
    $(".insertModal").fadeOut();
  });
  
});

$(function(){ 
	
$(".btn-update").click(function(){
    $(".updateModal").fadeIn();
  });
	  $("#updatePartsCancel").click(function(){
    $(".updateModal").fadeOut();
  });
});
		

</script>

<!-- 파츠 등록 모달창 CSS -->
<style>
.insertModal, .updateModal {
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
	height: 480px;
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

<!-- 파츠 활성화/비활성화 JS -->
<script> 

function fncUpdateParts(e){
	const no = $(e).data("value");
	
	$.ajax({
		url : "/product/api/getPartsName/"+no,
		method : "GET",
		dataType : "json",
		contentType : "application/json; charset=utf-8",
        success : function(data){
        	$('#updateNo').val(data["partsNo"]);
        	$('#updateName').val(data["name"]);
        	$('#updatePrice').val(data["price"]);
        	$('#updateCalorie').val(data["calorie"]);
        }
	})
}
	
$(function(){ 

	  $(".btn-delete").click(function(){
		  const no =$(this).data("value");
		window.location.href = '/product/deleteParts/'+no;
	  });
	  
	  $(".btn-restore").click(function(){
		  const no =$(this).data("value");
		window.location.href = '/product/restoreParts/'+no;
	  });
	  
	});
</script>

</body>
</html>