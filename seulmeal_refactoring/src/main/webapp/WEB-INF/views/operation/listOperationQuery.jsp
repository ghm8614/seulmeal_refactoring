<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록</title>
<style type="text/css">
	.psBtn{
		cursor: pointer;
	}
	.psBtn:hover{
		color: #ff4500 !important;
	}
	


.pwWrap {
  width: 80%;
  max-width: 450px;
  background-color:#ff4500;
  margin: 20px auto;
}

.pwWrap .pwSection {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 150px;
}

.pwWrap .pwSection .dot {
  display: block;
  width: 10px;
  height: 10px;
  background: #fff;
  border-radius: 100%;
  margin: 0 5px;
}

.pwWrap .pwSection .dot.active {
  background: #182848;
}

.pwWrap .pwSection .message {
  position: absolute;
  bottom: 5px;
  left: 0;
  z-index: 1;
  min-width: 100%;
  text-align: center;
  font-size: 14px;
  font-weight: bold;
  letter-spacing: -0.03em;
  opacity: 0;
  transition: .2s ease-out;
}

.pwWrap .numberSection {
  overflow: hidden;
}

.pwWrap .numberSection .number {
	color:#fff;
  float: left;
  width: 33.33%;
  border: 1px solid #fff;
  padding: 12px 0;
  cursor: pointer;
  background: #ff4500;
}

.pwWrap .numberSection .number:last-child {
  margin-left: 33.33%;
}

.pwWrap.error .message {
  opacity: 1;
  color: red;
}

.pwWrap.confirm .message {
  opacity: 1;
  color: green;
}

</style>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>


<!-- 
<div aria-live="polite" aria-atomic="true" style="position: relative;">
  <div id="test" class="toast" style="position: absolute; top: 800px; right: 0; z-index: 999;">
    <div class="toast-header">
      <img src="..." class="rounded mr-2" alt="...">
      <strong class="mr-auto">Bootstrap</strong>
      <small>11 mins ago</small>
      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="toast-body">
      Hello, world! This is a toast message.
    </div>
  </div>
</div> -->
	<div class="container">
		<div class="row" style="border-top: thick double #ff4500; border-bottom: thick double #ff4500; margin-bottom: 1rem; margin-top: 2rem;">
			<div class="col-6">
				<h1 class="pt-5 mb-4 fw-bold">문의 목록</h1><h5 class="align-bottom">문의 목록입니다.</h5>				
			</div>
			<div class="dropdown pt-5 mb-4 col-6">		  
			<div class="float-right" style="display:flex;">
			
				<div class="dropdown show">
					<button class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						문의 관련
					</button>					
					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="/operation/getListOperation/3/0/0">답변중인 문의</a>
						<a class="dropdown-item" href="/operation/getListOperation/3/0/1">답변완료 문의</a>
					</div>
				</div>
				
				<form id="searchNotice" action="/operation/getListOperation/3" method="get">
					<div style="display:flex;">
						<div class="form-outline">
							<input type="search" name="searchKeyword" id="searchKeyword" class="form-control" placeholder="내용 혹은 제목을 입력" />
						</div>		  
							<button type="button" class="btn btn-primary">
							<i class="bi bi-search"></i>
						</button>
					</div>
				</form>
			</div>
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
					<th style="display:flex;">
						<c:if test="${user != null && user.role == 1}">
							<a href="/operation/getOperation/${post.postStatus}/${post.postNo}" class="link-dark text-decoration-none">${post.title}</a>
						</c:if>
						<c:if test="${user == null || user.role != 1}">
							<c:if test="${post.answerStatus ==1 }">
								<span style="color:#ff4500;" class="badge badge-light">답변 완료</span>
							</c:if>
							<c:if test="${post.publicStatus ==0}">
								<a href="/operation/getOperation/${post.postStatus}/${post.postNo}" class="link-dark text-decoration-none">${post.title}</a>
							</c:if>
							<c:if test="${post.publicStatus ==1}">
								<div class="psBtn" data-value="${post.postNo}" data-toggle="modal" data-target="#exampleModalCenter">${post.title }<i class="bi bi-lock-fill"></i></div>						
							</c:if>
						</c:if>
						
					</th>
					<th style="font-weight: bolder;">${post.user.userId}</th>
					<th>${post.regDate}</th>
					<th>${post.views}</th>
				</tr>
				</c:forEach>
			</tbody>
		</table>	
		
		<c:if test="${user !=null }">
			<button class="btn btn-primary float-right" onclick="insertQuery()">문의 작성</button>
		</c:if>
		<div class="row">
			<div class="col-md-5"></div>
			<div class="col-md-4">
				<nav aria-label="...">
				  <ul class="pagination">
				  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
				  		<li class="page-item">
				  			<c:if test="${search.searchKeyword ==null }">
				  				<a class="page-link" href="/operation/getListOperation/3/${i}">${i}</a>
				  			</c:if>
				  			<c:if test="${search.searchKeyword !=null }">
				  				<a class="page-link" href="/operation/getListOperation/3/${i}?searchKeyword=${search.searchKeyword}">${i}</a>
				  			</c:if>
				  		</li>
				  	</c:forEach>
				  </ul>
				</nav>
			</div>
		</div>		
	</div>
	
	

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center" id="exampleModalLongTitle">비공개 문의 비밀번호</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<input type="hidden" class="pNo" />
        <div class="pwWrap">
        	<div style="display: flex; justify-content: center; padding-top: 50px; font-size: 20px; color: #fff;">비밀번호</div> 
		    <div class="pwSection" style="padding-bottom: 100px;">		       	
		        <span class="dot"></span>
		        <span class="dot"></span>
		        <span class="dot"></span>
		        <span class="dot"></span>
		        <p class="message">&nbsp;</p>
		    </div>
		    <div class="numberSection">
		        <button class="number">1</button>
		        <button class="number">2</button>
		        <button class="number">3</button>
		        <button class="number">4</button>
		        <button class="number">5</button>
		        <button class="number">6</button>
		        <button class="number">7</button>
		        <button class="number">8</button>
		        <button class="number">9</button>
		        <button class="number">0</button>
		    </div>
		</div>
      </div>
    </div>
  </div>  
