<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>구매 상세</title>

</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>

	<style>

		.thumbnail{
			width: 250px;
			height: 250px;
		}
		
		.getcard{
			width: 300px;
			text-align: center;
			border : 1px solid #FF4500;
			border-radius: 5px;
		}
		
		p {
		    margin:20px 0px;
		}
		
		h2:after {
			content: "";
			display: block;
			width: 290px;
			border-bottom: 2px solid #FFF;
			margin: 10px 0px;
			padding:0px 10px 0px 10px;
		}
		
		h5:after {
	       content: "";
			display: block;
			width: 80px;
			border-bottom: 2px solid #FF4500;
			margin: 10px 0px;
			padding:0px 10px 0px 10px;
		}
		
		/*버튼*/
		.bt{
			margin-right:10px; 
			border:2px solid #FF4500; 
			border-radius:5px; 
			background-color:#FFF; 
			font-size:16px; 
			width: 100px;
		}
		
		.bt:hover{
			color: #FF4500;
		}
		
		.card{
			border: none; 
			width: 300px; 
			line-height: 200%;
		}
	</style>
	 
	 <div class="container">
	 <h2>${purchase.user.userName}님의 구매정보 
	</h2>
	 <div style="font-size: 19px;">&ensp;${purchase.regDate} [${purchase.purchaseNo}]</div>

	    <div class="container">
	        <c:set var="price" value="0" />
			<c:forEach var="cpd" items="${purchase.customProduct}">
	          <p></p>
	          <div class="getcard" style="float:left; margin:20px; min-height: 600px;">
	            <div class="card-header" style="background-color: #FF4500; color: #FFF;">
	              ${cpd.product.name}
	            </div><br/>
	            <div>
	            <a href="/product/getProduct/${cpd.product.productNo}" class="btn btn-primary">
	           		 <img class="thumbnail" src='/resources/attachments/${cpd.product.thumbnail}'>
	           	</a>
	              <p class="card-text">
	              	  <fmt:formatNumber type="number" maxFractionDigits="0" value="${cpd.price}"/>원<br/>
	              	  ${cpd.count}개<br/><br/>
		              <c:forEach var="pp" items="${cpd.plusParts}">
					  	+ ${pp.parts.name}, ${pp.gram}g, <fmt:formatNumber type="number" maxFractionDigits="0"  value="${pp.parts.price*pp.gram/10}" />원 <br/>
					  </c:forEach>
					  <c:forEach var="mp" items="${cpd.minusParts}">
					  	- ${mp.minusName} <br/>
					  </c:forEach> 
				  </p>
	              <a href="/product/getProduct/${cpd.product.productNo}" class="btn btn-primary">상품보기</a>
	              <c:set var="price" value="${price+cpd.price*cpd.count}" />
	            </div>
	          </div>
	        </c:forEach>
	    </div>
	</div>
	
     
    <div class="container" style="clear:both; display: flex; justify-content: center;">
    
    	<div class="container">
    	<div class="row">
    	
    		<div class="col-md-4">
			<div class="card">
					<div class="card-body">
					    <h5 class="card-title">구매정보</h5>
					    <p class="card-text">
							<div>구매번호 : ${purchase.purchaseNo} </div>
								<div>구매일자 : ${purchase.regDate} </div>
								<div>구매자이름 : ${purchase.user.userName} </div>
								<div>구매자 휴대전화 : ${purchase.user.phone} </div>
								<div>구매처리상태 : 
									<c:choose>
										<c:when test="${purchase.purchaseStatus eq '1'}">상품준비중</c:when>
										<c:when test="${purchase.purchaseStatus eq '2'}">배송중</c:when>
										<c:when test="${purchase.purchaseStatus eq '3'}">배송완료</c:when>
										<c:when test="${purchase.purchaseStatus eq '4'}">구매확정</c:when>
									</c:choose><br/>
									적립 포인트 :
									<c:choose>
										<c:when test="${purchase.user.grade eq '0'}"> <fmt:formatNumber type="number" maxFractionDigits="0" value="${price*0.005}" />P<br/>
										(${purchase.user.userName}님은 슬밀프랜드 등급으로<br/> 구매금액의 0.5%가 적립됩니다)</c:when>
										<c:when test="${purchase.user.grade eq '1'}"><fmt:formatNumber type="number" maxFractionDigits="0" value="${price*0.01}" />P<br/>
										(${purchase.user.userName}님은 슬밀패밀리 등급으로<br/> 구매금액의 1%가 적립됩니다)</c:when>
										<c:when test="${purchase.user.grade eq '2'}"><fmt:formatNumber type="number" maxFractionDigits="0" value="${price*0.03}" />P<br/>
										(${purchase.user.userName}님은 슬밀히어로 등급으로<br/> 구매금액의 3%가 적립됩니다)</c:when>
										<c:when test="${purchase.user.grade eq '3'}"><fmt:formatNumber type="number" maxFractionDigits="0" value="${price*0.05}" />P<br/>
										(${purchase.user.userName}님은 슬밀마스터 등급으로<br/> 구매금액의 5%가 적립됩니다)</c:when>
									</c:choose><br/>
							</div>
						</p>
					</div>
				</div>
				</div>
	
				<div class="col-md-4">
				<div class="card">
					<div class="card-body">
					    <h5 class="card-title">결제정보</h5>
					    <p class="card-text">
							<div> 총 구매금액 : <fmt:formatNumber type="number" maxFractionDigits="0" value="${price}"/>원</div>
							<div>포인트사용 :  <fmt:formatNumber type="number" maxFractionDigits="0" value="${purchase.usePoint}"/>P </div>
							<div>총 결제금액 : <fmt:formatNumber type="number" maxFractionDigits="0" value="${purchase.amount}"/>원 </div>
						</p>
					</div>
				</div>
				</div>
				
				<div class="col-md-4">
				<div class="card">
					<div class="card-body">
					    <h5 class="card-title">배송정보</h5>
					    <p class="card-text">
							<div>받으시는분 : ${purchase.name} </div>
							<div>주소 :
							${fn:replace(purchase.address, '/', '<br/>')}
							</div>
							<div>휴대전화 : ${purchase.phone} </div>
							<div>배송메시지 : ${purchase.message} </div>
						</p>
					</div>
				</div>
			    </div>

		</div>
		<div class="container" style="display: flex; justify-content: center;">
			<button type="button" class="bt" onClick="window.location.href='/purchase/getListPurchase'">확인</button>
		</div>
		</div>
	</div>

<jsp:include page="../layer/footer.jsp"></jsp:include>	
</body>
</html>