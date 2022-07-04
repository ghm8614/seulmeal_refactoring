<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../../resources/css/summernote/summernote-lite.css">
<title>게시글 등록</title>

</head>
<body>
	<jsp:include page="../layer/header.jsp"></jsp:include>
	
	<!-- <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script> -->
	<script src="/resources/javascript/summernote/summernote-lite.js"></script>
	<script src="/resources/javascript/summernote/lang/summernote-ko-KR.js"></script>



	<div class="container" style="margin-top:20px;">
		
		<div style="color:#ff4500; border-bottom: 2px solid #ff4500; margin-bottom: 30px;">
			<h1>게시글 등록</h1>
		</div>

		<form id = "post-form" action="/community/insertPost" method="POST" enctype="multipart/form-data">		
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="Email3" class="col-sm-2 control-label h4" >제목</label>
						<div class="col-md-12">
						<input type="text" class="form-control" id = "title" name="title" placeholder="제목을 입력해 주세요">
					</div>
				</div>
				<div class="col-md-12">
					<textarea id="summernote" id = "postContent" name="content"></textarea>		
				</div>
			</div>
			<div style="display:flex; justify-content: space-between;">
				<div>
					<input type="file" name="uploadfile" multiple="multiple" />
				</div>
				<div>
					<button type="button" onclick="insertPost()" class="btn btn-primary">
						등록
					</button>
					<button type="button" onclick="history.back()" class="btn btn-primary">
						취소
					</button>
				</div>
			</div>	
		</form>
	</div>
<jsp:include page="../layer/footer.jsp"></jsp:include>


<script>
	
	function insertPost(){
		
		const title = $("#title").val();
		const content = $("#summernote").val();
		
		if(title === ""){
			toastr.error("제목을 올바르게 입력하세요","제목 에러",{timeOut:10000})
			return;
		}
		
		if(content ===""){
			toastr.error("내용을 올바르게 입력하세요","내용 에러",{timeOut:10000})
			return;
		}
		
		$("#post-form").submit();
	}


	$(document).ready(function () {
		$('#summernote').summernote({
			height: 500,                // 에디터 높이
			minHeight: 500,            // 최소 높이
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
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		});		
	});
</script>

</body>

</html>

