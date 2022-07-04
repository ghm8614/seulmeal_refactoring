<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>슬밀 내정보</title>
</head>
<style>  
body { background: #fff; }

  table {
    width: 700px;
     margin-left:auto; 
    margin-right:auto;
  }

.modal-title{
 display: flex; 
 justify-content: center;
}  
  
.bluetop {
  border-collapse: collapse;
  border-top: 3px solid #ff4500;
}  
.bluetop th {
  color: #ff4500;
  background: #FBF8EF;
}
.bluetop th, .bluetop td {
  padding: 10px;
  border: 1px solid #ddd;
}
.bluetop th:first-child, .bluetop td:first-child {
  border-left: 0;
}
.bluetop th:last-child, .bluetop td:last-child {
  border-right: 0;
}
	 #wrap{
    width:100%;
    height:100%;
}
  
#wrap .box{ 
    width:800px;
   margin: 0 auto;
  
}
.input{
	/*  margin: 0px 10px 8px 10px; */
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
    width: 500px;
	}
.col-sm-2{
margin-top: 15px;
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
.btn-user:disabled{
border: solid 1px #dadada;
}
.btn-post{
border: solid 1px #ff4500;
height:46px;
background: #fff;
height:44px;
}
.line{
 border: solid 1px #212121;
 margin: 20px  0px 20px 0px;
}
</style>

<body>

	<jsp:include page="../layer/header.jsp"></jsp:include>

	<div id="wrap">
		<div class="box">
		<h2 style="text-align: center;">내 정보</h2>
		<div class="line"></div>
		<form method="post" action="/user/getUpdateUser" enctype="multipart/form-data">
			
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10" style="margin-top:15px;">
				 <input type='hidden'  name='userId' value='${user.userId }' />
				${user.userId }
				</div>
			</div>
			<div class="form-group row">
				<label for="Password3" class="col-sm-2 control-label">비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="input" id="password" name="password" placeholder="">
					 <div id="checkPassword"></div>
				</div>
			</div>
			<div class="form-group row">
				<label for="Password3" class="col-sm-2 control-label">새 비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="input" id="newPassword" name="newPassword" placeholder="">
					<div id="passResult" style="color:crimson;"></div>
				</div>
			</div>
			<div class="form-group row">
				<label for="Password3" class="col-sm-2 control-label">비밀번호 확인</label>
				<div class="col-sm-10">
					<input type="password" class="input" id="confirmPassword" placeholder="">
					<div id="passCheck" style="color:crimson;"></div>
				</div>
			</div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">이름</label>
				<div class="col-sm-10">
					<input type="text" class="input" id="userName" name="userName" value="${user.userName }" placeholder="">
				</div>
			</div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">닉네임</label>
				<div class="col-sm-10">
					<input type="text" class="input" id="nickName" name="nickName" value="${user.nickName }" placeholder="">
				</div>
			</div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">회원등급</label>
				<!-- <div class="col-sm-10" data-toggle="modal" data-target="#exampleModalCenter" style="margin-top:10px;"> -->
				<div class="col-sm-10" style="margin-top:10px;">
				
				
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#grade">
					 <c:choose>
						<c:when test="${user.grade eq '0'}">슬밀프랜즈</c:when>
						<c:when test="${user.grade eq '1'}">슬밀패밀리</c:when>
						<c:when test="${user.grade eq '2'}">슬밀히어로</c:when>
						<c:when test="${user.grade eq '3'}">슬밀마스터</c:when>
					</c:choose>	
					</button>
					 
				</div>
			</div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">이메일</label>
				<div class="col-sm-10">
					<input type="text" class="input" id="email" name="email" value="${user.email }" placeholder="">
				</div>
			</div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">휴대폰</label>
				<div class="col-sm-10">
					<input type="text" class="input" id="phone" name="phone" value="${user.phone }" placeholder="">
				</div>
			</div>
		   <div class="form-group row">
		    <label for="Email3" class="col-sm-2 control-label">주소</label>
		    <div class="col-sm-10">
		    	<!-- 주소 -->
		    	<div style="display: flex; justify-content: space-between;">
		    	<input type="text" class="input" id="sample3_postcode" name="address"  placeholder="우편번호" value="${user.address.split(',')[0] }" style="margin-bottom: 5px;" readonly>
				<input class="btn-post" id="findAddress" type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기">
				</div>
				<input type="text" class="input" id="sample3_address" name="address" value="${user.address.split(',')[1]} ${user.address.split(',')[2]}" style="margin-bottom: 5px;"  placeholder="주소" ><br>
				<input type="text" class="input" id="address" name="address" style="display: none;" placeholder="상세주소">
				
				<div id="addressWrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
				
		    </div>
		  </div>
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">생년월일</label>
				<div class="col-sm-10">
					 ${user.birth } 
				</div>
			</div>
			<br/>

			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">프로필 이미지</label>
				<div class="col-sm-3">
					<img src="/resources/attachments/profile_image/${user.profileImage }" id="img_section" style="width: 200px; height: 200px;">
				
				</div>
				<br/><br/>
				<div class="col-sm-7" style="margin-top: 160px;">
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
						<!-- 선택 안했을 경우 -->
						<c:if test="${user.foodCategoryName1 == null}">
							<input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);"> ${foodcategory.name }
						</c:if>
						
						<!-- 체크한 박스 -->
						<c:if test="${user.foodCategoryName1 != null}">
							<c:choose>							
								<c:when test="${user.foodCategoryName1 == foodcategory.name}">
									<input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);" checked> ${foodcategory.name }
								</c:when>
								<c:when test="${user.foodCategoryName2 == foodcategory.name}">
									<input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);" checked> ${foodcategory.name }
								</c:when>
								<c:when test="${user.foodCategoryName3 == foodcategory.name}">
									<input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);" checked> ${foodcategory.name }
								</c:when>							
								
								<c:otherwise><input type="checkbox" name="foodcategory" value="${foodcategory.name }" onclick="count_check(this);"> ${foodcategory.name }</c:otherwise>
							</c:choose>
						</c:if>
					</label> 
					
					
				</c:forEach>
				</div>
			</div>
					
			<div class="form-group row">
				<label for="Email3" class="col-sm-2 control-label">비선호 재료</label>
				<div class="col-sm-10">
					<div class="container"> 
								<div class="hateParts"  style="display:flex;">	
									<div class="form-outline">
										<input name="searchKeyword" type="search" class="form-control search" value="" />
									</div>		  
									<button type="button" class="btn btn-primary partSearch" onclick="search()">
										<i class="bi bi-search"></i>
									</button>
								</div>
						</div>
						<div class="container">
							<div class="plusparts"></div>
						</div>
				</div>
			</div>
				
			
			<div class="form-group row">
			
				<div class="col-sm-10" style="text-align: right">
					<button type="submit" class="btn-user" id="save" disabled="disabled">저장</button>
					<button id="cancelBtn" type="button" class="btn-user" onclick="history.back()">취소</button>
					<button id="cancelBtn" type="button" class="btn-user" onclick="location.href='/user/deleteUser'">탈퇴</button>
				</div>
			</div>

		</form>
		
		</div>
		
	</div>
	
	
	
	<!-- Modal -->
