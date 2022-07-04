<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
      
</script>

<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<title>슬밀 메인</title>
<!-- favicon -->
<link href="/resources/pageFabicon/favicon.ico" rel="icon" type="image/x-icon" />
<link rel="shortcut icon" href="/resources/pageFabicon/favicon.ico" type="image/x-icon" />
<style type="text/css">	
	@charset "UTF-8";

	@font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	body {
		font-family: 'GmarketSansMedium';
		margin:0;
		padding:0;
	}
	
	a:link {
		color: black; 
		text-decoration: none;
	}
	a:visited {
		color:black;
		text-decoration: none;
	}

	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
	
	.text-shadow-1 { text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25); }
	
	.cardProduct{
		transaition : all 0.2s linear;
	}
	
	.productCover:hover{
		transform: scale(1.1);
	}
	
	.card-cover {
		min-width: 400px;
		min-height:400px;
	  background-repeat: no-repeat;
	  background-position: center center;
	  background-size: cover;
	  cursor: pointer;
	  background-color: #0005;
	  background-blend-mode: normal;
	}
	.card-cover:hover{		
		opacity: 0.7;
	  	background-blend-mode: soft-light;		
	}
	
	.card-cover > .text-white > .productTarget{
		display: none;
	}
	
	.card-cover:hover > .text-white > .productTarget{
		display:block;
		color: #fff;
	}
	
	.carousel-control.left, .carousel-control.right {
	    background-image: none
	}

	
	.bi {
		vertical-align: -.125em;
		fill: currentColor;
	}
	
	.text-shadow-1 { 
		text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25);
	}
	
	.card-cover {
		background-repeat: no-repeat;
		background-position: center center;
		background-size: cover;
	}
	
</style>

