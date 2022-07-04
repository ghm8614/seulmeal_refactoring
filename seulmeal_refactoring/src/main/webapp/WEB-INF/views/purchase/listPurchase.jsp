<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>구매내역 목록</title>

</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>

<style>
	
	.thumbnail{
		width: 200px;
		height: 200px;
	}
	
	h2{
		text-align: left; 
	}

	h2:after {
		content: "";
		display: block;
		width: 370px;
		border-bottom: 2px solid #FFF;
		margin: 10px 0px;
		padding:0px 10px 0px 10px;
	}
	
	 tbody { 
	 	background: #fff; 
	 }

	th, td {
	  border-bottom: 1px solid #bcbc;
	  padding: 10px;
	}
	
	/*테이블 로우 글자색 호버*/
	.link:hover{
		color: #FF4500;
	}
	
	/*구매내역 검색조건 버튼*/
	.status{
		border: 2px solid #FFF;
		border-radius: 7px;
		background-color: #FFF;
		padding: 4px;
	}
	
	.status:hover{
		color: #FF4500;
		background-color:none;
	}
	
	/*테이블 x버튼*/
	.delete{
		font-size: 22px;
		padding: 10px;
	}

	.delete:hover{
		color: #FF4500;
	}
	
</style>


	 <div class="container">
	 
	 <div class="row">
		 <div class="col-xs-6" style="padding: 100px 0px 0px 40px;">
	 
		 <h2>${user.userName}님의 구매내역 조회</h2>
		    <form class="form-inline" name="detailForm">
		     <input type="hidden" name="userId" value="${user.userId}"/>
			 <div class="form-group text-right">&emsp;&emsp;
				 <button class="status" onclick="location.href='/purchase/getListPurchase'">전체</button>&emsp;
				 <button class="status" name="searchCondition" value="0">오늘</button>&emsp;
				 <button class="status" name="searchCondition" value="1">1주일</button>&emsp;
				 <button class="status" name="searchCondition" value="2">1개월</button>&emsp;
				 <button class="status" name="searchCondition" value="3">3개월</button>
			  </div> 
			</form>
	   	</div>

		 <div class="col-md-3">
		 	<div style="border:1px solid; padding:1px 0px 10px 12px; width:550px; margin-top:80px; margin-left:15px; border-radius: 10px; border-color: #969696;">
		 		<div class="row">
					<div class="col-xs-3" style="padding: 7px 0px 0px 0px;">
					 	<div style="border:1px solid; padding:10px; margin:20px; width:85px; border-radius: 4px; border-color: #969696;">
	 						<div text-align="center">혜택정보</div>
	 					</div>
	 				</div>
	 				<div class="col-xs-6" style="padding: 15px 0px 0px 0px;">
	 					<div align="center">${user.userName}님의 회원등급은 [
	 						<c:choose>
								<c:when test="${user.grade eq '0'}">슬밀프랜드</c:when>
								<c:when test="${user.grade eq '1'}">슬밀패밀리</c:when>
								<c:when test="${user.grade eq '2'}">슬밀히어로</c:when>
								<c:when test="${user.grade eq '3'}">슬밀마스터</c:when>
							 </c:choose> 
							 ]입니다.</div>
	 					<hr style="border:1px solid #FF4500; width:370px; bottom:15px"/>
	 					<div align="center" style="padding: 0px 0px 0px 30px;">가용포인트 : <fmt:formatNumber type="number" maxFractionDigits="0"  value="${user.totalPoint}"/> P</div>
	 				</div>			
		 		</div>
		 	</div>
		 </div>
		 
		</div><br/>
	</div>
			
	<div class="container">
	 <table class="table table-hover" id="list">
 
        <thead>
          <tr>
            <th align="center">구매일자 [구매번호]</th>
            <th align="right"></th>
            <th align="center">수량</th>
            <th align="center" >상품명</th>
            <th align="center" >옵션</th>
            <th align="center">상품구매금액</th>
            <th align="center"></th>
          </tr>
        </thead>

		<tbody>
			<c:set var="price" value="0" />
			<c:forEach var="purchase" items="${purchaseList}">
			<c:forEach var="cpd" items="${purchase.customProduct}">
			<tr class="ct_list_pop">	
			      <td class="link" align="center"><br/><br/>
			      	<a href='/purchase/getPurchase/${purchase.purchaseNo}'>
			      	${purchase.regDate}&ensp;[${purchase.purchaseNo}]<br/><br/>
			      	</a>
			      		<div>
			      		<c:choose>
							<c:when test="${purchase.purchaseStatus eq '1'}">상품준비중</c:when>
							<c:when test="${purchase.purchaseStatus eq '2'}">배송중</c:when>
							<c:when test="${purchase.purchaseStatus eq '3'}">
								배송완료<br/>
								<button type="button" class="btn btn-outline-primary btn-sm" data-value="${purchase.purchaseNo}" onClick="fncPurchaseStatus(this)">구매확정하기</button></c:when>
							<c:when test="${purchase.purchaseStatus eq '4'}">구매확정</c:when>
						</c:choose>
						</div>
			      </td>
				  <td align="left">
				  	<a href="/product/getProduct/${cpd.product.productNo}" class="btn btn-primary">
				  		<img class="thumbnail" src='/resources/attachments/${cpd.product.thumbnail}'>
				  	</a>
				  </td>
				  <td class="link" align="center" style="cursor:pointer;" onClick="window.location.href='/purchase/getPurchase/${purchase.purchaseNo}'">${cpd.count}</td>
				  <td class="link" align="left" style="cursor:pointer;" onClick="window.location.href='/purchase/getPurchase/${purchase.purchaseNo}'">${cpd.product.name}</td>
				  <td class="link" align="left" style="cursor:pointer;" onClick="window.location.href='/purchase/getPurchase/${purchase.purchaseNo}'">
				  <c:forEach var="pp" items="${cpd.plusParts}">
				  	+ ${pp.parts.name}, ${pp.gram}g, <fmt:formatNumber type="number" maxFractionDigits="0"  value="${pp.parts.price*pp.gram/10}" />원 <br/>
				  	</c:forEach>
				  <c:forEach var="mp" items="${cpd.minusParts}">
				  	- ${mp.minusName} <br/>
				  	</c:forEach>
				  </td>
				  <td class="link" align="center" style="cursor:pointer;" onClick="window.location.href='/purchase/getPurchase/${purchase.purchaseNo}'"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${cpd.price}"/>원</td>
				  <c:set var="price" value="${price+cpd.price*cpd.count}" />
			 	  <td>	
		          	<a type="button" class="delete" data-value="${purchase.purchaseNo}" onClick="fncDelete(this)">&ensp;x</a>      	
				  </td>		 
			  </tr>  
			  </c:forEach> 
			  </c:forEach>			  
        </tbody>
      </table>
      </div>
      
