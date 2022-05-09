<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
<link rel="stylesheet" href="../../../resources/css/sub.css"><!-- 하이알피 서브페이지 CSS -->
<link rel="stylesheet" href="../../../resources/css/project.css">

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/inc_header.jsp" %>
	
	<div id="conts">
        <aside id="snb">
            <h1>
                	메일
            </h1>
            <a class="btn--function" href="/mail/writeView.hirp">메일쓰기</a>

            <ul>
               <li>
                   <a href="">메일함</a>
                   <ul>
                       <li><a href="#">받은메일함</a></li>
                       <li><a href="#">보낸메일함</a></li>
                       <li><a href="#">임시보관함</a></li>
                       <li><a href="#">내게쓴메일함</a></li>
                       <li><a href="#">중요메일함</a></li>
                       <li><a href="#">휴지통</a><button class="basic mt-20" type="button">비우기</button></li>
                   </ul>
               </li>
            </ul>
            
            <a class="btn--function" href="#">버그리포트 작성</a>
        </aside>

        <article id="sub" class="">
        	<%@ include file="/WEB-INF/views/include/inc_nav_right.jsp" %>
        	
        	<h1 class="basic-border-bottom">
				메일쓰기
            </h1>
            <div class="subConts">
            	<form action="/mail/send.hirp" method="post">
		            <button class="basic mt-20" type="submit">보내기</button>
		            <button class="basic mt-20" type="button">임시저장</button>
	            	<h4>받는사람</h4>
	            	<input id="check1" class="mt-20" type="checkbox">
	            	<label for="check1">나에게</label>
	            	<input type="text" name="mailRecipient">
	            	<button class="basic mt-20" type="button">주소록</button><br>
	            	<h4>참조</h4>
	            	<input type="text" name="mailReferrer">
	            	<button class="basic mt-20" type="button">주소록</button><br>
	            	<h4>제목</h4>
	            	<input type="text" name="mailTitle"><br>
	            	<h4>파일첨부</h4>
	            	<button class="basic mt-20" type="button">파일선택</button>
	            	<button class="basic mt-20" type="button">모두 삭제</button>
	            	<textarea rows="" cols="" name="mailContents"></textarea>
            	</form>
	        </div>
        </article>
	</div>
</body>
</html>