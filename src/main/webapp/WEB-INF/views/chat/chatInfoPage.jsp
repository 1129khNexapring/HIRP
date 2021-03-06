<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 정보</title>
<%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
<link rel="stylesheet" href="../../../resources/css/chat.css">
</head>
<body>
	<div id="conts" class="pos-rel">
        <article id="sub" class="padding-20" style="padding-bottom:10px;">
        	<div class="t-c">
        		<h2 class="mb-10 padding-top">${chatroom.chatroomName }</h2>
        		<h3 style="font-weight:normal; color: #8C8C8C">${fn:length(chatRoomJoinList)}명</h3>
        	</div>
        	<!-- 버튼 div -->
        	<div class="t-c mt-20 mb-20 basic-border-bottom" style="padding-bottom:30px;">
	        	<div class="t-c" style="display:inline-block">
	        		<button id="editChatroom" class="btn--profile mb-10" type="button">
	      		    	<i class="fa-solid fa-pen"></i>
				    </button>
				    <div>
				    	편집
				    </div>
				    <section id="chatNameModal" class="modal--chatSelect shadow t-c">
						<div style="width: 90%; position: absolute; top: 50%; margin-top: -80px;">
							<h3 style="text-align:left"> 채팅방 이름 입력 </h3>
							<input style="width: 95%;" type="text" name="chatroomName" placeholder="${chatroom.chatroomName } ">
						</div>
						<div class="btns-wrap">
							<button class="point" type="button" onclick="updateChatroomName('${chatroom.chatroomNo}');">확인</button>
							<button class="cancel" type="button">취소</button>
						</div>
					</section>
			    </div>
			    <div class="t-c ml-20" style="display:inline-block">
	        		<button id="addEmpl" class="btn--profile mb-10" type="button">
	      		    	<i class="fa-solid fa-plus"></i>
				    </button>
				    <div>
				    	직원초대
				    </div>
<!-- 				    <form id="addChatroomJoinForm" action="/addChatroomJoin.hirp" method="post"> -->
						<!-- 채팅방 추가 모달창 -->
						<section id="chatEmplListModal" class="modal--chatSelect shadow">
							<h3>대화상대 선택 <span></span></h3>
							<!-- 검색창 -->
							<div class="modal--chatSelect__srch row mt-10 t-c padding-bottom-10">
								<input type="text" name="emplSearchKeyword" placeholder="부서명 또는 사원명 검색">
								<button class="point" type="button" onKeypress="javascript:if(event.keyCode==13) {emplSearch(this);}" onclick="emplSearch(this);">검색</button>
							</div>
							<div class="modal--chatSelect__emplList" style="text-align: left;">
							    <c:forEach items="${emplList }" var="empl">
							   		
							    	<c:if test="${empl.emplId ne sessionScope.emplId }"> <!-- 내가 아닐 때 -->
									    <!-- 직원명 div  -->
									    <!-- 여기 count로 해놨는데 사실은 roomid로 해야할 듯. -->
									    <div class="chat-row mt-10  padding-bottom-10">
										    <div class="mr-20" style="width:30px;">
								      		    <button class="btn--profile" type="button">
								      		    	<c:if test="${empl.emplProfile eq null}">
												        <img src="../resources/images/img_no_profile.png" alt="profile">
								      		    	</c:if>
								      		    	<c:if test="${empl.emplProfile ne null}">
												        <img src="../resources/uploadFiles/${empl.emplProfile }" alt="profile">
								      		    	</c:if>
											    </button>
										    </div>
										    <div class="modal--chatSelect__empList__checkbox-wrap pos-rel ml-20">
										    	<label for="${empl.emplId }">${empl.deptName } ${empl.emplName } ${empl.positionName }</label>
										    	<c:set var="doneChatJoinLoop" value="false"/>
										    	<c:forEach items="${chatRoomJoinList }" var="chatJoin" varStatus="chatJoinStatus">
										    		<c:if test="${not doneChatJoinLoop}">
												    	<c:if test="${empl.emplId eq chatJoin.joinchatId}"> <!-- 참가자일 때 -->
												    		<input type="checkbox" id="${empl.emplId }" name="alreadyJoinchatId" value="${empl.emplId }" checked="checked" disabled="disabled">
												    		<c:set var="doneChatJoinLoop" value="true"/>
												    	</c:if>
												    	<c:if test="${chatJoinStatus.last && empl.emplId ne chatJoin.joinchatId}"> <!-- 아닐 때 -->
															<input type="checkbox" id="${empl.emplId }" name="joinchatId" value="${empl.emplId }">
														</c:if>
													</c:if>
								            	</c:forEach>
												<!-- joinchatId checked된 값 알아서 넘겨줌 -->
										    </div>
						            	</div>
						            	<!-- 직원명 div 끝 -->
						            </c:if>
				            	</c:forEach>
							</div>
							<div class="btns-wrap">
								<button class="point" type="button" onclick="addChatroomJoin('${chatroom.chatroomNo }');">확인</button>
								<button class="cancel" type="button">취소</button>
							</div>
						</section>
						
						<!-- 채팅 참가자 추가 모달창 끝-->
		        	