</head>
<body> <!-- #BAD7DF -->
	<jsp:include page="../layer/header.jsp"></jsp:include>
	<div id="carouselExampleIndicators" class="carousel slide">
	<div class="your-class">
		<div class="carousel-inner">
			<img style="width: 100%; height:600px;" src="/resources/attachments/image/seulMeal.png" alt="">
		</div>
		<c:forEach var="post" items="${listE}">
			<div class="carousel-inner eventBanner"  id="eventBanner"  data-value="${post.postNo}">
				<c:if test="${post.thumnail == null}">
					<img style="width: 100%; height:600px;" src="/resources/attachments/image/tetris.png" alt="">
				</c:if>
				<c:if test="${post.thumnail != null}">
					<img style="width: 100%; height:600px;" src="/resources/attachments/${post.thumnail}" alt="">
				</c:if>
				<div class="carousel-caption d-none d-md-block">
					<h2 class="display-6 fw-bold">${post.title}</h2>
					<h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">${post.shortContent}</h2>
					<h2 class="endDateView">~${post.endDate}</h2>
				</div>
			</div>
		</c:forEach>
	</div>
	</div>
	 
	<main role="main">
	<section class="text-center">
	<div class="container px-4 py-5" id="custom-cards">
    
    
    <!-- ---------------------------------- -->
    <div style="margin-bottom: 30px; color:black;">
    	<c:if test="${!empty user}">
    		<h2 class="pb-2 border-bottom">${user.userName} 님 추천제품</h2>
    	</c:if>
    	<c:if test="${empty user}">
    		<h2 class="pb-2 border-bottom">이 달의 인기 상품</h2>
    	</c:if>
    	
    </div>
    <div class="mainProduct">
	<c:forEach var="product" items="${monthSaleProduct}">
			<div class="col cardProduct">
				<div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg productCover" style="background-image: url('/resources/attachments/${product.THUMBNAIL}');">
					<div class="d-flex flex-column h-100 p-5 pb-0 text-white text-shadow-1">
						<div data-value="${product.PRODUCT_NO}" class="productHref" onclick="getProductPage(this)">
						<h2 class="display-6fw-bold productTarget">${product.NAME}</h2>
						<h4 class="pt-5 mt-5 mb-5 display-6fw-bold"></h4>
						<c:if test="${product.ORIGIN_PRICE != null}">
							<h5 class="productTarget" style="text-decoration: line-through;">${product.ORIGIN_PRICE}원</h5>
						</c:if>						
						<h5 class="productTarget">${product.PRICE}원</h5>
						<h5 class="productTarget">${product.CALORIE}Cal</h5>
						</div>
						<ul class="d-flex list-unstyled mt-auto">
							<li class="me-auto">
								<c:if test="${ !empty user }">
									<i class="bi bi-cart3" style="font-size: 1.5rem;" onclick="window.location.href='/purchase/insertCustomProduct/${product.PRODUCT_NO}'" type="button" class="btn btn-primary">
									</i>
								</c:if>
							</li>
							<li class="d-flex align-items-center me-3">
								<i style="font-size:1.5rem; color:black;" class="bi bi-clipboard-heart-fill"></i>
								&nbsp;<small>${product.REVIEW_COUNT}</small>
							</li>
							<li class="d-flex align-items-center">
								<c:if test="${!empty user}">
									<c:if test="${product.likeStatus == 1}">
										<i style="font-size:1.5rem;" class="bi bi-heart-fill" onclick="updateLikeProduct(this)"></i>
									</c:if>
									<c:if test="${product.likeStatus != 1}">
										<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
									</c:if>
								</c:if>
								<c:if test="${empty user}">
									<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
								</c:if>
								&nbsp;<small class="likeText">${product.LIKE_COUNT}</small>
							</li>
						</ul>
					</div>
				</div>
			</div>			
	</c:forEach>
	</div>
    
    
    
    
    
    <!-- ----------------------------------- -->
    
    <div style="margin-top: 30px; color:black;">
    	<h2 class="pb-2 border-bottom">모든 상품 목록</h2>
    </div>
    
    <div class="row row-cols-1 row-cols-lg-4 align-items-stretch g-4 py-5">
	<c:forEach var="product" items="${list}">		
			<div class="col cardProduct">
				<div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg productCover" style="background-image: url('/resources/attachments/${product.thumbnail}');">
					<div class="d-flex flex-column h-100 p-5 pb-0 text-white text-shadow-1">
						<div data-value="${product.productNo}" class="productHref"  onclick="getProductPage(this)">
						<h2 class="display-6fw-bold productTarget productName">${product.name}</h2>
						<h4 class="pt-5 mt-5 mb-5 display-6fw-bold"></h4>
						<c:if test="${product.originPrice != 0}">
							<h5 class="productTarget originPrice" style="text-decoration: line-through;">${product.originPrice}원</h5>
						</c:if>						
						<h5 class="productTarget price">${product.price}원</h5>
						<h5 class="productTarget calorie">${product.calorie}Cal</h5>
						</div>
						<ul class="d-flex list-unstyled mt-auto">
							<li class="me-auto">
								<c:if test="${ !empty user }">
									<i class="bi bi-cart3" style="font-size: 1.5rem;" onclick="window.location.href='/purchase/insertCustomProduct/${product.productNo}'" type="button" class="btn btn-primary">
									</i>
								</c:if>
							</li>
							<li class="d-flex align-items-center me-3">
								<i style="font-size:1.5rem; color:black;" class="bi bi-clipboard-heart-fill"></i>
								&nbsp;<small>${product.reviewCount}</small>
							</li>
							<li class="d-flex align-items-center">
								<c:if test="${ !empty user }">
									<c:if test="${product.likeStatus==1}">
										<i style="font-size:1.5rem;" class="bi bi-heart-fill" onclick="updateLikeProduct(this)"></i>
									</c:if>
									<c:if test="${product.likeStatus==0}">
										<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
									</c:if>
								</c:if>
								<c:if test="${ empty user }">
									<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>
								</c:if>
								&nbsp;<small class="likeText">${product.likeCount}</small>
							</li>
						</ul>
					</div>
				</div>
			</div>			
	</c:forEach>
    </div>
	</div>
	</section>
	
	
	<!-- pdf
	<object type="application/pdf" data="/resources/attachments/769b4f3c-2996-4de5-9064-aecc40c9216f_StartUMLPdf.pdf" width="100%" height="100%"></object>
	 -->
	<jsp:include page="../chatBot/chatBot.jsp"></jsp:include>
	</main>		
	<jsp:include page="../confirm.jsp"></jsp:include>
	<jsp:include page="../layer/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
