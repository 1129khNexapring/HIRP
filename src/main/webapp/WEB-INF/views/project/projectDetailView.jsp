<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
<link rel="stylesheet" href="../../../resources/css/sub.css"><!-- 하이알피 서브페이지 CSS -->
<link rel="stylesheet" href="../../../resources/css/project.css?after">
<body>
	<%@ include file="/WEB-INF/views/include/inc_header.jsp" %>
	
	<div id="conts">
        <aside id="snb">
            <h1>프로젝트 관리</h1>
            <a class="btn--function" href="/project/writeView.hirp">프로젝트 만들기</a>

           	<ul>
               <li>
                   <a href="#none">프로젝트관리</a>
                   <ul>
                       <li class="on"><a href="/project/list.hirp">프로젝트 보기</a></li>
                   </ul>
               </li>
            </ul>
        </aside>

        <article id="sub" class="">
        	<%@ include file="/WEB-INF/views/include/inc_nav_right.jsp" %>
        	
        	<h1 class="basic-border-bottom">
				프로젝트 보기
            </h1>
            <div id="projectDetail" class="subConts">
	            <div class="basic-border mt-20">
					<div class="d-flex align-items-center justify-content-between">
						<h2 class="square-tit">프로젝트정보</h2>
						<div class="t-r">
							<button class="basic" type="button" onclick="openAlert(this);">삭제</button>
							<section class="section--alert">
								<div class="bg-black"></div>
								<div class="section--alert__conts">
									<button type="button" class="btn--close"></button>
									<p>
										확인을 누르시면<br>
										프로젝트 삭제가 진행됩니다. 삭제하시겠습니까?
									</p>
									<div class="btns-wrap mt-20">
										<button class="point" type="button" onclick="location.href='/project/remove.hirp?projectNo=${project.projectNo }'">확인</button>
										<button class="finished closeWindow" type="button">닫기</button>
									</div>
								</div>
							</section>
							<button class="basic" type="button" onclick="openModal(this);">수정</button>
							<section class="section--modal">
								<div class="section--modal__conts t-l">
									<button type="button" class="btn--close"></button>
									<h3>프로젝트 정보수정</h3>
									<ul>
										<li>
											<label for="">프로젝트명</label><input type="text" id="projectName" class="ml-10" name="projectName" value="${project.projectName }">
										</li>
										<li class="mt-10">
											<label for="">담당자(PM)</label><input type="text" id="projectManager" class="ml-10" name="projectManager" value="${project.projectManager }">
											<button class="basic ml-10" type="button" onclick="onAddEmplButton(this);">찾기</button>
											<section class="section--modal modal--chat">
												<div class="section--modal__conts" style="border: none">
													<button class="btn--close" type="button"></button>
													<h3>직원 선택</h3>
													<div class="mb-20">
														<ul>
															<li>
																<input type="text" name="emplSearchKeyword" size="25" placeholder="부서명 또는 사원명 검색">
																<button class="point" type="button" onclick="emplSearch();">검색</button>
															</li>
														</ul>
														<table class="table--basic mt-20" id="emplTable">
															<thead>
																<tr>
																	<th>부서</th>
																	<th>직급</th>
																	<th>이름</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach items="${emplList }" var="empl">
																	<tr onclick="emplTrClick(this);">
																		<td>${empl.deptName}</td>
																		<td>${empl.positionName}</td>
																		<td>${empl.emplName}</td>
																	</tr>
																	<input type="hidden" name="deptCode" value="${empl.deptCode }">
																	<input type="hidden" name="positionCode" value="${empl.positionCode }">
																	<input type="hidden" name="emplId" value="${empl.emplId }">
																</c:forEach>
															</tbody>
														</table>
													</div>
													<div class="btns-wrap mt-20 t-r">
														<button class="finished closeWindow" type="button">닫기</button>
													</div>
												</div>
											</section>
										</li>
										<li class="mt-10">
											<label for="">일자</label><input type="date" id="startDate" class="ml-10" name="startDate" value="${project.startDate }">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="${project.endDate }">
										</li>
									</ul>
									<div class="btns-wrap mt-20 t-r">
										<button class="point" type="button" onclick="updateBtn();">확인</button>
										<button class="finished closeWindow" type="button">닫기</button>
									</div>
								</div>
							</section>
							<button class="basic" onclick="location.href='/project/list.hirp'">목록</button>
						</div>
					</div>
	            	<table class="table--basic mt-20">
			            <tr>
			                <td>프로젝트명</td>
			                <td>${project.projectName }</td>
			            </tr>
			            <tr>
			                <td>담당자(PM)</td>
			                <td id="projectManager">${project.projectManager }</td>
			            </tr>
			            <tr>
			                <td>일자</td>
			                <td>${project.startDate }&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;${project.endDate }</td>
			            </tr>
		            </table>
		            <input type="hidden" id="projectNo" value="${project.projectNo }">
	            </div>
		            
				<div class="basic-border mt-20">
					<h2 class="square-tit">칸반보드보기</h2>
					<div class="row mt-10">
						<div class="col" data-order="0">
							<div class="basic-border mt-20 padding-20 pos-rel">
								<h3 id="noView"></h3><button class="btn--plus" type="button" onclick="openModal(this);">추가</button>
									<section class="section--modal">
										<div class="section--modal__conts">
											<button type="button" class="btn--close"></button>
											<h3>칸반보드 추가</h3>
											<ul>
												<li>
													<label for="">담당자</label><input type="text" id="emplName0" value="${project.projectManager }">
												</li>
												<li>
													<label for="">내용</label><input type="text" id="bContents0">
												</li>
											</ul>
											<div class="btns-wrap mt-20 t-r">
												<button class="point" type="button" onclick="boardBtn(this);" value="0">추가</button>
												<button class="finished closeWindow" type="button">닫기</button>
											</div>
										</div>
									</section>
							</div>
							<div class="basic-border mt-20 padding-20 kanbanCard" id="btbZero" data-draggable="target">
							</div>
						</div>
						<div class="col" data-order="1">
							<div class="basic-border mt-20 padding-20 pos-rel">
								<h3 id="beforeView"></h3><button class="btn--plus" type="button" onclick="openModal(this);">추가</button>
									<section class="section--modal">
										<div class="section--modal__conts">
											<button type="button" class="btn--close"></button>
											<h3>칸반보드 추가</h3>
											<ul>
												<li>
													<label for="">담당자</label><input type="text" id="emplName1" value="${project.projectManager }">
												</li>
												<li class="mt-10">
													<label for="">내용</label><input type="text" id="bContents1">
												</li>
											</ul>
											<div class="btns-wrap mt-20 t-r">
												<button class="point" type="button" onclick="boardBtn(this);" value="1">추가</button>
												<button class="finished closeWindow" type="button">닫기</button>
											</div>
										</div>
									</section>
							</div>
							<div class="basic-border mt-20 padding-20 kanbanCard" id="btbOne" data-draggable="target">
							</div>
						</div>
						<div class="col" data-order="2">
							<div class="basic-border mt-20 padding-20 pos-rel">
								<h3 id="proceedingView"></h3><button class="btn--plus" type="button" onclick="openModal(this);">추가</button>
									<section class="section--modal">
										<div class="section--modal__conts">
											<button type="button" class="btn--close"></button>
											<h3>칸반보드 추가</h3>
											<ul>
												<li>
													<label for="">담당자</label><input type="text" id="emplName2" value="${project.projectManager }">
												</li>
												<li>
													<label for="">내용</label><input type="text" id="bContents2">
												</li>
											</ul>
											<div class="btns-wrap mt-20 t-r">
												<button class="point" type="button" onclick="boardBtn(this);" value="2">추가</button>
												<button class="finished closeWindow" type="button">닫기</button>
											</div>
										</div>
									</section>
							</div>
							<div class="basic-border mt-20 padding-20 kanbanCard" id="btbTwo" data-draggable="target">
							</div>
						</div>
						<div class="col" data-order="3">
							<div class="basic-border mt-20 padding-20 pos-rel">
								<h3 id="completeView"></h3><button class="btn--plus" type="button" onclick="openModal(this);">추가</button>
									<section class="section--modal">
										<div class="section--modal__conts">
											<button type="button" class="btn--close"></button>
											<h3>칸반보드 추가</h3>
											<ul>
												<li>
													<label for="">담당자</label><input type="text" id="emplName3" value="${project.projectManager }">
												</li>
												<li>
													<label for="">내용</label><input type="text" id="bContents3">
												</li>
											</ul>
											<div class="btns-wrap mt-20 t-r">
												<button class="point" type="button" onclick="boardBtn(this);" value="3">추가</button>
												<button class="finished closeWindow" type="button">닫기</button>
											</div>
										</div>
									</section>
							</div>
							<div class="basic-border mt-20 padding-20 kanbanCard" id="btbThree" data-draggable="target">
							</div>
						</div>
						<div class="col" data-order="4">
							<div class="basic-border mt-20 padding-20 pos-rel">
								<h3 id="stopView"></h3><button class="btn--plus" type="button" onclick="openModal(this);">추가</button>
								<section class="section--modal">
									<div class="section--modal__conts">
										<button type="button" class="btn--close"></button>
										<h3>칸반보드 추가</h3>
										<ul>
											<li>
												<label for="">담당자</label><input type="text" id="emplName4" value="${project.projectManager }">
											</li>
											<li>
												<label for="">내용</label><input type="text" id="bContents4">
											</li>
										</ul>
										<div class="btns-wrap mt-20 t-r">
											<button class="point" type="button" onclick="boardBtn(this);" value="4">추가</button>
											<button class="finished closeWindow" type="button">닫기</button>
										</div>
									</div>
								</section>
							</div>
							<div class="basic-border mt-20 padding-20 kanbanCard" id="btbFour" data-draggable="target">
							</div>
						</div>
					</div>
				</div>
				
				<div class="basic-border mt-20">
					<h2 class="square-tit">프로젝트진행률</h2>
					<div class="progress-bar mt-20">
						<div class="progress" id="project-progress"></div>
					</div>
					<h3 id="progress" class="mt-10"></h3>
	<!--             	계산식 {(완료)+0.5*(진행중)/(전체-중지)}*100 -->
					<table class="table--basic mt-30">
						<thead>
							<tr>
								<th>진행상태</th>
								<th>갯수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>진행상태없음</td>
								<td id="noP"></td>
							</tr>
							<tr>
								<td>시작 전</td>
								<td id="beforeS"></td>
							</tr>
							<tr>
								<td>진행 중</td>
								<td id="proceeding"></td>
							</tr>
							<tr>
								<td>완료</td>
								<td id="complete"></td>
							</tr>
							<tr>
								<td>중지</td>
								<td id="stop"></td>
							</tr>
						</tbody>
					</table>
				</div>
           	</div>
		</article>
	</div>
	<script>
		// 드래그앤드롭
		$(function(){
			getBoardList();
			if
			(
				!document.querySelectorAll 
				|| 
				!('draggable' in document.createElement('span')) 
				|| 
				window.opera
			) 
			{ return; }
			
			for(var 
				items = document.querySelectorAll('[data-draggable="item"]'), 
				len = items.length, 
				i = 0; i < len; i ++)
			{
				items[i].setAttribute('draggable', 'true');
			}
			
			var item = null;
	
			document.addEventListener('dragstart', function(e)
			{
				item = e.target;
				e.dataTransfer.setData('text', '');
			
			}, false);
	
			document.addEventListener('dragover', function(e)
			{
				if(item)
				{
					e.preventDefault();
				}
			
			}, false);	
	
			document.addEventListener('drop', function(e)
			{
				if(e.target.getAttribute('data-draggable') == 'target')
				{
					e.target.appendChild(item);
					
					e.preventDefault();
					modifyBoard(item);
				}
			}, false);
			
			document.addEventListener('dragend', function(e)
			{
				item = null;
			
			}, false);
		});
		
		function openAlert(alertWindow) {
			var emplName = "${emplName}";
			var projectManager = "${project.projectManager}";
			if(emplName == projectManager) {
			    $(alertWindow).siblings('.section--alert').css('display', 'flex');
			}else {
				alert("프로젝트 담당자만 삭제할 수 있습니다.");
			}
		}
		
		function openModal(modalWindow) {
			var emplName = "${emplName}";
			var projectManager = "${project.projectManager}";
			if(emplName == projectManager) {
			    $(modalWindow).siblings('.section--modal').css('display', 'flex');
			}else {
				alert("프로젝트 담당자만 수정할 수 있습니다.");
			}
		}
		
		// 칸반보드 추가
		function boardBtn(btn) {
			var projectNo = $("#projectNo").val();
			var boardStatus = $(btn).val();
			var emplName = $("#emplName"+boardStatus).val();
			var boardContents = $("#bContents"+boardStatus).val();
			$.ajax({
				url : "/project/boardAdd.hirp",
				type : "post",
				data : {
					"projectNo" : projectNo,
					"emplName" : emplName,
					"boardContents" : boardContents,
					"boardStatus" : boardStatus
				},
				success : function(data) {
					location.reload();
					$(".section--modal").stop().fadeOut(100);
					$("#bContents"+boardStatus).val("");
					getBoardList();
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
		
		// 칸반보드 리스트
		function getBoardList() {
			var pNo = $("#projectNo").val();
			$.ajax({
				url : "/project/selectBoard.hirp",
				type : "get",
				data : { "projectNo" : pNo },
				dataType : "json",
				async : false,
				success : function(data) {
					var count = data.length;
					var $divZero = $("#btbZero");
					var $divOne = $("#btbOne");
					var $divTwo = $("#btbTwo");
					var $divThree = $("#btbThree");
					var $divFour = $("#btbFour");
					$divZero.html("");
					$divOne.html("");
					$divTwo.html("");
					$divThree.html("");
					$divFour.html("");
					for(var i = 0; i < data.length; i++) {
						var $table = $("<table class='basic-border kanban' data-draggable='item' data-number='"+data[i].boardNo+"'>");
						var $trHead = $("<tr class='kanbanHead'>");
						var $trBody = $("<tr class='kanbanBody'>");
						var $emplName = $("<td>").text(data[i].emplName);
						var $boardContents = $("<td colspan='2'>").text(data[i].boardContents);
						var $btnArea = $("<td>")
										.append("<button class='kanbanCloseBtn' type='button' onclick='openAlert(this);'></button>"
									                    +"<section class='section--alert'>"
								                        +"<div class='bg-black'></div>"
								                        +"<div class='section--alert__conts'>"
								                            +"<button class='btn--close' type='button'></button>"
								                            +"<p style='color:black;'>"
								                                +"확인을 누르시면<br>"
								                                +"칸반보드 삭제가 진행됩니다. 삭제하시겠습니까?"
								                            +"</p>"
								                            +"<div class='btns-wrap mt-20'>"
								                                +"<button class='point' type='button' onclick='removeBoard("+data[i].boardNo+");'>확인</button>"
								                                +"<button class='finished closeWindow' type='button'>닫기</button>"
								                            +"</div>"
								                        +"</div>"
								                    +"</section>");
						$trHead.append($emplName);
						$trHead.append($btnArea);
						$trBody.append($boardContents);
						$table.append($trHead);
						$table.append($trBody);
						if(data[i].boardStatus == "0") {
							$divZero.append($table);
						}else if(data[i].boardStatus == "1") {
							$divOne.append($table);
						}else if(data[i].boardStatus == "2") {
							$divTwo.append($table);
						}else if(data[i].boardStatus == "3") {
							$divThree.append($table);
						}else if(data[i].boardStatus == "4") {
							$divFour.append($table);
						}
					}
					document.getElementById("noView").innerHTML = "진행사항없음("+$("#btbZero >table").length+"/9999)";
					document.getElementById("beforeView").innerHTML = "시작 전("+$("#btbOne >table").length+"/9999)";
					document.getElementById("proceedingView").innerHTML = "진행 중("+$("#btbTwo >table").length+"/9999)";
					document.getElementById("completeView").innerHTML = "완료("+$("#btbThree >table").length+"/9999)";
					document.getElementById("stopView").innerHTML = "중지("+$("#btbFour >table").length+"/9999)";
					var projectProgress =
						Math.floor((($("#btbThree >table").length + 0.5) * ($("#btbTwo >table").length)) / (count-($("#btbFour >table").length)) * 100);
					document.getElementById("progress").innerHTML = "진행률 <strong>" + projectProgress + "%</strong>";
					document.getElementById("noP").innerHTML = $("#btbZero >table").length;
					document.getElementById("beforeS").innerHTML = $("#btbOne >table").length;
					document.getElementById("proceeding").innerHTML = $("#btbTwo >table").length;
					document.getElementById("complete").innerHTML = $("#btbThree >table").length;
					document.getElementById("stop").innerHTML = $("#btbFour >table").length;
					document.getElementById("project-progress").style.width = projectProgress + "%";
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
		
		// 칸반보드 드래그앤드롭 시 상태값 수정
		function modifyBoard(obj) {
			var boardNo = $(obj).attr("data-number");
			var boardStatus = $(obj).parent().parent().attr("data-order");
			$.ajax({
				url : "/project/updateBoard.hirp",
				type : "post",
				data : { "boardNo" : boardNo, "boardStatus" : boardStatus},
				success : function(data) {
					location.reload();
				},
				error : function() {
					alert("ajax 실패!");
				}
			});
		}
		
		// 칸반보드 삭제
		function removeBoard(boardNo) {
			$.ajax({
				url : "/project/deleteBoard.hirp",
				type : "get",
				data : { "boardNo" : boardNo },
				success : function(data) {
					if(data == "success") {
						getBoardList();
					}else {
						alert("칸반보드 삭제 실패!");
					}
				},
				error : function() {
					alert("Ajax 통신 실패!");
				}
			});
		}
		
		// 프로젝트 정보 수정
		function updateBtn() {
			var projectNo = '${project.projectNo }';
			var projectName = document.getElementById('projectName').value;
			var projectManager = document.getElementById('projectManager').value;
			var startDate = document.getElementById('startDate').value;
			var endDate = document.getElementById('endDate').value;
			location.href = '/project/modify.hirp?projectNo='+projectNo+'&projectName='+projectName+'&projectManager='+projectManager+'&startDate='+startDate+'&endDate='+endDate;
		}
		
		//응답자 추가 버튼
		function onAddEmplButton(e){
			openModal(e);
			//본인 소속팀과 하위 부서 check 해제
			$("#subjectRadio2").prop("checked", true);
			$("#subDeptCheck").prop("checked", false);
		}
		
		//응답자 목록에서 검색 (ajax)
		function emplSearch(){
			var emplSearchKeyword = $("[name='emplSearchKeyword']").val();
			
			$.ajax({
				url:"/searchEmplList.hirp",
				type:"post",
				data:{"emplSearchKeyword" : emplSearchKeyword},
				success: function(eList){
	    			var count = eList.length;
	    			
	    			var $tableBody = $("#emplTable tbody");
	    			$tableBody.html("");
	    			
	    			for(var i=0; i<count; i++){
	        			var $tr = $("<tr onclick='emplTrClick(this);'>");
	        			var $tdDept = $("<td>").html(eList[i].deptName);
	        			var $tdPosition = $("<td>").html(eList[i].positionName);
	        			var $tdName = $("<td>").html(eList[i].emplName);
						$tr.append($tdDept);
						$tr.append($tdPosition);
						$tr.append($tdName);
						$tableBody.append($tr);
						
						var hiddenDeptCode = "<input type='hidden' name='deptCode' value="+eList[i].deptCode+">"
						var hiddenPositionCode = "<input type='hidden' name='positionCode' value="+eList[i].positionCode+">"
						var hiddenEmplId = "<input type='hidden' name='emplId' value="+eList[i].emplId+">"
						$tableBody.append(hiddenDeptCode);
						$tableBody.append(hiddenPositionCode);
						$tableBody.append(hiddenEmplId);
					}
	    			
	    		},
	    		error: function(){
					var $tableBody = $("#emplTable tbody");
	    			$tableBody.html("");
	    			var $tr = $("<tr>");
	    			var $text = $("<div class='t-c' style='align:center;'>").html("검색 결과가 없습니다.");
					$tr.append($text);
					$tableBody.append($tr);
	    		}
			});
		}
		
		//tr이 클릭될 때
		function emplTrClick(e) {
 			var tdArr = new Array();
			
 			var tr = $(e);
 			var td = tr.children();
			
			td.each(function(i){
				tdArr.push(td.eq(i).text());
 			});
			
 			var hiddenEmplId = tr.next().next().next();
			
 			tdArr.push(hiddenEmplId.val());
			
 			$("#projectManager").val(tdArr[3]);
		}
	</script>
</body>
</html>