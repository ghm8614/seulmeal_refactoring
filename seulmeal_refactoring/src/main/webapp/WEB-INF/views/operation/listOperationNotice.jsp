<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>


	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold">공지사항</h1>
			</div>
			<div class="dropdown pt-5 mb-4 col-6">
			<form id="searchNotice" action="/operation/getListOperation/1" method="get">
				<div class="float-right" style="display:flex;">
					<div class="form-outline">
						<input type="search" placeholder="검색내용을 입력하세요" name="searchKeyword" id="searchKeyword" class="form-control" />
					</div>		  
						<button type="button" class="btn btn-primary">
						<i class="bi bi-search"></i>
					</button>
				</div>
			</form>
		</div>
		</div>			
		<table class="table table-hover text-center">
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${list.size() == 0}">
					<tr>
						<td colspan="5" style="font-size: 100px;">							
							<i class="bi bi-chat-left-dots"></i>
							<div>글이 없습니다</div>						
						</td>
					</tr>					
				</c:if>
				<c:forEach var="post" items="${list}">
				<tr>
					<th>${post.postNo}</th>
					<th>
						<a href="/operation/getOperation/1/${post.postNo}" class="link-dark text-decoration-none">${post.title}</a>
					</th>
					<th style="font-weight: bolder;">${post.user.userId}</th>
					<th>${post.regDate}</th>
					<th>${post.views}</th>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<hr/>
		<c:if test="${user.role == 1}">
			<div class="seulBtn" onclick="insertNotice()" style="float: right;">공지 작성</div>
		</c:if>
		<jsp:include page="../common/pageNavigator_new.jsp"/>
	</div>
	
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
	function searchNotice(){
		const searchKeyword = $("#searchKeyword").val();
		if(searchKeyword == ""){
			alret("검색내용을 입력하세요")
			return;
		}
		$("#searchNotice").submit();
	}

	function insertNotice(){
		window.location.href = "/operation/insertOperation/1";
	}
</script>
</body>
</html>