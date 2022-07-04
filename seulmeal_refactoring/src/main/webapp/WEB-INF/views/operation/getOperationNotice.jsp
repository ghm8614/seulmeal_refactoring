<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세정보</title>
<style type="text/css">
	.closetPost:hover{
		color:#fff !important;
	}
</style>
</head>
<body>
	<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="container">
		<div class="row" style="margin-top:20px;">			
			<div class="col-md-12">
				<div class="row" style="min-height:40px; border-bottom: 2px double #ff4500;">
					<div class="col-md-3 text-center" style="background-color:#ff4500; color:#fff; padding-top:10px;">제목</div>
					<div class="col-md-9" style="padding-top:10px;">${post.title}</div>
				</div>
				<div class="row" style="min-height:40px; border-bottom: 2px double #ff4500;">
					<div class="col-md-3 text-center" style="background-color:#ff4500; color:#fff; padding-top:10px;">작성자</div>
					<div class="col-md-9" style="padding-top:10px;">${post.user.userId}</div>
				</div>
				<div class="row" style="min-height:40px; border-bottom: 2px double #ff4500;">
					<div class="col-md-3 text-center" style="background-color:#ff4500; color:#fff; padding-top:10px;">작성일</div>
					<div class="col-md-3" style="padding-top:10px;">${post.regDate}</div>
					<div class="col-md-3 text-center" style="background-color:#ff4500; color:#fff; padding-top:10px;">조회수</div>
					<div class="col-md-3" style="padding-top:10px;">${post.views}</div>
				</div>
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="row justify-content-end">
		        	<div class="col-1">
		        		<c:if test="${post.attachments.size() !=0}">
			        		<div class="dropdown show">
								<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="d-none d-sm-inline mx-1" style="color:black;">첨부파일</span>					
								</a>					
								<div class="dropdown-menu dropdown-menu-right dropdown-menu-dark text-small shadow" aria-labelledby="dropdownMenuLink">
									<c:forEach var="attachments" items="${post.attachments}">		          	
						            	<a class="dropdown-item" href="/download/${attachments.attachmentName}">${attachments.attachmentName }</a>
						            </c:forEach>
								</div>
							</div>
						</c:if>
		        	</div>		
		        </div>				
			</div>
			<div class="row" style="min-height:700px;">
				<div class="col-md-10" style="margin-left:2.5%; margin-top: 20px;">
						${post.content}
				</div>
			</div>
			<div class="col-md-12">
				<div class="row" style="border-bottom: 2px double #ff4500; border-top: 2px double #ff4500; justify-content: flex-end;">					
					<span style="margin-bottom:10px; margin-top:10px;">
						<c:if test="${user.role == 1}">							
							<c:if test="${user.userId == post.user.userId}">
								<input class="btn btn-primary" style="margin-right:10px; width: 60px;" value="삭제" onclick="deleteNotice()">
							</c:if>
							<input class="btn btn-primary" style="margin-right:10px; width: 60px;" value="수정" onclick="updateNotice()">
						</c:if>
						<input class="btn btn-primary" style="width: 60px;" value="목록" onclick="cancelNotice()">
					</span>						
				</div>
				<div class="row" style="border-bottom: 2px double #BAD7DF;">
					<div class="col-md-12" style="background-color:#ff4500; color:#fff;">
						<div class="row">
							<div class="col-md-1">다음글</div>
							<div>
								<c:if test="${post.npost !=null}">
									<a class="closetPost" href="/operation/getOperation/1/${post.npost.postNo}">${post.npost.title}</a>
								</c:if>
								<c:if test="${post.npost ==null}">
									<div class="closetPost" >마지막 글 입니다.</div>
								</c:if>
							</div>
						</div>
					</div>
					<div class="col-md-12" style="background-color:#ff4500; color:#fff;">
						<div class="row">
							<div class="col-md-1">이전글</div>
								<c:if test="${post.bpost !=null}">
									<a class="closetPost" href="/operation/getOperation/1/${post.bpost.postNo}">${post.bpost.title}</a>
								</c:if>
								<c:if test="${post.bpost ==null}">
									<div class="closetPost" >마지막 글 입니다.</div>
								</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
	function updateNotice(){
		window.location.href = '/operation/updateOperation/1/${post.postNo}';
	}
	
	function cancelNotice(){
		window.location.href = '/operation/getListOperation/1';
	}
	
	function deleteNotice(){
		
		$.ajax({
			url : "/operation/api/deleteOperation",
			method : "POST",
			data : JSON.stringify({
				postNo : ${post.postNo},
				postStatus : ${post.postStatus}
			}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	window.location.href = '/operation/getListOperation/1';
	        }
		})
		
	}
</script>
</body>
</html>