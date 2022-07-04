<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>회원 목록</title>
<style type="text/css">
	#blackList{
		color:#fff !important;
	}
	#blackList:hover{
	color: #ff4500 !important;
	}
	
	.float-right{
	margin: 50px 10px 0px 10px;
	
	} 
	
</style>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="container">
	<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-8">
				<h1 class="pt-5 mb-4 fw-bold">회원목록</h1>
			</div>
			<form method="get" action="/user/listUser/0/0">
				<div class="float-right" style="display: flex;"><!--style="display: flex;"  -->
					<div class="form-outline">
						<input type="search" id="form1" class="form-control" name="searchKeyword" placeholder="아이디 or 이름" />
					</div>
					<button type="submit" class="btn btn-primary">
						<i class="bi bi-search"></i>
					</button>
				</div>
			</form> 
		</div>
		
		
		<table class="table table-hover text-center">
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>닉네임</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${list}">
				<tr>
					<th><a href="/user/getUser/${user.userId}" class="link-dark text-decoration-none">${user.userId}</a></th>
					<th>${user.userName}</th>
					<th>${user.nickName}</th>
				</tr>
				</c:forEach>
			</tbody>
			
		</table>
		<hr/>
		
	</div>
	<div class="container">
	<div class="row">		<div class="col-md-3"></div>
		<div class="col-md-6">
			<nav aria-label="...">
			  <ul class="pagination">
		  		<li class="page-item disabled">
			      <span class="page-link" data-value="1">Previous</span>
			    </li>
			  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
			  		<li class="page-item"><a class="page-link" href="/user/listUser/${i}">${i}</a></li>
			  	</c:forEach>
			  	<li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>	
</div>

<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
function blackList(){
	
	
	$.ajax({
		url: "/user/api/listBlackList",
		method: "GET",
		headers : {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        dataType : "json",
        success : function(data){
        	console.log(data);
        	
        	
        	
        }
	})		
}

</script>
</body>
</html>