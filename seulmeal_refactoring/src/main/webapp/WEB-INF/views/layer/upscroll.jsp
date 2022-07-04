<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.floating-menu { position: fixed; right: 50px; top: 50%; z-index: 100; margin: -120px 0 0 0;}

.footer { height: 100px; background-color: #707070;}

	.bi-caret-up-fill,
	.bi-caret-down-fill{
         font-size: 40px;
         line-height: 40px;
         color:#FF4500;
     }

</style>

</head>
<body>
<div class="floating-menu">
	<div style="margin-right: 280px;">
		<i class="bi bi-caret-up-fill"></i><br/>
		<i class="bi bi-caret-down-fill"></i>
	</div>
</div>
<script>

	$('.bi-caret-up-fill').on('click',function(){
		window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
	});
	
	$('.bi-caret-down-fill').on('click',function(){
		var down = document.body.offsetHeight - window.innerHeight;
		window.scrollTo({ top: down, left: 0, behavior: 'smooth' });
	});
	
</script>
</body>
</html>