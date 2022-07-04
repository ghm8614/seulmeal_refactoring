<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>구매 등록</title>

</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>

<style>

	input{
	   width:300px;
	   height:50px;
	   border-top:none;
	   border-left:none;
	   border-right:none;
	   border-bottom:2px solid #FF4500;
	}
	
	input[type="checkbox"]{
        display: none;
      }
      
    input[type="checkbox"] + label{
        display: inline-block;
        width: 20px;
        height: 20px;
        border:3px solid #FF4500;
        position: absolute;
        font-size: 14px;
      }
	input[type="checkbox"]:checked + label::after{
        content:'V';
        color: #FF4500;
        font-size: 16px;
        width: 20px;
        height: 20px;
        text-align: center;
        position: absolute;
        left: 0;
        top:0;
      }

	h2:after {
		content: "";
		display: block;
		width: 100px;
		border-bottom: 2px solid #969696;
		margin: 20px 0px;
		padding:0px 10px 0px 10px;
	}
	
	.thumbnail{
		width: 100px;
		height: 100px;
	}

</style>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

	<form class="cc">
	 <div class="container">
	  <div class="row">
		 <div class="col-xs-4" style="padding: 100px 0px 0px 40px;">
		 	<h2>구매&emsp;&emsp;</h2>
		 </div>
		 <div class="col-xs-4">
		 	<div style="border:1px solid; padding:1px 0px 10px 12px; margin:20px; width:600px; margin-top:80px; border-radius: 3px; border-color: #969696;">
		 			<div class="row">
						 <div class="col-xs-4" style="padding: 7px 0px 0px 0px;">
						 	<div style="border:1px solid; padding:10px; margin:20px; width:85px; border-radius: 4px; border-color: #969696;">
		 						<div text-align="center">혜택정보</div>
		 					</div>
		 				</div>
		 				<div class="col-xs-8" style="padding: 15px 0px 0px 0px;">
		 					<div align="center">${user.userName}님의 회원등급은 [
		 						<c:choose>
									<c:when test="${user.grade eq '0'}">슬밀프랜드</c:when>
									<c:when test="${user.grade eq '1'}">슬밀패밀리</c:when>
									<c:when test="${user.grade eq '2'}">슬밀히어로</c:when>
									<c:when test="${user.grade eq '3'}">슬밀마스터</c:when>
								 </c:choose> 
								 ]입니다.</div>
		 					<hr style="border:1px solid; width:400px; bottom:15px; border-color: #FF4500;"/>
		 					<div align="center" style="padding: 0px 0px 0px 30px;">가용포인트 : <fmt:formatNumber value="${user.totalPoint}" pattern="#,###"/> P</div>
		 				</div>				
		 			</div>
		 	</div>
		 </div>
		 <div class="col-xs-4">
			 <br/><br/>
		 	<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-receipt-cutoff" viewBox="0 0 16 16" style="padding: 50px 0px 0px 0px;">
			  <path d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zM11.5 4a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"/>
			  <path d="M2.354.646a.5.5 0 0 0-.801.13l-.5 1A.5.5 0 0 0 1 2v13H.5a.5.5 0 0 0 0 1h15a.5.5 0 0 0 0-1H15V2a.5.5 0 0 0-.053-.224l-.5-1a.5.5 0 0 0-.8-.13L13 1.293l-.646-.647a.5.5 0 0 0-.708 0L11 1.293l-.646-.647a.5.5 0 0 0-.708 0L9 1.293 8.354.646a.5.5 0 0 0-.708 0L7 1.293 6.354.646a.5.5 0 0 0-.708 0L5 1.293 4.354.646a.5.5 0 0 0-.708 0L3 1.293 2.354.646zm-.217 1.198.51.51a.5.5 0 0 0 .707 0L4 1.707l.646.647a.5.5 0 0 0 .708 0L6 1.707l.646.647a.5.5 0 0 0 .708 0L8 1.707l.646.647a.5.5 0 0 0 .708 0L10 1.707l.646.647a.5.5 0 0 0 .708 0L12 1.707l.646.647a.5.5 0 0 0 .708 0l.509-.51.137.274V15H2V2.118l.137-.274z"/>
			</svg>
		 </div>
		</div><br/>
	
		<table class="table table-hover" style="border-color: #FF4500; width:1000px;">
	 
	        <thead>
	          <tr>
	            <th align="center">NO</th>
	            <th align="center">이미지</th>
	            <th align="center">상품명</th>
	            <th align="center">옵션</th>
	             <th align="center">수량</th>
	            <th align="center">합계</th>
	          </tr>
	        </thead>
	        
	       <c:choose>
	       	 <c:when test="${cartStatus eq '0'}">
	
				<tbody style="font-size:15px">
						<tr class="ct_list_pop">
							  <input type="hidden" class="customProductNo" name="customProductNo" value="${customProduct.customProductNo}"/>
							  <td align="left">1</td>
							  <td align="left" data-value="${customProduct.product.productNo}" title="Click : 상품확인" ><img class="thumbnail" src='/resources/attachments/${customProduct.product.thumbnail}'></td>
							  
							  <td align="left">${customProduct.product.name}</td>
							  <td align="left">
							  <c:forEach var="pp" items="${customProduct.plusParts}">
							  	+ ${pp.parts.name}, ${pp.gram}g, <fmt:formatNumber type="number" maxFractionDigits="0"  value="${pp.parts.price*pp.gram/10}" />원 <br/>
							  	</c:forEach>
							  <c:forEach var="mp" items="${customProduct.minusParts}">
							  	- ${mp.minusName} <br/>
							  	</c:forEach> 
							  	 </td>
							  <td align="left">
							  	<span id ="count" name="count"> ${customProduct.count} </span>
							  </td>
							  <td align="left">
							  <span id="customprice" name="customPrice">${customProduct.price*customProduct.count}</span>원</td>
							  <c:set var="sum" value="${customProduct.price*customProduct.count}" />
						  </tr>  

				  
				</c:when>
			
				<c:when test="${cartStatus eq '1'}">
	
				<tbody style="font-size:15px">
				<c:set var="sum" value="0" />
				<c:set var="i" value="0" />
				<c:forEach var="cpd" items="${customProductList}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						  <input type="hidden" class="customProductNo" name="customProductNo" value="${cpd.customProductNo}"/>
						  <td align="left">${i}</td>
						  <td align="left" data-no="${cpd.product.productNo}" title="Click : 상품확인" ><img class="thumbnail" src='/resources/attachments/${cpd.product.thumbnail}'></td>
						  <td align="left">${cpd.product.name}</td>
						  <td align="left">
						  <c:forEach var="pp" items="${cpd.plusParts}">
						  	+ ${pp.parts.name}, ${pp.gram}g, <fmt:formatNumber type="number" maxFractionDigits="0"  value="${pp.parts.price*pp.gram/10}" />원 <br/>
						  	</c:forEach>
						  <c:forEach var="mp" items="${cpd.minusParts}">
						  	- ${mp.minusName} <br/>
						  	</c:forEach> 
						  	 </td>
						  <td align="left">
						  	<span id ="count" name="count"> ${cpd.count} </span> 
						  </td>
						  <td align="left">
						  <span id="customprice" name="customPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${cpd.price*cpd.count}"/></span>원</td>
						  <c:set var="sum" value="${sum+cpd.price*cpd.count}" />
						  
					  </tr>  
				  </c:forEach>
	        </tbody>
	        </c:when>
	        </c:choose>
	      </table><br/>
	 </div>
	
	<div class="container">
	<div class="row">
	<div class="col-xs-6">
	 
	<div class="card" style=" border-radius: 10px; width:470px; min-height: 670px; margin-left: 60px;">
		<div class="card-body">
		    <h6 class="card-title">배송정보</h6>
		    <h8 class="card-subtitle mb-2 text-muted"></h8>
		    <p class="card-text">
				<div class="container" >
					<input type="hidden" id="userId" name="userId" value="${user.userId}"/><br/>
					<label class="placeholder-text">
					   <div class="text">받으시는분</div>
					</label>
					<div>
					<input type="text" id="name" name="name" value="${user.userName}" placeholder="받으시는분"></input><br/>
					</div><br/>
					<label class="placeholder-text">
					   <div class="text">주소</div>
					</label>
					<div>
					<div style="display: flex; justify-content: space-between;">
				    	<input type="text" id="sample3_postcode" placeholder="우편번호" style="width: 100%;" readonly>
						<input class="btn btn-default" type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기">
					</div>
						<input type="text" id="sample3_address" placeholder="주소" readonly><br>
						<input type="text" id="address" placeholder="상세주소">
					
					<div id="addressWrap" style="display:none;border:1px solid;width:100%;height:300px;margin:5px 0;position:relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
					</div><br/>
					<label class="placeholder-text">
					   <div class="text">휴대전화</div>
					</label>
					<div>
					<input type="text" id="phone" name="phone" value="${user.phone}" placeholder="휴대전화"></input><br/>
					</div><br/>
					<label class="placeholder-text">
					   <div class="text">이메일</div>
					</label>
					<div>
					<input type="text" id="email" name="email" value="${user.email}" placeholder="이메일"></input><br/>
					</div><br/>
					<label class="placeholder-text">
					   <div class="text">배송메시지</div>
					</label>
					<div>
					<input type="text" id="message" name="message" placeholder="배송메시지"></input><br/>
					</div>
			</p>
		</div>
	</div>
	</div>
	</div>
			
			<div class="col-xs-2">
				<div class="card" style="border:none; color:white;">
					슬밀슬
				</div><br/>
			</div>
	
			<div class="col-xs-3">
				<div class="card" style="border-radius: 10px; width: 370px;">
					<div class="card-body">
					    <h6 class="card-title">결제수단</h6>
					    <h8 class="card-subtitle mb-2 text-muted"></h8>
					    <p class="card-text">
					    	<div>
					    		<input type="checkbox" id="pay1" value="0" onClick="fncClickCheck(this)" checked="checked"/>신용카드&ensp;&ensp;&ensp;
					    		<label for="pay1"></label><br/>
					    		<input type="checkbox" id="pay2" value="2" onClick="fncClickCheck(this)"/>네이버페이&ensp;
					    		<label for="pay2"></label><br/>
					    		<input type="checkbox" id="pay3" value="3" onClick="fncClickCheck(this)"/>카카오페이&ensp;
					    		<label for="pay3"></label>
					    	</div><br/>

							<div class="header" id="head">
								<!-- 아코디언-->		
								<div>
									<a class="bg_links" data-toggle="collapse" data-target="#collapse" aria-expanded="false" aria-controls="collapse"> 포인트사용(보유 <fmt:formatNumber type="number" maxFractionDigits="0" value="${user.totalPoint}"/>P) </a>
								</div>	
							</div>
					
							<!-- 아코디언 바디 -->
							<div class="container" style="margin-top: 20px;">
								<div id="accordion">
									<div class="card">
										<div id="collapse" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
											<div class="card-body">
												<input input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="usepoint" placeholder="사용할 포인트" style="width:150px;"></input> P<br/><br/>
												(100P 단위로 사용가능)<br/><br/>
												<input type="password" id="password" name="password" value="" placeholder="비밀번호" style="width:150px;"></input>
												<button type="button" class="btn btn-outline-primary" id="confirm" style="font-size:16px;" onClick="fnCalTotal()">확인</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							
													
						</p>
					</div>
				</div><br/>
				
				<div class="card" style="border-radius: 10px; min-height: 80px; width: 370px;">
					<div class="card-body">
					    <h6 class="card-title">최종결제금액</h6>
					    <h8 class="card-subtitle mb-2 text-muted"></h8>
					    <p class="card-text">
							<div style="text-align: right;">KRW&ensp;&ensp;<span id="price" style="font-size: 20px;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${sum}"/></span>&ensp;</div>
							<button type=button class="pay" id="pay" style="background-color:#FFF; border-radius:5px; border:2px solid #FF4500; font-size:22px; width: 320px" onClick="iamport()">결제하기</button>		
						</p>
						<div id="pluspoint">
							적립예정 포인트 : <span id="pluspoint" nmae="pluspoint"><fmt:formatNumber type="number" maxFractionDigits="0" value="${sum*0.005}"/></span>P
						</div>
	
					</div>
				</div><br/>
				
			</div>
		</div>
	</div><br/><br/>

	</form>

