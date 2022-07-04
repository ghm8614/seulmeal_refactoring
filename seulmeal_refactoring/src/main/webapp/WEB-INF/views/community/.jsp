<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차단 유저 목록 모달창</title>
</head>
<body>

			<!-- 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">차단 유저 목록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


			<!-- 바디 -->
				<div class="modal-body">
				
					<!-- table : 차단 유저 목록 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="margin-top: 10px;">
		
						<tr>
							<td class="ct_list_b">차단당한유저_프로필이미지</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" >차단당한유저_닉네임</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b">차단당한유저_상태메시지</td>
							<td class="ct_line02"></td>
						</tr>
						<tr>
							<td colspan="11" bgcolor="808285" height="1"></td>
						</tr>
						
						<tr>
							<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>
						
						<c:forEach var="relation" items="${blockList}">
							<tr class="ct_list_pop">
								<td align="left"><img style="width: 80px; height: 80px" src="/resources/attachments/profile_image/${ralation.relationUser.profileImage}"/></td>
								<td></td>
								<td align="left">${ralation.relationUser.nickName}</td>
								<td></td>
								<td align="left">${relation.relationUser.profileMessage}</td>
								<td></td>
							</tr>
						</c:forEach>
						
					</table>
				</div>


			<!-- 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>





</body>
</html>