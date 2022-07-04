<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>

  <style>
*{list-style: none; text-decoration: none; font-family: sans-serif; font-weight: bold; font-size: 0.9rem;}

#index_wrap ul {display: block; margin-bottom: 50px;}
#index_wrap ul li {position: relative; display: inline-block; margin: 0 20px; height: 40px; text-align: center; line-height: 30px; cursor: pointer;}
#index_wrap ul p {font-size: 1.1rem; font-weight:800;}
#index_wrap ul li a {color: #000;}

#leftToRight li::after {position: absolute; content:""; display: block; border-bottom: 3px solid #000; transition: width 250ms ease-out; left: auto; right: 0;  width: 0;}
#leftToRight li:hover::after {width: 100%; left: 0; right: auto;}

#fromInsideOut li::after {position: absolute; content:""; display: block; border-bottom: 3px solid #000; transition: all 250ms ease-out; left: 50%; width: 0;}
#fromInsideOut li:hover::after {transition: all 250ms ease-out; left: 0%; width: 100%;}

#stretch li::after {position: absolute; content:""; display: block; border-bottom: 3px solid #000; transition: width 250ms ease-in-out; left: auto; width: 0;}
#stretch li:hover::after {width: 100%;}
  </style>

</head>


<body>
<div id="index_wrap">
  <ul id ="leftToRight">
    <p>왼쪽에서 오른쪽으로</p>
    <li><a href="#">ABOUT US</a></li>
    <li><a href="#">DESIGN CASE</a></li>
    <li><a href="#">STORY</a></li>
    <li><a href="#">CONTACT</a></li>
  </ul>

  <ul id ="fromInsideOut">
    <p>가운데서 바깥쪽으로</p>
    <li><a href="#">ABOUT US</a></li>
    <li><a href="#">DESIGN CASE</a></li>
    <li><a href="#">STORY</a></li>
    <li><a href="#">CONTACT</a></li>
  </ul>

  <ul id ="stretch">
    <p>늘어났다 줄어들었다</p>
    <li><a href="#">ABOUT US</a></li>
    <li><a href="#">DESIGN CASE</a></li>
    <li><a href="#">STORY</a></li>
    <li><a href="#">CONTACT</a></li>
  </ul>
</div>
</body>

</html>