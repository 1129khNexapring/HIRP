<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
<link rel="stylesheet" href="../../../resources/css/sub.css"><!-- 하이알피 서브페이지 CSS -->
<body>
	<%@ include file="/WEB-INF/views/include/inc_header.jsp" %>
	
	<div id="conts">
        <aside id="snb">
            <h1>메일</h1>
            <a class="btn--function" href="/mail/writeView.hirp">메일쓰기</a>

            <ul class="ul--mail">
               <li>
                   <a href="#none">메일함</a>
                   <ul>
                       <li <c:if test="${mailCategory == 'R' }">class="on"</c:if>><a href="/mail/Rlist.hirp">받은메일함</a></li>
                       <li <c:if test="${mailCategory == 'S' }">class="on"</c:if>><a href="/mail/Slist.hirp">보낸메일함</a></li>
                       <li <c:if test="${mailCategory == 'T' }">class="on"</c:if>><a href="/mail/Tlist.hirp">임시보관함</a></li>
                       <li <c:if test="${mailCategory == 'M' }">class="on"</c:if>><a href="/mail/Mlist.hirp">내게쓴메일함</a></li>
                       <li <c:if test="${mailCategory == 'I' }">class="on"</c:if>><a href="/mail/Ilist.hirp">중요메일함</a></li>
                       <li <c:if test="${mailCategory == 'W' }">class="on"</c:if>><a href="/mail/Wlist.hirp">휴지통</a><button class="basic" type="button" onclick="deleteAllMail();">비우기</button></li>
                   </ul>
               </li>
            </ul>
            
            <a class="btn--function bugReport" href="/bugReport/WriteView.hirp">
				<img src="../../../resources/images/icons/icon_bugreport.png" alt="icon">
				버그리포트 작성
			</a>
        </aside>

        <article id="sub" class="mailList">
        	<%@ include file="/WEB-INF/views/include/inc_nav_right.jsp" %>
        	
        	<!-- 검색 -->
        	<form class="form--srch" action="/mail/searchMail.hirp" method="get">
        		<select name="searchCondition">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="contents">내용</option>
					<option value="sender">보낸사람</option>
					<option value="recipient">받는사람</option>
					<option value="referrer">참조</option>
				</select>
                <input type="text" name="searchValue" placeholder="메일검색">
                <button type="submit"></button>
            </form>
            
        	<h1 class="basic-border-bottom">
	            <c:if test="${mailCategory == 'R' }">
					받은메일함
	            </c:if>
	            <c:if test="${mailCategory == 'S' }">
					보낸메일함
	            </c:if>
            	<c:if test="${mailCategory == 'T' }">
					임시보관함
            	</c:if>
            	<c:if test="${mailCategory == 'M' }">
					내게쓴메일함
            	</c:if>
            	<c:if test="${mailCategory == 'I' }">
					중요메일함
            	</c:if>
            	<c:if test="${mailCategory == 'W' }">
					휴지통
            	</c:if>
            	<c:if test="${mailCategory != 'R' && mailCategory != 'S' && mailCategory != 'T'
            	&& mailCategory != 'M' && mailCategory != 'I' && mailCategory != 'W' }">
            		검색
            	</c:if>
            </h1>
            
			<div class="btns-wrap padding-20">					
				<input id="check1" type="checkbox" onclick="selectAll(this);">
				<label for="check1"></label>
				<c:if test="${mailCategory != 'W' && mailCategory != 'T' && mailCategory != 'M'}">
					<button class="basic" type="button" onclick="replyMail();">답장</button>
				</c:if>
				<button class="basic type="button" value="${mail.mailNo }" onclick="wasteMail('${mailCategory}');">삭제</button>
				<c:if test="${mailCategory != 'W' && mailCategory != 'T'}">
					<button class="basic" type="button" onclick="relayMail();">전달</button>
				</c:if>
				<c:if test="${mailCategory == 'W' }">
					<button class="basic" type="button" onclick="restoreMail();">복구</button>
				</c:if>
			</div>
            
            <div class="subConts">
	        	<table class="table--basic">
					<c:if test="${mailCategory == 'W' }">
						<colgroup>
							<col style="width:2%;">
							<col style="width:2%;">
							<col style="width:15%;">
							<col style="width:53%;">
							<col style="width:10%;">
						</colgroup>
					</c:if>
					<c:if test="${mailCategory != 'W' }">
						<colgroup>
							<col style="width:2%;">
							<col style="width:2%;">
							<col style="width:2%;">
							<col style="width:15%;">
							<col style="width:53%;">
							<col style="width:10%;">
						</colgroup>
					</c:if>
                   	<c:forEach items="${mList }" var="mail">
                   		<!-- 검색 -->
                  		<c:if test="${mailCategory != 'R' && mailCategory != 'S' && mailCategory != 'T'
            			&& mailCategory != 'M' && mailCategory != 'I' && mailCategory != 'W' }">
	                    	<tr>
	                            <c:url var="mDetail" value="/mail/detail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" name="impMail" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailSender }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
                        </c:if>
                    	<!-- 받은메일함 -->
                    	<c:if test="${mailCategory == 'R' }">
	                        <tr>
	                            <c:url var="mDetail" value="/mail/Rdetail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" name="impMail" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailSender }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
	                    <!-- 보낸메일함 -->
                    	<c:if test="${mailCategory == 'S' }"> 	
	                        <tr>
	                            <c:url var="mDetail" value="/mail/Sdetail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" name="impMail" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailRecipient }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
	                    <!-- 임시보관함 -->
	                    <c:if test="${mailCategory == 'T' }"> 
	                        <tr>
	                            <c:url var="mDetail" value="/mail/temporaryStorageDetailView.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<c:if test="${mail.mailRecipient eq null }">(받는이없음)</c:if>
									${mail.mailRecipient }
								</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
	                    <!-- 내게쓴메일함 -->
	                    <c:if test="${mailCategory == 'M' }">
	                        <tr>
	                            <c:url var="mDetail" value="/mail/Mdetail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailSender }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
	                    <!-- 중요메일함 -->
	                    <c:if test="${mailCategory == 'I' }"> 	
	                        <tr>
	                            <c:url var="mDetail" value="/mail/Idetail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--star">
										<input type="checkbox" id="important${mail.mailNo }" value="${mail.mailNo }" onclick="importantMail(this);"
										<c:if test="${mail.importantMail == 'Y' }">checked</c:if>>
										<label for="important${mail.mailNo }"></label>
									</div>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailSender }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
	                    <!-- 휴지통 -->
	                    <c:if test="${mailCategory == 'W' }">			
	                        <tr>
	                            <c:url var="mDetail" value="/mail/Wdetail.hirp">
									<c:param name="mailNo" value="${mail.mailNo }"></c:param>
								</c:url>
								<td>
									<input id="check${mail.mailNo }" type="checkbox" name="mail" value="${mail.mailNo }">
									<label for="check${mail.mailNo }"></label>
								</td>
								<td>
									<div class="mail--read">
										<input type="checkbox" id="read${mail.mailNo }" name="readMail" value="${mail.mailNo }" onclick="readMail(this, ${mail.mailNo});"
										<c:if test="${mail.mailRead == 'Y' }">checked</c:if>>
										<label for="read${mail.mailNo }"></label>
									</div>
								</td>
								<td>${mail.mailSender }</td>
								<td><a href="${mDetail}" onclick="readMail(this, ${mail.mailNo});">${mail.mailTitle }</a></td>
								<td>${mail.mailDate }</td>
	                        </tr>
	                    </c:if>
					</c:forEach>
                </table>
                
                <!-- 받은메일함 페이징 -->
                <c:if test="${mailCategory == 'R' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Rlist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Rlist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Rlist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
                <!-- 보낸메일함 페이징 -->
                <c:if test="${mailCategory == 'S' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Slist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Slist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Slist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
                <!-- 임시보관함 페이징 -->
                <c:if test="${mailCategory == 'T' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Tlist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Tlist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Tlist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
                <!-- 내게쓴메일함 페이징 -->
                <c:if test="${mailCategory == 'M' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Mlist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Mlist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Mlist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
                <!-- 중요메일함 페이징 -->
                <c:if test="${mailCategory == 'I' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Ilist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Ilist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Ilist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
                <!-- 휴지통 페이징 -->
                <c:if test="${mailCategory == 'W' }">
	                <div class="btns--paging">
		                <c:if test="${pi.currentPage > '1' }">
		                	<button class="fa-solid fa-angle-left prev" onclick="location.href='/mail/Wlist.hirp?page=${pi.currentPage-1 }'"></button>
		                </c:if>
		                <c:forEach var="p" begin="${pi.startNavi }" end="${pi.endNavi }">
		                	<c:url var="pagination" value="/mail/Wlist.hirp">
		                		<c:param name="page" value="${p }"></c:param>
		                	</c:url>
		                	&nbsp;<a href="${pagination }">${p }</a>&nbsp;
		                </c:forEach>
		                <c:if test="${pi.currentPage < pi.endNavi }">
		                	<button class="fa-solid fa-angle-right next" onclick="location.href='/mail/Wlist.hirp?page=${pi.currentPage+1 }'"></button>
		                </c:if>
	                </div>
                </c:if>
			</div>
        </article>
	</div>
	<script>
		// 답장
		function replyMail() {
			var mailTag = $("input[name=mail]:checked");
			var mailNo;
			if(mailTag.length != 1)	{
				alert("1개의 메일을 선택해 주세요.");
			}else {
				mailNo = mailTag[0].value;
				location.href='/mail/mailReplyView.hirp?mailNo='+mailNo;
			}
		}

		// 전달
		function relayMail() {
			var mailTag = $("input[name=mail]:checked");
			var mailNo;
			if(mailTag.length != 1)	{
				alert("1개의 메일을 선택해 주세요.");
			}else {
				mailNo = mailTag[0].value;
				location.href='/mail/mailRelayView.hirp?mailNo='+mailNo;
			}
		}
		
		// 전체 선택
		function selectAll(selectAll) {
			const checkboxes = document.getElementsByName("mail");
			
			checkboxes.forEach((checkbox) => {
				checkbox.checked = selectAll.checked;
			})
		};
		
		// 체크박스 선택 후 버튼 클릭 메일 휴지통으로 이동
		function wasteMail(category) {
			if(category == 'W') {
				deleteSelectMail();
			}else {
				var mailTag = $("input[name=mail]:checked");
				var mailNo = [];
				for(var i = 0; i < mailTag.length; i++) {
					mailNo.push(mailTag[i].value);
				}
				$.ajax({
					url : "/mail/wasteMail.hirp",
					type : "post",
					data : { "mailNo" : mailNo },
					traditional : true,
					success : function() {
						location.reload();
					},
					error : function() {
						alert("ajax 실패!");
					}
				});
			}
		};
				
		// 휴지통 메일 복구
		function restoreMail() {
			var mailTag = $("input[name=mail]:checked");
			var mailNo = [];
			for(var i = 0; i < mailTag.length; i++) {
				mailNo.push(mailTag[i].value);
			}
			$.ajax({
				url : "/mail/restoreMail.hirp",
				type : "post",
				data : { "mailNo" : mailNo },
				traditional : true,
				success : function() {
					location.reload();
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
				
		// 메일 읽음 표시
		function readMail(read, mailNumber) {
			var chkread = $(read).prop("checked");
			var mailRead = 'Y';
			if($(read).attr("type") == "checkbox") {
				if(chkread == true) {
					mailRead = 'Y';
				}else {
					mailRead = 'N';
				}
			}
			$.ajax({
				url : "/mail/readMail.hirp",
				type : "post",
				data : { "mailNo" : mailNumber, "mailRead" : mailRead },
				success : function() {
					location.reload;
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
		
		// 휴지통 선택 메일 삭제
		function deleteSelectMail() {
			var mailTag = $("input[name=mail]:checked");
			var mailNo = [];
			for(var i = 0; i < mailTag.length; i++) {
				mailNo.push(mailTag[i].value);
			}
			$.ajax({
				url : "/mail/deleteSelectMail.hirp",
				type : "get",
				data : { "mailNo" : mailNo },
				traditional : true,
				success : function() {
					location.reload();
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
	</script>
	<script src="../../../resources/js/mail.js"></script>
</body>
</html>