<div class="modal fade" id="grade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원등급 안내</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="bluetop">
           <%--  <caption>표 제목</caption> --%>
            <thead>
                <tr align="center" bgcolor="white">
                    <td></td>
                    <th>슬밀프렌드</th>
                    <th>슬밀패밀리</th>
                    <th>슬밀히어로</th>
                    <th>슬밀마스터</th>
                </tr>
            </thead>

            <tbody>
                <tr align="center" bgcolor="white">
                    <td>조건</td>
                    <td>회원가입</td>
                    <td>월 3회 구매</td>
                    <td>월 5회 구매</td>
                    <td>월 10회 구매</td>
                </tr>
                <tr align="center" bgcolor="white">
                  <td>혜택</td>
                  <td>구매액 0.5% 적립</td>
                  <td>구매액 1% 적립</td>
                  <td>구매액 3% 적립</td>
                  <td>구매액 5% 적립</td>
                </tr>
            </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
	
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/javascript/user/address.js"></script>
<script type="text/javascript">	
	
$("#findAddress").on("click",()=>{
	$("#address").css("display","block");
})


function search(){
	var word = $(".search").val();
	console.log(word);
	
	if(word == null || word.length<1){
		alert("추가할 재료이름을 입력하세요.");
	}
}

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



function fncClose(ths){
	 $(ths).closest("div").parent().remove();
	
}