</div>
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script type="text/javascript">


	function PwCheck(pw) {
	    const _this = this;	    
	    _this.pwStr = pw.toString(); // 문자, 숫자열을 모두 허용하기 위해 무조건 한가지 타입으로 맞춤
	    _this.password = []; // 지정된 패스워드
	    _this.passwordNumber = []; // 입력할 패스워드
	    _this.cnt = 0; // 입력횟수 체크
	    _this.compChk = false; // 입력완료 체크
	    _this.msg = [
	    ]; 
	
	    _this.parent = document.querySelector('.pwWrap');
	    _this.dots = document.querySelectorAll('.dot');
	    _this.numbers = document.querySelectorAll('.number');
	    _this.message = document.querySelector('.message');
	
	
	    // 비밀번호를 배열에 넣음 
	    _this.getPw = function(){
	        for(let i=0; i<_this.pwStr.length; i++) {
	            _this.password[i] = _this.pwStr[i];
	        }
	    }
	
	    // 숫자버튼 click이벤트 연동
	    _this.handleListener = function(){
	        if(!_this.compChk) {
	            _this.numbers.forEach(function(number){
	                number.addEventListener('click', function(){_this.handleNumber(number)});
	            })
	        }
	    }
	
	    // 숫자키를 눌렀을때 이벤트 
	    _this.handleNumber = function(number){
	        if(!_this.compChk) {
	            _this.passwordNumber[_this.cnt] = number.textContent;
	            _this.handleDotActive(true);
	            
	            _this.cnt++;
	            if(_this.cnt === 4) {
	                _this.handleResult();
	            }
	        }
	    }
	
	    // dot 활성화 
	    _this.handleDotActive = function(type){
	        if(type) {
	            _this.dots.forEach(function(dot, i){
	                if(i === _this.cnt) dot.classList.add('active'); 
	            })
	        } else {
	            _this.dots.forEach(function(dot){
	               dot.classList.remove('active'); 
	            })
	        }
	    }
	
	    // 비밀번호 비교
	    _this.handleCheckPw = function(){
	        let compare = JSON.stringify(_this.password) === JSON.stringify(_this.passwordNumber);
	        return compare; 
	    }
	
	    // 결과처리 
	    _this.handleResult = function(){
	    	let passwordF="";
            for(let i=0; i < this.passwordNumber.length; i++){
            	passwordF += this.passwordNumber[i];
            }
	    	console.log($(".pNo").val());
	    	$.ajax({
				url:"/operation/api/confirmQueryPassword",
				method:"POST",
				data:JSON.stringify({
		            postNo : $(".pNo").val(),
		            password : passwordF,
		            postStatus: 3
		        }),
				headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){
		        	console.log(data)
		        	if(data.result === 'true') {
		        		window.location.href = '/operation/getOperation/3/'+$(".pNo").val();
		        		$(".pNo").val("");
		        	} else {
		        		_this.message.textContent = _this.msg[0];
		        		toastr.error("비밀번호가 틀렸습니다","비공개 게시글",{timeOut:10000})
		        		$("#exampleModalCenter").modal("hide");
		        		$(".pNo").val("");
		        	}
		        }
			})
	    	
	        if(_this.handleCheckPw()) {
	            _this.parent.classList.add('confirm');
	            _this.message.textContent = _this.msg[1];
	            _this.compChk = true;
	            
	            
	            console.log(passwordF)
	        } else {
	            _this.parent.classList.add('error');	            
	            // 입력상태 초기화 
	            _this.passwordNumber = [];
	            _this.cnt = 0; 
	            _this.compChk = true; // 일시적인 클릭 방지 
	            
	            setTimeout(function(){
	                _this.compChk = false;
	                _this.parent.classList.remove('error');
	                _this.handleDotActive();
	            }, 1000);
	        }
	    }
	
	    _this.init = function(){
	        _this.handleListener();
	        _this.getPw();
	    }();
	}
	
	PwCheck(1231231232134);
	
	function searchNotice(){
		const searchKeyword = $("#searchKeyword").val();
		if(searchKeyword == ""){
			alret("검색내용을 입력하세요")
			return;
		}
		$("#searchNotice").submit();
	}	
	
	

	function insertQuery(){
		window.location.href = "/operation/insertOperation/3";
	}
	
	$(function(){
		
		$(".psBtn").on("click",function(){
			const pNo = $(this).data('value');
			$(".pNo").val(pNo);			
		});
		
		$(".psSearch").click(function(){
			
			$.ajax({
				url:"/operation/api/confirmQueryPassword",
				method:"POST",
				data:JSON.stringify({
		            postNo : $(".pNo").val(),
		            password : $(".password").val(),
		            postStatus: 3
		        }),
				headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){
		        	console.log(data)
		        	if(data.result === 'true') {
		        		window.location.href = '/operation/getOperation/3/'+$(".pNo").val();
		        	} else {
		        		alert("비밀번호 틀림");
		        	}
		        }
			})
		})
	})
</script>
</body>
</html>