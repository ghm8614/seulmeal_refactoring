<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<title>insertUserInformation</title>
<style type="text/css">

#wrap{
    width:100%;
    height:100%;
}
  
#wrap .box{ 
    width:800px;
   margin: 0 auto;
  
}
.under-login{
	width:450px;
   /* height: 50px; */
   /*  border-bottom: 1px solid gainsboro; */
    margin: 0px 0px 0px 0px;
}
/* .card-body{
width:300px;
 margin: 0px 0px 0px 160px;
   /*  text-align: right; */
}
 */
.category{
margin: 0px 0px 0px 0px;
}

.col-sm-offset-2{
text-align: right;
}

.hateParts{
margin: 0px 0px 0px 0px;
}


.form-group{
margin: 0px 0px 0px 0px;
}

.line{
 border: solid 1px #212121;
 margin: 20px  0px 20px 0px;
} 

.input{
	/*  margin: 0px 10px 8px 10px; */
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
    width: 500px;
	}
	
.input-file	{
 padding: 5px;
    border: solid 1px #dadada;
    background: #fff;
}
.btn-user{
border: solid 1px #ff4500;
background: #fff;
height:40px;
width: 90px;
}
</style>
</head>
<script type="text/javascript">
	
 /* $(()=>{
	$(".partSearch").on("click",()=>{
		$.ajax({
			url:"/product/api/getPartsName/"+$(".search").val(),
			method:"GET",
	        headers : {
	            "Accept" : "application/json",
	            "Content-Type" : "application/json"
	        },
	        dataType : "json",
	        success : function(data){	        	
	        	console.log(data);
	        	const parts = "<div> <input type='hidden' name='partsNo' value='"+data.partsNo+"' /> <input type='hidden' name='partsName' value='"+data.name+"' />"
	                +"<div class='part' data-parts='"+data.partsNo+"'>"+ data.name +"</div>"
	                +"</div>"
	        	$(".parts").append(parts);
	        }
		})
	})
})
 */


/* const minusName = [];

function fncInsertCustomProduct(ths) {
	
	alert("제외한 재료 : "+minusName)
	const count = $("#customProductCount").text();
	const customprice= $("#total").text();
	const cartStatus = $(ths).val();
	
	$(".cc").append(`<input name ="count" value="\${count}">`);
	$(".cc").append(`<input name ="minusNoA" value="\${minusNo}">`);
	$(".cc").append(`<input name ="minusNameA" value="\${minusName}">`);
	$(".cc").append(`<input name ="price" value="\${customprice}">`);
	$(".cc").append(`<input name ="cartStatus" value="\${cartStatus}">`);
	$(".cc").attr("method" , "POST").attr("action" , "/purchase/insertCustomProduct").submit();
 }


$(function() {
    $('.execpt').on('click', function() {
        const partsNo = $(this).attr('data-partsNo');	        
        minusNo.push(partsNo);
        	       	        
        const partsName = $(this).attr('data-partsName'); 
        minusName.push(partsName);
        
        alert(partsName+" 제외되었습니다.");
        console.log("minusNo : "+minusNo);
        
        $(this).attr("disabled","disabled");
    })
});
 */
function search(){
	var word = $(".search").val();
	console.log(word);
	
	if(word == null || word.length<1){
		alert("추가할 재료이름을 입력하세요.");
	}
}


/* function fnCalGram(type, ths){
	var stat = $(ths).closest("div").find("span[name='gram']").text();
	var num = parseInt(stat,10);		
	let calprice = parseInt($(ths).closest("div").find("span[name='partsprice']").text());

	if(type=='minus'){
		num-=10;
		if(num<10){
			alert('더이상 줄일수 없습니다.');
			return;
		}

		$(ths).closest("div").find("span[name='gram']").text(num);
		
        const minus = parseInt($("#total").text()) - calprice;
        $("#total").text(minus);
	}else{
		num+=10;
		$(ths).closest("div").find("span[name='gram']").text(num);

        const plus = parseInt($("#total").text()) + calprice;
        $("#total").text(plus);
	}
	const pgram = parseInt($(ths).closest("div").find("span[name='gram']").text(num));
	const ppgram = $(ths).closest("div").find("input[name='plusGram']").val(num);
	const pprice = $(ths).closest("div").find("span[name='partsprice']").val();
	console.log($(ths).closest("div").find("input[name='plusGram']").val())

}
 */

function fnCalCount(type, ths){
	var statcount = $(ths).parents("div").find("span[name='count']").text();
	var number = parseInt(statcount,10);
	let calprice = parseInt($("#total").text());

	if(type=='minus'){
		number--;
		if(number<1){
			alert('더이상 줄일수 없습니다.');
			return;
		}
		$(ths).parents("div").find("span[name='count']").text(number);

	}else{
		number++;
		$(ths).parents("div").find("span[name='count']").text(number);
	}
}