//비밀번호 동일여부
$("#password").on("keyup",()=>{
	console.log($("#password").val())
	if($("#password").val() !==''){
		$.ajax({
			url: "/user/api/confirmPassword/"+$("#password").val(),
			method: "GET",
			headers : {
	            "Accept" : "application/json",
	            "Content-Type" : "application/json"
	        },
	        dataType : "json",
	        success : function(data){
	        	console.log(data)
	        	if(data.result ==="fail"){
	        		$("#checkPassword").css("color","crimson").text("비밀번호가 일치하지 않습니다");
	        		$("#save").attr("disabled","disabled");
	        	} else if(data.result ==="success") {
	        		$("#checkPassword").css("color","#ff4500").text("비밀번호가 일치합니다");
	        		$("#save").removeAttr("disabled");
	        	} else {
	        		alert(data);
	        		alert("서버오류");
	        	}
	        }
		})
	} else {
		$("#checkPassword").css("color","crimson").text("내정보 수정을 원하시면 비밀번호를 입력해 주세요");
		$("#save").attr("disabled","disabled");
	}
	
})	

//비밀번호 검증
$("#newPassword").on("keyup",()=>{
	const pw = $("#newPassword").val();
	/* const id = $("#userId").val(); */
		
	const reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
	/* const hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;		 */
	
	/* if(id===''){
		$("#passResult").css("color","crimson").text("아이디를 먼저 입력하세요.");
		return
	} */
	
	if(false === reg.test(pw)) {
		$("#passResult").css("color","crimson").text("비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.");
		
		if(/(\w)\1\1\1/.test(pw)){
			$("#passResult").css("color","crimson").text("같은 문자를 4번 이상 사용하실 수 없습니다.");
		/* }else if(pw.search(id) > -1){			
			$("#passResult").css("color","crimson").text("비밀번호에 아이디가 포함되었습니다."); */
		}else if(pw.search(/\s/) != -1){
			$("#passResult").css("color","crimson").text("비밀번호는 공백 없이 입력해주세요.");
		}else if(hangulcheck.test(pw)){
			$("#passResult").css("color","crimson").text("비밀번호에 한글을 사용 할 수 없습니다.");
		}else if(pw === ''){
			$("#passResult").css("color","crimson").text("비밀번호를 입력하세요.");
		} 
	} else {
		$("#passResult").css("color","#ff4500").text("사용가능한 비밀번호 입니다.");
		
		if(/(\w)\1\1\1/.test(pw)){
			$("#passResult").css("color","crimson").text("같은 문자를 4번 이상 사용하실 수 없습니다.");
		}else if(pw.search(id) > -1){			
			$("#passResult").css("color","crimson").text("비밀번호에 아이디가 포함되었습니다.");
		}else if(pw.search(/\s/) != -1){
			$("#passResult").css("color","crimson").text("비밀번호는 공백 없이 입력해주세요.");
		}else if(hangulcheck.test(pw)){
			$("#passResult").css("color","crimson").text("비밀번호에 한글을 사용 할 수 없습니다.");
		}else if(pw === ''){
			$("#passResult").css("color","crimson").text("비밀번호를 입력하세요.");
		} 
	}
	
})
	
	// 비밀번호 동일 체크
	$("#confirmPassword").on("keyup",()=>{
		const pw = $("#newPassword").val();
		const pwC = $("#confirmPassword").val();
		
		if(pw === pwC){
			$("#passCheck").css("color","#ff4500").text("비밀번호가 동일 합니다.");
		} else {
			$("#passCheck").css("color","crimson").text("비밀번호가 일치하지 않습니다.");
		}
	})
	
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
</body>
</html>