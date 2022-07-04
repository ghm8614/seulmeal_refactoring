<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<link rel="stylesheet" href="/resources/css/common/fileTag.css">
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
	<div class="container" style="margin-top:20px;">
		<h1 style="color:#ff4500; border-bottom: 2px solid #ff4500; margin-bottom: 30px;">공지 등록</h1>
		<form id="insertForm" action="/operation/insertOperation" method="POST" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="Email3" class="col-sm-2 control-label h4" >제목</label>
						<div class="col-md-12">
						<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
					</div>
				</div>
				
				<div class="col-md-12" style="margin-top:20px;" >
					<div class="filebox" style="display: flex; justify-content:space-around;">
							<input class="upload-name" value="파일선택" disabled="disabled" style="width:90%;">
							<label class="btn btn-primary" for="ex_filename">업로드</label> 
							<input type="file" name="uploadfile" multiple="multiple" id="ex_filename" class="upload-hidden" />  
					</div>
				</div>
				
				<div class="col-md-12" style="margin-top:20px;">
					<textarea id="summernote" name="content"></textarea>		
				</div>
			
				<input type="hidden" name="postStatus" value="1" />
			
			</div>				
			<div class="text-right" style="margin-top:20px;">
				<button onClick="insertNotice()" type="button" class="btn btn-primary">
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
	function insertNotice(){
		const title = $("#title").val()
		const content = $("#summernote").val()
		
		if(jsonArray.length != 0){
			for(let i=0; i<jsonArray.length; i++){
				let str = jsonArray[i];
				const result = str.toString().split('/')
				const tag = `<input name="summerImg" value="\${result[3]}" />`
				$("#insertForm").append(tag);
				console.log(result[3]);			
			}
		}
		if(title == ""){
			alert("제목입력하세요");
			return;
		}
		if(content == ""){
			alert("내용입력하세요");
			return;
		}
		
		$("#insertForm").submit();
	}
    
	
	function cancelBtn(){
		window.location.href = "/operation/getListOperation/1";
	}

</script>

</body>
</html>