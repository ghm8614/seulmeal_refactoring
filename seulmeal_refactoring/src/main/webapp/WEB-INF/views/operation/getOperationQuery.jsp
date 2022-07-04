<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../../resources/css/summernote/summernote-lite.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<title>문의사항 상세정보</title>
<link rel="stylesheet" href="/resources/css/common/fileTag.css">
<style>
	.queryHeader{
		margin:10px;
	}
	
	.commentArg{
		margin-top: 20px;
	}
	
	.answerHeaderClass{
		border-bottom: 1px solid #ff4500;
		margin-bottom: 10px;
		display: flex;
		justify-content: space-between;
	}
	
	.answerBox{
		border: 1px solid #ff4500;
		border-radius: 10px;
		box-shadow: 0 6px 6px 0 gray;
	}
	.answerBox+.answerBox{
		margin-top: 20px;
	}
	
	.answerHeader{
		margin-top: 10px;
		margin-left: 10px;
	}
	
	.answerHeader+.answerHeader{
		margin-right: 10px;
	}
	
	.uploadAnswerBtn{
		margin:10px;
		padding-bottom:5px;
		width:70px;
		height: 30px;
		font-size: 10px !important;
	}
</style>
</head>
<body>

	<jsp:include page="../layer/header.jsp"></jsp:include>
<script src="/resources/javascript/summernote/summernote-lite.js"></script>
<script src="/resources/javascript/summernote/lang/summernote-ko-KR.js"></script>	
	<div class="container">
        <div class="row" >
            <div class="col" style="border-bottom: 2px solid #ff4500; margin-top:20px;">            	
            	<h1>${post.title}<c:if test="${post.publicStatus==1}"><i class="bi bi-lock-fill"></i></c:if></h1>
            </div>            
        </div>
        <div class="row" style="text-align: center;">
            <div class="col-2 queryHeader">${post.postNo}</div>
            <div class="col-2 queryHeader">${post.regDate}</div>
        </div>
        <div class="row" style="border-bottom: 2px solid #ff4500; text-align: center;">
            <div class="col-2 queryHeader">${post.user.userId}</div>
            <div class="col-3" style="display: flex;">
            <div style="margin-right: 10px;">
	            <c:if test="${post.answerStatus ==0}">
	            	<input class="btn btn-primary float-right uploadAnswerBtn" id="answerAnswer" type="button" value="답변대기중">
	            </c:if>
	            <c:if test="${post.answerStatus ==1}">
	            	<input class="btn btn-primary float-right uploadAnswerBtn answerAnswer" type="button" value="답변완료">
	            </c:if>
            </div>
            
            <c:if test="${user.userId == post.user.userId}">
            	<c:if test="${post.answerStatus ==0}">
            		<input class="btn btn-primary float-right uploadAnswerBtn" type="button" onclick="updateQuery()" value="수정">
            		<input class="btn btn-primary float-right uploadAnswerBtn" type="button" onclick="deleteQuery()" value="삭제">
            	</c:if>
            	<c:if test="${post.answerStatus ==1}">
            		<input class="btn btn-primary float-right uploadAnswerBtn" type="button" onclick="deleteQuery()" value="삭제">
            	</c:if>
            </c:if>            
        </div>
        </div>
        <div class="row justify-content-end">
        	<div class="col-1">
        		<c:if test="${post.attachments.size() != 0}">
	        		<div class="dropdown show">
						<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<span class="d-none d-sm-inline mx-1" style="color:black;">첨부파일</span>					
						</a>					
						<div class="dropdown-menu dropdown-menu-right dropdown-menu-dark text-small shadow" aria-labelledby="dropdownMenuLink">
							<c:forEach var="attachments" items="${post.attachments}">		          	
				            	<a class="dropdown-item" href="/download/${attachments.attachmentName}">${attachments.attachmentName }</a>
				            </c:forEach>
						</div>
					</div>
				</c:if>
        	</div>		
        </div>
        <div class="row" style="border-bottom: 2px solid #ff4500; min-height: 400px;">
            <div class="col">${post.content}</div>            
        </div>
        <c:if test="${user.role==1}">        
	        <div class="row justify-content-end">
	            <button id="answerInsert" style="margin-top:10px; margin-right:10px;" class="btn btn-primary float-right">답변등록</button>
	        </div>
        </c:if>
        <div class="commentArg">
	        <c:forEach var="comment" items="${post.comments}">
	        	<c:if test="${comment.commentNo != 0}">
				<c:set var="i" value="${i+1}" />
				<div class="answerBox">
					<div class="answerHeaderClass">
						<div style="display: flex;">
							<div class="answerHeader">${comment.commentNo}</div>
				            <div class="answerHeader">${comment.regDate}</div>
				            <div class="answerHeader">${comment.user.userId}</div>
			            </div>
			            
			            <c:if test="${user.userId==comment.user.userId}">
			            	<div style="display: flex; justify-content: flex-end;">
				            	<input data-value="${comment.commentNo}" class="btn btn-primary float-right uploadAnswerBtn deleteAnswer" onclick="deleteAnswer(this)" type="button" value="답변삭제">
				            </div>
			            </c:if>
			            
			        </div>
		        
		        	<div style="display: flex; justify-content: flex-end;">
		        		<c:if test="${comment.attachments.size() != 0}">
			        	<div class="dropdown">
							<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span class="d-none d-sm-inline mx-1" style="color:black;">첨부파일</span>					
							</a>					
							<div class="dropdown-menu dropdown-menu-right dropdown-menu-dark text-small shadow" aria-labelledby="dropdownMenuLink">
								<c:forEach var="attachments" items="${comment.attachments}">		          	
					            	<a class="dropdown-item" href="/download/${attachments.attachmentName}">${attachments.attachmentName}</a>
					            </c:forEach>
							</div>
						</div>
						</c:if>
					</div>
		        
		        <div class="row">
		            <div class="col" style=" min-height: 100px; margin-left:20px; margin-right:20px;">${comment.content}</div>
		        </div>
		        
		        </div>
		        </c:if>
			</c:forEach>
		</div> 
    </div>
    
    <!-- 답변 모달 -->
	<div class="answer" style="display:none;">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">문의 답변 입력</h5>
			</div>
			<form method="POST" enctype="multipart/form-data" id="answerForm">
				<div class="modal-content">
					<div class="modal-body">    
						<div class="filebox">
							<input class="upload-name" value="파일선택" disabled="disabled">
							<label class="btn btn-primary" for="ex_filename">업로드</label> 
							<input type="file" name="uploadfile" multiple="multiple" id="ex_filename" class="upload-hidden" />  
						</div>
						<div class="row answerForm">
							<input id="postNo" type="hidden" name="postNo" value="${post.postNo}" />
							<div class="col-md-12">
								<textarea id="summernote" name="content"></textarea>		
							</div>				
						</div>		
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" onClick="ajaxAnswer()" type="button">저장</button>
						<button class="btn btn-primary" onClick="colseModal()" type="button">취소</button>
					</div> 
				</div>
			</form>
		
	</div>

	<jsp:include page="../layer/footer.jsp"></jsp:include>
	
