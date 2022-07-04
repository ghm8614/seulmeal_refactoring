<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../../resources/css/summernote/summernote-lite.css">
<!--<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet"> -->
<link rel="stylesheet" href="/resources/css/common/fileTag.css">
<title>이벤트 등록</title>
<style type="text/css">
	.col-md-12{
		margin-top: 20px;
	}
</style>
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>

<div class="container">
		<div class="container px-4 py-5" id="custom-cards">
			<div class="row row-cols-1 row-cols-lg-10 align-items-stretch g-4 py-3">
				<div class="col">
					<div id="imageThumbnail" class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('../../../resources/attachments/image/tetris.png');">
						<div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
							<h1 id="titleView" class="fw-bold">Title</h1>
							<h2 id="shortContentView" class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">ShortContent</h2>
							<h2 class="endDateView">2022-08-11</h2>							
							<div style="display:flex; justify-content:space-between;">
								<ul class="d-flex list-unstyled mt-auto">
									<li class="me-auto">
										<i class="bi bi-cart-plus-fill" style="font-size:2rem; color:black;"></i>
									</li>							
								</ul>
								<ul class="d-flex list-unstyled mt-auto">
									<li class="d-flex align-items-center me-3" style="font-size:1.5rem; margin-right:5px;">
										<i class="bi bi-emoji-heart-eyes"></i><br/>
										<small>&nbsp;0</small>
									</li>
									<li class="d-flex align-items-center"  style="font-size:1.5rem; margin-left:5px;">
										<i class="bi bi-calendar-date"></i>
										<small id="end_date">&nbsp;2022-08-11</small>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">
	<form action="/operation/insertOperation" method="POST" enctype="multipart/form-data" id="insertForm">
		<div class="row">
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-2 control-label h4" >제목</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요">
				</div>
			</div>
			
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-2 control-label h4" >짧은 내용</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="shortContent" name="shortContent" placeholder="제목을 입력해 주세요">
				</div>
			</div>
			
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-2 control-label h4" >기간</label>
					<div class="col-md-12">
					<input type="date" class="form-control" id="endDate" name="endDate">
				</div>
			</div>
			
			<div class="col-md-12 fileTag" style="margin-top:20px;" >
				<div class="filebox" style="display: flex; justify-content:space-around;">
						<input class="upload-name" value="파일선택" disabled="disabled" style="width:90%;">
						<label class="btn btn-primary" for="">썸네일</label> 
						<input type="file" accept="image/*" name="thumnailFile" id="ex_filename" class="upload-hidden" onchange="readURL(event);" />  
				</div>
			</div>
			
			<div class="col-md-12">
				<textarea id="summernote" name="content"></textarea>
			</div>
		
			<input type="hidden" name="postStatus" value="2" />
			
			<div class="col-md-6 form-group">
				<label for="Email3" class="col-sm-4 control-label h4" >상품명</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="productSearch" name="productSearch" />
				</div>				
			</div>
			
			<div class="col-md-6 form-group">
				<label for="discount" class="col-sm-4 control-label h4" >할인율</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="discount" name="discount" placeholder="1~100" />
				</div>
			</div>
			
			<div id="productClass" class="col-md-12" style="margin-top:20px;">
				<div>
					<span style="margin-right: 10px;">상품명</span><span style="margin-right: 10px;">원가격</span><span>할인가격</span>
				</div>
			</div>
			
			<div class="col-md-12" style="margin-top:20px;" >
				<input type="file" name="uploadfile" multiple="multiple" id="ex_uploadfile" />
			</div>
		</div>
		
		<div class="text-right" style="margin-top:20px;">
			<button type="button" onclick="insertEvent()" class="btn btn-primary">
				등록
			</button>
			<button type="button" onclick="cancelBtn()" class="btn btn-primary">
				취소
			</button>
		</div>
			
		
	</form>
	</div>
<jsp:include page="../layer/footer.jsp"></jsp:include>
<script>
	function readURL(){
		const reader = new FileReader();
		
		reader.onload = function(event){
			$("#imageThumbnail").css({"background":"url("+event.target.result+")"});
		}
		
		reader.readAsDataURL(event.target.files[0]);
	}
	
	// fileUploadTag
	$(document).ready(function(){
		const fileTarget = $('.filebox .upload-hidden');
		let filename;	
		fileTarget.on('change', function(){  // 값이 변경되면
			if(window.FileReader){  // modern browser
				filename = $(this)[0].files[0].name;
			} else {  // old IE
				filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
			}		   
			// 추출한 파일명 삽입
			$(this).siblings('.upload-name').val(filename);
		});
	});
	
	$(".filebox").on("click",()=>{
		document.querySelector("#ex_filename").click();
	})
	//////
	
	$("#title").on("keyup",function(){
		$("#titleView").text($(this).val());
	});
	
	$("#shortContent").on("keyup",function(){
		$("#shortContentView").text($(this).val());
	});
	
	$("#endDate").on("change",function(){
		$("#end_date").text($(this).val());
		$(".endDateView").text($(this).val());
	});
	
	
