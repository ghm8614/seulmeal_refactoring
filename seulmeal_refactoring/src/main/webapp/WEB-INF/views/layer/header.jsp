<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- jquery/js-->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<!-- 
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
 -->

<!-- bootStrap/js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<!-- summernote -->
<script src="/resources/javascript/summernote/summernote-lite.js"></script>
<script src="/resources/javascript/summernote/lang/summernote-ko-KR.js"></script>

<!-- slick -->
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- toastr -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- kakao -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
 
<!-- jquery -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<!-- bootStrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<!-- bootStrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

<link rel="stylesheet" href="/resources/css/body.css">

<!-- slick -->
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />

<style>

	.toast {
		opacity: 1 !important;
	}
			
	.toast-title {
		color:crimson;
	}
	.toast-message {		
		color:crimson;	
		font-size: 100%;
	}  
	.header{
		transition: background 0.6s;
		text-align: center;	
	}	
	
	.navbar.fixed {
		z-index: 100;
		position: fixed;
		left: 0;
		top: 0;
		width: 100%;
	}
	
	ul.nav li.dropdown:hover > ul.dropdown-menu { display:block; margin:0; }
</style>
	<!-- 어드민 -->
	<!-- 
	<c:if test="${user.role == 1}">
		<div style="display:flex; justify-content:space-between;">
			<h3>오늘 할일</h3>
			<h4>신규 주문</h4>
			<h4>교환/반품 승인</h4>
			<h4><a href="/community/getListReportPost">게시글 신고</a></h4>
			<h4>재고 소진</h4>
			<h4>문의 답변대기</h4>
		</div>
	</c:if> -->
	<c:if test="${prevPage !='admin'}">

	<div class="header" style="background:#fff; padding-top:10px; ">
	<div style="display:flex; justify-content:right; margin-left:10px; margin-right:10px;">
		
	    <div class="float-right" style="margin-right: 30px; padding-top:10px;">
        	
        	<c:if test="${ empty user }">
        		<button type="button" class="btn btn-outline-primary me-2" onclick="login()" style="border:none;">로그인</button>
	        	<button type="button" class="btn btn-primary" onclick="join()">회원가입</button>
        	</c:if>
        	
        	<c:if test="${ !empty user }">
        		<div class="dropdown show">
					<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<c:if test="${user.profileImage == null}">
							<img src="https://github.com/mdo.png" alt="hugenerd" width="30" height="30" class="rounded-circle">
						</c:if>
						<c:if test="${user.profileImage != null}">
							<img src="/resources/attachments/profile_image/${user.profileImage}" alt="hugenerd" width="30" height="30" class="rounded-circle">
						</c:if>
	               		<span class="d-none d-sm-inline mx-1" style="color:black;">${user.userName}</span>					
					</a>					
					<div class="dropdown-menu dropdown-menu-right text-small shadow" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="/user/getUpdateUser/${user.userId}">내 정보</a>
						<a class="dropdown-item" href="/user/listUserPoint/1">내 포인트</a>
						<a class="dropdown-item" href="/purchase/getListCustomProduct/1">내 장바구니</a>
						<a class="dropdown-item" href="/purchase/getListPurchase">내 구매내역</a>
						<a class="dropdown-item" href="/community/getProfile/${user.userId}">내 게시글</a>
						<a class="dropdown-item" href="/product/listLikeProduct/1">찜 목록</a>
						<c:if test="${user.role == 1}">
							<a class="dropdown-item" href="/admin">관리자페이지</a>
						</c:if>
							<a class="dropdown-item" href="/user/logout">로그아웃</a>
					</div>
				</div>		
        	</c:if>        	

        	
      	</div>
	</div>
	</div>
	<nav class="navbar navbar-expand-lg navbar-light" style="background:#fff;">		
	  <div class="container-fluid">
	    <a class="navbar-brand" href="/"><img style="margin-top:10px; width: 80px;" src="/resources/attachments/image/logo.jpeg"></a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav" style=" display: flex; justify-content: space-between;">
	      <ul class="navbar-nav nav">
	      	<li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle headerNav" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	           전체카테고리
	          </a>
	          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
	          	<c:forEach var="foodcategory" items="${fList}">
	          		<li><a class="dropdown-item" href="/product/listProduct/1/${foodcategory.foodCategoryNo}">${foodcategory.name}</a></li>
				</c:forEach>
	          </ul>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active headerNav" aria-current="page" href="/product/listProduct/1">신상품</a>
	        </li>
	        <li class="nav-item">
	        <c:if test="${user.blackListStatus==1 }">
	        <a class="nav-link headerNav" href="#" id="blackUser">게시판</a>
	       </c:if>
	       <c:if test="${user.blackListStatus ==0 }">
	        <a class="nav-link headerNav" href="/api/v1/community/">게시판</a>
	       </c:if>
	       
	          
	        </li>
	        <li class="nav-item">
	          <a class="nav-link headerNav" href="/operation/getListOperation/2/0/0">특가/이벤트</a>
	        </li>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle headerNav" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            고객센터
	          </a>
	          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
	            <li><a class="dropdown-item" href="/operation/getListOperation/1">공지사항</a></li>
	            <li><a class="dropdown-item" href="/operation/getListOperation/3">문의관리</a></li>
	          </ul>
	        </li>
	      </ul>
	      
	
	      <!-- 검색창 -->
		<form class="searchProduct" >
			<div style="display:flex;">	
				<div class="form-outline" style="margin-top: 5px;">
					<input name="searchKeyword" type="search" class="form-control searchP" placeholder="원하는 상품 검색" id="searchProductInput" value="${search.searchKeyword}" />
				</div>		  
				<button style="font-size: 20px;"  type="button" class="btn btn-primary" >
					<i class="bi bi-search" onclick="searchProduct(this)"></i>
				</button>
				<c:if test="${ !empty user }">
					<button style="font-size: 25px;" onclick="window.location.href='/purchase/getListCustomProduct/1'" type="button" class="btn btn-primary">
						<i style="" class="bi bi-cart3"></i>
					</button>
				</c:if>				
				<button style="font-size: 20px;" onclick="sendLink()" type="button" class="btn btn-primary">
					<img style="width: 30px; height: 30px;" src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" />
				</button>								
			</div>
		</form>
				
	    </div>
	           
	  </div>
	</nav> 
	


