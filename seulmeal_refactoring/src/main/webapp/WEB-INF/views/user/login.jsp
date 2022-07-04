<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lnag="ko">

<head>
	<meta charset="UTF-8">
	<title>슬밀 로그인</title>
	<link rel="stylesheet" href="style.css">
	<!-- <script src="login.js"></script> -->
<style type="text/css">
/* body{
    background-color: #f5f6f7;
} */
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

/*언어설정*/
.select-lang{
    text-align: right;
    padding-right: 10px;
}
/*네이버 로고설정*/
.image{
    height: 32px;
    padding: 20px;
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
#input-pw{
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
    width:100px;
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
    text-align: right;
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
/*IP보안 표시X*/
#ip-check{
    display: none;
}
/*IP보안 ON/OFF*/
#ip-context{
    color:rgb(160, 160, 160);
    font-weight: 900;
    display: inline-block;
    width: 22px;
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
.onetime-login{
    float: right;
    border: 1px solid #03c75a;
    background-color: #fff;
    margin: 0px 0px 0px 4px;
    line-height: 55px;
}
/*더욱 간편한 로그인-en모드*/
.qr-login-en{
    font-family: Helvetica,Dotum,sans-serif;
    font-size: 18px;
    font-weight: 400;
    text-align: center;
    line-height: 50px;
    border: solid 1px #dadada;
    background: #fff;
    margin-bottom: 10px;
    background-color: #03c75a;
}
.facebook-login, .line-login{
    font-family: Helvetica,Dotum,sans-serif;
    font-size: 18px;
    font-weight: 400;
    text-align: center;
    line-height: 50px;
    border: solid 1px #dadada;
    background: #fff;
    margin-bottom: 10px;
    background-color: #FEE500;
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
/*저작권 표시X*/
footer{
    display: none;
}


/*가로 800px 이상일때*/
@media(min-width : 800px)
{
    .main{
        width: 460px;
        margin: auto;
    }

/*언어설정*/
.select-lang{
    margin-top: 20px;
    width: 550px;
    padding-right: 10px;
}
/*네이버 로고설정*/
.image{
    margin-top: 40px;
    height: 44px;
    padding: 20px;
}

/*IP보안 표시*/
#ip-check{
    margin-right: 7px;
    float: right;
    display:block;
}

/*저작권 표시*/
footer{
    display:block;
}

}


/*회원가입 부분*/
.main-signup{
    text-align: center;
    width: 460px;
    margin: auto;
}
h3{
    margin:19px 0px 8px;
    text-align: left;
    font-size: 14px;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
.signup-input{
    display:flex;
    /* margin: 0px 10px 8px 10px; */
    padding: 10px;
    border: solid 1px #dadada;
    background: #fff;
    cursor: pointer;
}
.signup-input-c{
    display:flex;
    /* margin: 0px 10px 8px 10px; */
    padding: 10px;
    border: solid 1px #dadada;
    background: #f5f6f7;
    cursor: pointer;
}
.signup-input-c input{
    background: #f5f6f7;
}
#signup-id, #signup-pw, #signup-pww{
    height: 29px;
    border: none;
    outline:none;
    width:100%;
}
.signup-at{
    color: rgb(150, 150, 150);
    font-size: 15px;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
    margin-top: 8px;
}
.pw-lock{
    /* content: ''; */
    /* display: inline-block; */
    top: 50%;
    right: 13px;
    width: 24px;
    height: 24px;
    margin-top: 5px;
    background-image: url(https://static.nid.naver.com/images/ui/join/m_icon_pw_step.png);
    background-size: 125px 75px;
    cursor: pointer;
}
.pww-lock{
    /* content: ''; */
    /* display: inline-block; */
    top: 50%;
    right: 13px;
    width: 24px;
    height: 24px;
    margin-top: 5px;
    background-image: url(https://static.nid.naver.com/images/ui/join/m_icon_pw_step.png);
    background-size: 125px 75px;
    cursor: pointer;
}

.signup-input-birth{
    display: block;
    position: relative;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px;
    background: #fff;
    box-sizing: border-box;
}
#signup-birth-yy, #signup-birth-mm, #signup-birth-dd{
    width: 113px;
    height: 29px;
    border: none;
    outline:none;
}
#signup-name, #signup-gender, #signup-email, #signup-country, #signup-phone, #signup-cnum{
    width:100%;
    height: 29px;
    border: none;
    outline:none;
}
#signup-gender{
    background-color: white;
}
#signup-country{
    background-color: white;
}
#signup-birth-mm{
    background-color: white;
}
/*본인 확인 이메일*/
.choice{
    display: flex;
}
.choice span{
    margin-top: 20px;
    color: rgb(150, 150, 150);
    font-size: 13px;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
/*회원가입버튼박스*/
.signup-btn-wrap{
    height: 52px;
    line-height: 55px;
    margin: 10px 0px 50px 0px;
    border: solid 1px rgba(0,0,0,.1);
    background-color: #03c75a;
    color: #fff;
    cursor: pointer;
}
/*회원가입버튼*/
#signup-btn{
    width:100px;
    background-color: #03c75a;
    border: none;
    color:#fff;
    font-size: 18px;
    outline:none;
    cursor: pointer;
}
/*인증번호버튼박스*/
.cnum-btn-wrap{
    height: 52px;
    line-height: 55px;
    margin: 10px 0px 0px 10px;
    border: solid 1px rgba(0,0,0,.1);
    background-color: #03c75a;
    color: #fff;
    cursor: pointer;
}
/*인증번호버튼*/
#cnum-btn{
    width:115px;
    background-color: #03c75a;
    border: none;
    color:#fff;
    font-size: 15px;
    outline:none;
    cursor: pointer;
}
#loginCheck{
	text-align: left;
	margin: 0px 0px 0px 12px;
}


