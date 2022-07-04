<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css">
<link rel="stylesheet" href="/resources/css/common/fileTag.css">
</head>
<body>
<jsp:include page="../layer/header.jsp"></jsp:include>
<div class="container">
	<form action="/product/insertProduct" method="POST" enctype="multipart/form-data">
		<div class="row">
			<div class="col-md-8">
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-6 control-label h4" >음식 카테고리</label>
					<div class="col-md-12">
					<select name="foodCategoryNo" style="width: 160px">
					<c:forEach var="foodcategory" items="${list}">
						<c:set var="i" value="${i+1}" />
						<option value="${foodcategory.foodCategoryNo}">${foodcategory.name}</option>
					</c:forEach>
				</select>
				</div>
			</div>
			
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-5 control-label h4" >상품명</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="name" name="name" required placeholder="상품명">
				</div>
			</div>
			
			<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-5 control-label h4" >짧은 내용</label>
					<div class="col-md-12">
					<input type="text" class="form-control" id="subContent" name="subContent" required placeholder="짧은내용" />
				</div>
			</div>
			
			<div class="col-md-5 form-group">
				<label for="Email3" class="col-sm-6 control-label h4" >가격</label>
					<div class="col-md-12">
					<input type="number" class="form-control" id="price" name="price" required />
				</div>				
			</div>
			
			<div class="col-md-5 form-group">
				<label for="Email3" class="col-sm-6 control-label h4" >칼로리</label>
					<div class="col-md-12">
					<input type="number" class="form-control" id="calorie" name="calorie" required />
				</div>
			</div>
			
			
			
			<div class="col-md-12" style="margin-top:20px;" >
				<label for="Email3" class="col-sm-6 control-label h4" >썸네일</label>
				<div class="filebox" style="display: flex; justify-content:space-around;">
					<input class="upload-name" value="파일선택" disabled="disabled" style="width:96%;">
					<input type="file" accept="image/*" name="thumbnailFile" id="ex_filename" class="upload-hidden" onchange="readURL(event);" />  
				</div>
			</div>
			</div>
			
			<div>
			<h4>상품 구성 재료</h4>
			<div class="container">
							재료 검색 : &emsp;
								<div style="display:flex;">	
									<div class="form-outline">
										<input name="searchParts" type="search" class="form-control search" value="" style="border-color: #FF4500; border-width: 2px;"/>
									</div>		  
									<button type="button" class="btn btn-primary partSearch" onclick="search()">
										<i class="bi bi-search"></i>
									</button>
								</div>
						</div>
						<div class="partsList" style="margin-top:5px; height: 335px; overflow: auto;"></div>
					
				
				<div class="col-md-12 form-group">
				<label for="Email3" class="col-sm-4 control-label h5" style="margin-top: 10px" >재고</label>
					<div class="col-md-12">
					<input type="number" class="form-control" id="stock" name="stock" required min="0" />
				</div>
				</div>
			</div>
			</div>	
			
			
			<div class="col-md-12" style="margin-top: 40px;">
				<textarea id="summernote" name="content""></textarea>
			</div>
		</div>
		
		<div class="text-right" style="margin-top:20px;">
			<button type="submit" class="btn btn-primary">
				등록
			</button>
			<button type="button" onclick="cancelBtn()" class="btn btn-primary">
				취소
			</button>
		</div>		
	</form>
	
	<jsp:include page="../layer/footer.jsp"></jsp:include>
</div>


<script> 
function search(){
	var word = $(".search").val();
	
	if(word == null || word.length<1){
		alert("추가할 재료이름을 입력하세요.");
	}}

function fncGetParts(){
	const inputTag = $(".partSearch").parent('div').find("input[name='searchParts']");
	
	if(inputTag.val().trim() != null){
		if(inputTag.val() != $('.name').text()){
			$.ajax({
				url:"/product/api/getPartsName/"+$(".search").val(),
				method:"GET",
		        headers : {
		            "Accept" : "application/json",
		            "Content-Type" : "application/json"
		        },
		        dataType : "json",
		        success : function(data){	        	
		        	console.log(data);

		        	const parts = "<div class='searchparts' style='height:30px;'>"
		        	+"<input type='hidden' class='partsNo' name='partsNo' value='"+data.partsNo+"' />"
		        	+"<input type='hidden' class='partsName' name='partsName' value='"+data.name+"' />"
		            +"<br/><div class='parts' data-parts='"+data.partsNo+"'>"
		            +"<span class='name'>" +data.name 
		            + "</span><button type='button' class='btn btn-primary' onClick='fncClose(this)'>x</button>"

	               $(".search").val('');
	               $(".partsList").append(parts);
		        }
			})
		}else{
			alert("이미 추가되어있는 재료입니다.");
			inputTag.val('');
		}
	}
 }
$(function(){ 
	 $(".search").autocomplete({ 
		 source : function(request, response) {
		     $.ajax({
		           url : "/product/api/autoComplete"   
		         , type : "POST"
		         , dataType: "JSON"
		         , data : {value: request.term}
		         , success : function(data){
		        	 response(
		                 $.map(data.resultList, function(item) {
		                     return {
		                    	     label : item.NAME,
		                             value : item.NAME 
		                     };
		                     console.log(data);
		                 })
		             );    //response
		         }
		         ,error : function(){
		             alert("오류가 발생했습니다.");
		         }
		     });
		 }
			,focus : function(event, ui) {
				return false;
			},
			minLength: 1,
			delay: 100
			, select : function(evt, ui) { 
				console.log(ui.item.label);
		 }
	 });
	 
	$(".partSearch").on("click",()=>{
		
		fncGetParts();
	})
	
	$(".search").keydown(function(key){
		        if(key.keyCode==13) {
			           fncGetParts();
			    }     
	});
	
})
$(document).keypress(function(e) {
            if (e.keyCode == 13)
                e.preventDefault();
});

function fncClose(ths){
	 $(ths).closest("div").parent().remove();
	
}	


/* 파일 업로드 */
	$(document).ready(function(){
		const fileTarget = $('.upload-hidden');
		let filename;	
		fileTarget.on('change', function(){ 
			if(window.FileReader){ 
				filename = $(this)[0].files[0].name;
			} else { 
				filename = $(this).val().split('/').pop().split('\\').pop();
			}
			$(this).siblings('.upload-name').val(filename);
		});
	});
	
	$(".filebox").on("click",()=>{
		document.querySelector("#ex_filename").click();
	})
	
	
/* 썸머노트 */
	$(document).ready(function () {
		
		$('#summernote').summernote({
			height: 700,
			minHeight: 700,
			maxHeight: null,
			focus: true,
			lang: "ko-KR",	
			placeholder: '최대 2048자까지 쓸 수 있습니다',
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
	
	
$(".btn-primary:contains('취소')").click(function(){
	window.location.href = '/product/admin/listProduct';
});
</script>
</body>
</html>