<script>
    Kakao.init("5a91dcc078a5d95d570495f33c363abb"); 
    function sendLink() {
    	console.log("${url}")
      Kakao.Link.sendCustom({
        templateId: 78625, 
        templateArgs: {
        	<c:if test="${empty product}">
        		title: "SeulMeal MealKit",
        	</c:if>
        	<c:if test="${!empty product}">
	    		title: "${product.name}",
	    	</c:if>   
          description: "커스텀이 가능한 슬밀 밀키트 몰입니다.",
			<c:if test="${!empty product}">
				imageUrl: "http:www.seulmeal.shop/resources/attachments/${product.thumbnail}",
			</c:if> 
          url : "${url}",
        },
      });
    }
</script>
<script type="text/javascript">	
	window.onload = function(){
		toastShow("t","1");
	}

	function toastShow(title, content){
		toastr.options.escapeHtml = true; // [escapeHtml 허용여부]
		toastr.options.closeButton = true; // [closeButton을 생성여부]
		toastr.options.progressBar = true;
		toastr.options.positionClass = "toast-top-full-width";
		
		
	}
	/*
	$("#searchProduct223").on("click",(e)=>{
		$(".searchProduct").submit();		
	})

	$(".searchP").on("keyup",(e)=>{
		console.log(e.keyCode === 13)
		if(e.keyCode === 13){
			$("#searchProduct").submit();
		}
	})
	*/
	
	
	function searchProduct(e){
		console.log($(e).parent().prev().find(".form-control").val())
		const search = $(e).parent().prev().find(".form-control").val()
		
		let url = "/product/listProduct/1";
		if('${searchCondition}' !== ''){
			url += "/${searchCondition}";
		}
		
		if(search !== ''){
			window.location.href = `/product/listProduct/1?searchKeyword=\${search}`
		}
		
	}
	
	$(function(){
		$("#searchProductInput").on("keyup",(e)=>{
			const searchKey = $("#searchProductInput").val();
			
			if(e.keyCode ===13 && searchKey !== ''){
				console.log(searchKey)
				window.location.href = `/product/listProduct/1?searchKeyword=\${searchKey}`
			}
		})
	})
	
	$(()=>{
		
		
		$("#blackUser").on("click",()=>{
			alert("당신은 블랙유저 입니다.");
		})
	})
	
	function join(){
		window.location.href = '/user/insertUser';
	}
	
	function login(){
		window.location.href = '/user/login';
	}
	
	const nav = $(".navbar").offset().top;
	
	$(window).scroll(function(){
		const window = $(this).scrollTop();
		
		if(nav <= window){
			$(".navbar").addClass("fixed");
		} else {
			$(".navbar").removeClass("fixed");
		}
	})
	
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	})
</script>	    
</c:if>