<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<title>insertUser</title>
</head>
<style>
	 #wrap{
    width:100%;
    height:100%;
}
  
#wrap .box{ 
     width:500px; 
     margin: 0 auto;
  	text-align: center;
}

</style>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>

 <div id="wrap">
 
	
		<div class="box">
	       <h3 style="text-align: center">회원탈퇴</h3>
	      
	    
	    <form>
	    <div class="form-group row">
				<label for="Email3" class="col-sm-6 control-label">회원탈퇴 안내</label>
				<div class="col-sm-6">
					정말 떠나실건가요?
				</div>
			</div>
			 <div class="form-group row">
				<label for="Email3" class="col-sm-6 control-label">비밀번호 확인</label>
				<div class="col-sm-6">
					<input type="password" class="input" id="confirmPassword" placeholder="">
					<div id="passCheck" style="color:crimson;"></div>
				</div>
			</div>
	    
	  
		
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-default">탈퇴</button>
	      <button type="button" onclick="location.href='/'" class="btn btn-default">취소</button>
	    </div>
	  
	  </form>
	  </div>
	</div>
	
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

    <jsp:include page="../layer/footer.jsp"></jsp:include>
</body>
</html>