<script type="text/javascript">
	let jsonArray = [];
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
	
	$("#answerInsert").on("click",function(){
		$(".answer").dialog({
			width : 1000,
			height : 1000,
			show : 'slide',
			"position" : {
                my	: "center",
                at	: "center",
                //of	: window,
                //of	: "#INI_mainModalDialog",
            },
			modal : true
		})
		$(".answer").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
	});	
		
	$(document).ready(function () {
		$('#summernote').summernote({
			height: 500,                // 에디터 높이
			minHeight: 600,            // 최소 높이
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
	
	function ajaxAnswer(){
		const form = $("#answerForm")[0];
		
		if(jsonArray.length != 0){
			for(let i=0; i<jsonArray.length; i++){
				let str = jsonArray[i];
				const result = str.toString().split('/')
				const tag = `<input name="summerImg" value="\${result[3]}" />`
				form.append(tag);
				console.log(result[3]);			
			}
		}
		
		const formData = new FormData(form);
		$.ajax({
			url : "/operation/api/insertAnswer",
			method : "POST",
			data : formData,
			processData: false,
			contentType: false,
			cache: false,
	        success : function(data){
	        	let answer = `	        	
	        	<div class="answerBox">
					<div class="answerHeaderClass">
					<div style="display: flex;">
						<div class="answerHeader">\${data.commentNo}</div>
			            <div class="answerHeader">\${data.regDate}</div>
			            <div class="answerHeader">\${data.user.userId}</div>
		            </div>
	            	<div style="display: flex; justify-content: flex-end;">
		            	<input data-value="\${data.commentNo}" class='btn btn-primary float-right uploadAnswerBtn deleteAnswer' onClick="deleteAnswer(this)" type='button' value='답변삭제' />
		            </div>
		        </div>
	        
	        	<div style="display: flex; justify-content: flex-end;">` 
	        	if(data.attachments.length != 0){
	        		answer += `<div class="dropdown">
						<a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#"  id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<span class="d-none d-sm-inline mx-1" style="color:black;">첨부파일</span>					
						</a>				
						<div class="dropdown-menu dropdown-menu-right dropdown-menu-dark text-small shadow" aria-labelledby="dropdownMenuLink">`
						
							data.attachments.forEach(function(e){
								answer+= `<a class="dropdown-item" href="/download/\${e.attachmentName}">\${e.attachmentName}</a>`
							})
						answer+=`</div>
					</div>`
	        	}
				answer+=`</div>
				<div class="row">
	            <div class="col" style=" min-height: 100px; margin-left:20px; margin-right:20px;">\${data.content}</div>
	        </div>	        
	        </div>	        
	        `
	        	$(".commentArg").append(answer);
	        	$("#answerAnswer").val("답변완료");
	        	$(".answer").dialog("close");
	        }
		})
	}
	
	function updateQuery(){
		window.location.href = "/operation/updateOperation/${post.postStatus}/${post.postNo}"
	}
	
	function deleteAnswer(e){
		const commentNo = $(e).data("value");
		const commentBox = $(e).parent("div").parent("div").parent("div");
		
		$.ajax({
			url : "/operation/api/deletetAnswer",
			method : "POST",
			data : JSON.stringify({
				commentNo : commentNo
			}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	if(data == 1){
	        		commentBox.css("display","none");
	        	}
	        }
		})
	}
	
	function deleteQuery(){
		
		$.ajax({
			url : "/operation/api/deleteOperation",
			method : "POST",
			data : JSON.stringify({
				postNo : ${post.postNo},
				postStatus : ${post.postStatus}
			}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	window.location.href = '/operation/getListOperation/${post.postStatus}';
	        }
		})
		
	}
</script>
</body>
</html>