<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



	<div class="row">		
		<div class="col-md-5"></div>
			<div class="col-md-4">
			<nav aria-label="...">
			  <ul class="pagination">
		  		<li class="page-item disabled">
			      <span class="page-link" data-value="1">Previous</span>
			    </li>
			  	<c:forEach var="i" begin="${page.beginUnitPage}" end="${page.endUnitPage}">
			  		<li class="page-item"><a class="page-link" href="/operation/getListOperation/1/${i}">${i}</a></li>
			  	</c:forEach>
			  	<li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>	