function fncGetParts(){
	const inputTag = $(".partSearch").parent('div').find("input[name='searchKeyword']");
	
	if(inputTag.val().trim() != null){
		if(inputTag.val() != $('.name').text()){
			$.ajax({
				url:"/product/api/getPartsName/"+$(".search").val(),
				method:"GET",
		        headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){	        	
		        	console.log(data);

		        	const parts = "<div class='searchparts'> <input type='hidden' class='partsNo' name='plusPartsNo' value='"+data.partsNo+"' /> <input type='hidden' class='partsName' name='partsName' value='"+data.name+"' />"
		        	+"<input type='hidden' class='price' name='plusPrice' value='"+data.price+"' />"
		            +"<br/><div class='parts' data-parts='"+data.partsNo+"'>"+"<span class='name'>" +data.name + "</span><button type='button' class='btn btn-primary' onClick='fncClose(this)'>x</button>"
		            +"<div class='partsprice' name=partsprice' data-parts='"+data.partsNo+"'>"
		            /* +"<div name=partsPrice' data-parts='"+data.partsNo+"'><span name='partsprice'>"+ data.price +"</span>원<br/>"
		            +"<input type='hidden' name='plusGram' value='10'/>"
		            +`<button type='button' class="btn btn-outline-primary btn-sm minus" onclick="fnCalGram('minus',this);">-</button>
         			&ensp; <span class='gram' name='gram'>10</span> &ensp; 
        			<button type='button' class="btn btn-outline-primary btn-sm plus" onclick="fnCalGram('plus',this);">+</button>` */
	               + "</div></div></div></div>" 

	               $(".search").val('');
	               $(".plusparts").append(parts);
	               
	                
	                const productprice = $("#total").text();
	                const result = parseInt(productprice)+parseInt(data.price);
	                $("#total").text(result);
		        }
			})
		}else{
			alert("이미 추가되어있는 재료입니다.");
			inputTag.val('');
		}
	}
 }


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
		             alert("오류가 발생했습니다.");
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
})


 $(".search").keydown(function(key){
	        if(key.keyCode==13) {
		           fncGetParts();
		    }     
});


/* document.insertCustom.addEventListener("keydown", evt => {
	  if (evt.code === "Enter") 
	  evt.preventDefault();
	});
 */
 
 $("#hates").on('keyup', function(e){
     if(e.key==='Enter'||e.keyCode===13){
    	 search();
  	   
     }
 })

function fncClose(ths){
	 $(ths).closest("div").parent().remove();
	
}

//카테고리 체크
	function count_check(obj){
	var chkBox = document.getElementsByName("foodcategory");
	var chkCnt = 0;
	
	for(var i = 0; i<chkBox.length; i++){
		if(chkBox[i].checked){
			chkCnt++;
		}
	}
	if(chkCnt > 3){
		alert("3개까지 체크할 수 있습니다.");
		obj.checked = false;
		return false;
	}
}
	
</script>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>
 <br/>
 <br/>

	<div id="wrap">
<div class="box">

<form class="form-horizontal" method="post" action="/user/insertUserInformation"  enctype="multipart/form-data">
			<h2 style="text-align: center;">추가 정보</h2>
			<div class="line"></div>

<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">프로필 이미지</label>
				<div class="col-sm-3">
					<img src="/resources/attachments/profile_image/default_profile.jpg" id="img_section" style="width: 200px; height: 200px;">
				
				</div>
				<br/><br/>
				<div class="col-sm-7" style="margin-top: 164px;">
				<div class="under-login" id="find-signup-wrap-ko" >
					<input type='hidden'  name='profileImage' value='${user.profileImage }' />
					<input type="text" id="file_route" class="input-file" disabled="disabled" value="이미지 선택"><!-- accept="image/*" -->
					<label for="upload_file" style="border: solid 1px #ff4500;padding: 5px;">확인</label>
					<input type="file" id="upload_file" name="imageFile" style="position: absolute; clip: rect(0, 0, 0, 0);">
				 <script>
			        const reader = new FileReader();
			
			        reader.onload = (readerEvent) => {
			            document.querySelector("#img_section").setAttribute("src", readerEvent.target.result);
			        };
			
			        document.querySelector("#upload_file").addEventListener("change", (changeEvent) => {
			
			            const imgFile = changeEvent.target.files[0];
			            reader.readAsDataURL(imgFile);
			        })
			    </script>
				</div>
				</div>
			</div>
			
			
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">상태메세지</label>
				<div class="col-sm-10">
					<input type="text" class="input" id="profilemessage" name="profilemessage" value="${user.profileMessage }" placeholder="">
				</div>
			</div>
			
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">음식 카테고리</label>
				<div class="col-sm-10">
					<c:forEach var="foodcategory" items="${foodcategoryList}">
					<label class="btn btn-primary active">
						<input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);"> ${foodcategory.name }
					</label> 
					
					
				</c:forEach>
				<div style="color:gray;">카테고리는 3개 이하 선택해 주세요.</div>
				</div>
			</div>
					
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">비선호 식재료</label>
				<div class="col-sm-10">
					<div class="con"> 
								<div class="hateParts"  style="display:flex;">	
									<div class="">
										<input name="searchKeyword" type="search" class="input search" id="hates" value="" placeholder="예) 양파" />
									</div>		  
									<button type="button" class="btn btn-primary partSearch"  onclick="search()">
										<i class="bi bi-search"></i>
									</button>
								</div>
						</div>
						<div class="con">
							<div class="plusparts"></div>
						</div>
				</div>
			</div>
				
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn-user">저장</button>
					<button type="button" class="btn-user"  onclick = "location.href = 'http://www.seulmeal.shop'">건너뛰기</button>
				</div>
			</div>

		</form>

</div>
</div>

		


	<jsp:include page="../layer/footer.jsp"></jsp:include>
</body>
</html>