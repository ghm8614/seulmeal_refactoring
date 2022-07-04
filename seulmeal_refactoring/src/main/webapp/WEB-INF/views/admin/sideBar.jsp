<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../../resources/css/body.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<meta charset="UTF-8">
<style type="text/css">
	a{
		color: #fff !important;
		font-weight: bold;
	}
</style>
<title>관리자 사이드 바</title>
</head>
<body>	
	<div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0" style="position:fixed; background-image: linear-gradient(-60deg, #ff7000 0%, #ff4500 78%);">
	    <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100" >
	        <a href="/ ${prevPage}" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	            <span class="fs-5 d-none d-sm-inline">seulMeal</span>
	        </a>
	        <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
	            <li class="nav-item">
	                <a href="/admin" class="nav-link align-middle px-0">
	                    <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">Admin</span>
	                </a>
	            </li>
	            <li>
	                <a href="#submenu1" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
	                    <i class="fs-4 bi-speedometer2"></i> <span class="ms-1 d-none d-sm-inline">User</span> </a>
	                <ul class="collapse nav flex-column ms-1" id="submenu1" data-bs-parent="#menu">
	                    <li class="w-100">
	                        <a href="#" class="nav-link px-0" id="userList"> <span class="d-none d-sm-inline">모든 유저</span></a>
	                    </li>
	                </ul>
	            </li>
	            <li>
	                <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
	                    <i class="fs-4 bi-table"></i> <span class="ms-1 d-none d-sm-inline">Product</span></a>
	                <ul class="collapse nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">
	                    <li class="w-100">
	                        <a href="#" class="nav-link px-0" id="productList"> <span class="d-none d-sm-inline">판매 상품</span></a>
	                    </li>
	                    <li>
	                        <a href="#" class="nav-link px-0" id="partsList"> <span class="d-none d-sm-inline">판매 재료</span></a>
	                    </li>
	                    <li>
	                        <a href="#" class="nav-link px-0" id="foodCategoryList"> <span class="d-none d-sm-inline">음식카테고리</span></a>
	                    </li>
	                    <li>
	                        <a href="#" class="nav-link px-0" id="reviewList"> <span class="d-none d-sm-inline">리뷰관리</span> 2</a>
	                    </li>
	                </ul>
	            </li>
	            <li>
	                <a href="#submenu3" data-bs-toggle="collapse" class="nav-link px-0 align-middle ">
	                    <i class="fs-4 bi-bootstrap"></i> <span class="ms-1 d-none d-sm-inline">Community</span></a>
	                <ul class="collapse nav flex-column ms-1" id="submenu3" data-bs-parent="#menu">
	                    <li class="w-100">
	                        <a href="#" class="nav-link px-0" id="reportPost"> <span class="d-none d-sm-inline">신고 게시글</span> 1</a>
	                    </li>	                    
	                </ul>
	            </li>
	            <li>
	                <a href="#submenu4" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
	                    <i class="fs-4 bi-grid"></i> <span class="ms-1 d-none d-sm-inline">Purchase</span> </a>
	                    <ul class="collapse nav flex-column ms-1" id="submenu4" data-bs-parent="#menu">
	                    <li class="w-100">
	                        <a href="#" class="nav-link px-0" id="sale"> <span class="d-none d-sm-inline">판매내역</span> 1</a>
	                    </li>	                    
	                    <li>
	                        <a href="#" class="nav-link px-0" id="discount"> <span class="d-none d-sm-inline">할인관리</span> 2</a>
	                    </li>
	                </ul>
	            </li>
	            <li>
	                <a href="#submenu5" data-bs-toggle="collapse" class="nav-link px-0 align-middle">
	                    <i class="fs-4 bi-grid"></i> <span class="ms-1 d-none d-sm-inline">Operation</span> </a>
	                    <ul class="collapse nav flex-column ms-1" id="submenu5" data-bs-parent="#menu">
	                    <li class="w-100">
	                        <a href="#" class="nav-link px-0" id="notice"> <span class="d-none d-sm-inline">공지사항</span> 1</a>
	                    </li>
	                    <li>
	                        <a href="#" class="nav-link px-0" id="event"> <span class="d-none d-sm-inline">이벤트</span> 2</a>
	                    </li>
	                    <li>
	                        <a href="#" class="nav-link px-0" id="query"> <span class="d-none d-sm-inline">문의답변</span> 3</a>
	                    </li>
	                </ul>
	            </li>
	        </ul>
	        <hr>
	        <div class="dropdown pb-4">
	            <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
	                <img src="https://github.com/mdo.png" alt="hugenerd" width="30" height="30" class="rounded-circle">
	                <span class="d-none d-sm-inline mx-1">${user.userId}</span>
	            </a>
	            <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
	                <li><a class="dropdown-item" href="#">Profile</a></li>
	                <li>
	                    <hr class="dropdown-divider">
	                </li>
	                <li><a class="dropdown-item" href="/user/logout">로그아웃</a></li>
	            </ul>
	        </div>
	    </div>
	</div>	        
</body>
</html>