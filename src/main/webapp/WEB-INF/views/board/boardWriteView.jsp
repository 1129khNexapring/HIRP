<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>
  <%@ include file="/WEB-INF/views/include/inc_head.jsp" %>
    <link rel="stylesheet" href="../../../resources/css/sub.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <body>
      <%@ include file="/WEB-INF/views/include/inc_header.jsp" %>
        <div id="conts">
          <%@ include file="/WEB-INF/views/include/inc_board.jsp" %>

            <article id="sub" class="">
              <%@ include file="/WEB-INF/views/include/inc_nav_right.jsp" %>
                <h1 class="basic-border-bottom">글쓰기</h1>
                <div class="subConts page--board-write">
                  <form id="multiform" action="/notice/register.hirp" method="post" enctype="multipart/form-data">
                    <!--  	<form name="dataForm" id="dataForm" action="/notice/register.hirp" >	-->
                    <table>
                      <tbody>
                        <tr>
                          <td>게시판 선택</td>
                          <td>
                            <select name="boardCode">
                              <option value="N" selected>공지게시판</option>
                              <option value="F">자유게시판</option>
                              <option value="A">익명게시판</option>
                              <option value="D">부서게시판</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td>제목</td>
                          <td><input type="text" name="noticeTitle" style="width:1300px;"></td>
                        </tr>
                        <tr>
                          <td>첨부파일</td>
                          <td>
                            <button id="btn-upload" type="button" style="border: 1px solid #ddd; outline: none;">파일 추가</button>
                            <input id="uploadFiles" name="uploadFiles" type="file" multiple style="display:none;">
                            <span style="font-size:10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
                            <div class="data_file_txt" id="data_file_txt">
                              <span>첨부 파일</span>
                              <br>
                              <div id="articlefileChange">
                              </div>
                            </div>
                          </td>
                        </tr>
                        <tr>                          
                          <td>내용</td>
                          <td><textarea name="noticeContents"></textarea></td>
                        </tr>
                      </tbody>
                    </table>
                    <div class="btns-wrap">
                      <button class="point" type="submit">수정하기</button>
                    </div>
                  </form>
                </div>
            </article>
        </div>


        <!-- 파일 업로드 스크립트 -->
        <script>
          $(document).ready(function ()
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
              alert('파일은 최대 ' + totalCount + '개까지 업로드 할 수 있습니다.');
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
                fileNum++;
              };
              reader.readAsDataURL(f);
            });
            console.log(content_files);
            //초기화 한다.
            $("#input_file").val("");
          }

          // 파일 부분 삭제 함수
          function fileDelete(fileNum) {
            var no = fileNum.replace(/[^0-9]/g, "");
            content_files[no].is_delete = true;
            $('#' + fileNum).remove();
            fileCount--;
            console.log(content_files);
          }
        </script>
    </body>

  </html>