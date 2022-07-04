<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#wrap{
    width:100%;
    height:100%;
}
  
#wrap .box{ 
    width:300px;
    height:300px;
    margin:0 auto;
}
</style>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 아래 제이쿼리는 1.0이상이면 원하는 버전을 사용하셔도 무방합니다. -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>

<jsp:include page="../layer/header.jsp"></jsp:include>
	<div id="wrap">
		<div class="box">
			<h1>포인트 충전</h1>
			<input type="hidden" id="userId" name="userId" value="${user.userId}"/>
			<input name="price" id="price"/>원
			<button type="button" class="btn btn-default" onClick="iamport()">충전하기</button>

		</div>
	</div>

	<jsp:include page="../layer/footer.jsp"></jsp:include>


<script type="text/javascript">

function iamport(){
	
	var form1 = $(".box").serialize();
	
	let customNo = [];
	let ar = $(".customProductNo").get();
	console.log(ar);
	
	for ( var i = 0; i < ar.length; i++) {
		customNo.push(ar[i].value);
	}
	console.log(customNo);
	console.log($('#price').val());
	const userId = $('#userId').val();
	const name = "0";
	const address ="0";
	const phone = "0";
	const email = "0";
	const message ="0";
	const price = $('#price').val();
	const usePoint = "0";
	//const plusPoint = $('#pluspoint').val();

/* 	 if(parseInt($('#price').val())==0){
		
		$(".cc").append(`<input type="hidden" name ="paymentCondition" value="1">`);
				
		$("form").attr("method" , "POST").attr("action" , "/purchase/insertPurchase").submit();
	}else{
		$(".cc").append(`<input type="hidden" id ="paymentCondition" value="0">`);  */
		const paymentCondition = "0";

		$.ajax({
			url:"/purchase/api/insertPurchase",
			method:"POST",
			data:JSON.stringify({
				name : name,
				address : address,
				phone : phone,
				email : email,
				message : message,
				price : price,
				paymentCondition : paymentCondition,
				usePoint : usePoint,
				customProductNo : customNo
				//plusPoint : plusPoint
			}),
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			dataType : "json",
			success : function(data){
				console.log(data);
				IMP.init('imp83644059'); 
				IMP.request_pay(
				    { 
		 		  	pay_method: data.paymentCondition,
		  		  	merchant_uid: data.purchaseNo,
		  		  	name: "포인트 충전",
		  		  	amount: data.price,
		   		 	buyer_email: data.email,
		   			buyer_name: data.name,
		  			buyer_tel: data.phone,
		  		  	buyer_addr: data.address,
		   		 	buyer_postcode: "01181"
					}, function(rsp) {
						if(rsp.success){
							var msg = '결제가 완료되었습니다.';
			  		      	
			  		      	 $.ajax({
			  		  			url:"/purchase/api/verifyIamport",
			  		  			method:"POST",
			  		  			data:JSON.stringify({
			  		  				imp_uid : rsp.imp_uid,
			  		  				purchaseNo : rsp.merchant_uid,
			  		  				amount : rsp.paid_amount
			  		  			}),
			  		  			headers : {
			  		  				"Accept" : "application/json",
			  		  				"Content-Type" : "application/json"
			  		  			},
			  		  			dataType : "json",
			  		  			success : function(data){
			  		  				console.log(data);
			  		  				window.location.href='/user/getChargeUserPoint/' + data.purchase.purchaseNo;
			  		  			}
			  		      	 })
						}else{
							var msg = '결제에 실패하였습니다.';
					         msg += '에러내용 : ' + rsp.error_msg;
	
						}
					alert(msg);
				})
			}
		})
	}
/* } */


/* function insertPoint() {
    const price = document.querySelector(".price").value;
    
    $.ajax({
        url:"/user/api/insertPoint",
        method:"POST",
        data:JSON.stringify({
            price :price,
            status: "2"
        }),
        headers : {
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        },
        dataType : "json",
        success : function(data){


            IMP.init('imp83644059'); // 콘솔에서 확인
            IMP.request_pay({
                
                
                merchant_uid : data.pointNo,
                name : '포인트 충전' , //결제창에서 보여질 이름
                amount : data.price, //실제 결제되는 가격
               /*  buyer_email : 'iamport@siot.do',
                buyer_name : data.member.name,
                buyer_tel : data.member.phone,
                buyer_addr : data.member.address,
                buyer_postcode : '123-456' */
                /*   }, function(rsp) {
                console.log(rsp);
                if ( rsp.success ) {
                    var msg = '결제가 완료되었습니다.';
                    msg += '고유ID : ' + rsp.imp_uid;
                    msg += '상점 거래ID : ' + rsp.merchant_uid;
                    msg += '결제 금액 : ' + rsp.paid_amount;
                    msg += '카드 승인번호 : ' + rsp.apply_num;
                    
                    $.ajax({
                        url:"/user/api/verifyIamport",
                        method:"POST",
                        data:JSON.stringify({
                            imp_uid :rsp.imp_uid,
                            no :rsp.merchant_uid,
                            amount:rsp.paid_amount
                        }),
                        headers : {
                            "Accept" : "application/json",
                            "Content-Type" : "application/json"
                        },
                        dataType : "json",
                        success : function(data){
                        	
                            console.log(data);
                            
                            if(data.success === "true"){
                            	
                            	const form = document.createElement('form');
                                form.method="post";
                                form.action="/point/getChargeUserPoint";
                                
                                const point = document.createElement('input');
                                const no = document.createElement('input');
                                
                                point.setAttribute("name","point");
                                point.setAttribute("value",data.purchase.amount);
                                
                                no.setAttribute("name","no");
                                no.setAttribute("value",data.purchase.no);

                                form.appendChild(point);
                                form.appendChild(no);
                                
                                document.body.appendChild(form);

                                form.submit();	
                            	
                            }
                            
                        }
                        
                    })
                    
                } else {
                     var msg = '결제에 실패하였습니다.';
                     msg += '에러내용 : ' + rsp.error_msg;
                }
                alert(msg);
            });
            
            
        }
        
    })
}
 */
/* function iamport(){
	//가맹점 식별코드
	IMP.init('imp31272612'); // 콘솔에서 확인
	IMP.request_pay({
	    pg : 'kcp',
	    pay_method : 'card',
	    merchant_uid : 06,
	    name : '상품1' , //결제창에서 보여질 이름
	    amount : 100, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '나다',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        
	        $.ajax({
	        	url:"/product/cofirm",
	        	method:"POST",
	        	data:JSON.stringify({
	        		imp_uid :rsp.imp_uid,
		        	merchat_uid :rsp.merchant_uid,
		        	amount:rsp.paid_amount
	        	}),
	        	headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				dataType : "json",
				success : function(data){
					console.log(data)
				}
	        	
	        })
	        
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
} */
</script>
</body>
</html>