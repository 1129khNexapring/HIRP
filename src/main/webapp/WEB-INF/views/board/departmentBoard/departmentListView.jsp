<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
<link rel="stylesheet" href="../../../resources/css/sub.css"><!-- 하이알피 서브페이지 CSS -->

<body>
    <%@ include file="/WEB-INF/views/include/inc_header.jsp" %>

    <div id="conts">
        <%@ include file="/WEB-INF/views/include/inc_board.jsp" %>

        <article id="sub" class="">
       
            <%@ include file="/WEB-INF/views/include/inc_nav_right.jsp" %>

           
            <h1 class="basic-border-bottom">부서게시판</h1>

            <div id="department" class="subConts padding-0">
				<table class="table--basic mt-40">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:40%;">
                        <col style="width:15%;">
                        <col style="width:15%;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                    </colgroup>
                    <thead>
                        <tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
							<th>첨부파일</th>
						</tr>
                    </thead>
                    <tbody>
						<c:forEach var="dept" items="${dList }">
                        <tr>
                           	<c:url var="dDetail" value="/department/detail.hirp">
								<c:param name="deptNo" value="${dept.deptNo }"></c:param>
							</c:url>
							<td><a href="${dDetail }">${dept.deptNo }</a></td>
							
							<td><a href="${dDetail }">&nbsp; ${dept.deptTitle }</a></td>
							<td>${dept.emplId }</td>
							<td>${dept.writeDate}</td>
							<td>${dept.deptCount }</td>
							<td>
							<c:if test="${empty dept.bList}">X</c:if>
							<c:if test="${not empty dept.bList}">O</c:if>
							</td>
                        </tr>
						</c:forEach>
                    </tbody>
				</table>
				<div class="btns--paging">
					<c:if test="${pi.currentPage > '1' }">
						<button class="fa-solid fa-angle-left prev" onclick="location.href='/department/list.hirp?page=${pi.currentPage-1 }'"></button>
					</c:if>
					<c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
						<c:url var="pagination" value="/department/list.hirp">
							<c:param name="page" value="${p }"></c:param>
						</c:url>
						<a href="${pagination }">${p }</a>
					</c:forEach>
					<c:if test="${pi.currentPage < pi.endNavi }">
						<button class="fa-solid fa-angle-right next" onclick="location.href='/department/list.hirp?page=${pi.currentPage+1 }'"></button>
					</c:if>
				</div>
				<div class="board__srch-wrap t-c">
					<form action="/department/searchList.hirp" method="get">
					<input type="hidden" name="currentPage" value="1">
					<input type="hidden" name="listLimit" value="10">
						<select name="searchCondition">
							<option value="all">전체</option>
							<option value="title">제목</option>
							<option value="contents">내용</option>
							<option value="writer">작성자</option>
						</select>
						<input type="text" name="searchValue">
						<input type="submit" value="검색">
					</form>
				</div>
            </div>           
        </article>
    </div>
</body>

</html>