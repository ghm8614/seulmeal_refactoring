<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 이미지 수정/삭제 모달창</title>
</head>
<body>

		<!-- Modal -->
		<div id="updateProfileImageModal" class="modal fade"  aria-labelledby="staticBackdropLabel" aria-hidden="true" data-backdrop="static" tabindex="-1" role="dialog">
			<div class="modal-dialog" >
				<div class="modal-content" style="width:460px; border-radius: 15px;">

					<!-- 헤더 -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
	
					<!-- 바디 -->
					<div class="modal-body" style="padding:0;"><br>
						<div class="filebox" style="text-align: center">					
							<label for="upload_file" style="margin:0px;">사진 업로드</label>
							<input id = "upload_file" type="file" name="imageFile" style="position: absolute;" />
						</div>
						<hr>
						<div style="text-align: center; height:24px; margin-bottom: 20px;" >
							<a role="button" id="deleteProfileImageBtn"
								class="btn btn-secondary popover-test" title="Popover title" >현재 사진 삭제</a>
						</div>
						<hr>
						<div style="margin:10px; text-align: center;">
							<button type="button"  class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</div>	
			
				</div>
			</div>
		</div>
</body>
</html>