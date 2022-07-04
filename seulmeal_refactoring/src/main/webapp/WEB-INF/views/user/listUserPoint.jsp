<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>회원 목록</title>
<style type="text/css">


.btnOrange {
  float: left ;
  width: 130px ;
  padding: 0;
  margin: 10px 20px 10px 0;
  text-align: center ;
  background: #fff;
  line-height: 50px ; 
  border: solid 1px #FF4500 !important;
  
}



input{
    margin: 0px 10px 8px 10px;
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
}
</style>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 아래 제이쿼리는 1.0이상이면 원하는 버전을 사용하셔도 무방합니다. -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="container">
		
		
		<div class="row">
			<div class="col-md-10">
			<h3 >포인트</h3>
	
			
		</div>
			
			<div class="col-md-2">
			 <button type="button" class="btnOrange" data-toggle="modal" data-target="#staticBackdrop">
			  포인트 충전
			</button>
			</div>
		<table class="table table-striped table-hover" style="text-align: right;">
			<thead>
				<tr>
					<th>
						<div class="dropdown">
						  구분
						</div>
					
					</th>
					<th>포인트</th>
					<th style="text-align: center;">구매 내역</th>
					<th style="text-align: center;">날짜</th>
				</tr>
			</thead>
			<tbody >
				<c:forEach var="point" items="${pointList}">
				<tr>
					<th ><c:choose>
						<c:when test="${point.pointStatus eq '0'}"><div style="color: #994936;">사용</div></c:when>
						<c:when test="${point.pointStatus eq '1'}"><div style="color: #6D992E;">적립</div></c:when>
						<c:when test="${point.pointStatus eq '2'}"><div style="color: #003EE6;">충전</div></c:when>
						
					</c:choose>
					</th>
					<th ><div >${point.point} P</div></th>
					
					<th style="text-align: center;"><c:choose>
						<c:when test="${point.pointStatus eq '0'}"><a  href="/purchase/getPurchase/${point.purchaseNo}">${point.purchaseNo}</a></c:when>
						<c:when test="${point.pointStatus eq '1'}"><a href="/purchase/getPurchase/${point.purchaseNo}">${point.purchaseNo}</a></c:when>
						<c:when test="${point.pointStatus eq '2'}"></c:when>	
					</c:choose>
					</th>
					
					
					
					<th style="text-align: center;">${point.regDate}</th>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
	<div class="container">
	<div class="row">		<div class="col-md-3"></div>
		<div class="col-md-6">
			<nav aria-label="...">
			  <ul class="pagination">
		  		<li class="page-item disabled">
			      <span class="page-link" data-value="1">Previous</span>
			    </li>
			  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
			  		<li class="page-item"><a class="page-link" href="/pont/listUserPoint/${i}">${i}</a></li>
			  	</c:forEach>
			  	<li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>	
</div>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">포인트 충전</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
        <div class="login-id-wrap" style="text-align: center;">
        <input id="input-id" type="hidden" id="userId" name="userId" value="${user.userId}"/>
		<input name="price" id="price"/> 원
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onClick="iamport()">충전하기</button>
         <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="getCharge" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">포인트 충전 완료</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
       <div id="insertPoint" style="text-align: center;"></div>
        <div id="totalPoint" style="text-align: center;"></div>
        
      </div>
      <div class="modal-footer">
        
         <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
function iamport(){
	
	var form1 = $(".box").serialize();
	
	let customNo = [];
	let ar = $(".customProductNo").get();
	console.log(ar);
	
	for ( var i = 0; i < ar.length; i++) {
		customNo.push(ar[i].value);
	}
	console.log(customNo);
	console.log($('#price').val());
	const userId = $('#userId').val();
	const name = "0";
	const address ="0";
	const phone = "0";
	const email = "0";
	const message ="0";
	const price = $('#price').val();
	const usePoint = "0";
	const paymentCondition = "0";

		$.ajax({
			url:"/purchase/api/insertPurchase",
			method:"POST",
			data:JSON.stringify({
				name : name,
				address : address,
				phone : phone,
				email : email,
				message : message,
				price : price,
				paymentCondition : paymentCondition,
				usePoint : usePoint,
				customProductNo : customNo
				//plusPoint : plusPoint
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			dataType : "json",
			success : function(data){
				console.log(data);
				IMP.init('imp83644059'); 
				IMP.request_pay(
				    { 
		 		  	pay_method: data.paymentCondition,
		  		  	merchant_uid: data.purchaseNo,
		  		  	name: "포인트 충전",
		  		  	amount: data.price,
		   		 	buyer_email: data.email,
		   			buyer_name: data.name,
		  			buyer_tel: data.phone,
		  		  	buyer_addr: data.address,
		   		 	buyer_postcode: "01181"
					}, function(rsp) {
						if(rsp.success){
							var msg = '결제가 완료되었습니다.';
			  		      	
			  		      	 $.ajax({
			  		  			url:"/purchase/api/verifyIamport",
			  		  			method:"POST",
			  		  			data:JSON.stringify({
			  		  				imp_uid : rsp.imp_uid,
			  		  				purchaseNo : rsp.merchant_uid,
			  		  				amount : rsp.paid_amount
			  		  			}),
			  		  			headers : {
			  		  				"Accept" : "application/json",
			  		  				"Content-Type" : "application/json"
			  		  			},
			  		  			dataType : "json",
			  		  			success : function(data){
			  		  				console.log(data);
			  		  				/*  window.location.href='/user/getChargeUserPoint/' + data.purchase.purchaseNo;  */
			  		  				
					  		  		
			  		  				
			  		  			$.ajax({
				  		  			url:"/user/api/insertPoint",
				  		  			method:"POST",
				  		  			data:JSON.stringify({
				  		  				purchaseNo : data.purchase.purchaseNo
				  		  			}),
				  		  			headers : {
				  		  				"Accept" : "application/json",
				  		  				"Content-Type" : "application/json"
				  		  			},
				  		  			dataType : "json",
				  		  			success : function(data){
				  		  			$("#insertPoint").text('충전 포인트 : '+data.chargePoint);
				  		  			$("#totalPoint").text('가용 포인트 : '+data.totalPoint);
				  		  			$("#staticBackdrop").modal('hide');
			  		  				$("#getCharge").modal('show');
			  		  				
				  		  			} 
				  		  		})
			  		  			}			
			  		  	
			  		      	 })	
			  		  			
			  		      	
						}else{
							var msg = '결제에 실패하였습니다.';
					         msg += '에러내용 : ' + rsp.error_msg;
	
						}
					/* alert(msg); */
				})
			}
		})
	}
</script>
</body>
</html>