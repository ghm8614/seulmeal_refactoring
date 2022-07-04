<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.todayList{
		font-size: 18px;
		border-left: 1px solid gray;
		border-right: 1px solid gray;
		padding: 5px;
		background-color: #ff4500;
		color: #fff;
	}
	
	.adminText{
		font-size: 18px;
		font-weight: 900;
	}
	
	.todayList+.todayList{
		margin-left: 40px;
	}
	
	.chartTitle{
		cursor: pointer;
		opacity: 0.5;
	}
	
	.chartTitle:hover{
		opacity: 1.0;
		color: #ff4500;
	}
	
	.chartTitle+.chartTitle{
		margin-left: 40px;
	}
	
	.adminCardCompnet{
		border: 1px solid #ddd;
		padding:5px;
		box-shadow: 0 6px 6px 0 gray;
		margin-left:10px;
		border-radius: 20px;
	}
	.adminCardCompnet+.adminCardCompnet{
		
	}
</style>
<title>관리자 페이지</title>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
</head>
<body>
	<div class="container-fluid">
	    <div class="row flex-nowrap">
		<jsp:include page="sideBar.jsp"/>
		<div class="col py-3" style="margin-left:17%;">
				<div class="" style="margin-bottom: 20px; justify-content: center; display: flex;">
					<span class="todayList adminCardCompnet"><span class="adminText">블랙리스트 유저 :</span> 0</span>			
					<span class="todayList adminCardCompnet"><span class="adminText">주문한 상품 :</span> ${count.PURCHASECOUNT}</span>
					<span class="todayList adminCardCompnet"><span class="adminText">재고없는 상품 :</span> ${count.PRODUCTCOUNT}</span>					
					<span class="todayList adminCardCompnet"><span class="adminText">진행중인 이벤트 :</span> ${count.EVENTCOUNT}</span>
					<span class="todayList adminCardCompnet"><span class="adminText">답변대기중인 문의 :</span> ${count.ANSWERWAITCOUNT}</span>
					<span class="todayList adminCardCompnet"><span class="adminText">신고된 게시글 :</span> ${count.REPORTCOUNT}</span>
				</div>
	            <iframe class="frame" style="height:100vh; width:100%; display:none;" src="/product/admin/listProduct"></iframe>
	            <!-- user -->
	            <iframe id="userListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/user/listUser/1"></iframe>
	            <iframe id="blackUserListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/user/listUser/1"></iframe>
	            
	            <!-- product -->
	            <iframe id="productListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/product/admin/listProduct/1"></iframe>
	            <iframe id="partsListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/product/listParts/1/0"></iframe>
	            <iframe id="foodCategoryListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/product/listFoodCategory"></iframe>
	            <iframe id="reviewListFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/product/listReview/1"></iframe>
	            
	            <!-- community -->
	            <iframe id="reportPostFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/community/getListReportPost/0"></iframe>
	            
	            <!-- purchase -->
	            <iframe id="saleFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/purchase/getListSale/1"></iframe>
	            <iframe id="discountFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/operation/listOperationDiscountEvent/admin/1"></iframe>
	            
	            <!-- operation -->
	            <iframe id="noticeFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/operation/getListOperation/1"></iframe>
	            <iframe id="eventFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/operation/getListOperation/2"></iframe>
	            <iframe id="queryFrame" class="frame" style="height:100vh; width:100%; display:none;" src="/operation/getListOperation/3/0/0"></iframe>
	            <!--<canvas id="myChart" width="400" height="200"></canvas>-->	            
				<div>
					
					
				</div>
				
				<div style="display:flex; width: 100%; justify-content: space-between;" class="adminMainComponet">
					<div style="width: 50%; margin-right:20px;">
						<div class="adminCardCompnet">
							<div style="display: flex; justify-content: center;">
								<h3 id="userJoinBtn" class="text-center chartTitle" style="color: #ff4500; opacity: 1.0;">유저 가입수</h3>
								<h3 id="saleCountBtn" class="text-center chartTitle">판매량</h3>
								<h3 id="salePriceBtn" class="text-center chartTitle">매출액</h3>							
							</div>
							<div class="chartComponet">
								<!-- 판매량 -->
								<div id="saleCount" style="display: none;">
									<canvas id="mixed-chart"></canvas>
								</div>
								<!-- 매출액 -->
								<div id="salePrice" style="display: none;">
									<canvas id="mixed-chart2"></canvas>
								</div>
								<!-- 유저가입수 -->
								<div id="userJoin">
									<canvas style="width: 100%; " id="user-chart"></canvas>
								</div>
							</div>
						</div>
						<br/>		
						
						<!-- 월통계 -->
						<div class="adminCardCompnet">
							<div>
								<div class="text-center year">2022</div>
								<h3 class="text-center">
									<input class="btn minusBestBtn" type="button" value="&lt;&lt;" />
									<span class="month" style="color:#ff4500;"></span>월 최고의 물건
									<input class="btn plusBestBtn" type="button" value=">>" />
								</h3>
							</div>
							<table class="table table-hover text-center">
								<thead style="background-color: #ff4500; color: #fff;">
									<tr>
										<th>목차</th>
										<th>이동링크</th>
										<th>조건</th>
										<th>일자</th>
									</tr>
								</thead>				
								<tbody id="bestMonth">
									<tr>
										<th>최고 좋아요 게시글</th>
										<th style="cursor: pointer;" data-target="postLike" data-value="${monthPostLike[0].POST_NO}" onClick="navi(this)">제목 :${monthPostLike[0].TITLE}</th>
										<th>좋아요 수 : ${monthPostLike[0].LIKE_COUNT}</th>
										<th>일자 : ${monthPostLike[0].REG_DATE}</th>
									</tr>
									
									<tr>
										<th>최고 댓글 게시글</th>
										<th style="cursor: pointer;" data-target="postComment" data-value="${monthPostComment[0].POST_NO}" onClick="navi(this)">제목 : ${monthPostLike[0].TITLE}</th>
										<th>댓글 수 : ${monthPostComment[0].COUNT}</th>
										<th>일자 : ${monthPostComment[0].REG_DATE}</th>
									</tr>
									
									<tr>
										<th>최고 판매 상품</th>
										<th style="cursor: pointer;" data-target="saleProduct" data-value="${monthSaleProduct[0].PRODUCT_NO}" onClick="navi(this)">상풍명 : ${monthSaleProduct[0].NAME}</th>
										<th>판매 수 : ${monthSaleProduct[0].COUNT}</th>
										<th>매출액 : ${monthSaleProduct[0].CNT}</th>
									</tr>
								</tbody>
							</table>
							</div>
						<br/>						
						
						
						<div class="monthP" style="display: flex; justify-content: center;">	
							<!-- 재료 월통계 -->
							
							<div class="adminCardCompnet" style="width: 100%;">
									<div class="text-center year">2022</div>
									<h3 class="text-center">
										<input class="btn minusBtnParts" type="button" value="&lt;&lt;" />
										<span class="month" style="color:#ff4500;"></span>월 재료 판매
										<input class="btn plusBtnParts" type="button" value=">>" />
									</h3>							
								<table class="table table-hover text-center">
									<thead style="background-color: #ff4500; color: #fff;">
										<tr>
											<th>랭킹</th>
											<th>상품명</th>
											<th>판매량</th>
										</tr>
									</thead>				
									<tbody id="parts10Card">
										<c:forEach var="parts" items="${monthSaleParts}">
											<c:set var="i" value="${i+1}" />
										<tr>
											<th>${i}</th>
											<th>${parts.NAME}</th>
											<th>${parts.COUNT}</th>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- 상품 월 통계 -->
							<div class="adminCardCompnet" style="width: 100%;">
								<div class="text-center year">2022</div>			
								<h3 class="text-center">
									<input class="btn minusBtnMonth" type="button" value="&lt;&lt;" />
									<span class="month" style="color:#ff4500;"></span>월 상품 판매
									<input class="btn plusBtnMonth" type="button" value=">>" />
								</h3>								
								<table class="table table-hover text-center">
									<thead style="background-color: #ff4500; color: #fff;">
										<tr>
											<th>랭킹</th>
											<th>상품명</th>
											<th>판매액</th>
											<th>판매량</th>
										</tr>
									</thead>				
									<tbody id="product10Card">
										<c:forEach var="product" items="${monthSaleProduct10}">
											<c:set var="j" value="${j+1}" />
										<tr>
											<th>${j}</th>
											<th>${product.NAME}</th>
											<th>${product.CNT}</th>
											<th>${product.COUNT}</th>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							</div>
									
					</div>
					
					
					<div style="width:50%; justify-content: center; display: flex;">
						<div class="adminCardCompnet" style="margin: auto;">
							<div class="text-center year">2022</div>
							<h3 class="text-center">
								<input class="btn minusBtn" type="button" value="&lt;&lt;" />
								<span class="month" style="color:#ff4500;"></span>월 통계
								<input class="btn plusBtn" type="button" value=">>" />
							</h3>
							
							<table class="table table-hover text-center dayStatis">
								<thead style="background-color: #ff4500; color: #fff;">
									<tr>
										<th>일자</th>
										<th>가입자수</th>
										<th>구매횟수</th>
										<th>판매액</th>
										<th>리뷰횟수</th>
										<th>문의횟수</th>
										<th>게시글횟수</th>
									</tr>
								</thead>				
								<tbody>					
									<c:forEach var="u" items="${userDay}" varStatus="statusNum">
									<tr>
										<th>${u.REGDATE}</th>
										<th>${u.UCNT}</th>
										<th>${purchaseDay[statusNum.index].UCNT}</th>
										<th>${purchasePriceDay[statusNum.index].UCNT}</th>
										<th>${reviewDay[statusNum.index].UCNT}</th>
										<th>${queryDay[statusNum.index].UCNT}</th>
										<th>${communityDay[statusNum.index].UCNT}</th>
									</tr>
									</c:forEach>
								</tbody>
							</table>
							
							
						</div>
					</div>				
				</div>
	            
	           
	            
	        </div>
	    </div>
	</div>	
	

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function navi(e){
		const target = $(e).data("target");
		
		if(target==='postLike'){
			window.location.href="/community/getPost/"+$(e).data('value')
			return;
		}
		
		if(target==='postComment'){
			window.location.href="/community/getPost/"+$(e).data('value')
			return;
		}
		
		if(target==='saleProduct'){
			window.location.href="/product/getProduct/"+$(e).data('value')
			return;
		}
		
	}
	
	// 매달 통계 ajax	
	function monthStatistics(differenceMonth){
		$.ajax({
			url : "/api/getDayStatistics/0/"+differenceMonth,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	const userDay = data.userDay;
	        	const purchaseDay = data.purchaseDay;
	        	const purchasePriceDay = data.purchasePriceDay;
	        	const reviewDay = data.reviewDay;
	        	const queryDay = data.queryDay;
	        	const communityDay = data.communityDay;
	        			        	
	        	let statisticsCard = `
	        	<thead style="background-color: #ff4500; color: #fff;">
					<tr>
						<th>일자</th>
						<th>가입자수</th>
						<th>구매횟수</th>
						<th>판매액</th>
						<th>리뷰횟수</th>
						<th>문의횟수</th>
						<th>게시글횟수</th>
					</tr>
				</thead>				
				<tbody>`
				
				for(let i=0; i<userDay.length; i++){
					statisticsCard += `
						<tr>
							<th>\${userDay[i].REGDATE}</th>
							<th>\${userDay[i].UCNT}</th>
							<th>\${purchaseDay[i].UCNT}</th>
							<th>\${purchasePriceDay[i].UCNT}</th>
							<th>\${reviewDay[i].UCNT}</th>
							<th>\${queryDay[i].UCNT}</th>
							<th>\${communityDay[i].UCNT}</th>
						</tr>`
				}
					
				statisticsCard +=`</tbody>`
	        	
				$(".dayStatis").empty();
				$(".dayStatis").append(statisticsCard);					
				
	        }
		})
	}
	
	// 매달 최고상품 통계 ajax	
	function monthProductAjax(differenceMonth){
		$.ajax({
			url : "/api/getDayStatistics/1/"+differenceMonth,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	console.log(data)
	        	const product = data.monthSaleProduct10;
	        	let productCard ="";
	        	
	        	for(let i=0; i<product.length; i++){
	        		productCard += `<tr>
						<th>\${i+1}</th>
						<th>\${product[i].NAME}</th>
						<th>\${product[i].CNT}</th>
						<th>\${product[i].COUNT}</th>
					</tr>`
	        	}
	        	
	        	if(product.length ===0){
	        		productCard += `
	        			<tr>
							<td colspan="5" style="font-size: 30px;">							
								<i class="bi bi-chat-left-dots"></i>
								<div>글이 없습니다</div>						
							</td>
						</tr>`
	        	}
				
	        	$("#product10Card").empty();
	        	$("#product10Card").append(productCard);
	        }
		})
	}
	
	/////////////////////////////////
	// 매달 최고재료 통계 ajax	
	function monthPartsAjax(differenceMonth){
		$.ajax({
			url : "/api/getDayStatistics/2/"+differenceMonth,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	console.log(data)
	        	const parts = data.monthSaleParts;
	        	let partsCard ="";
	        	
	        	for(let i=0; i<parts.length; i++){
	        		partsCard += `<tr>
						<th>\${i+1}</th>
						<th>\${parts[i].NAME}</th>
						<th>\${parts[i].COUNT}</th>
					</tr>`
	        	}
	        	
	        	if(parts.length ===0){
	        		partsCard += `
	        			<tr>
							<td colspan="5" style="font-size: 30px;">							
								<i class="bi bi-chat-left-dots"></i>
								<div>글이 없습니다</div>						
							</td>
						</tr>`
	        	}
				
	        	$("#parts10Card").empty();
	        	$("#parts10Card").append(partsCard);
	        }
		})
	}
	///////////////////////////////////////
	
	// 이달의 최고 물건들
	function monthBestAjax(differenceMonth){
		$.ajax({
			url : "/api/getDayStatistics/3/"+differenceMonth,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	const monthPostLike = data.monthPostLike;
	        	const monthPostComment = data.monthPostComment;
	        	const monthSaleProduct = data.monthSaleProduct;
	        	let bsetCard ="";
	        	
	        	
	        	if(monthPostLike.length !=0 ){
	        		bsetCard += `
	    	        	<tr>
	    					<th>최고 좋아요 게시글</th>
	    					<th style="cursor: pointer;" data-target="postLike" data-value="\${monthPostLike[0].POST_NO}" onClick="navi(this)">제목 :\${monthPostLike[0].TITLE}</th>
	    					<th>좋아요 수 : \${monthPostLike[0].LIKE_COUNT}</th>
	    					<th>일자 : \${monthPostLike[0].REG_DATE}</th>
	    				</tr>`
	        	} else {
	        		bsetCard += `<tr>
						<th>최고 좋아요 게시글</th>
						<td colspan="3" style="font-size: 20px;">							
							<i class="bi bi-chat-left-dots"></i>
							<div>글이 없습니다</div>						
						</td>
					</tr>`
	        	}
	        	
	        	if(monthPostComment.length != 0){
	        		bsetCard += `
	        			<tr>
							<th>최고 댓글 게시글</th>
							<th style="cursor: pointer;" data-target="postComment" data-value="\${monthPostComment[0].POST_NO}" onClick="navi(this)">제목 : \${monthPostLike[0].TITLE}</th>
							<th>댓글 수 : \${monthPostComment[0].COUNT}</th>
							<th>일자 : \${monthPostComment[0].REG_DATE}</th>
						</tr>`
	        	} else {
	        		bsetCard += `<tr>
						<th>최고 댓글 게시글</th>
						<td colspan="3" style="font-size: 20px;">						
							<i class="bi bi-chat-left-dots"></i>
							<div>글이 없습니다</div>						
						</td>
					</tr>`
	        	}
				
				if(monthSaleProduct.length != 0){
					bsetCard += `
						<tr>
							<th>최고 판매 상품</th>
							<th style="cursor: pointer;" data-target="saleProduct" data-value="${monthSaleProduct[0].PRODUCT_NO}" onClick="navi(this)">상풍명 : \${monthSaleProduct[0].NAME}</th>
							<th>판매 수 : \${monthSaleProduct[0].COUNT}</th>
							<th>매출액 : \${monthSaleProduct[0].CNT}</th>
						</tr>
						`
				} else {
					bsetCard += `<tr>
						<th>최고 판매 상품</th>
						<td colspan="3" style="font-size: 20px;">							
							<i class="bi bi-chat-left-dots"></i>
							<div>글이 없습니다</div>						
						</td>
					</tr>`
        		}	
				
	        					
	        	$("#bestMonth").empty();
	        	$("#bestMonth").append(bsetCard);
	        }
		})
	}
	
	///////////////////////////////////////
	
	$(()=>{		
		const now = new Date();	// 현재 날짜 및 시간
		const month = (now.getMonth())+1;	// 월
		const year = (now.getFullYear());
		
		function yearCount(target, event, trueMo, status){
			const mt = target.parent().find(".month").text();
			const tYear = parseInt(target.text())
			console.log(status)
			if(trueMo !==month && event%6 === 0 && mt === "12" && status==="m"){
				
				target.text(tYear-1);
				return;
			}
			if(trueMo !==month && event%6 === -5 && mt === "1" && status ==="p"){
				target.text(tYear+1);
				return;
			}
		}
		
		function donClick(mo,dayStatistics){
			if(dayStatistics<0){
				return false;
			}
			if(mo === 12){
				return false;
			}
			if(month >= mo){
				return false;
			}
			return true
		}
		
		function monthCycle(month){
			if(month === 0){
				return 12;
			}
			if(month === 13){
				return 1;
			}
			return month;
		}
		
		$(".month").text(month);
		$(".year").css("color","#ff4500").text(year)
		
		// 월 통계
		let dayStatistics = month;
		
		// 월 상위 10개 상품
		let monthProducts = month;
		
		// 월 상위 10개 재료
		let monthParts = month;
		
		// 월 최고의 물건
		let monthBest = month;
		
		/////////////////////
		// 월 상품판매
		$(".minusBtnMonth").on("click",function(){
			const mo =parseInt($(this).next(".month").text())-1;			
			const trueMo = monthCycle(mo);
			monthProducts--;
			$(this).next(".month").text(trueMo);
			const differenceMonth = monthProducts - month;
			monthProductAjax(differenceMonth);
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"m");
		})
		
		// 월 상품판매
		$(".plusBtnMonth").on("click",function(){
			const mo = parseInt($(this).prev(".month").text())+1;			
			const trueMo = monthCycle(mo);
					
			if(donClick(trueMo,monthProducts)){
				return;
			};
			monthProducts++;	
			$(this).prev(".month").text(trueMo);
			const differenceMonth = monthProducts - month;
			monthProductAjax(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"p");
		})
		//////////////////
		
		/////////////////////
		// 월 재료판매
		$(".minusBtnParts").on("click",function(){
			const mo =parseInt($(this).next(".month").text())-1;			
			const trueMo = monthCycle(mo);
			monthParts--;
			$(this).next(".month").text(trueMo);
			const differenceMonth = monthParts - month;
			monthPartsAjax(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"m");
		})
		
		// 월 재료판매
		$(".plusBtnParts").on("click",function(){
			const mo = parseInt($(this).prev(".month").text())+1;			
			const trueMo = monthCycle(mo);
			console.log(monthParts)
			if(donClick(trueMo,monthParts)){
				return;
			};
			monthParts++;	
			$(this).prev(".month").text(trueMo);
			const differenceMonth = monthParts - month;
			monthPartsAjax(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"p");
		})
		//////////////////
		
		// 달통계 전달 데이터
		$(".minusBtn").on("click",function(){
			const mo =parseInt($(this).next(".month").text())-1;			
			const trueMo = monthCycle(mo);
			monthBest--;
			console.log(monthBest)
			$(this).next(".month").text(trueMo);			
			const differenceMonth = monthBest - month;			
			monthStatistics(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"m");
		});
		
		// 달통계 전달 데이터
		$(".plusBtn").on("click",function(){
			const mo = parseInt($(this).prev(".month").text())+1;			
			const trueMo = monthCycle(mo);
						
			if(donClick(trueMo,monthBest)){
				return;
			};
			monthBest++;
			$(this).prev(".month").text(trueMo);			
			const differenceMonth = monthBest - month;			
			monthStatistics(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"p");
		});
		//////////////////
		
		// 달 베스트 데이터
		$(".minusBestBtn").on("click",function(){
			const mo =parseInt($(this).next(".month").text())-1;			
			const trueMo = monthCycle(mo);
			dayStatistics--;
			console.log(dayStatistics)
			$(this).next(".month").text(trueMo);			
			const differenceMonth = dayStatistics - month;			
			monthBestAjax(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"m");
		});
		
		// 달통계 전달 데이터
		$(".plusBestBtn").on("click",function(){
			const mo = parseInt($(this).prev(".month").text())+1;			
			const trueMo = monthCycle(mo);
						
			if(donClick(trueMo,dayStatistics)){
				return;
			};
			dayStatistics++;
			$(this).prev(".month").text(trueMo);			
			const differenceMonth = dayStatistics - month;			
			monthBestAjax(differenceMonth)
			
			const target = $(this).parent().prev(".year");
			yearCount(target,differenceMonth,trueMo,"p");
		});
		//////////////////
		
		// chart 클릭
		// userChart
		$("#userJoinBtn").on("click",function (){
			//글자색 바꾸기
			$(".chartTitle").css({"color":"black","opacity":"0.5"});			
			$(this).css({"color":"#ff4500","opacity":"1"});
			
			// 다른 chart display none
			$("#saleCount").css("display","none");
			$("#salePrice").css("display","none");
			
			// 자기 chart block
			$("#userJoin").css("display","block");			
		});
		
		// saleCountChart
		$("#saleCountBtn").on("click",function (){
			//글자색 바꾸기
			$(".chartTitle").css({"color":"black","opacity":"0.5"});			
			$(this).css({"color":"#ff4500","opacity":"1"});
			
			// 다른 chart display none
			$("#userJoin").css("display","none");
			$("#salePrice").css("display","none");
			
			// 자기 chart block
			$("#saleCount").css("display","block");
		});
		
		// salePriceChart		
		$("#salePriceBtn").on("click",function (){
			//글자색 바꾸기
			$(".chartTitle").css({"color":"black","opacity":"0.5"});			
			$(this).css({"color":"#ff4500","opacity":"1"});
			
			// 다른 chart display none
			$("#userJoin").css("display","none");
			$("#saleCount").css("display","none");
			
			// 자기 chart block
			$("#salePrice").css("display","block");
		});
		
		//
		$("#notice").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#noticeFrame").css("display","block");
		})
		$("#event").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#eventFrame").css("display","block");
		})
		$("#query").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#queryFrame").css("display","block");
		})
		
		// 유저
		$("#userList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#userListFrame").css("display","block");
		})
		$("#blackUserList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#blackUserListFrame").css("display","block");
		})
		
		// product		
		$("#productList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#productListFrame").css("display","block");
		})
		$("#partsList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#partsListFrame").css("display","block");
		})
		$("#foodCategoryList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#foodCategoryListFrame").css("display","block");
		})
		$("#reviewList").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#reviewListFrame").css("display","block");
		})
		
		// purchase
		$("#sale").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#saleFrame").css("display","block");
		})
		
		$("#discount").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#discountFrame").css("display","block");
		})
		
		// 커뮤니티
		$("#reportPost").on("click",()=>{
			$(".adminMainComponet").css("display","none");
			$(".frame").css("display","none");
			$("#reportPostFrame").css("display","block");
		})
	})	
