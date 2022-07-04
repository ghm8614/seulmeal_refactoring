<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lnag="ko">

<head>
	<meta charset="UTF-8">
	<title>슬밀 비밀번호 찾기</title>
	<link rel="stylesheet" href="style.css">
	<script src="login.js"></script>
<style type="text/css">
body{
    background-color: #f5f6f7;
}
select{
    width:85px;
    height:25px;
    outline: none;
    background: #f5f6f7;
    border: 1px solid #999;
}
a{
    color: black;
    text-decoration: none;
}
.main{
    text-align: center;
	margin-top: 20px;
}
input{
    cursor: pointer
}

/*input 아이디박스*/
.login-id-wrap{

    margin: 0px 10px 8px 10px;
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
}

/*input 아이디 form*/
#input-id{
    border: none;
    outline:none;
    width:100%;
}
/*input 패스워드박스*/
.login-pw-wrap{

    margin: 0px 10px 8px 10px;
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
}
/*input 패스워드 form*/
#email{
    border: none;
    outline:none;
    width:100%;
}
#emailCode{
    border: none;
    outline:none;
    width:100%;
}
/*로그인버튼박스*/
 .login-btn-wrap{
    height: 52px;
    line-height: 55px;
    margin: 0px 10px 8px 10px;
    border: solid 1px rgba(0,0,0,.1);
	background-color: #ff4500;
    color: #fff;
    cursor: pointer; 
}
/*로그인버튼*/
#login-btn{
    width:200px;
    height: 50px;
    background-color: #ff4500;
    border: none;
    color:#fff;
    font-size: 18px;
    outline:none;
    cursor: pointer;
}
/*로그인 아래 박스*/
.under-login{
    height: 50px;
    border-bottom: 1px solid gainsboro;
    margin: 0px 10px 35px 10px;
}
/*로그인상태유지*/
.stay-check{
    margin-left: 7px;
    float: left;
}
/*로그인상태유지 체크박스*/
.stay-check input[type="checkbox"] {
    /*기존 체크박스 숨기기*/
    position: absolute;
    width: 0px;
    position: absolute;
}
.stay-check input[type="checkbox"] + label {
    display: inline-block;
    position: relative;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    }
.stay-check input[type="checkbox"] + label::before {
    content: ' ';
    display: inline-block;
    width: 22px;
    height: 22px;
    line-height: 18px;
    margin: -2px 8px 0 0;
    text-align: center;
    vertical-align: middle;
    background: #fafafa;
    border: 1px solid #cacece;
    border-radius: 50%;
    box-shadow: 0px 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
}
.stay-check input[type="checkbox"]:checked + label::before {
    content: '\2713';
    color: white;
    text-shadow: 1px 1px white;
    background: #ff4500;
    border-color: #ff4500;
    box-shadow: 0px 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
}

/*간편한 로그인 구역*/
#easy-login-wrap{
    height: 90px;
    margin: 0px 10px 35px 10px;
}
/*간편한 로그인 텍스트*/
.easy-login{
    font-size: 20px;
    font-weight: 500;
}
/*QR & 일회용 로그인 박스 구역*/
.easy-login-box{
    display: grid;
    grid-template-columns: 1fr 1fr;
}
/*QR코드 로그인*/
.qr-login{
    float: left;
    border: 1px solid #03c75a;
    background-color: #fff;
    margin: 0px 4px 0px 0px;
    line-height: 55px;
}
/*일회용 번호 로그인*/
/* .onetime-login{
    float: right;
    border: 1px solid #03c75a;
    background-color: #fff;
    margin: 0px 0px 0px 4px;
    line-height: 55px;
} */
/*더욱 간편한 로그인-en모드*/
.qr-login-en, .facebook-login, .line-login{
    font-family: Helvetica,Dotum,sans-serif;
    font-size: 18px;
    font-weight: 400;
    text-align: left;
    line-height: 55px;
    border: solid 1px #dadada;
    background: #fff;
    margin-bottom: 10px;
}
/*더욱 간편한 로그인 이미지-en모드*/
.easy-login-box-en img{
    display: inline-block;
    vertical-align: middle;
    margin: 0 10px 0 10px;
}
/*찾기 및 회원가입*/
.find-signup-wrap{
    height: 100px;
    grid-template-columns: 1fr 1fr 1fr;
}
/*찾기 및 회원가입 글자 희미하게 바꾸기*/
.find-signup-wrap a{
    color: rgb(150, 150, 150);
    text-decoration: none;
    font-weight: 500;
}
.find-signup-wrap span{
    color: rgb(150, 150, 150);
    font-weight: 500;
}
/*아이디 찾기*/
.find-id{
    margin: 3px;
    font-size: 14px;
    border-right: 1px solid gainsboro;
}
/*아이디 찾기-en모드*/
.find-id-en{
    font-size: 14px;
}
/*비밀번호 찾기*/
.find-pw{
    margin: 3px;
    font-size: 14px;
    border-right: 1px solid gainsboro;
}
/*회원가입*/
.sign-up{
    margin: 3px;
    font-size: 14px;
}

/*가로 800px 이상일때*/
@media(min-width : 800px)
{
    .main{
        width: 460px;
        margin: auto;
    }

.login-confirm-wrap{

    margin:  10px 10px 10px 10px;
}

}

