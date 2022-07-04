<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>커스터마이징 옵션</title>
</head>

<style>
		
		h2{
			text-align: center; 
		}

		h2:after {
			content: "";
			display: block;
			width: 300px;
			border-bottom: 2px solid #FF4500;
			margin: 20px auto;
		}
		
		h5:after {
	        content: "";
	        display: block;
	        width: 60px;
	        border-bottom: 2px solid #FF4500;
	        margin: 20px auto;
	        margin-top: 10px;
		}
		
		.close {
		  display:inline-block;
		  padding:2px 5px;
		  font-weight: 700;
		  text-shadow: 0 1px 0 #fff;
		  font-size: 1rem;
		}
		
		.close:hover {
		  border: 0;
		  cursor:pointer;
		  opacity: .75;
		}
		
		.card {
	        margin: 0 auto; 
	        margin-bottom: 10px; 
	        width: 50rem; 
	        text-align: center !important;
	        border: 1px solid #646464 !important; 
	        border-radius: 10px !important;
		}	
		
		
		.thumbnail{
			width: 250px;
			height: 250px;
			border-radius: 10px;
			magin-left: 30px;
		}

	</style>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	
	<form class="cc" name="insertCustom" method="post">
		<input type="hidden" name="productNo" value="${product.productNo}"/>
		<div class="container">
		<h2>커스터마이징 : ${product.name}</h2> 
			<div class="card">
			  <div class="card-body">
			  	<div class="row">
			  		<div class="col-md-6">
				  	<img class="thumbnail" src='/resources/attachments/${product.thumbnail}'>
				  	</div>
				  	<div class="col-md-6" align="justify" style="margin-top: 60px; font-size: 18px;">
				    <div class="card-title" id="price"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${product.price}"/>원</div>
				    <div class="card-subtitle mb-2 text-muted" style="font-size: 15px;">!! 재료 추가,제외를 원하지 않는 분은<br/> 설정을 그대로 진행해주세요 !!</div>
				    </div>
				</div>
			  </div>
			</div>
		    
			<div class="card">
			  <div class="card-body">
			    <h5 class="card-title">제품구성</h5>
			    <p class="card-text"><c:forEach var="parts" items="${partsList}">
			    <div class="row">
			    	<div class="col-md-6">
						<div class="container productparts">${parts.name} &emsp;&emsp; </div>
					</div>
					<div class="col-md-6">
						<button type="button" class="btn btn-outline-primary execpt" style="margin-right:10px;" data-partsNo="${parts.productPartsNo}" data-partsName="${parts.name}">제외하기</button>
					</div>
				</div>
					</c:forEach>
				</p>
			  </div>
			</div>
			
			<div class="card" id="insertcard">
				<div class="card-body">
				    <h5 class="card-title">추가재료</h5>
				    <h8 class="card-subtitle mb-2 text-muted">*추가를 원하는 재료는 검색 후 추가해주세요 (한번 추가당 10g)*</h8>
				    <p class="card-text">
						<div class="container" style="display:flex; justify-content: center">
							재료 검색 : &emsp;
								<div style="display:flex;">	
									<div class="form-outline">
										<input name="searchKeyword" type="search" class="form-control search" value="" style="border-color: #FF4500; border-width: 2px;"/>
									</div>		  
									<button type="button" class="btn btn-primary partSearch" onclick="search()">
										<i class="bi bi-search"></i>
									</button>
								</div>
						</div>
						<div class="container">
							<div class="plusparts"></div>
						</div>
					</p>
				  </div>
			</div>	  

		  		<div class="card">
					<div class="card-body">
					    <p class="card-text">
							<div>커스터마이징상품 금액 :&ensp;<span id="total"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${product.price}"/></span>원</div><br/>
	
							<div>커스터마이징상품 수량 :<span id="count">
								<button type='button' class="btn btn-outline-primary btn-sm minus" onclick="fnCalCount('minus',this);">-</button>
						        &ensp; <span id="customProductCount" class="count" name="count">1</span> &ensp; 
						        <button type='button' class="btn btn-outline-primary btn-sm plus" onclick="fnCalCount('plus',this);">+</button></span>
						    </div>
						</p>
	
					</div>
				</div><br/>

		<div class="container">
				<div class="container" style="display: flex; justify-content: center;">
					<button type="button" class="btn btn-primary status" style="margin-right:10px;" name=cartStatus value="0" onClick="fncInsertCustomProduct(this)">바로 구매하기</button>
					<button type="button" class="btn btn-primary status" style="margin-right:10px;" name=cartStatus value="1" onClick="fncInsertCustomProduct(this)">장바구니 담기</button>
					 <button type="button" class="btn btn-primary" onClick="history.back(-1)">취&nbsp;소</button>
				</div><br/><br/>	
		</div>
	</form>
	
		
