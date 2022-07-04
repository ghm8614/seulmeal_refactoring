<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>seulMeal ChatBot</title>    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.0/sockjs.min.js" integrity="sha512-ksHM9XpigYGeRdXZfI4GddPsUjmLj6zd1MCNXL4fsfDwp1G+u6hC73uwDjlpjdX4tbEtj/N1AWkLo6WjDwQkyA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<style>
body {
    background-color: #f5f5f5;
}

#main-content {
    max-width: 940px;
    padding: 2em 3em;
    margin: 0 auto 20px;
    background-color: #fff;
    border: 1px solid #e5e5e5;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
}

.sideBanner {
	  position: absolute;
	  width: 100px;
	  height: 100px;
	  top: 50px;
	  background-image: url('/resources/attachments/image/free-icon-chatbot-2040946.png');
	  color: #fffffff;
	  margin-top:500px;
	  background-repeat: no-repeat;
	  background-position: center center;
	  background-size: cover;
	  border-radius: 100%;
	}

.floating-menu { right: 50px; top: 50%; z-index: 100; margin: -120px 0 0 0;}

.footer { height: 100px; background-color: #707070;}

	.bi-caret-up-fill,
	.bi-caret-down-fill{
         font-size: 40px;
         line-height: 40px;
         color:#FF4500;
     }

</style>
<body>

<div style="display:flex; justify-content:space-between; margin-left:90%;">

	<div class="sideBanner psBtn" >
		<!-- <span class="txt-label">
			seulMeal 챗봇
		</span>
	</div> -->
</div>

<div id="ps" style="display:none;">
<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being
    enabled. Please enable
    Javascript and reload this page!</h2></noscript>
<div id="main-content" class="container">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="connect">웹소켓 연결:</label>
                    <button id="connect" class="btn btn-default" type="submit">연결</button>
                    <button id="disconnect" class="btn btn-default" type="submit" disabled="disabled">해제
                    </button>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="msg">문의사항</label>
                    <input type="text" id="msg" class="form-control" placeholder="내용을 입력하세요....">
                </div>
                <button id="send" class="btn btn-default" disabled type="submit">보내기</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>메세지</th>
                </tr>
                </thead>
                <tbody id="communicate">
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
	var stompClient = null;
	
	function setConnected(connected) {
	    $("#connect").prop("disabled", connected);
	    $("#disconnect").prop("disabled", !connected);
	    $("#send").prop("disabled", !connected);
	    if (connected) {
	        $("#conversation").show();
	    }
	    else {
	        $("#conversation").hide();
	    }
	    $("#msg").html("");
	}
	
	function connect() {
	    var socket = new SockJS('/ws');
	    stompClient = Stomp.over(socket);
	    stompClient.connect({}, function (frame) {
	        setConnected(true);
	        console.log('Connected: ' + frame);
	        stompClient.subscribe('/topic/public', function (message) {
	            showMessage("받은 메시지: " + message.body); //서버에 메시지 전달 후 리턴받는 메시지
	        });
	    });
	}
	
	function disconnect() {
	    if (stompClient !== null) {
	        stompClient.disconnect();
	    }
	    setConnected(false);
	    console.log("Disconnected");
	}
	
	function sendMessage() {
	    let message = $("#msg").val()
	    $("#msg").val("")
	    showMessage("보낸 메시지: " + message);
	
	    stompClient.send("/app/sendMessage", {}, JSON.stringify(message)); //서버에 보낼 메시지
	}
	
	function showMessage(message) {
	    $("#communicate").append("<tr><td>" + message + "</td></tr>");
	}
	
	$(function () {
	    $("form").on('submit', function (e) {
	        e.preventDefault();
	    });
	    $( "#connect" ).click(function() { connect(); });
	    $( "#disconnect" ).click(function() { disconnect(); });
	    $( "#send" ).click(function() { sendMessage(); });
	});

	// modal
	$(function(){
		$(".psBtn").on("click",function(){
			const pNo = $(this).data('value');
			$(".pNo").val(pNo);
			$("#ps").dialog({
				title : "seulMeal ChatBot!!",
				width : 700,
				height : 700,
				modal : true
			})
		})
	})
	
	// 기본 위치(top)값
	const floatPosition = parseInt($(".sideBanner").css('top'))
	
	// scroll 인식
	$(window).scroll(function() {
	  
	    // 현재 스크롤 위치
	    const currentTop = $(window).scrollTop();
	    const bannerTop = currentTop + 2*floatPosition + "px";
	
	    //이동 애니메이션
	    $(".sideBanner").stop().animate({
	      "top" : bannerTop
	    }, 500);
	
	}).scroll();
</script>
</body>
</html>