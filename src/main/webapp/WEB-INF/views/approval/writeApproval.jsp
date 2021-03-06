<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalCommonPage.jsp" %>

			<h1 class="basic-border-bottom">기안하기</h1>

			<div id="guide" class="subConts">
				<!-- 여백 필요 없을 경우 클래스에 padding-0 추가, 
            	필요 없으면 지울 것 -->
				<button class="basic apprbtn" type="button" id="approvalLine-btn"
					onclick="openModal(this);">
					<img src="../../../../resources/images/icons/btn_plus.png"
						style="width: 10px; height: auto; vertical-align: middle;" />&nbsp&nbsp결재선
				</button>
				<section class="section--modal" id="apprLineSession">
					<div class="bg-black"></div>
					<div class="section--modal__conts"
						style="border: none;height:500px; padding: 10px 30px 30px;">
						<ul class="tabs">
							<li class="tab-link current" data-tab="tab-1">결재자 선택</li>
							<li class="tab-link" data-tab="tab-2">참조자/열람자 선택</li>
						</ul>
						<button class="btn--close" type="button" onclick="closeApprModal()"></button>
						<div class="row tab-content current tab-1" id="tab-1">
						<h3>결재선 선택</h3>
						  <div id="groupContainer" class="container" style="float:left; "> 
						
								<div id="organization" class="subConts" style="padding:20px 0px 0px 0px;">
									<ul id="orgList">
									</ul> 
								</div>
								
							</div>
							<div class="container"style="width:470px;float:left;" id="emplListDiv">
								<table class="table--basic mt-20" id="apprEmplTable">
									<tr class="apprEmplTableHead">
										<th>부서</th>
										<th>직급</th>
										<th>이름</th>
										<th>구분</th>
										<th><button class="noneBackground" onclick='removeAllEmpl(this)'><i class="fa-solid fa-trash-can"></i></button></th>
									</tr>
								</table>
							</div> 
						</div>
						
						<div id="tab-2" class="row tab-content tab-2">
							<h3>참조자/열람자 선택</h3>
								 <div id="groupContainer" class="container" style="float:left;"> 
									 <div id="organization" class="subConts"  style="padding:20px 0px 0px 0px;">
										<ul id="orgList2">
										</ul> 
									</div>
								</div>
						<div class="container" style="width:470px;float:left;float:left;">
								<table class="table--basic mt-20" id="refTable">
									<tr class="apprEmplTableHead">
										<th>부서</th>
										<th>직급</th>
										<th>이름</th>
										<th>구분</th>
										<th><button class="noneBackground" onclick='removeAllEmpl(this)'><i class="fa-solid fa-trash-can"></i></button></th>
									</tr>
								</table>
							</div> 
							</div>
						<br><br>
						<div class="btns-wrap mt-20 t-r" style="position : absolute;bottom : 25px; right : 25px;">
								<button class="point" type="button" onclick="addApprLine()">확인</button>
								<button class="finished" type="button" onclick="closeApprModal()">닫기</button>
						</div>
				</section>
				<br> <br>
				<c:if test="${msg eq '결재양식' }">
				<form action="/register/appr.hirp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="formNo" value="${apprform.formNo}">
				</c:if>	
				<c:if test="${msg eq '휴가신청서'}">
				<form action="/register/annualLeaveAppr.hirp" method="post" enctype="multipart/form-data">
				</c:if>	
					<input type="hidden" name="emplId" value="${emplId}">
					<div style="border: solid 1px #888;  margin-top: 20px; position: relative;">
						<table id="apprTable">
							<tr style="height: 30px; border: solid 1px #888;  line-height: 30px;">
								<td>기안자</td>
								<td>${emplName} ${employee.positionCode }</td>
							</tr>
							<tr
								style="height: 30px; border: solid 1px #888; line-height: 30px;">
								<td>기안일</td>
								<td><div id="current_date" /></td>
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
							<div class='singleApprLineMiddle'>${emplName} ${employee.positionCode}</div>
							<div class='singleApprLineBottom'></div>
							</div>
						</div>
						
						</div>
						<c:if test="${msg eq '휴가신청서' }">
						
						<div style="border:solid 1px #888;border-top:none; padding :5px 0px 20px 0px;">
						<p><br></p><p style="text-align: center; "><b><span style="font-size: 22px;">휴가신청서</span></b></p><p><br></p><p style="text-align: center; "><br></p><p style="text-align: center; "><br></p><p> 
						</c:if>
						<c:if test="${msg eq '근태조정신청서'}">
						<div style="border:solid 1px #888;border-top:none; padding :5px 0px 20px 0px;">
						<p><br></p><p style="text-align: center; "><b><span style="font-size: 22px;">근태조정신청서</span></b></p><p><br></p><p style="text-align: center; "><br></p><p style="text-align: center; "><br></p><p> 
						
						</c:if>
					<div class="row mt-20">
							<div style="width: 6%">
								<div style="font-size: 15px; line-height: 30px; text-align: center;">제목</div>
							</div>

							<div>
								<input type="text" size="125" name="apprTitle" style="border-radius: 4px;border:solid 1px #888;">
							</div>
						</div>
						<div class="row mt-20" id="refDiv">
							<div style="width: 6%">
								<div style="font-size: 15px; line-height: 30px; text-align: center;">참조자</div>
							</div>

							<div>
								<input type="text" size="125" id="refInput" style="border-radius: 4px;border:solid 1px #888;" >
							</div>
						</div>
						<div class="row mt-20">
							<div style="line-height: 25px;">첨부파일</div>
							<div>
								<button id="btn-upload" type="button" style= "background-color: white; border: solid 1px #888; border-radius: 4px;">파일 추가</button>
							</div>
							<input id="uploadFiles" name="uploadFiles" type="file" multiple style="display: none;"> 
							<span style="font-size: 10px; color: gray; line-height: 25px;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
							<div class="data_file_txt" id="data_file_txt" style="margin-top:20px; margin-left:80px; width:960px; height:100px; border:1px solid #888;">
								<span></span> <br>
								<div id="articlefileChange"></div>
							</div>
						</div>
					
					
					<br>
					<c:if test="${msg eq '결재양식' }">
					<div>
						<textarea id="summernote" name="apprContents">${apprform.formContents}</textarea>
					</div>
					</c:if>
					<c:if test="${msg eq '휴가신청서' }">
					<!-- <div class="row mt-20">
						<div style="width: 6%">
							<p class=" " style="line-height: 25px;">종류</p>
			            </div>
			            <div>
			            <select name="vacationDivision">
							<option value="연차">연차</option>
						</select>
						</div>
					</div>
					<div class="row mt-20">
			                <div style="width: 6%">
			                    <p style="line-height: 25px;">기간</p>
			                </div>
			                <div class="">
			                    <input class="" type="date" name="vacationStart"> ~ <input class="" type="date" name="vacationEnd">
			                </div>
			            </div>
					<div class="row mt-20">
			            <div>
							<textarea placeholder="사유를 작성해주세요" rows="10" cols="140" name="vacationContent"></textarea>
						</div>
					</div> -->
					
					</p><p></p><table class="__se_tbl" style="text-align: center;  width:960px; margin-top: 0px; margin-left:69px; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; border-collapse: collapse !important;"><tbody> 
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">휴가&nbsp;종류</td> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;"> <span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"><select class="editor_slt" data-dsl="{{cSel_연차_조퇴_지각_경조사_공가_병가}}" name="select_type">
					     <option value="연차">연차</option>
					     <option value="조퇴">조퇴</option>
					     <option value="지각">지각</option>
					     <option value="경조사">경조사</option>
					     <option value="공가">공가</option>
					     <option value="병가">병가</option>
					</select>
					</span> </td> 
					  </tr> 
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">기간&nbsp;및&nbsp;일시</td> 
					   <td style="padding: 3px; border: 1px solid black; width: 700px; height: 22px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: middle; background: rgb(255, 255, 255);"> <input type="date" name="vacationStart">&nbsp;~&nbsp; <input type="date" name="vacationEnd"> <span id="usingPointArea">
					<b id="usingPoint_Comment" style="font-weight:bold; color:red"></b>
					</span> </td> 
					  </tr> 
					  
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 80px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;"> &nbsp;휴가&nbsp;사유 </td> 
					   <td style="padding: 3px; border: 1px solid black; width: 700px; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: top; "> <textarea class="txta_editor" data-dsl="{{textarea:description}}" name="description" id="description" value="" data-id="description" data-name="description" data-require="false" data-maxlength="" data-width="" data-defaultstr="" data-editable="true" data-value="" placeholder=""></textarea> </td> 
					  </tr> 
					  
					 </tbody> 
					</table>
				
					<input type="hidden" value="${emplName}" name="vacationName">
					<input type="hidden" value="${employee.deptCode}" name="vacationDepartment">
					</div>
					</c:if>
					
					
					
					<c:if test="${msg eq '근태조정신청서' }">
					
					
					</p><p></p><table class="__se_tbl" style="text-align: center;  width:960px; margin-top: 0px; margin-left:69px; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: &quot;malgun gothic&quot;, dotum, arial, tahoma; border-collapse: collapse !important;"><tbody> 
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">조정&nbsp;일자</td> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;"> <span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
					<input type="date">
					</span> </td> 
					  </tr> 
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">출근&nbsp;시간</td> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;"> <span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
					<input type="time">
					</span> </td> 
					  </tr> 
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">퇴근&nbsp;시간</td> 
					   <td style=" padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;"> <span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
					<input type="time">
					</span> </td> 
					  </tr> 
					  
					  <tr> 
					   <td style=" padding: 5px; border: 1px solid black; height: 80px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;"> &nbsp;변경&nbsp;사유 </td> 
					   <td style="padding: 3px; border: 1px solid black; width: 700px; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: top; "> <textarea class="txta_editor" data-dsl="{{textarea:description}}" name="description" id="description" value="" data-id="description" data-name="description" data-require="false" data-maxlength="" data-width="" data-defaultstr="" data-editable="true" data-value="" placeholder=""></textarea> </td> 
					  </tr> 
					  
					 </tbody> 
					</table>
				
					<input type="hidden" value="${emplName}" name="vacationName">
					<input type="hidden" value="${employee.deptCode}" name="vacationDepartment">
					</div>
					</c:if>
					
					
					
			<button class="point mt-20 apprbtn" type="submit">상신하기</button>
			<button class="basic mt-20 apprbtn" type="button" onclick="tempStorage(this.form)">임시 저장</button>
			</form>
			</div>
		</article>
	</div>




		<script>
			$(document).ready(function(){
				
				$('ul.tabs li').click(function(){
					var tab_id = $(this).attr('data-tab');
	
					$('ul.tabs li').removeClass('current');
					$('.tab-content').removeClass('current');
	
					$(this).addClass('current');
					$("#"+tab_id).addClass('current');
				})
	
			});
		
		
			var today = new Date();
			 // 년도 getFullYear()
			var year = today.getFullYear(); 
			 // 월 getMonth() (0~11로 1월이 0으로 표현되기 때문에 + 1을 해주어야 원하는 월을 구할 수 있다.)
			var month = today.getMonth() + 1
			 // 일 getDate()
			var date = today.getDate(); // 일
		 	 today = year + '-' + month + '-' + date;
		    document.getElementById("current_date").innerHTML = today; 
	
		    
		    $(document).ready(function()
		    		// 파일 첨부시 fileCheck 함수 실행
		    		{
		    			$("#uploadFiles").on("change", fileCheck);
		    		});

		    /**
		     * 첨부파일로직
		     */
		    $(function () {
		        $('#btn-upload').click(function (e) {
		            e.preventDefault();
		            $('#uploadFiles').click();
		        });
		    });

		    // 파일 현재 필드 숫자 totalCount랑 비교값
		    var fileCount = 0;
		    // 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
		    var totalCount = 10;
		    // 파일 고유넘버
		    var fileNum = 0;
		    // 첨부파일 배열
		    var content_files = new Array();

		    function fileCheck(e) {
		        var files = e.target.files;//파일객체, 파일 목록에 접근 가능
		        
		        // 파일 배열 담기
		        var filesArr = Array.prototype.slice.call(files);//객체를 배열로 변환
		        
		        // 파일 개수 확인 및 제한
		        if (fileCount + filesArr.length > totalCount) {
		          alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
		          return;
		        } else {
		        	 fileCount = fileCount + filesArr.length;
		        }
		        
		        // 각각의 파일 배열담기 및 기타
		        filesArr.forEach(function (f) {
		          var reader = new FileReader();
		          reader.onload = function (e) {
		            content_files.push(f);
		            $('#articlefileChange').append(
		           		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
		           		+ '<font style="font-size:12px">' + f.name + '</font>'  
		           		+ '<img src="../../../../resources/images/bg_close.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
		           		+ '<div/>'
		    		);
		            fileNum ++;
		          };
		          reader.readAsDataURL(f);
		        });
		        console.log(content_files);
		        //초기화 한다.
		        $("#input_file").val("");
		      }

		    // 파일 부분 삭제 함수
		    function fileDelete(fileNum){
		        var no = fileNum.replace(/[^0-9]/g, "");
		        content_files[no].is_delete = true;
		    	$('#' + fileNum).remove();
		    	fileCount --;
		        console.log(content_files);
		    }
     
		    
		    
		    
		    
	  
		    $('#summernote').summernote({
		        placeholder: 'Hello stand alone ui',
		        tabsize: 2,
		        height: 500,
		        toolbar: [
				    // [groupName, [list of button]]
				    ['fontname', ['fontname']],
				    ['fontsize', ['fontsize']],
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    ['color', ['forecolor','color']],
				    ['table', ['table']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert',['picture','link','video','hr']],
				    ['view', ['fullscreen', 'codeview', 'help']]
				  ],
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		      });
    
  
			/* function refClick(e) {
				var tdArr = new Array();
				var tr = $(e)//클릭한 tr
				var td = tr.children();//tr의 후손인 td
				td.each(function(i, e) {
					tdArr.push(td.eq(i).text());//td의 각각의 값을 배열에 넣어줌(deptName, positionName, emplName값 들어가있음)  
				})
				tdArr.push(tr.next().val());//hidden값인 emplId값을 배열에 넣어줌
				addrefDiv(tdArr); //(deptNAme, positionName, emplName, emplId)
			} */

			
			
			function emplClick(e){
				var arr = new Array();
				var aTag = $(e);
				aTag.each(function(i,e){
				arr.push(aTag.parent().siblings('a').text());
				arr.push(aTag.eq(i).text().split(' ')[1]);
				arr.push(aTag.eq(i).text().split(' ')[0]);
				arr.push(aTag.children('input').val());
				console.log(aTag.children('input').val());
				
				})
					//결재자선택 탭인지 참조자 선택 탭인지 확인 후 다른 함수로 보내기
					if( $(e).parents().hasClass('tab-1')) {
						addEmplDiv(arr); //(deptNAme, positionName, emplName, emplId)
					}else{
						addrefDiv(arr);
					}
			
			}
			 
			
			
			
			
			
			
			
			var arr = []; //2차원 배열{(deptName, positionName, emplName, emplId),(deptName, positionName, emplName, emplId),...}
			function addEmplDiv(tdArr) {
				var dblCheck = null;
				for(var i=0;i<arr.length;i++){
				//중복된 결재자 추가 안되게 처리
					dblCheck = JSON.stringify(arr[i][0])===JSON.stringify(tdArr[0])&&JSON.stringify(arr[i][1])===JSON.stringify(tdArr[1])&&JSON.stringify(arr[i][2])===JSON.stringify(tdArr[2])
					if(dblCheck == true){
						break;
					}
				}
				if(dblCheck){
					alert("이미 등록한 결재자입니다.");
				}
				else{
				
					arr.push(tdArr);//tdArr 배열을 2차원 배열에 넣어줌
				if(arr.length > 6){
					alert("결재선은 6명까지 등록가능합니다.");
					arr.pop();
				
				}else{
				var $apprEmplTable = $("#apprEmplTable");//모달창에 클릭한 값을 넣어줄 테이블
				var emplDivHtml = "<tr>"
						+ "<td>"
						+ tdArr[0]
						+ "</td>"
						+ "<td>"
						+ tdArr[1]
						+ "</td>"
						+ "<td>"
						+ tdArr[2]
						+ "</td>"
						+ "<td>"
						+ "<select id='apprOpt[]' name='apprOpt[]'style='width:50px;' onchange='addSelected(this)'>"
						+ "<option value='결재'>결재</option>"
						+ "<option value='합의'>합의</option>"
						+ "</select>" + "</td>" 
						+ "<td>"+"<button class='noneBackground' onclick='removeEmplTr(this)'><i class='fa-solid fa-trash-can'></i></button>"+"</td>"
						+ "</tr>"
				$apprEmplTable.append(emplDivHtml);//값을 넣어준다.
			}}
				}
				
			var refArr = []; //2차원 배열{(deptName, positionName, emplName, emplId),(deptName, positionName, emplName, emplId),...}
			function addrefDiv(tdArr) {
				var dblCheck = null;
				for(var i=0;i<refArr.length;i++){
				//중복된 결재자 추가 안되게 처리
					dblCheck = JSON.stringify(refArr[i][0])===JSON.stringify(tdArr[0])&&JSON.stringify(refArr[i][1])===JSON.stringify(tdArr[1])&&JSON.stringify(refArr[i][2])===JSON.stringify(tdArr[2])
					if(dblCheck == true){
						break;
					}
				}
				if(dblCheck){
					alert("이미 등록한 참조자/열람자 입니다.");
				}
				else{
				
					refArr.push(tdArr);//tdArr 배열을 2차원 배열에 넣어줌
				if(arr.length > 6){
					alert("6명까지 등록가능합니다.");
					refArr.pop();
				
				}else{
				var $refTable = $("#refTable");//모달창에 클릭한 값을 넣어줄 테이블
				var emplDivHtml = "<tr>"
						+ "<td>"
						+ tdArr[0]
						+ "</td>"
						+ "<td>"
						+ tdArr[1]
						+ "</td>"
						+ "<td>"
						+ tdArr[2]
						+ "</td>"
						+ "<td>"
						+ "<select id='refOpt[]' name='refOpt[]'style='width:50px;' onchange='addSelected(this)'>"
						+ "<option value='참조자'>참조</option>"
						+ "<option value='열람자'>열람</option>"
						+ "</select>" + "</td>" 
						+ "<td>"+"<button class='noneBackground' onclick='removeEmplTr(this)'><i class='fa-solid fa-trash-can'></i></button>"+"</td>"
						+ "</tr>"
				$refTable.append(emplDivHtml);//값을 넣어준다.
				console.log(refArr);
			}}
				}
			
			

			//모달창 테이블과 배열에서 해당 tr 삭제
			function removeEmplTr(obj){
				var emplTr = $(obj).closest('tr');//obj와 가장 가까운 tr
				var emplTrNum = emplTr.prevAll().length;//tr의 index
				if( $(obj).parents().hasClass('tab-1')) {
					arr.splice(emplTrNum-1,1);//배열에서 삭제
				}else{
					refArr.splice(emplTrNum-1,1);//배열에서 삭제
				}
				
				emplTr.remove();//table에서 삭제
			}
			
			//모달창에서 선택한 요소 전체 삭제
			function removeAllEmpl(obj){
				var allEmplTr = $(".apprEmplTableHead").nextAll();//table head부분 제외한 나머지부분 전체 선택
				if($(obj).parents().hasClass('tab-1')) {
					arr=[];//배열 비워줌
				}else{
					refArr=[];//배열 비워줌
				}
				allEmplTr.remove();//table에서 전체 삭제
			}
			
		
			//모닫창 닫고 목록 테이블 삭제
			function closeApprModal(){
				 $("#apprLineSession").stop().fadeOut(100);
				
			}
			
			//select 선택된 값 넣기
			function addSelected(obj){
				var emplTr = $(obj).closest('tr');//obj와 가장 가까운 tr
				var emplTrNum = emplTr.prevAll().length;//tr의 index
				
				if($(obj).parents().hasClass('tab-1')) {
					if(arr[emplTrNum-1].length > 4){
						arr[emplTrNum-1].pop()
						arr[emplTrNum-1].push($('select[name="apprOpt[]"]')[emplTrNum-1].value);
					}else{
						arr[emplTrNum-1].push($('select[name="apprOpt[]"]')[emplTrNum-1].value);
					} 
				}else{
					if(refArr[emplTrNum-1].length > 4){
						refArr[emplTrNum-1].pop()
						refArr[emplTrNum-1].push($('select[name="refOpt[]"]')[emplTrNum-1].value);
					}else{
						refArr[emplTrNum-1].push($('select[name="refOpt[]"]')[emplTrNum-1].value);
					} 
				}
				//arr[i].push($('select[name="apprOpt[]"]')[i].value);
				console.log(refArr);
			}
			
			
			function addApprLine() {
				
				//배열에 값이 들어있을 경우 동작
				 if (arr != null) {
					var $approvalLine = $("#approvalLine");
					var refInput =  $("#refInput");
					var otherDiv = $(".singleApprLine").first().nextAll();
					otherDiv.remove();	
					
					
					for (var i = 0; i < arr.length; i++) {
						//결재type select 값 배열에 넣어줌
						if(arr[i].length == 4 ){
						arr[i].push($('select[name="apprOpt[]"]')[i].value);
						}
						//결재라인 div 출력
						var apprLineHtml = /*"<div class='singleApprType'>"+arr[i][0]+"</div>"+*/"<div class='singleApprLine'>"+"<div class='singleApprLineTop'>"+ arr[i][4]+"</div>"+"<div class='singleApprLineMiddle'>"+ arr[i][2] +" "+ arr[i][1]+"</div>"+"<div class='singleApprLineBottom'>"+"</div>"+ "</div>"
								+ "<input type='hidden' value="+arr[i][3]+" name='aList["+i+"].emplId'>"
								+ "<input type='hidden' value="+arr[i][4]+" name='aList["+i+"].apprType'>"
						$approvalLine.append(apprLineHtml)
					}
					
					var refName = [];
					for (var i = 0; i < refArr.length; i++) {
						if(refArr[i].length == 4 ){
							refArr[i].push($('select[name="refOpt[]"]')[i].value);
							}
						
						refName.push(refArr[i][2]);
						$("#refInput").val(refName);
						var refInputHidden =  "<input type='hidden' value="+refArr[i][3]+" name='rList["+i+"].emplId'>"
						+ "<input type='hidden' value="+refArr[i][4]+" name='rList["+i+"].refType'>"
						$("#refDiv").append(refInputHidden)
					}
						
					$(".section--modal").stop().fadeOut(100);
				} else {
					$(".section--modal").stop().fadeOut(100);//배열이 null일 경우 모달창 닫기
				}
			}
			
			// 조직도 조회
			$(document).ready(function(){
				$.ajax({
					url : "/group/groupViewData.hirp",
					type : "get",
					dataType : "json",
					success : function(data) {
						if (data.length != 0) {
							data.forEach(function(e, i) {
								/*console.log(e);*/
								var codeNm = e.deptName;
								var codeId = e.deptCode;
								var parentId = e.deptUppercode;
								var codeLvl = e.deptLevel;
								var $rootList = $("#orgList");
								var $ul = '<ul id="emplUl"><li id="'+ codeId +'"><a href="#">' + codeNm+ '</a></li></ul>';
								// 1레벨은 그냥 추가
								// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
								if (codeLvl == 0) {
									var $li = '<li id="'+ codeId +'" lvl="' + codeLvl + '"><a href="#">'+ codeNm + '</a></li>';
									$rootList.append($li);
								} else {
									if(codeLvl == 3){
										$ul = '<ul id="emplUl"><li id="'+ codeId +'" onclick="emplClick(this);"><a href="#">' + codeNm+ '</a><input type="hidden" value="'+codeId+'"></li></ul>';
									}
									$("#" + parentId).append($ul);
								}
							});
							var $rootList2 = $("#orgList").clone().html();
							$("#orgList2").html($rootList2);
						} else {
							alert("조직도 데이터가 없습니다.");
						}
						$("#orgList2, #orgList, #navigation").treeview({
							collapsed : true
						});
						
					},
					error : function() {
						alert("조직도 조회 중에 실패했습니다.");
					}
				});
			});
			
			
			function tempStorage(obj){
				obj.action = "/temporaryStorage/appr.hirp";
				obj.method = "post";
				obj.submit();
			}
			
			
		</script>
	</body>
</html>