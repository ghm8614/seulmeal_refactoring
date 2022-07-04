<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품 할인 목록</title>
<style type="text/css">
</style>

</head>
<body style="background-color: #fff;">

<jsp:include page="../layer/header.jsp"></jsp:include>	
	<br/>
	<div class="container">
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold">할인 품목</h1>
			</div>			
		</div>			
    </div>
    
    
	<div class="container">
				<div class="row">
					<c:forEach var="post" items="${list}">
						<div class="col-6" style="padding:10px;">
							<table class="table table-hover text-center">
								<thead style="background-color: #ff4500; color: #fff;">
									<tr>
										<th>제목</th>
										<th>할인률</th>
										<th>상품/가격</th>
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
									<tr>
										<th rowspan="5" style="justify-content: center;">
											<a href="/operation/getOperation/2/${post.postNo}" class="link-dark text-decoration-none">${post.title}</a>
										</th>
										<th style="font-weight: bolder;">${post.discount}</th>
										<c:forEach var="product" items="${post.discountProduct}">
											<c:if test="${product.productNo !=0}">
												<th style="display:flex; justify-content: space-between;">
													<div style="display:flex; justify-content: space-between;">
														<div>${product.name}</div>
														<div class="deleteEventProduct" data-value="${product.productNo}">x</div>
													</div>
													<div>${product.price}</div>
												</th>
											</c:if>
										</c:forEach>										
									</tr>									
								</tbody>
							</table>
						</div>			
					</c:forEach>
				</div>
	</div>
	<jsp:include page="../layer/footer.jsp"></jsp:include>
	<jsp:include page="../chatBot/chatBot.jsp"></jsp:include>	

	
<script type="text/javascript">
	$(function(){
		$(".deleteEventProduct").on("click",function(){
			const target = $(this)
			const targetName = $(this).prev().text();
			const no =$(this).data("value");
			console.log(no)
			
			$.ajax({
				url:"/operation/api/delectEventProduct",
				method:"POST",
				data:JSON.stringify({
		            productNo : no
		        }),
				headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){
		        	console.log(data)
		        	if(data.result === 'true') {
		        		target.parent().parent().remove();
		        		toastr.error(`\${targetName}`,"삭제되었습니다.",{timeOut:10000})
		        	} else {
		        		alert("삭제실패");
		        	}
		        }
			})
			
			
			
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
		
	
	
</script>
</body>
</html>