<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
	body, body *{
		font-family: 'Jua'
	}
</style>
</head>
<body>
<h2><b>Jenkins에 Maven project 배포 연습</b></h2>
<h5>코붕이 젠킨스 배포 성공했냐?</h5>
<h5>자동빌드 테스트</h5>

<div class="input-group">
	<textarea id="msg" style="width:100%; height:120px;" class="form-control">오늘자 코붕이 ㅈ 됐다</textarea>
</div>
<div class="input-group" style="width:250px; margin-lef:50px; margin-top:10px;">
	<select id="seltrans" class="form-select">
		<option value="ko">한국어</option>
		<option value="en">영어</option>
		<option value="ja">일어</option>
		<option value="zh-CN">중국어</option>
		<option value="es">스페인어</option>
		<option value="de">독일어</option>
	</select>
	<button type="button" id="btntrans" class="btn btn-outline-danger">번역하기</button>
	
	<i class="bi bi-megaphone speak voicespeak" style="font-size:30px; margin-left:10px; cursor:pointer"></i>
</div>
<div id="trans"></div>
<script>
	$("#btntrans").click(function(){
		//입력한 메세지
		let msg=$("#msg").val();
		let lang=$("#seltrans").val();
		$.ajax({
			type:"post",
			url:"trans",
			data:{"msg":msg,"lang":lang},
			dataType:"text", //String이 리턴되니까 text
			success:function(res){
				//alert(res);
				//String을 json데이터로 변환
				let j=JSON.parse(res);
				//번역한 문자열을 얻는다
				let s=j.message.result.translatedText;
				$("#trans").html(s);
			}
		});
	});
	
	$(".voicespeak").click(function(){
		let msg=$("#trans").text();
		let lang=$("#seltrans").val();
		
		if(lang=='en' || lang=='ja' || lang=='zh-CN' || lang=='es' || lang=='ko'){
		$.ajax({
			type:"get",
			url:"voice",
			data:{"msg":msg,"lang":lang},
			dataType:"text",
			success:function(res) { //res:mp3파일명 반환
				let audio=new Audio(res);
				audio.play();
			}
		});
		}
		else
			alert("ㅇㅇ?");
	});
</script>
</body>
</html>