<script type="text/javascript">
const $jq = jQuery.noConflict();
$jq(document).ready(function() {
	$jq('.your-class').slick({
		autoplay : true,
		dots : true, /* 하단 점 버튼 */
		speed : 300 /* 이미지가 슬라이딩시 걸리는 시간 */,
		infinite : true,
		autoplaySpeed : 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
		arrows : true,
		slidesToShow : 1,
		slidesToScroll : 1,
		touchMove : true, /* 마우스 클릭으로 끌어서 슬라이딩 가능여부 */
		nextArrows : true, /* 넥스트버튼 */
		/* prevArrows : true,
		arrow : true, */
		fade : false
	});
	
	$jq('.mainProduct').slick({
		  centerMode: true,
		  centerPadding: '60px',
		  arrows : true,
		  //dots: true,
		  autoplay: true,
		  autoplaySpeed: 2000,
		  infinite: true,
		  nextArrows : true,
		  slidesToShow: 3,
		  responsive: [
		    {
		      breakpoint: 768,
		      settings: {
		        arrows: false,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 3
		      }
		    },
		    {
		      breakpoint: 480,
		      settings: {
		        arrows: false,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
		});
});
	
	$(function(){
		$(".searchP").on("keyup",function(){
			filter();
		});
		
				
		$(".eventBanner").on("click",function(){
			const no = $(this).data("value");
			console.log(no)
			window.location.href="/operation/getOperation/2/"+no;
		});
		
		///////////// test 코드////////////
		$("#testJson").on("click",()=>{
			$.ajax({
				url : "/operation/api/jsonTest",
				method : "POST",
				data : JSON.stringify({
					commentNo : 12345,
					testNo : 56789,
					ok : "test"
				}),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
		        success : function(data){
		        	console.log(data);
		        }
			})
		})
	})
	
	function getProductPage(e){
		const no =$(e).data("value");
		window.location.href = '/product/getProduct/'+no;
	}
		
	function updateLikeProduct(e){
		if("${user}" === ""){
			toastr.error("로그인해주세요","로그인해주세요",{timeOut:10000})
			return;
		}
		const no = $(e).parent().parent().parent().find(".productHref").data("value");
		const cl = $(e).next("small");
		///*
		$.ajax({
			url : "/product/api/updateLikeProduct/"+no,
			method : "GET",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	cl.text(data.likeCount);
	        	if(data.result === "Liked"){
	        		$(e).attr("class","bi-heart-fill")
	        	} else {
	        		$(e).attr("class","bi-heart")
	        	}
	        	
	        }
		})
		//*/
	}
	
	
	
	   // 게시글 무한스크롤
	   $(function(){
	      
	      let currentPage = 2;
	      let maxPage = ${resultPage.maxPage};

	      
	      let abc = 1;
	      $(window).scroll(function(){
	         
	         let $window = $(this);
	         let scrollTop = $window.scrollTop();
	         let windowHeight = $window.height();
	         let documentHeight = $(document).height();
	         
	         if(scrollTop + windowHeight+200>= documentHeight && currentPage <= maxPage){
	            setTimeout(getListPost,200);//0.2초
	         }
	         
	            function getListPost(){	               
	               $.ajax({
	                  url:"/api/main?currentPage="+currentPage,
	                  type:"GET",
	                  datatype:"json",
	                  async: false,
	                  success: function(data, status, jqXHR){

	                     for(let i=0; i<data.list.length; i++){
	                    	 const product = data.list[i];
	                    
	                    	 
		                     let productCard = `
			             			<div class="col cardProduct">
			         				<div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg productCover" style="background-image: url('/resources/attachments/\${product.thumbnail}');">
			         					<div class="d-flex flex-column h-100 p-5 pb-0 text-white text-shadow-1">
			         						<div data-value="\${product.productNo}" class="productHref"  onclick="getProductPage(this)">
			         						<h2 class="display-6fw-bold productTarget productName">\${product.name}</h2>
			         						<h4 class="pt-5 mt-5 mb-5 display-6fw-bold"></h4>`
			         						
       						if(product.originPrice != 0){
       							productCard += `<h5 class="productTarget originPrice" style="text-decoration: line-through;">\${product.originPrice}원</h5>`
  							}
			         		
      						productCard +=	`<h5 class="productTarget price">\${product.price}원</h5>
			         						<h5 class="productTarget calorie">\${product.calorie}Cal</h5>
			         						</div>
			         						<ul class="d-flex list-unstyled mt-auto">
			         							<li class="me-auto">
			         								<c:if test="${ !empty user }">
			         									<i class="bi bi-cart3" style="font-size: 1.5rem;" onclick="window.location.href='/purchase/insertCustomProduct/\${product.productNo}'" type="button" class="btn btn-primary">
			         									</i>
			         								</c:if>
			         							</li>
			         							<li class="d-flex align-items-center me-3">
			         								<i style="font-size:1.5rem; color:black;" class="bi bi-clipboard-heart-fill"></i>
			         								&nbsp;<small>\${product.reviewCount}</small>
			         							</li>
			         							<li class="d-flex align-items-center">`
			         		if(product.likeStatus === 1){
			         			productCard += `<i style="font-size:1.5rem;" class="bi bi-heart-fill" onclick="updateLikeProduct(this)"></i>`
			         		} else {
			         			productCard += `<i style="font-size:1.5rem;" class="bi bi-heart" onclick="updateLikeProduct(this)"></i>`
			         		}
			         			productCard += `&nbsp;<small class="likeText">\${product.likeCount}</small>
			         							</li>
			         						</ul>
			         					</div>
			         				</div>
			         			</div>
			                     `
			                     //console.log(productCard)
			                     $(".align-items-stretch").append(productCard)
			                     filter()
	                     }
					
	                     
	                     

	                     
	                     
	                     
	                  }//success
	                  , error: function(status, jqXHR){
	                     console.log("error status: "+ status);
	                     console.log("jqXHR: "+ jqXHR);
	                     alert("페이지 로드 실패");
	                  }
	                  
	               })//jQuery.ajax()
	               
	            currentPage ++;
	            }//getListPost
	            
	      })//window.scroll()
	      
	      
	   });
	   
	   
	   
	   //검색 필터
	   // 메인페이지 검색
	   function filter(){
			const search = $(".searchP").val();
			const cardCom = $(".align-items-stretch .text-shadow-1")
						
			for(let i=0; i<cardCom.length; i++){				
				
				title = $(cardCom[i]).find(".productName");
				calorie = $(cardCom[i]).find(".calorie");
				price = $(cardCom[i]).find(".price");
				originPrice = $(cardCom[i]).find(".originPrice");
				
				//console.log($(cardCom[i]).parent().parent())
				//console.log($(cardCom[i]).find(".productName"))
				
				if($(title[0]).text().indexOf(search) != -1 || $(calorie[0]).text().indexOf(search) != -1
						|| $(price[0]).text().indexOf(search) != -1 || $(originPrice[0]).text().indexOf(search) != -1){
					$(cardCom[i]).parent().parent().css("display","block");
				} else {
					$(cardCom[i]).parent().parent().css("display","none");
				}
				
			}
		}
	
</script>
</body>
</html>