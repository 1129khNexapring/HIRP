<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalCommonPage.jsp" %>
<h1 class="basic-border-bottom">결재문서함</h1>
<div id="guide" class="subConts">
<!-- 여백 필요 없을 경우 클래스에 padding-0 추가,필요 없으면 지울 것 -->
			<c:forEach var="appr" items="${aList}">
			<c:if test="${appr.emplId eq emplId && appr.apprType eq '결재'}">
			<button class="basic mt-20 apprbtn" type="button" id="apprbtn" onclick="openModal1(this);">반려</button>
			<section class="section--modal modal-reject" >
					<div class="bg-black"></div>
					<div class="section--modal__conts">
						<button class="btn--close" type="button"></button>
						<h3>반려하기</h3>
                            <form action="/proceed/appr.hirp" method="post">
                            <input type="hidden" value="${emplId}" name="emplId">
                            <input type="hidden" value="${approval.apprNo}" name="apprNo">
                            <input type="hidden" value="반려" name="aStatus">
                            <input type="hidden" value="반려" name="apprStatus">
                            
                            <ul>
                                <li>
                                	<textarea  cols="50" rows="7" placeholder="반려의견을 작성해주세요." name="apprComment"></textarea>
                                </li>
                            </ul>
						<div class="btns-wrap mt-20 t-r">
								<button class="point " type="submit">반려</button>
								<button class="finished closeWindow " type="button" >닫기</button>
						</div>
						</form>
				</section>
			
			<button class="point mt-20 apprbtn" type="button" id="apprbtn" onclick="openApprModal2(this);">결재</button>
				<section class="section--modal modal--appr" >
					<div class="bg-black"></div>
					<div class="section--modal__conts">
						<button class="btn--close" type="button"></button>
						<h3>결재하기</h3>
                            <form action="/proceed/appr.hirp" method="post" name="frmSubmit">
                            <input type="hidden" value="${emplId}" name="emplId">
                            <input type="hidden" value="${approval.apprNo}" name="apprNo">
                            <input type="hidden" value="승인" name="aStatus">
                            <c:if test="${aList[0].emplId eq emplId}">
                            <input type="hidden" value="진행" name="apprStatus">
                            </c:if>
                           <c:if test="${aList.get(aList.size()-1).emplId eq emplId}">
                            <input type="hidden" value="완료" name="apprStatus">
                            </c:if> 
                            <ul>
                                <li>
                                	<textarea  cols="50" rows="7" placeholder="의견을 작성해주세요." name="apprComment"></textarea>
                                </li>
                            </ul>
						<div class="btns-wrap mt-20 t-r">
								<button class="point" type="submit">승인</button>
								<button class="finished closeWindow" type="button" >닫기</button>
						</div>
							</form>
				</section>
				</c:if>
				<c:if test="${appr.emplId eq emplId && appr.apprType eq '합의'}">
			<button class="basic mt-20 apprbtn" type="button" id="apprbtn" onclick="openModal1(this);">반대</button>
			<section class="section--modal modal-reject" >
					<div class="bg-black"></div>
					<div class="section--modal__conts">
						<button class="btn--close" type="button"></button>
						<h3>합의 반대</h3>
                            <form action="/proceed/appr.hirp" method="post">
                            <input type="hidden" value="${emplId}" name="emplId">
                            <input type="hidden" value="${approval.apprNo}" name="apprNo">
                            <input type="hidden" value="반대" name="aStatus">
                            <c:if test="${aList[0].emplId eq emplId}">
                            <input type="hidden" value="진행" name="apprStatus">
                            </c:if>
                           	<c:if test="${aList.get(aList.size()-1).emplId eq emplId}">
                            <input type="hidden" value="완료" name="apprStatus">
                            </c:if> 
                            <ul>
                                <li>
                                	<textarea  cols="50" rows="7" placeholder="반대의견을 작성해주세요." name="apprComment"></textarea>
                                </li>
                            </ul>
						<div class="btns-wrap mt-20 t-r">
								<button class="point " type="submit">반대</button>
								<button class="finished closeWindow " type="button" >닫기</button>
						</div>
						</form>
				</section>
			
			<button class="point mt-20 apprbtn" type="button" id="apprbtn" onclick="openApprModal2(this);">합의</button>
				<section class="section--modal modal--appr" >
					<div class="bg-black"></div>
					<div class="section--modal__conts">
						<button class="btn--close" type="button"></button>
						<h3>합의</h3>
                            <form action="/proceed/appr.hirp" method="post" name="frmSubmit">
                            <input type="hidden" value="${emplId}" name="emplId">
                            <input type="hidden" value="${approval.apprNo}" name="apprNo">
                            <input type="hidden" value="합의" name="aStatus">
                            <c:if test="${aList[0].emplId eq emplId}">
                            <input type="hidden" value="진행" name="apprStatus">
                            </c:if>
                           <c:if test="${aList.get(aList.size()-1).emplId eq emplId}">
                            <input type="hidden" value="완료" name="apprStatus">
                            </c:if> 
                            <ul>
                                <li>
                                	<textarea  cols="50" rows="7" placeholder="의견을 작성해주세요." name="apprComment"></textarea>
                                </li>
                            </ul>
						<div class="btns-wrap mt-20 t-r">
								<button class="point" type="submit">합의</button>
								<button class="finished closeWindow" type="button" >닫기</button>
						</div>
							</form>
				</section>
				</c:if>
				</c:forEach>
			<div style="border: solid 1px #888; border-radius: 4px; margin-top: 60px; position: relative;">
			
			<table id="apprTable">
							<tr style="height: 30px; border: solid 1px #888;  line-height: 30px;">
								<td>기안자</td>
								<td>${employee.emplName} ${employee.positionCode }</td>
							</tr>
							<tr
								style="height: 30px; border: solid 1px #888; line-height: 30px;">
								<td>기안일</td>
								<td>${approval.writeDate }</td>
							</tr>
							<tr
								style="height: 35px; border: solid 1px #888; line-height: 30px;">
								<td>소속</td>
								<td>${employee.deptCode}</td>
							</tr>
						</table>
						<div id="approvalLine" class="fz-0">
							<!-- <div class="singleApprType">기안자</div> -->
							<div class="singleApprLine">
								<div class='singleApprLineTop'>기안자</div>
								<c:if test="${approval.temporaryStorage eq'N'}">
								<div class='singleApprLineMiddle2'>
								<img src="../../../../resources/images/icons/승인.png" style="width:40px; height:auto; vertical-align: middle;"/>
								<br>
								${employee.emplName} ${employee.positionCode}</div>
								</c:if>
								<c:if test="${approval.temporaryStorage eq'Y'}">
								<div class='singleApprLineMiddle'">
								${employee.emplName} ${employee.positionCode}</div>
								</c:if>
								
								<c:if test="${approval.temporaryStorage eq'N'}">
								<div class='singleApprLineBottom'>
								${approval.writeDate}
								</div>
								</c:if>
							</div>
						<c:forEach var="appr" items="${aList}">
							<div class="singleApprLine">
								<div class='singleApprLineTop'>${appr.apprType }</div>
								<c:if test="${appr.aStatus eq'승인'}">
								<div class='singleApprLineMiddle2'>
								<img src="../../../../resources/images/icons/승인.png" style="width:40px; height:auto; vertical-align: middle;"/>
								<br>
								${appr.employee.emplName} ${appr.employee.positionCode }</div>
								</c:if>
								<c:if test="${appr.aStatus ne '승인'}">
								<div class='singleApprLineMiddle' style="padding-top : 23px;">
								${appr.employee.emplName} ${appr.employee.positionCode}</div>
								</c:if>
								<c:if test="${appr.aStatus eq'승인'}">
								<div class='singleApprLineBottom' >
								 ${appr.apprDate}
								</div>
								</c:if>
								<c:if test="${appr.aStatus eq'반려'}">
								<div class='singleApprLineBottom' style="color:rgb(192,1, 1);">
								반려 ${appr.apprDate}
								</div>
								</c:if>
								<c:if test="${appr.aStatus eq'합의'}">
								<div class='singleApprLineBottom' style="color: #0b2a60" >
								합의 ${appr.apprDate}
								</div>
								</c:if>
								<c:if test="${appr.aStatus eq'반대'}">
								<div class='singleApprLineBottom' style="color:rgb(192,1, 1);">
								반대 ${appr.apprDate}
								</div>
								</c:if>
							</div>	
						</c:forEach>
						</div>
						
					</div>	
						<div class="row mt-20" style="margin-left:5px; ">
							<div>
								<div style="font-size: 15px; line-height: 30px; text-align: center; ">제목</div>
							</div>

							<div>
								<input type="text" size="125" name="apprTitle" value=" ${approval.apprTitle }" style="border-radius: 4px; border : 1px solid #888" readonly>
							</div>
						</div>
				
				<div id="apprContents">${approval.apprContents }</div>
			<div id="attached-file-div">	 
					<div style="margin-bottom : 10px; font-size:15px; font-weight:bolder;">첨부파일</div>
					<c:forEach var="file" items="${approval.fList}">
						<div><img src="../../../../resources/images/icons/attachedFile.png" style="width:12px; height:auto; vertical-align: middle;"/><a href="../../../../resources/uploadFiles/${file.fileRename }" download>${file.fileName}</a></div>
					</c:forEach>
			</div>
			</div>
			<script>
			function openApprModal2(modalWindow) {
			    $(modalWindow).siblings('.modal--appr').css('display', 'flex');
			}
			function openModal1(modalWindow) {
				    $(modalWindow).siblings('.modal-reject').css('display', 'flex');
			}
			    
			
			function submitForm(){
				var apprStatus = $("#apprStatus");
				var apprLevel = "${aList[0].emplId}";
				var emplId = "${emplId}";
				var theForm = document.frmSubmit;
				//첫번째 결재자가 로그인한 사람이라면
				console.log("${aList.get(aList.size()-1).emplId}");
			}
			
			</script>
			
			
</body>
</html>