</style>
</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="main">
		<!--로그인 부분-->
		<form class="form-signin" method="post" action="/user/findUserPasswordView" target="_self">
			<section class="login-wrap">
				<h2>비밀번호 찾기</h2>
				<div class="login-confirm-wrap">
					<table>
					  <tr>
					    <td id ="line1" class="line1" style="width:250px;height: 50px;"><a onclick="phone()" >핸드폰</a> </td>
					    <td id ="line2" class="line2"style="width:250px;height: 50px;"><a onclick="email()" >이메일</a></td>
					  </tr>
					</table>		
				</div>
				<div class="login-id-wrap">
					<input id="input-id" name="userId" placeholder="아이디" type="text"></input>
				</div>
				<div class="login-pw-wrap">
					<input class="phone" id="email" name="phone" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="숫자만 입력해주세요" type="text"></input>
					<input class="email" id="email" name="email" placeholder="이메일" type="text" style="display: none;"></input>
				</div>
				<div class="login-pw-wrap" id="emailCheckForm" style="display: none;">
					<input id="emailCode" name="email" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="인증번호를 입력하세요" type="text"></input>
				</div>
				<div class="login-btn-wrap" id="confirm">
					<button id="login-btn" type="button" onclick="passwordSearch()">인증 번호 받기</button>
				</div>
				<div class="login-btn-wrap" id="reset" style="display: none;">
					<button id="login-btn" type="button" onclick="confirmEmail()" >비밀번호 재설정</button>
				</div>
			</section>
		</form>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header" >
        <h5 class="modal-title" id="exampleModalLabel" style="display: none;"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="findId">
        <div id="success" style="display: none;"></div>
        <div id="fail" style="display: none;">인증번호가 일치하지 않습니다</div>
         <div id="noneDb" style="display: none;">가입시 등록한 정보가 맞는지 다시 확인해주세요</div>
        </div>
      </div>
      <div class="modal-footer" >
        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary">비밀번호 찾기</button> -->
        <div id="resetPw" style="display: none;"><a href="/user/findUserPasswordView">비밀번호 찾기</a></div>
      </div>
    </div>
  </div>
</div>

		<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">

function email(){
	$(".phone").css("display","none");
	$(".email").css("display","block");
	$("#line2").css("border-top","2px solid black");
	$("#line2").css("border-left","2px solid black");
	$("#line2").css("border-right","2px solid black");
	$("#line1").css("border-bottom","2px solid black");
	$("#line1").css("border-top",'');
	$("#line1").css("border-left",'');
	$("#line1").css("border-right",'');
	$("#line2").css("border-bottom",'');
	
}

function phone(){
	$(".email").css("display","none");
	$(".phone").css("display","block");
	$("#line1").css("border-top","2px solid black");
	$("#line1").css("border-left","2px solid black");
	$("#line1").css("border-right","2px solid black");
	$("#line2").css("border-bottom","2px solid black");
	$("#line2").css("border-top",'');
	$("#line2").css("border-left",'');
	$("#line2").css("border-right",'');
	$("#line1").css("border-bottom",'');
	
}

 $(function(){
	$("#line1").css("border-top","2px solid black");
	$("#line1").css("border-left","2px solid black");
	$("#line1").css("border-right","2px solid black");
	$("#line2").css("border-bottom","2px solid black");
});  



//계정 유뮤 체크
function passwordSearch(){
	const passwordSearch = {
			id: $("#input-id").val(),
			email: $(".email").val(),
			phone: $(".phone").val()
	}
	
	console.log(passwordSearch)
	
	  $.ajax({
		url: "/user/api/findPassword",
		method: "GET", 
		data: passwordSearch,
		headers : {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        dataType : "json",
        success : function(data){
        	if(data.result === "success"){
        		/* alert("인증번호를 입력하세요"); */
        		$("#emailCheckForm").css("display","block");
        		$("#reset").css("display","block");
        		$("#confirm").css("display","none");
        		return;
        	}
        	if(data.result === "fail"){
        		/* alert("가입시 등록한 정보가 맞는지 다시 확인해주세요");
        		return; */
        		$("#noneDb").css("display","block");
        		$("#exampleModal").modal();
        	}
        }
	})		  
}


//이메일인증 확인
function confirmEmail(){

	const confirmCode = {
			code: $("#emailCode").val(),
			idSearch: "1"
	}
	
	let url = "/user/api/findIdCode";
	$.ajax({
		url: url,
		method: "GET",
		headers : {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        data: confirmCode,
        dataType : "json",
        success : function(data){
        	if(data.result === "인증완료"){
        		/* alert(data.userId); */
        		location.href='/user/resetUserPassword'
            		return;
            	
        	}
        	if(data.result === "인증실패"){
        		/* alert("인증코드가 일치하지 않습니다"); */
        		$("#fail").css("display","block");
        		$("#noneDb").css("display","none");
        		$("#exampleModal").modal();
            	
        	}
        	
        	
       
        }
	})
}


//이메일인증 확인
/* function confirmEmail(){
	const confrimNum = $("#emailCode").val();
	/* const emailNum = $(".email").val(); */
	
	/*let url = "/user/api/confirmCode/"+confrimNum;
	$.ajax({
		url: url,
		method: "GET",
		headers : {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        dataType : "json",
        success : function(data){
        	if(data.result === "인증완료"){
        		location.href='/user/resetUserPassword'
        		return;
        	}
        	if(data.result === "인증실패"){
        		/* alert("인증번호가 틀렸습니다 다시 입력해주세요");
        		return; */
        		/*$("#fail").css("display","block");
        		$("#exampleModal").modal();
        		
        	}
        }
	})
} */

</script>

</body>
</html>