<script type="text/javascript">
	
	const minusNo = [];
	const minusName = [];

	//form insertCustomProduct
	function fncInsertCustomProduct(ths) {

		const count = $("#customProductCount").text();
		const customprice= $("#total").text().replace(",","");
		const cartStatus = $(ths).val();
		
		$(".cc").append(`<input type="hidden" name ="count" value="\${count}">`);
		$(".cc").append(`<input type="hidden" name ="minusNoA" value="\${minusNo}">`);
		$(".cc").append(`<input type="hidden" name ="minusNameA" value="\${minusName}">`);
		$(".cc").append(`<input type="hidden" name ="price" value="\${customprice}">`);
		$(".cc").append(`<input type="hidden" name ="cartStatus" value="\${cartStatus}">`);
		$(".cc").attr("method" , "POST").attr("action" , "/purchase/insertCustomProduct").submit();

	 }
	
	//상품구성재료 제외안되어있으면 제외하기
	function fncExecpt(partsNo, partsName, ths){
		minusNo.push(partsNo);

        minusName.push(partsName);
        
        toastr.error(" 제외되었습니다.",`\${partsName}`,{timeOut:2000});
        ths.text("제외취소하기");
	}
	//상품구성재료 제외하기버튼 클릭
	$(function() {
	    $('.execpt').on('click', function() {
	    	const partsNo = $(this).attr('data-partsNo');	
	    	const partsName = $(this).attr('data-partsName'); 
	    	partsName
	    	if(minusNo.length == 0){
	    		fncExecpt(partsNo, partsName, $(this));
	    		return;
	    	}
	    	
	    	for(let i=0; i<minusNo.length; i++){

	    		if(minusNo[i] === partsNo){
	    			toastr.error(" 제외 취소되었습니다.",`\${minusName[i]}`,{timeOut:2000});
	    			minusNo.splice(i,1);
	    			minusName.splice(i,1);
	    			$(this).text("제외하기");
	    			console.log("ddminusNo"+minusNo);
	    			console.log("ddminusName"+minusName);
	    			return;
	    		}
	    	}
	    	fncExecpt(partsNo, partsName, $(this));
	    	console.log("ggminusNo"+minusNo);
	    	console.log("ggminusName"+minusName);
	    	return;
	    })
	});
	
	//추가재료 검색
	function search(){
		var word = $(".search").val();
		
		if(word == null || word.length<1){
			toastr.error("추가할 재료이름을 입력하세요.","",{timeOut:2000});
		}
	}
	
	//추가재료 g변경
	function fnCalGram(type, ths){
		var stat = $(ths).closest("div").find("span[name='gram']").text();
		var num = parseInt(stat,10);		
		let calprice = parseInt($(ths).closest("div").find("span[name='partsprice']").text().replace(",",""));

		if(type=='minus'){
			num-=10;
			if(num<10){
				toastr.error("더이상 줄일수 없습니다.","",{timeOut:2000});
				return;
			}

			$(ths).closest("div").find("span[name='gram']").text(num);
			
            const minus = parseInt($("#total").text().replace(",","")) - calprice;
            $("#total").text(minus.toLocaleString());
		}else{
			num+=10;
			$(ths).closest("div").find("span[name='gram']").text(num);

            const plus = parseInt($("#total").text().replace(",","")) + calprice;
            $("#total").text(plus.toLocaleString());
		}
		const pgram = parseInt($(ths).closest("div").find("span[name='gram']").text(num));
		const ppgram = $(ths).closest("div").find("input[name='plusGram']").val(num);
		const pprice = $(ths).closest("div").find("span[name='partsprice']").val();
		console.log($(ths).closest("div").find("input[name='plusGram']").val())

	}
	
	//추가재료 검색
	function fncGetParts(){
		const inputTag = $(".partSearch").parent('div').find("input[name='searchKeyword']");
		
		if(inputTag.val().trim() != null){
			if(!($('.name').text().includes(inputTag.val(),0))){
				$.ajax({
					url:"/product/api/getPartsName/"+$(".search").val(),
					method:"GET",
			        headers : {
			            "Accept" : "application/json",
			            "Content-Type" : "application/json"
			        },
			        dataType : "json",
			        success : function(data,status){
			        	//console.log(data);
			        	const parts = "<div class='searchparts'> <input type='hidden' class='partsNo' name='plusPartsNo' value='"+data.partsNo+"' /> <input type='hidden' class='partsName' name='plusName' value='"+data.name+"' />"
			        	+"<input type='hidden' class='price' name='plusPrice' value='"+data.price+"' />"
			            +"<br/><div class='parts' data-parts='"+data.partsNo+"'>"+"<span class='name'>" +data.name + "</span><button type='button' class='btn btn-primary' onClick='fncClose(this)'>x</button>"
			            +"<div class='partsprice' name=partsprice' data-parts='"+data.partsNo+"'>"
			            +"<div name=partsPrice' data-parts='"+data.partsNo+"'><span name='partsprice'>"+ data.price +"</span>원<br/>"
			            +"<input type='hidden' name='plusGram' value='10'/>"
			            +`<button type='button' class="btn btn-outline-primary btn-sm minus" onclick="fnCalGram('minus',this);">-</button>
	         			&ensp; <span class='gram' name='gram'>10</span> &ensp; 
	        			<button type='button' class="btn btn-outline-primary btn-sm plus" onclick="fnCalGram('plus',this);">+</button>`
		               + "</div></div></div></div>" 

		               $(".search").val('');
		               $(".plusparts").append(parts);
		               
		                
		                const productprice = $("#total").text().replace(",","");
		                const result = parseInt(productprice)+parseInt(data.price);
		                $("#total").text(result.toLocaleString());
			        },
			        error : function(status){
			        	if(status.statusText === "parsererror"){
			        		toastr.error("없는 재료 입니다..","",{timeOut:2000});
			        	}
			        }
				})
			}else{
				toastr.error("이미 추가되어있는 재료입니다.","",{timeOut:2000});
				inputTag.val('');
			}
		}
	 }
	
	//추가재료 검색 + autocomplete
	 $(function(){ 
		 $(".search").autocomplete({ 
			 source : function(request, response) { //source: 입력시 보일 목록
			     $.ajax({
			           url : "/purchase/api/autocomplete"   
			         , type : "POST"
			         , dataType: "JSON"
			         , data : {value: request.term}	// 검색 키워드
			         , success : function(data){ 	// 성공
			        	 response(
			                 $.map(data.resultList, function(item) {
			                     return {
			                    	     label : item.NAME,    	// 목록에 표시되는 값
			                             value : item.NAME 		// 선택 시 input창에 표시되는 값
			                     };
			                     console.log(data);
			                 })
			             );    //response
			         }
			         ,error : function(){ //실패
			        	 toastr.error("재료없음","",{timeOut:2000});
			         }
			     });
			 }
				,focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
					return false;
				},
				minLength: 1,// 최소 글자수
				delay: 100	//autocomplete 딜레이 시간(ms),
				, select : function(evt, ui) { 
		      	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
					console.log(ui.item.label);
			 }
		 });
		 
		$(".partSearch").on("click",()=>{	
			fncGetParts();
		})
		
		//추가재료 검색 엔터적용
		$(".search").on("keydown", function(e){
	        if(e.key==="Enter" || e.keyCode==13) {
		           fncGetParts();
		    }     
		});
	})

	//엔터 시 submit 방지
	document.insertCustom.addEventListener("keydown", e => {
		  if(e.code === "Enter" || e.keyCode==13) 
			  e.preventDefault();
		});
	
	//추가재료 삭제
	function fncClose(ths){
		let partsPrice = parseInt($(ths).closest("div").parent().find("span[name='partsprice']").text());
		let count = parseInt($(ths).closest("div").parent().find("span[name='gram']").text())/10;
		let customPrice = $('#total').text().replace(",","");
		let total = customPrice - (partsPrice*count);
		$('#total').text(total.toLocaleString());
		
		$(ths).closest("div").parent().remove();
		
	}
	
	//커스터마이징 한 상품 수량변경
	function fnCalCount(type, ths){
		var statcount = $(ths).parents("div").find("span[name='count']").text();
		var number = parseInt(statcount,10);
		let calprice = parseInt($("#total").text());

		if(type=='minus'){
			number--;
			if(number<1){
				toastr.error("더이상 줄일수 없습니다.","",{timeOut:2000});
				return;
			}
			$(ths).parents("div").find("span[name='count']").text(number);

		}else{
			number++;
			$(ths).parents("div").find("span[name='count']").text(number);
		}
	}
	
</script>

<jsp:include page="../layer/footer.jsp"></jsp:include>	
</body>
</html>