<script>
    
	//getListPurchase submit
      function fncGetListPurchase(currentPage) {

  		$("form").attr("method" , "POST").attr("action" , "/purchase/getListPurchase").submit();
  	  }
  	
	//기간별 구매내역리스트 버튼
  	 $(function() {
  		  
  		 $(".status").on("click" , function() {

  			fncGetListPurchase(1);
  			});
  	 });
  	 
  	//구매확정버튼 
	function fncPurchaseStatus(ths){
		
		let purchaseNo=$(ths).data('value');	

		let status = confirm("구매확정하시겠습니까?");
		
		if(status){
			
			$.ajax({
				url:"/purchase/api/updatePurchaseCode",
				method:"POST",  
				data:JSON.stringify({
					purchaseNo : purchaseNo,
					purchaseStatus: "4"
				}),
		        headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){	
		        	toastr.error(`\${data}P 적립되었습니다.`,"",{timeOut:3000});
		        	$(ths).closest('div').text('구매확정');
		        	$(ths).remove();
		        }
	    	})
		}
		return;
	}
  	
	//테이블 셀병함
	$.fn.rowspan = function(colIdx, isStats) {       
	    return this.each(function(){      
	        var that;     
	        $('tr', this).each(function(row) {      
	            $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
	                 
	                if ($(this).html() == $(that).html()
	                    && (!isStats 
	                            || isStats && $(this).prev().html() == $(that).prev().html()
	                            )
	                    ) {            
	                    rowspan = $(that).attr("rowspan") || 1;
	                    rowspan = Number(rowspan)+1;
	 
	                    $(that).attr("rowspan",rowspan);               
         
	                    $(this).hide();
	                     
	                } else {            
	                    that = this;         
	                }          
	                that = (that == null) ? this : that;      
	            });     
	        });    
	    });  
	}; 
	
	$('#list').rowspan(0);
	$('#list').rowspan(6);
	
	//구매내역리스트에서 삭제
	function fncDelete(ths){
		var del = confirm("구매내역에서 삭제할까요?");	
		const purchaseNo = $(ths).data('value');
		if(del){
			window.location.href="/purchase/deletePurchase/"+purchaseNo;
		}
	}
	
	//무한스크롤
	$(function(){
		
		let currentPage = 1;
		let maxPage = ${resultPage.maxPage};

		$(window).scroll(function(){
			
			let $window = $(this);
			let scrollTop = $window.scrollTop(); //스크롤의 top이 위치하고 있는 높이
			let windowHeight = $window.height(); //화면의 높이
			let documentHeight = $(document).height(); //문서 전체의 높이
	
			if(scrollTop + windowHeight + 1 >= documentHeight && currentPage <= maxPage){ //scrollbar의 thumb가 바닥 전 10px 까지 도달하면 리스트 가져옴
				currentPage++;
				setTimeout(getListPurchase,100);//0.1초
			}
			
				function getListPurchase(){
								
					$.ajax({
						url:"/purchase/api/getListPurchase/"+currentPage+"/${search.searchCondition}",
						type:"GET",
						datatype:"json",
						success: function(data, status, jqXHR){

							//console.log("success status: "+ status);
							//console.log("data: " + data);
							//console.log("jqXHR: "+ jqXHR);
							//console.log("json/stringify: "+JSON.stringify(data));													
							
							//purchaseList
							for(let i = 0; i<data.length; i++){
								let purchaseOne = data[i];
								let cpd = "";
								
								let purchaseListHtml = "";
								let ppartsHTML = "";
								let mpartsHTML = "";
								
								let status = "";
								if(purchaseOne.purchaseStatus==="1"){
									status="상품준비중"
								}else if(purchaseOne.purchaseStatus==="2"){
									status="배송중"
								}else if(purchaseOne.purchaseStatus==="3"){
									status="배송완료<br/><button type='button' class='btn btn-outline-primary btn-sm' data-value='"+purchaseOne.purchaseNo+"' onClick='fncPurchaseStatus(this)'>구매확정하기</button>"
								}else if(purchaseOne.purchaseStatus==="4"){
									status="구매확정"
								}
								
								//customproductList
								for(let k = 0; k<purchaseOne.customProduct.length; k++){
									cpd = purchaseOne.customProduct[k];	
									
									//custompartsList
									for(let n = 0; n<cpd.plusParts.length; n++){
										let pp = cpd.plusParts[n];
										
										ppartsHTML+= ("+" + pp.parts.name+","+ pp.gram +"g, "+ (pp.parts.price*pp.gram/10).toLocaleString()+ "원 <br/>");
									}

									for(let m = 0; m<cpd.minusParts.length; m++){
										let mp = cpd.minusParts[m];
										
										mpartsHTML+=("-"+ mp.minusName+ "<br/>");
									}
								
								purchaseListHtml = 

									`<tr class='ct_list_pop'><td class='link' align='center' style='cursor:pointer;' onClick="window.location.href='/purchase/getPurchase/`+purchaseOne.purchaseNo+ `'"><br/><br/>`
									+purchaseOne.regDate+"&ensp;["+purchaseOne.purchaseNo+"]</a><br/><br/><div>"+status
									+"</div></td><td align='left'><a href='/product/getProduct/"+cpd.product.productNo+"' class='btn btn-primary'><img class='thumbnail' src='/resources/attachments/"+cpd.product.thumbnail+"'></a></td>"
									+`<td class='link' align='center' style='cursor:pointer;' onClick="window.location.href='/purchase/getPurchase/`+purchaseOne.purchaseNo+ `'">`+cpd.count 
									+`</td><td class='link' align='center' style='cursor:pointer;' onClick="window.location.href='/purchase/getPurchase/`+purchaseOne.purchaseNo+ `'">` + cpd.product.name 
									+`</td><td class='link' align='center' style='cursor:pointer;' onClick="window.location.href='/purchase/getPurchase/`+purchaseOne.purchaseNo+ `'">`
									+ ppartsHTML + mpartsHTML
									+`</td><td class='link' align='center' style='cursor:pointer;' onClick="window.location.href='/purchase/getPurchase/`+purchaseOne.purchaseNo+ `'">`+cpd.price.toLocaleString() + "원</td>"
									+"<td><a type='button' class='delete' data-value='"+purchaseOne.purchaseNo+"' onClick='fncDelete(this)'>&ensp;x</a></td></tr>";							

								$("table tbody:last-child").append(purchaseListHtml);
								ppartsHTML="";
								mpartsHTML="";
								
								}
							}//for
							
							$('#list').rowspan(0);
							$('#list').rowspan(6);

							
						}//success
						, error: function(status, jqXHR){
							console.log("error status: "+ status);
							console.log("jqXHR: "+ jqXHR);
							toastr.error("페이지 로드 실패","",{timeOut:2000});
						}
						
					})//jQuery.ajax()
					
				}//getListPurchase
				
		})//window.scroll()
			
	});	

      
</script>

<jsp:include page="../layer/footer.jsp"></jsp:include>	

</body>
</html>