<!-- 주소록 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/javascript/user/address.js"></script>	
<script type="text/javascript">

	let usepoint = 0;
	if(!$('#usepoint').val()){
		usepoint = 0;
	}else{
		usepoint = parseInt($('#usepoint').val());
	}
	
	let sum = parseInt($('#price').text().replace(",",""));

	//사용포인트>결제금액 시 keydown
	$('#usepoint').keyup(function() {
		usepoint = parseInt($('#usepoint').val());
		
		if(usepoint>sum){
			toastr.error("결제금액보다 적은 포인트를 입력하세요.","",{timeOut:2000});
			$('#usepoint').val('');
			return;
		}	
		
		if(usepoint>${user.totalPoint}){
			toastr.error("보유포인트보다 적은 포인트를 입력하세요.","",{timeOut:2000});
			$('#usepoint').val('');
			return;
		}
	});
	
	//사용포인트를 적지않고 비밀번호를 작성하려고 할 때 or 100포인트단위가 아닐 때
	$('#password').on('click', function() {
		if(usepoint === 0 || isNaN(usepoint)){
			toastr.error("사용할 포인트를 먼저 입력하세요.","",{timeOut:2000});
		}else{
			if(usepoint%100 != 0){
				toastr.error("100 포인트단위로 입력하세요.","",{timeOut:2000});
				$('#usepoint').val('');
				return;
			}
		}
	});
	
	//포인트사용 비밀번호체크 후 결제금액차감
	function fnCalTotal(){
		usepoint = parseInt($('#usepoint').val());
		console.log(usepoint);
		
		if($('#confirm').text()==="적용취소"){
			let con = confirm("포인트적용을 취소할까요?");
			if(con){
				$("#price").text(sum.toLocaleString());
				$('#usepoint').val('');
				$('#password').val('');
				document.getElementById('usepoint').readOnly = false;
        		document.getElementById('password').readOnly = false;
        		$('#confirm').text('확인');
			}
		}

		let total = sum-usepoint;
		const password = $('#password').val();
		
		if(usepoint == 0 || usepoint == "" || usepoint =="undefined" || usepoint == null || isNaN(usepoint)){
			toastr.error("사용할 포인트를 먼저 입력하세요.","",{timeOut:2000});
			return;
		}else{
			if(password == "" || password == "undefined" || password == null){
				toastr.error("비밀번호를 올바르게 입력하세요.","",{timeOut:2000});
				$('#password').val('');
				return;
			}
			$.ajax({
				url: "/purchase/api/confirmPassword",
				method : "POST",
		        data:JSON.stringify({
		        	password : password,
		        	usePoint : usepoint
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
		        success : function(data){	
		        	console.log(data);
		        	if(data.success==='true'){
		        		toastr.error("포인트적용완료","",{timeOut:2000});
		        		$("#price").text(total.toLocaleString());
		        		console.log(parseInt($('#price').text().replace(",","")));
		        		
		        		$('#confirm').text('적용취소');
		        		document.getElementById('usepoint').readOnly = true;
		        		document.getElementById('password').readOnly = true;
		        		
		        	}else if(data.success==='pw'){
		        		toastr.error("비밀번호를 다시 입력하세요.","",{timeOut:2000});
		        		$('#password').val('');
		        		return;
		        		
		        	}else{
		        		toastr.error("다시 시도해주세요.","",{timeOut:2000});
		        		$('#usepoint').val('');
		        		$('#password').val('');
		        		return;
		        	}
		        }
	    	});	
		}
	}
	
	//체크박스 하나만 선택
	function fncClickCheck(ths) {
	    document.querySelectorAll(`input[type=checkbox]`)
	    	.forEach(el => el.checked = false);

	    ths.checked = true;
	}

		
	//결제시작 insertPurchase 후 아임포트연결
	function iamport(){
		
		//배송지 입력여부 체크
		var postcode = $('#sample3_postcode').val();
		if(postcode == "undefined" || postcode == "" || postcode == null ){
			toastr.error("배송지는 필수입력사항입니다.","",{timeOut:2000});
			return;
		}
			
		var form1 = $(".cc").serialize();
		
		let customNo = [];
		let ar = $(".customProductNo").get();
		
		for ( var i = 0; i < ar.length; i++) {
			customNo.push(ar[i].value);
		}
		
		const userId = $('#userId').val();
		const name = $('#name').val();
		const address = $('#sample3_postcode').val() +"/"+ $('#sample3_address').val() +"/"+ $('#address').val();
		console.log(address);
		const phone = $('#phone').val();
		const email = $('#email').val();
		const message = $('#message').val();
		const price = $('#price').text().replace(",","");
		const usePoint = (!$('#usepoint').val().replace(",","")) ? "0": $('#usepoint').val().replace(",","");
		
		//포인트로만 결제시 아임포트 불필요
		if(parseInt($('#price').text().replace(",",""))==0){
			
			$(".cc").append(`<input type="hidden" name ="usePoint" value="\${usePoint}">`);
			$(".cc").append(`<input type="hidden" name ="paymentCondition" value="1">`);
			$(".cc").append(`<input type="hidden" name ="address" value="\${address}">`);
					
			$("form").attr("method" , "POST").attr("action" , "/purchase/insertPurchase").submit();
			
		//아임포트결제
		}else{
			$(".cc").append(`<input type="hidden" id ="paymentCondition" value="0">`);
			const paymentCondition = $('#paymentCondition').val();

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
			  		  	name: "밀키트",
			  		  	amount: data.price,
			   		 	buyer_email: data.email,
			   			buyer_name: data.name,
			  			buyer_tel: data.phone,
			  		  	buyer_addr: data.address
						}, function(rsp) {
							if(rsp.success){
								var msg = '결제가 완료되었습니다.';
				  		      	
				  		      	 $.ajax({
				  		  			url:"api/verifyIamport",
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
				  		  				window.location.href='/purchase/getPurchase/' + data.purchase.purchaseNo;
				  		  			}
				  		      	 })
							}else{
								
								var msg = '결제에 실패하였습니다.';
						         msg += '에러내용 : ' + rsp.error_msg;

							}
							toastr.error(msg,"",{timeOut:2000});
					})
				}
			})
		}
	}
</script>
	
<jsp:include page="../layer/footer.jsp"></jsp:include>	
</body>
</html>