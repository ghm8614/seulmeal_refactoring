<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Cookie" rel="stylesheet" type="text/css">
<title>footer</title>
<style>
	footer{
		/*position: fixed;*/
		bottom: 0;
	}
	
	@media (max-height:800px){
		footer { position: static; }
		header { padding-top:40px; }
	}
	.footer-distributed{
		border-top: 1px solid #292c2f;
		/*background-color: #292c2f;*/
		box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.12);
		box-sizing: border-box;
		width: 100%;
		font: bold 16px sans-serif;
		text-align: left;
	
		padding: 50px 60px 40px;
		margin-top: 80px;
		overflow: hidden;
	}
	
	/* Footer left */
	
	.footer-distributed .footer-left{
		float: left;
	}
	
	/* The company logo */
	
	.footer-distributed h3{
		color:  #ff4500;
		font: normal 36px 'Cookie', cursive;
		margin: 0 0 10px;
	}
	
	.footer-distributed h3 span{
		color:  #5383d3;
	}
	
	/* Footer links */
	
	.footer-distributed .footer-links{
		color:  #ff4500;
		margin: 0 0 10px;
		padding: 0;
	}
	
	.footer-distributed .footer-links a{
		display:inline-block;
		line-height: 1.8;
		text-decoration: none;
		color:  inherit;
	}
	
	.footer-distributed .footer-company-name{
		color:  #8f9296;
		font-size: 14px;
		font-weight: normal;
		margin: 0;
	}
	
	/* Footer social icons */
	
	.footer-distributed .footer-icons{
		margin-top: 40px;
	}
	
	.footer-distributed .footer-icons a{
		display: inline-block;
		width: 35px;
		height: 35px;
		cursor: pointer;
		background-color:  #fff;
		border-radius: 2px;
	
		font-size: 20px;
		color: #ff4500;
		text-align: center;
		line-height: 35px;
	
		margin-right: 3px;
		margin-bottom: 5px;
	}
	
	/* Footer Right */
	
	.footer-distributed .footer-right{
		float: right;
	}
	
	.footer-distributed .footer-right p{
		display: inline-block;
		vertical-align: top;
		margin: 15px 42px 0 0;
		color: #ff4500;
	}
	
	/* The contact form */
	
	.footer-distributed form{
		display: inline-block;
	}
	
	.footer-distributed form input,
	.footer-distributed form textarea{
		display: block;
		border-radius: 3px;
		box-sizing: border-box;
		background-color:  #fff;
		box-shadow: 0 1px 0 0 rgba(255, 255, 255, 0.1);
		border: none;
		resize: none;
	
		font: inherit;
		font-size: 14px;
		font-weight: normal;
		color:  #d1d2d2;
	
		width: 400px;
		padding: 18px;
	}
	
	.footer-distributed ::-webkit-input-placeholder {
		color:  #5c666b;
	}
	
	.footer-distributed ::-moz-placeholder {
		color:  #5c666b;
		opacity: 1;
	}
	
	.footer-distributed :-ms-input-placeholder{
		color:  #5c666b;
	}
	
	
	.footer-distributed form input{
		height: 55px;
		margin-bottom: 15px;
	}
	
	.footer-distributed form textarea{
		height: 100px;
		margin-bottom: 20px;
	}
	
	.footer-distributed form button{
		border-radius: 3px;
		background-color:  #33383b;
		color: #ffffff;
		border: 0;
		padding: 15px 50px;
		font-weight: bold;
		float: right;
	}
	
	/* If you don't want the footer to be responsive, remove these media queries */
	
	@media (max-width: 1000px) {
	
		.footer-distributed {
			font: bold 14px sans-serif;
		}
	
		.footer-distributed .footer-company-name{
			font-size: 12px;
		}
	
		.footer-distributed form input,
		.footer-distributed form textarea{
			width: 250px;
		}
	
		.footer-distributed form button{
			padding: 10px 35px;
		}
	
	}
	
	@media (max-width: 800px) {
	
		.footer-distributed{
			padding: 30px;
		}
	
		.footer-distributed .footer-left,
		.footer-distributed .footer-right{
			float: none;
			max-width: 300px;
			margin: 0 auto;
		}
	
		.footer-distributed .footer-left{
			margin-bottom: 40px;
		}
	
		.footer-distributed form{
			margin-top: 30px;
		}
	
		.footer-distributed form{
			display: block;
		}
	
		.footer-distributed form button{
			float: none;
		}
	}
	
	.bi-caret-down-fill{
         font-size: 40px;
         line-height: 40px;
         color:#FF4500;
     }
</style>
</head>
<body>
	<footer class="footer-distributed" >

			<div style="display:flex; justify-content: center;" class="footer-center center">

				<h3 style="font-size: 60px;">Seul<span>meal</span></h3>
				<div style="margin-left:30px; margin-right: 30px;">
				<p class="footer-links">
					<a href="/">Home</a>
					·
					<a href="https://github.com/jeongmooon">표정문</a>
					·
					<a href="https://github.com/ghm8614">천수병</a>
					·
					<a href="https://github.com/ttaehee">김태희</a>
					·
					<a href="https://github.com/KimMH853">김민혜</a>
					·
					<a href="https://github.com/CODArchive00">임정철</a>
				</p>

				<p class="footer-company-name" style="display: flex; justify-content: center;">seulmeal &copy; 2022</p>

				<div class="footer-icons" style=" display:flex; justify-content: center;">

					<a href="#"><i class="fa fa-facebook"></i></a>
					<a href="#"><i class="fa fa-twitter"></i></a>
					<a href="#"><i class="fa fa-linkedin"></i></a>
					<a href="https://github.com/ttaehee/seulmeal"><i class="fa fa-github"></i></a>
					
				</div>
				</div>
		<div id="google_translate_element" class="hd_lang" style="padding-top:10px;"></div>

	    <script>
	      function googleTranslateElementInit() {
	        new google.translate.TranslateElement({
	          pageLanguage: 'ko',
	          includedLanguages: 'ko,zh-CN,zh-TW,ja,vi,th,tl,km,my,mn,ru,en,fr,ar',
	          //layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
	          autoDisplay: false
	        }, 'google_translate_element');
	      }
	    </script>
	    <script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
			</div>
			<div class="footer-right">
				<p>맨 위로</p>
				<i class="bi bi-caret-up-fill"></i><br/>

			</div>

		</footer>

		<!-- Demo ads. Please ignore and remove. -->
		<script src="https://cdn.tutorialzine.com/misc/enhance/v2.js" async></script>
		
	</body>
	<!-- Footer -->
	<!-- 
	<div class="text-center footer">
		<hr />
		<p>2022.02~2022.06 seulMeal</p>
	</div> -->
	<script type="text/javascript">
	$('.footer-right').on('click',function(){
		window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
	});
	
	
	</script>
</body>
</html>