</style>
</head>

<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="main">
		
		<!--로그인 부분-->
		<section class="login-wrap">
 		<form action="/user/login" method="post" id="loginForm">
         <h1>슬밀</h1>
         <div class="login-id-wrap">
            <input id="input-id" name="userId" placeholder="아이디" type="text" value="ghm8614"></input>
         </div>
         <div class="login-pw-wrap">
            <input id="input-pw" name="password" placeholder="비밀번호" type="password" value="Cjstnqud1!"></input> 
         </div>
         <div id="loginCheck" style="color:crimson;"></div>
         <div class="login-btn-wrap">
            <button type="button" id="login-btn" onclick="login()">로그인</button>
         </div>
         <div>
            <span class="stay-check">
				<input id="stay-checkbox" type="checkbox" name="checkLogin"></input>
				<label for="stay-checkbox" id="stay-text">로그인 상태 유지</label>
			</span>
         </div>
      </form>
		<div class="under-login" id="find-signup-wrap-ko">
				<span class="find-id">
					<a href="/user/findUserIdView" >아이디 찾기</a>
				</span>

				<span class="find-pw">
					<a href="/user/findUserPasswordView">비밀번호 찾기</a>
				</span>

				<span class="sign-up">
					<a href="/user/insertUser">회원가입</a>
				</span>
			</div>
		</section>

		<!--간편한 로그인 부분-->
		<section id="easy-login-wrap">

			<div id="easy-login-wrap-en" >
				<div class="easy-login-box-en">

					<div class="qr-login-en">
						
						<img src="/resources/attachments/image/btnG_완성형.png" width="210px" height="50px" onclick="showLoginPopup()" >
					</div>
					<div class="facebook-login">
						
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=972aafa79be1ef957c5ab9ed1149b0e7&redirect_uri=http://www.seulmeal.shop/user/kakaoLogin&response_type=code">
						<img src = "/resources/attachments/image/kakao_login_large_narrow.png" width="210px" height="50px">
						</a>
					</div>
				</div>
			</div>
		</section>
	</div>
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
   $("#checkLogin").on("change",()=>{
      const result = document.querySelector("#checkLogin");
      if(result.checked){
         result.value = "1";
      } else {
         result.value = "0";
      }
   })
   
   function showLoginPopup(){
        let uri = 'https://nid.naver.com/oauth2.0/authorize?' +
            'response_type=code' +                  // 인증과정에 대한 내부 구분값 code 로 전공 (고정값)
            '&client_id=9v2VufeHsXfFnp8KaD49' +     // 발급받은 client_id 를 입력
            '&state=NAVER_LOGIN_TEST' +             // CORS 를 방지하기 위한 특정 토큰값(임의값 사용)
            '&redirect_uri=http://www.seulmeal.shop/user/naver'   // 어플케이션에서 등록했던 CallBack URL를 입력

        // 사용자가 사용하기 편하게끔 팝업창으로 띄어준다.
        window.location.href=uri;
    } 
   
   $("#input-pw").on('keyup', function(e){
       if(e.key==='Enter'||e.keyCode===13){
    	   login();
    	   
       }
   })

   
   
   
   
   function login(){
	   
	   const userId= $("#input-id").val();
	   const password= $("#input-pw").val();

	   $.ajax({
			url: "/user/api/confirmLogin",
			method: "POST",
			data:JSON.stringify({
				 userId : userId,
				 password : password
			}),
			headers : {
	            "Accept" : "application/json",
	            "Content-Type" : "application/json"
	        },
	        dataType : "json",
	        success : function(data){
	        	if(data.result === "success"){
	        		$("#loginForm").submit();
	        		
	        	}
	        	if(data.result === "failId"){
	        		$("#loginCheck").css("color","crimson").text("등록되지 않은 아이디입니다.");
	        		return;
	        	}
	        	if(data.result === "failPassword"){
	        		$("#loginCheck").css("color","crimson").text("비밀번호가 일치하지 않습니다.");
	        		return;
	        	}
	     
	        }
		})		 
		
	}
   
   
 
   
</script>
</body>
</html>