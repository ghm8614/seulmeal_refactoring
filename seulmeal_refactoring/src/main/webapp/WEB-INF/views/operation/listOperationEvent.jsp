<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
<style type="text/css">
	
	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
	
	.text-shadow-1 { text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25); }
	
	.card-cover {
	  background-repeat: no-repeat;
	  background-position: center center;
	  background-size: cover;
	  color:none !important;
	  cursor: pointer;
	  transform: scale(1.1);
	}
	
	.cdCol{
		transaition : all 0.2s linear;
	}
	
	.card-cover:hover{
		transform: scale(1.2);
	}
	
	.cardComponet{
		opacity:1;
	}
	
	.cardComponet:hover{
		opacity:0.7;
	}
	
</style>

</head>
<body style="background-color: #fff;">

<jsp:include page="../layer/header.jsp"></jsp:include>	
	<br/>
	<div class="container">
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold">이벤트</h1>
			</div>
			
			<div class="dropdown pt-5 mb-4 col-6">
			
			<div class="float-right" style="display:flex;">
				<div class="dropdown">
					<div class="dropdown show">
						<button class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							이벤트 목록
						</button>					
						<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<a class="dropdown-item" href="/operation/getListOperation/2/0/0">진행중인 이벤트</a>
							<a class="dropdown-item" href="/operation/getListOperation/2/0/1">종료된 이벤트</a>
							<a class="dropdown-item" href="/operation/getListOperation/2">모든 이벤트</a>
							<c:if test="${user.role == 1}">
								<a class="dropdown-item" href="/operation/insertOperation/2">이벤트 등록</a>
							</c:if>
						</div>
					</div>			
				</div>
				<div class="form-outline">
					<input type="search" placeholder="검색내용을 입력하세요" name="searchKeyword" id="searchKeyword" onkeyup="filter()" class="form-control" />
				</div>
			</div>
		</div>
		</div>			
    </div>
    
    
	<div class="container">
		<div class="container px-4 py-5" id="custom-cards">	
			
			<c:forEach var="post" items="${list}">	
				<div class="row row-cols-1 row-cols-lg-10 align-items-stretch g-4 py-3 cardComponet">
					<div class="col cdCol" style="overflow: hidden;">
						<div data-value="${post.postNo}" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('/resources/attachments/${post.thumnail}');">						
							<div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
								<h2 class="display-6 fw-bold title">${post.title}</h2>
								<h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold shortContent">${post.shortContent}</h2>
								<h2 class="endDateView">~${post.endDate}</h2>
								<div style="display:flex; justify-content:space-between;">
									<ul class="d-flex list-unstyled mt-auto">			
									</ul>
									<ul class="d-flex list-unstyled mt-auto">
										<li class="d-flex align-items-center me-3" style="font-size:1.5rem; margin-right:5px;">
											<i class="bi bi-emoji-heart-eyes"></i><br/>
											<small>&nbsp;${post.views}</small>
										</li>
										<li class="d-flex align-items-center"  style="font-size:1.5rem; margin-left:5px;">
											<i class="bi bi-calendar-date"></i>
											<small>&nbsp;${post.endDate}</small>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>		
	</div>
	<jsp:include page="../layer/footer.jsp"></jsp:include>
	<jsp:include page="../chatBot/chatBot.jsp"></jsp:include>	

	
<script type="text/javascript">
	$(function(){
		$(".card-cover").on("click",function(){
			const no =$(this).data("value");
			window.location.href = '/operation/getOperation/2/'+no;
		});
		
		$("#searchEventBtn").on("click",function(){
			const searchKeyword = $("#searchKeyword").val();
			if(searchKeyword == ""){
				alert("검색내용을 입력하세요")
				return;
			}
			$("#searchEvnet").submit();
		});
	})
		
	function searchEvent(){
		const searchKeyword = $("#searchKeyword").val();
		if(searchKeyword == ""){
			alert("검색내용을 입력하세요")
		}
		$("#searchEvnet").submit();
	}
	
	function insertEvent(){
		window.location.href = '/operation/insertOperation/2';
	}
	
	
	function filter(){
		const search = $("#searchKeyword").val();
		const cardCom = $(".text-shadow-1")
		
		
		for(let i=0; i<cardCom.length; i++){
			title = $(cardCom[i]).find(".title");
			shortContent = $(cardCom[i]).find(".shortContent");
			endDate = $(cardCom[i]).find(".endDateView");

			if($(title[0]).text().indexOf(search) != -1 || $(shortContent[0]).text().indexOf(search) != -1 || $(endDate[0]).text().indexOf(search) != -1){
				$(cardCom[i]).parent().parent().parent().css("display","flex");
			} else {
				$(cardCom[i]).parent().parent().parent().css("display","none");
			}
			
		}
	}
	
</script>
</body>
</html>