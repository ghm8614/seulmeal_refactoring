<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>재료 등록</title>
</head>
<script type="text/javascript">
</script>
<body>
	<form action="/product/updateParts/${parts.partsNo}" method="POST">
	재료명 : <input name = "name" value="${parts.name }"/><br/>
	재료 가격 : <input name = "price" value="${parts.price}"/><br/>
	칼로리 : <input name = "calorie" value="${parts.calorie}"/><br/>
	재료 중량 : 10g 기준
	<button type="submit">등록</button>
	</form>
</body>
</html>