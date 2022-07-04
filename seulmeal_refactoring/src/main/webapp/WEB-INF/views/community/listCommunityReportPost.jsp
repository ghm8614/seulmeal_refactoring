<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고게시글 목록</title>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>

	<div class="container">
		
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold">신고게시글</h1>
			</div>
			<div class="dropdown pt-5 mb-4 col-6">
			
		</div>
		</div>			
		<table class="table table-hover text-center">
			<thead style="background-color: #ff4500; color: #fff;">
				<tr>
					<th>신고날짜</th>
					<th>신고한 유저 ID</th>
					<th>신고당한 게시글 ID</th>
					<th>신고 사유</th>
					<th>답변상태</th>
					<th>삭제하기</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${reportList.size() == 0}">
					<tr>
						<td colspan="5" style="font-size: 100px;">							
							<i class="bi bi-chat-left-dots"></i>
							<div>글이 없습니다</div>						
						</td>
					</tr>					
				</c:if>
				<c:forEach var="report" items="${reportList}">
				<tr>
					<th>${report.regDate}</th>
					<th>${report.reporterId}</th>
					<th class="postNo"><a href="/community/getPostAdmin/${report.postNo}" class="link-dark text-decoration-none">${report.postNo}</a></th>					
					<th>
						${report.reason}
					</th>
					<th class="status" style="font-weight: bolder;">
						<c:if test="${report.status==0}">
							답변전
						</c:if>
						<c:if test="${report.status==1}">
							답변완료
						</c:if>
					</th>
					<c:if test="${report.status==0}">
						<th style="cursor: pointer;" onclick="deleteReportPost(this)">삭제</th>
					</c:if>	
					<c:if test="${report.status==1}">
						<th>삭제완료</th>
					</c:if>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<hr/>
		<div class="row" style="justify-content : center;">
			<nav aria-label="...">
			  <ul class="pagination">
		  		<li class="page-item disabled">
			      <span class="page-link" data-value="1">Previous</span>
			    </li>
			  	<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
			  		<li class="page-item">
			  			<c:if test="${search.searchKeyword ==null }">
			  				<a class="page-link" href="/community/getListReportPost/${i}">${i}</a>
			  			</c:if>
			  			<c:if test="${search.searchKeyword !=null }">
			  				<a class="page-link" href="/community/getListReportPost/${i}?searchKeyword=${search.searchKeyword}">${i}</a>
			  			</c:if>
			  		</li>
			  	</c:forEach>
			  	<li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>
	
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">
	function deleteReportPost(e){
		const no = $(e).parent().find(".postNo").text()
		
		$.ajax({
			url : "/community/api/deleteReportPost/"+no,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data,status){
	        	$(e).parent().find(".status").text("답변완료");
	        	$(e).text("삭제완료");
	        	$(e).css("cursor","");
	        	$(e).attr("onClick","")
	        }
		})
	}

	function searchNotice(){
		const searchKeyword = $("#searchKeyword").val();
		if(searchKeyword == ""){
			alret("검색내용을 입력하세요")
			return;
		}
		$("#searchNotice").submit();
	}

</script>
</body>
</html>