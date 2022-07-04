<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 유저 목록</title>
</head>
<body>


	<!-- 팔로우 유저 목록 모달 -->
	<div id="followModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-md "
			role="document">
			<div class="modal-content">

				<!-- 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalScrollableTitle">팔로잉</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div id="follow-modal-body" class="modal-body">

					<!-- 팔로워 유저 리스트 -->
					<c:forEach var="relation" items="${followMap.followList}">
						<div class="follow-li">
							<div class="followUser_section">


								<div id="follow-list-card" class="profile-card">
									<div id="follow-list-image" class="profile-pic" style="width:45px; height: 45px;">
										<c:choose>
											<c:when test="${empty relation.relationUser.profileImage}">
												<a
													href="/community/getProfile/${relation.relationUser.userId}"><img
													src="/resources/attachments/profile_image/default_profile.jpg"
													class="rounded-circle"></a>
											</c:when>
											<c:otherwise>
												<a
													href="/community/getProfile/${relation.relationUser.userId}"><img
													src="/resources/attachments/profile_image/${relation.relationUser.profileImage}"
													class="rounded-circle" /></a>
											</c:otherwise>
										</c:choose>
									</div>
									<div>
										<div id="follow-list-nickname" style="font-size: 15px">
											<c:choose>
												<c:when test="${not empty relation.relationUser.nickName}">
													<a
														href="/community/getProfile/${relation.relationUser.userId}">${relation.relationUser.nickName}</a>
												</c:when>
												<c:otherwise>
													<a
														href="/community/getProfile/${relation.relationUser.userId}">${relation.relationUser.userId}</a>
												</c:otherwise>
											</c:choose>
										</div>
										<div id="follow-list-profilemsg" class="sub-text" style="margin:0px; font-size: 10px;">${relation.relationUser.profileMessage}</div>
									</div>
									<div>
										<button class="action-btn" onclick="deleteFollow(this)"
											data-value="${relation.relationUser.userId}">팔로우 해제</button>
									</div>
								</div>

							</div>

						</div>
					</c:forEach>

				</div>

				<!-- 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 팔로우 모달 끝 -->





</body>
</html>