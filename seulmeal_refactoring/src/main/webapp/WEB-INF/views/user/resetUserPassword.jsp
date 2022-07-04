<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lnag="ko">

<head>
	<meta charset="UTF-8">
	<title>슬밀 비밀번호 재설정</title>
	<link rel="stylesheet" href="style.css">
	<!-- <script src="login.js"></script> -->
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
    padding:10px;
    border: solid 1px #dadada;
    background: #fff;
}
.login-confirm-wrap{

    margin: 10px 60px 20px 60px;
    padding: 10px;
    /* border: solid 1px #dadada; */
    background: #fff;
}
.message-wrap{

    margin: 0px 10px 8px 10px;
    padding: 0px 10px 0px 10px;
    border: solid 1px #fff;
    background: #fff;
}
/*input 아이디 form*/
#password{
    border: none;
    outline:none;
    width:100%;
}

#confirmPassword{
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
/*로그인버튼박스*/
 .login-btn-wrap{
    height: 52px;
    line-height: 55px;
    margin: 0px 10px 8px 10px;
    border: solid 1px rgba(0,0,0,.1);
	background-color: #fff;
    color: #fff;
    cursor: pointer; 
}
/*로그인버튼*/
#login-btn{
    width:440px;
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

#login-btn:disabled {
  background-color: #DCDCDC !important;
 }


}

</style>
</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="main">
		<!--로그인 부분-->
		<form class="form-signin" method="post" action="/user/resetUserPassword" target="_self">
			<section class="login-wrap">
				<h2>비밀번호 재설정</h2>
				<div class="login-id-wrap">
					<input id="password" name="password" placeholder="비밀번호" type="password"></input>
				</div>
				<div class="message-wrap">
				<div id="passResult" style="font-size: 12px; color:crimson; text-align: left;"></div>
	     		<div style="font-size: 12px; text-align: left;">비밀번호는 8글자 이상 특수문자1개, 알파벳 대문자 1개를 포함하고 공백과 아이디가 포함되지 않아야 합니다.</div>
				</div>
				
				<div class="login-pw-wrap">
					<input id="confirmPassword" name="email" placeholder="비밀번호 확인" type="password"></input>
				</div>
				<div class="message-wrap">
				<div id="passCheck" style="font-size: 12px; color:crimson; text-align: left;"></div>
				</div>
				<div class="login-btn-wrap">
					<button id="login-btn" type="submit" disabled="disabled">확 인</button>
				</div>
				

			</section>
		</form>
</div>

		<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
//비밀번호 검증
$("#password").on("keyup",()=>{
	const pw = $("#password").val();
	/* const id = $("#userId").val(); */
		
	const reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
	const hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;		 
	
	/* if(id===''){
		$("#passResult").css("color","crimson").text("아이디를 먼저 입력하세요.");
		return
	} */
	
	if(false === reg.test(pw)) {
		$("#passResult").css("color","crimson").text("비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.");
		
		if(/(\w)\1\1\1/.test(pw)){
			$("#passResult").css("color","crimson").text("같은 문자를 4번 이상 사용하실 수 없습니다.");
			$("#login-btn").attr("disabled","disabled");
		/* }else if(pw.search(id) > -1){			
			$("#passResult").css("color","crimson").text("비밀번호에 아이디가 포함되었습니다."); */
		}else if(pw.search(/\s/) != -1){
			$("#passResult").css("color","crimson").text("비밀번호는 공백 없이 입력해주세요.");
			$("#login-btn").attr("disabled","disabled");
		}else if(hangulcheck.test(pw)){
			$("#passResult").css("color","crimson").text("비밀번호에 한글을 사용 할 수 없습니다.");
			$("#login-btn").attr("disabled","disabled");
		}else if(pw === ''){
			$("#passResult").css("color","crimson").text("비밀번호를 입력하세요.");
			$("#login-btn").attr("disabled","disabled");
		} 
	} else {
		$("#passResult").css("color","#ff4500").text("사용가능한 비밀번호 입니다.");
		
		if(/(\w)\1\1\1/.test(pw)){
			$("#passResult").css("color","crimson").text("같은 문자를 4번 이상 사용하실 수 없습니다.");
			$("#login-btn").attr("disabled","disabled");
		}else if(pw.search(id) > -1){			
			$("#passResult").css("color","crimson").text("비밀번호에 아이디가 포함되었습니다.");
			$("#login-btn").attr("disabled","disabled");
		}else if(pw.search(/\s/) != -1){
			$("#passResult").css("color","crimson").text("비밀번호는 공백 없이 입력해주세요.");
			$("#login-btn").attr("disabled","disabled");
		}else if(hangulcheck.test(pw)){
			$("#passResult").css("color","crimson").text("비밀번호에 한글을 사용 할 수 없습니다.");
			$("#login-btn").attr("disabled","disabled");
		}else if(pw === ''){
			$("#passResult").css("color","crimson").text("비밀번호를 입력하세요.");
			$("#login-btn").attr("disabled","disabled");
		} 
	}
	
})

// 비밀번호 동일 체크
$("#confirmPassword").on("keyup",()=>{
	const pw = $("#password").val();
	const pwC = $("#confirmPassword").val();
	if($("#passResult").text()==="사용가능한 비밀번호 입니다."){
		
		if(pw === pwC){
			$("#passCheck").css("color","#ff4500").text("비밀번호가 동일 합니다.");
			$("#login-btn").removeAttr("disabled");
		} else {
			$("#passCheck").css("color","crimson").text("비밀번호가 일치하지 않습니다.");
			$("#login-btn").attr("disabled","disabled");
		}
		
	}
	
	
	
})
</script>

</body>
</html>