const jsonArray = [];
	
	$(document).ready(function () {
		
		$('#summernote').summernote({
			height: 700,                // 에디터 높이
			minHeight: 700,            // 최소 높이
			maxHeight: null,            // 최대 높이
			focus: true,                // 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",				// 한글 설정
			placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
			toolbar: [				    
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
		            // 파일 업로드(다중업로드를 위해 반복문 사용)
		            for (var i = files.length - 1; i >= 0; i--) {
		            uploadSummernoteImageFile(files[i],
		            this);
		            		}
		            	}
			}
		});
		
		$('#summernote').summernote(setting);
		
		function uploadSummernoteImageFile(file, el){
			const data = new FormData;
			data.append("file",file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/uploadSummernoteImgFile",
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(data) {
					$(el).summernote('editor.insertImage', data.url);					
					jsonArray.push(data.url);
					jsonFn(jsonArray);
				},
				error : function(e){
					console.log(e);
				}
			})
		}
		
		
		function jsonFn(jsonArray){
			console.log(jsonArray)
		}
				
    });
	
	// 할인
	function discount(){
		const pA = $(".iprice");
		const dis = $("#discount").val();
		
		if(dis !== ""){
			pA.each((i,el)=>{
				$(el).parent().find(".price").text(el.value*(100-dis)/100);
				$(el).parent().find(".tprice").val(el.value*(100-dis)/100);
				console.log($(el).parent().find(".tprice").val())
			})
		}
	
	}
	
	function getProduct(){
		const name = $("#productSearch").val();
		console.log(name)
		$.ajax({
			type : "GET",
			url : "/operation/api/getProduct/"+name,
			datatype:"json",
			success : function(data) {
				if(data !== ''){
					const productCard = `<div class="productCommponet">
						<input type="hidden" name="productNo" value="\${data.productNo}" />
						<input type="hidden" class="iprice" value="\${data.price}" />
						<input type="hidden" name="tprice" class="tprice" value="\${data.price}" />
						<span class='name'>\${data.name}</span>
						<span class='oriPrice'>\${data.price}</span>
						<span class='price'>\${data.price}</span>
						<button type='button' class='btn btn-primary' onClick='deleteProduct(this)'>x</button>
					</div>`
					$("#productClass").append(productCard);
					discount()
				}
			},
			error : function(e){
				console.log(e);
			}
		})
	}
	
	function deleteProduct(e){
		$(e).parent().remove();
	}
	
	$(()=>{
		
		
		$("#discount").on("focus keyup",(e)=>{
			console.log(e.keyCode)
			if( e.keyCode<96 || e.keyCode>106 || $("#discount").val() <0 || $("#discount").val() >100){
				$("#discount").val("");
				toastr.error("할인율을 올바르게 입력하세요","할인률 에러",{timeOut:10000})
				return;			
			}
			
			discount();
		})
		
		$("#productSearch").keydown(function(key){
		        if(key.keyCode==13) {
			           getProduct();
			    }     
		});
		$("#productSearch").autocomplete({			
			 source : function(request, response) { //source: 입력시 보일 목록
			     $.ajax({
			           url : "/operation/api/autocomplete" 
			         , type : "POST"
			         , dataType: "JSON"
		        	 , data : {value: request.term}
			         , success : function(data){ 	// 성공
			        	 response(
			                 $.map(data.resultList, function(item) {
			                     return {
			                    	     label : item.NAME,    	// 목록에 표시되는 값
			                             value : item.NAME 		// 선택 시 input창에 표시되는 값
			                     };
			                 })
			             );    //response
			         }
			         ,error : function(){ //실패
			             alert("오류가 발생했습니다.");
			         }
			     });
			 }
				,focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
					return false;
				},
				minLength: 1,// 최소 글자수
				delay: 100	//autocomplete 딜레이 시간(ms),
				, select : function(evt, ui) { 
		      	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
					console.log(ui.item.label);
			 }
		 });
	})
	 
	
	
	// insert
	function insertEvent(){
		if(jsonArray.length != 0){
			for(let i=0; i<jsonArray.length; i++){
				let str = jsonArray[i];
				const result = str.toString().split('/')
				const tag = `<input name="summerImg" value="\${result[3]}" />`
				$("#insertForm").append(tag);
				console.log(result[3]);			
			}
		}
		const discount = $("#discount").val();
		const title = $("#title").val();
		const content = $("#summernote").val();
		const shortContent = $("#shortContent").val();
		const endDate = $("#endDate").val();
		const thumnail = $("#ex_filename").val();
		
		if(title === ""){
			toastr.error("제목을 올바르게 입력하세요","제목 에러",{timeOut:10000})
			return;
		}
		
		if(content ===""){
			toastr.error("내용을 올바르게 입력하세요","내용 에러",{timeOut:10000})
			return;
		}
		
		if(shortContent ===""){
			toastr.error("짧은 내용을 올바르게 입력하세요","짧은 내용 에러",{timeOut:10000})
			return;
		}
		
		if(thumnail ===""){
			toastr.error("썸내일을 등록해 주세요","썸네일 에러",{timeOut:10000})
			return;
		}
		
		if(endDate ===""){
			toastr.error("종료일을 올바르게 입력하세요","종료 날짜 에러",{timeOut:10000})
			return;
		}
		
		if(discount >101 || discount <0 || discount ===""){
			toastr.error("할인률을 올바르게 입력하세요","할인률 에러",{timeOut:10000})
			return;
		}
		
		$("#insertForm").submit();
	}
	
</script>
</body>
</html>