</script>

<script>
/*
const ctx = document.getElementById('myChart').getContext('2d');

const myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
*/
new Chart(document.getElementById("user-chart"), {	
    type: 'bar',
    data: {
      labels: [
			<c:forEach var="userCount" items="${userCount}">
				"${userCount.MONTHLYDATA.split("-")[1]}월",
			</c:forEach>
    	  //"1월", "2월", "3월", "4월", "5월", "6월"
    	  ],
      datasets: [{
          label: "가입수",
          type: "bar",
          backgroundColor: "#F3A285",
          data: [
				<c:forEach var="userCount" items="${userCount}">
					${userCount.COUNT},
				</c:forEach>
        	  //408,547,675,734
        	  ],
        }]
    },
    options: {
    	responsive:false,
      title: {
        display: true,
        text: 'Population growth (millions): Europe & Africa'
      },
      legend: { display: false }
    }
});

new Chart(document.getElementById("mixed-chart"), {	
    type: 'bar',
    data: {
      labels: [
			<c:forEach var="purchaseCount" items="${purchaseCount}">
				"${purchaseCount.MONTHLYDATA.split("-")[1]}월",
			</c:forEach>
    	  //"1월", "2월", "3월", "4월", "5월", "6월"
    	  ],
      datasets: [{
          label: "판매량",
          type: "line",
          backgroundColor:"#F3A285",
          borderColor: "#8e5ea2",
          data: [
				<c:forEach var="purchaseCount" items="${purchaseCount}">
					"${purchaseCount.COUNT}",
				</c:forEach>
        	  //40,547,675,734
        	  ],
          fill: true
        }]
    },
    options: {
      title: {
        display: true,
        text: 'Population growth (millions): Europe & Africa'
      },
      legend: { display: false }
    }
});