<!-- 		        	</form> -->
				    
			    </div>
			    <div class="t-c ml-20" style="display:inline-block">
	        		<button class="btn--profile mb-10" type="button" onclick="exitChatRoom(${chatroom.chatroomNo});">
	      		    	<i class="fa-solid fa-arrow-right-from-bracket"></i>
				    </button>
				    <div>
				    	나가기
				    </div>
			    </div>
        	</div>
        	<!-- 참가자 리스트 -->
        	<div class=" padding-left padding-right" style="overflow:scroll; margin: auto; height:300px">
        		<c:forEach items="${chatRoomJoinList }" var="chatJoin">
<%-- 			    	<c:if test="${empl.emplId ne sessionScope.emplId }"> <!-- 내가 아닐 때 --> --%>
					    <!-- 직원명 div  -->
					    <!-- 여기 count로 해놨는데 사실은 roomid로 해야할 듯. -->
					    <div class="chat-row mt-10  padding-bottom-10">
						    <div class="mr-20" style="width:30px;">
				      		    <button class="btn--profile" type="button">
				      		    	<c:if test="${chatJoin.emplProfile eq null}">
								        <img src="../resources/images/img_no_profile.png" alt="profile">
				      		    	</c:if>
				      		    	<c:if test="${chatJoin.emplProfile ne null}">
								        <img src="../resources/uploadFiles/${chatJoin.emplProfile }" alt="profile">
				      		    	</c:if>
							    </button>
						    </div>
						    <div class="ml-20">
						    	${chatJoin.deptName } ${chatJoin.emplName } ${chatJoin.positionName }
						    </div>
		            	</div>
		            	<!-- 직원명 div 끝 -->
