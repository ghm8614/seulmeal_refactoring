<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차단유저 목록</title>
</head>
<body>
	

		<!-- 차단목록 모달 -->
              <div id="blockUserModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable modal-md " role="document">
                  <div class="modal-content">
                  
                          <!-- 헤더 -->
                          <div class="modal-header">
                              <h5 class="modal-title text-center" id="exampleModalScrollableTitle">차단 유저</h5>
                              <button type="button" class="close" data-dismiss="modal"
                                  aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                              </button>
                          </div>
                      
                      
                      <div class="modal-body">
                          
                              <!-- 차단 유저 리스트 -->
                                  <c:forEach var="relation" items="${blockMap.blockList}">
                                      <div class ="block-li">
                                          <div class="blockUser_section" >
                                          
                                          
								            <div id="block-list-card" class="profile-card" >
								                <div id="block-list-image" class="profile-pic" style="width:45px; height: 45px;">
								                	<c:choose>
	                                                  <c:when test="${empty relation.relationUser.profileImage}">
	                                                     <img src="/resources/attachments/profile_image/default_profile.jpg"  class="rounded-circle">
	                                                  </c:when>
	                                                  <c:otherwise>
	                                                     <img src="/resources/attachments/profile_image/${relation.relationUser.profileImage}" class="rounded-circle"/>
	                                                  </c:otherwise>
	                                              	</c:choose>
								                </div>
								                <div>
								                   <div id="block-list-nickname" style="font-size: 15px">
								                   		<c:choose>
										                  	<c:when test="${not empty relation.relationUser.nickName}">
																${relation.relationUser.nickName}
															</c:when>
															<c:otherwise>
																${relation.relationUser.userId}		
															</c:otherwise>
														</c:choose>	
								                  </div>
								                    <div id="block-list-profilemsg" class="sub-text" style="margin:0px; font-size: 10px;">${relation.relationUser.profileMessage}</div>
								                </div>
								                <div><button class="action-btn" onclick="deleteBlock(this)" data-value="${relation.relationUser.userId}">차단해제</button></div>
								            </div>
								            
                                          </div>
                                          
                                      </div>
                                  </c:forEach>
                  
                    	  </div>
                      
                      
                          <!-- 푸터 -->
                          <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                          </div>			    	
                                    
                    </div>
                </div>
            </div>
            <!-- 모달 끝 -->

	
	
	
</body>
</html>