new Chart(document.getElementById("mixed-chart2"), {	
    type: 'bar',
    data: {
      labels: [
			<c:forEach var="salePrice" items="${salePrice}">
				"${salePrice.MONTHLYDATA.split("-")[1]}월",
			</c:forEach>
    	  //"1월", "2월", "3월", "4월", "5월", "6월"
    	  ],
      datasets: [{
          label: "판매량",
          type: "line",
          backgroundColor:"#F3A285",
          borderColor: "#3e95cd",
          data: [
				<c:forEach var="salePrice" items="${salePrice}">
					"${salePrice.COUNT}",
				</c:forEach>
        	  //40,547,675,734
        	  ],
          fill: true
        }, {
          label: "매출액",
          type: "line",
          borderColor: "#3e95cd",
          data: [],
          fill: false
        }, {
          label: "가입수",
          type: "bar",
          backgroundColor: "rgba(0,2,0,0.2)",
          data: [
				
        	  //408,547,675,734
        	  ],
        }, {
          label: "123",
          type: "bar",
          backgroundColor: "rgba(0,0,0,0.2)",
          backgroundColorHover: "#3e95cd",
          data: []
        }
      ]
    },
    options: {
      title: {
        display: true,
        text: 'Population growth (millions): Europe & Africa'
      },
      legend: { display: false }
    }
});
</script>
</body>
</html>