<%-- 	            	</c:if> --%>
            	</c:forEach>
        	</div>
        </article>
    </div>
    <script>
    	//채팅방 이름 변경
    	function updateChatroomName(chatroomNo){
    		console.log($("input[name=chatroomName]").val());
    		var chatroomName = $("input[name=chatroomName]").val();
    		$.ajax({
				url : "/updateChatroom.hirp",
				type : "post",
				data :{"chatroomNo" : chatroomNo,
					"chatroomName" : chatroomName},
				success : function(data){
// 					exitChatPage(chatroomNo);
// 					alert("채팅방 이름 변경 성공");
					window.location.reload(); //추가되면 info창 바로 로드
					//동시에 채팅방 창도 reload
					window.open('/chat.hirp?chatroomNo='+chatroomNo,'chattingRoom'+chatroomNo,'width=400,height=600, left=410, location=no,status=no,scrollbars=no');
				},
				error : function(data){
// 					alert("채팅방 이름 변경 실패");
				}
			});
    	}
    	//초대
    	function addChatroomJoin(chatroomNo){
    		console.log($("input[name=joinchatId]:checked"));
    		
    		var joinchatIdList = [];
    	    $("input[name='joinchatId']:checked").each(function(i) {
    	    	joinchatIdList.push($(this).val());
    	    });
    	    console.log(joinchatIdList);
    		$.ajax({
				url : "/addChatroomJoin.hirp",
				type : "post",
				data :{"chatroomNo" : chatroomNo,
					"joinchatIdList" : joinchatIdList},
				success : function(data){
// 					exitChatPage(chatroomNo);
// 					alert("채팅방 초대 성공");
					window.location.reload(); //추가되면 info창 바로 로드
					//동시에 채팅방 창도 reload
					window.open('/chat.hirp?chatroomNo='+chatroomNo,'chattingRoom'+chatroomNo,'width=400,height=600, left=410, location=no,status=no,scrollbars=no');
				},
				error : function(data){
// 					alert("채팅방 초대 실패");
				}
			});
    	}
    	
		//채팅창 닫기
		function exitChatPage(chatroomNo){
			console.log(chatroomNo);
			//채팅방 정보창 닫기
			window.close('', 'chattingRoomInfo'+chatroomNo);
			//채팅방 닫기
			var chattingPage = window.open('/chat.hirp?chatroomNo='+chatroomNo,'chattingRoom'+chatroomNo,'width=400,height=600, left=410, location=no,status=no,scrollbars=no');
			chattingPage.close();
		}
		
		//채팅방 나가기
		function exitChatRoom(chatroomNo) {
			$.ajax({
				url : "/deleteChatRoomJoin.hirp",
				type : "post",
				data : {"chatroomNo" : chatroomNo},
				success : function(data){
					exitChatPage(chatroomNo);
				},
				error : function(data){
					alert("채팅방 나가기 실패");
				}
			});
		}
		
		//직원 목록에서 검색 (ajax)
		function emplSearch(obj){ //버튼 클릭 시 동작
			console.log(obj);
			console.log($(obj).prev()); //검색창 input
			console.log($(obj).parent().next()); //id empllist 또는 모달창 empllist div
			console.log($(obj).parent().next()[0]); //div의 아이디값 가져오기
// 			console.log($("#emplList"));
			var searchVal = $(obj).prev().val(); //검색한 내용
			var $emplListDiv = $(obj).parent().next(); //id empllist 또는 모달창 empllist div
			var emplDivId = $emplListDiv[0].id; //div의 아이디값 가져오기
			console.log(searchVal);
			console.log(emplDivId);
			if(emplDivId == 'emplList'){
				console.log("모달 아님");
			} else {
				console.log("모달임");
			}
			
			$.ajax({
				url:"/searchEmplList.hirp",
				type:"post",
				data:{"emplSearchKeyword" : searchVal},
				success: function(eList){
					console.log("성공");
	    			console.log(eList);
	    			var count = eList.length;
	    			var myId = "${sessionScope.emplId}";
	    			console.log("아이디 : " + myId);
	    			
// 	    			var $emplDiv = $("#emplList");
	    			$emplListDiv.html("");//기존 내용 있으면 비우기
	    			
	    			//list가 null값이면 아무 데이터도 안나옴. controller에서 empty 체크 안함.
	    			for(var i=0; i<count; i++){
	    				if(eList[i].emplId != myId){ //내가 아닌 데이터만 가져오기
	    					var countUp = "";
	    					var emplOneDiv = "";
	    					
							if(emplDivId == 'emplList'){ //직원 리스트 검색일 때
			    				countUp = "<c:set var='count' value='"+i+"' />" //원래는 여기 roomId 들어가야 할 듯.
			    				emplOneDiv = "<div class='chat-row mt-10  padding-bottom-10' ondblclick='addPersonalChatroom(\""+eList[i].emplId+"\")'>"
													  +  "<div class='mr-20 ml-20' style='width:30px;'>"
										      		  +  "<button class='btn--profile' type='button'>";
								if(eList[i].emplProfile == null) { //사진 null값 체크해서 다르게 넣어줌.
									emplOneDiv += "<img src='../resources/images/img_no_profile.png' alt='profile'>";
								} else {
									emplOneDiv += "<img src='../resources/uploadFiles/"+eList[i].emplProfile+"' alt='profile'>";
								}
								
								emplOneDiv +=	"</button>"
										+    "</div>";
								emplOneDiv +=	"<div class='ml-20'>"
												    +	eList[i].deptName+" "+eList[i].emplName+" "+eList[i].positionName
											+    "</div>"
							            +	"</div>";
							} else { //모달창 내부 검색일 때
								countUp = "<c:set var='count' value='"+i+"' />" //원래는 여기 roomId 들어가야 할 듯.
			    				emplOneDiv = "<div class='chat-row mt-10  padding-bottom-10'>"
													  +  "<div class='mr-20 ml-20' style='width:30px;'>"
										      		  +  "<button class='btn--profile' type='button'>";
								if(eList[i].emplProfile == null) { //사진 null값 체크해서 다르게 넣어줌.
									emplOneDiv += "<img src='../resources/images/img_no_profile.png' alt='profile'>";
								} else {
									emplOneDiv += "<img src='../resources/uploadFiles/"+eList[i].emplProfile+"' alt='profile'>";
								}
								
								emplOneDiv +=	"</button>"
										+    "</div>";
										
								emplOneDiv += "<div class='modal--chatSelect__empList__checkbox-wrap pos-rel ml-20'>"
										    	+ "<label for=" + eList[i].emplId + ">"
										    		+ eList[i].deptName+" "+eList[i].emplName+" "+eList[i].positionName
										    	+ "</label>"
										    	+ "<input type='checkbox' id="+eList[i].emplId+" name='joinchatId' value="+eList[i].emplId+">"
										    + "</div>"
										+	"</div>";
							}
							
							$emplListDiv.append(countUp);
							$emplListDiv.append(emplOneDiv);
							
	    				}
					}
	    			if(emplDivId == 'emplList'){
	    				console.log("모달 아님");
	    			} else {
	    				console.log("모달임");
	    			}
	    		},
	    		error: function(){
	    			console.log("실패");
// 	    			console.log(searchVal);
// 					var $tableBody = $("#emplTable tbody");
// 	    			$tableBody.html("");//기존 내용 있으면 비우기
// 	    			var $tr = $("<tr>");
// 	    			var $text = $("<div class='t-c' style='align:center;'>").html("검색 결과가 없습니다."); //이거 td 안 합쳐짐.
// 					$tr.append($text);
// 					$tableBody.append($tr);
	    		}
			});
		}
		
		$(function(){
			//직원 초대창 열기
			$("#addEmpl").on("click", function(){
				$("#chatEmplListModal").show();
			});
			//직원 초대창 확인
			$("#chatEmplListModal .btns-wrap button.point").on("click", function(){
				$("#chatEmplListModal").hide();
			});
			
			//직원 초대창 취소
			$("#chatEmplListModal .btns-wrap button.cancel").on("click", function(){
				$("#chatEmplListModal").hide();
			});
			
			//채팅방 이름 수정창 열기
			$("#editChatroom").on("click", function(){
				$("#chatNameModal").show();
			});
			//채팅방 이름 수정창 닫기(취소)
			$("#chatNameModal .btns-wrap button.cancel").on("click", function(){
				$("#chatNameModal").hide();
			});

		});
    </script>
</body>
</html>