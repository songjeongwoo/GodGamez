<title>갓겜:로그 관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>

<style>
#buttonBar .btn {
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
}

#logTitle{
	font-size:20;
}
#logView, #logSetting{
	margin:1rem;
}

#logView #downButton{
	float:right;
}

#logView #search{
	margin-left:1rem;
}

#logView table{
	text-align:center;
}

#searchBar input {
	width: 60%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}

#searchBar button {
	width: 40%;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

#logSetting #logButton{
	float:right;
}

#logSetting #checkbox{
	margin-left:2rem;
}

#timeShow {
	position: relative;
}

#timeShow span {
	position: absolute;
	right: 1.5rem;
	top: 2rem;
	color:green;
}

#logView {
  -ms-flex: 0 0 60%;
  flex: 0 0 60%;
  max-width: 60%;
}

@media (max-width: 768px) {
	#logView {
	  -ms-flex: 0 0 97%;
	  flex: 0 0 97%;
	  max-width: 97%;
	}
	
	#adminGnb {
		height: calc(100% + 23rem);
	}
}
</style>

<script>
/*수정버튼 누르면 저장,취소버튼 보임 */
$(document).ready(() => {
	$('#cancelBtn').hide();
    $('#saveBtn').hide();
    
   $('#fixBtn').click(() => { 
      $('#cancelBtn').show();
      $('#saveBtn').show();
      $('#fixBtn').hide();
      $('#logSetting #text, #ms, #logFileName, #checkbox').attr('disabled',false)
   })
   
   $('#saveBtn, #cnclBBtn').click(() => { 
      $('#cancelBtn').hide();
      $('#saveBtn').hide();
      $('#fixBtn').show();
      $('#logSetting #text, #ms, #logFileName, #checkbox').attr('disabled',true);
   })
});

/*밀리세컨드 -> 시간*/
function printHour()  {
	var inputNum = document.getElementById('ms').value / 60 / 60;
  	const printHour = inputNum.toFixed(1);
 	document.getElementById("result").innerText = printHour + "시간";
}

/*엑셀로 테이블 저장 입력한 파일명설정 까지만 구현*/
 
let downExcel = function fnExcelReport(id) {
		let logFileName = document.getElementById("logFileName").value;
		var title = JSON.stringify(logFileName);
	    
	    var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
	    tab_text = tab_text + '<head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8">';
	    tab_text = tab_text + '<xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>'
	    tab_text = tab_text + '<x:Name>Sheet</x:Name>';
	    tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet>';
	    tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';
	    tab_text = tab_text + "<table border='1px'>";
	    var exportTable = $('#' + id).clone();
	    exportTable.find('input').each(function (index, elem) { $(elem).remove(); });
	    tab_text = tab_text + exportTable.html();
	    tab_text = tab_text + '</table></body></html>';
	    var data_type = 'data:application/vnd.ms-excel';
	    var ua = window.navigator.userAgent;
	    var msie = ua.indexOf("MSIE ");
	    var fileName = title + '.xls';
    //Explorer 환경에서 다운로드
	    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
	        if (window.navigator.msSaveBlob) {
	            var blob = new Blob([tab_text], {
	                type: "application/csv;charset=utf-8;"
	                });
	            navigator.msSaveBlob(blob, fileName);
	        }
	    } else {
	        var blob2 = new Blob([tab_text], {
	            type: "application/csv;charset=utf-8;"
	            });
	        var filename = fileName;
	        var elem = window.document.createElement('a');
	        elem.href = window.URL.createObjectURL(blob2);
	        elem.download = filename;
	        document.body.appendChild(elem);
	        elem.click();
	        document.body.removeChild(elem);
   	}
}

/*
	백업 시간 설정 구현 실패
function checkExcel(){
	if($('input[type="checkbox"]:checked').length != 0) {
		downExcel();
	}
}

let backupExcel = function setIntervalExcel(){
	var inputNum = document.getElementById('ms').value;
	const backupTime = inputNum.toFixed(1);
	if(backupTime){
		setInterval(function () { downExcel(); }, backupTime);
	}
}
*/
/*2글자 미만일시 버튼 비활성화*/
function clsNameInChk2() { //검색창에 2글자 이상 입력
	$('#srchClsBtn2').attr('disabled', true);
	
	if(2 <= $('#clsNameIn2').val().length)
		$('#srchClsBtn2').removeAttr('disabled');
}

function fileNameInput()  {
	var inputName = document.getElementById('logFileName').value;
  	const printHour = inputNum.toFixed(1);
 	document.getElementById("result").innerText = printHour + "시간";
}

function logList() {
	$('#logList').empty()

	$.ajax('/godgamez.selfdevelopment/log/list')
	.done(logs => {
		console.log(logs);
		console.log(logs.length);
		if(logs.length) {
			let logList =[]
			 
			$.each(logs, (idx, log) => {
				logList.unshift(
					`<tr>
						<td>\${log.userType}</td>
						<td>\${log.logEvent}</td>
						<td>\${log.logTask}</td>
						<td>\${log.logDate}</td>
						<td>\${log.dbId}</td>
					</tr>`
				);
			});
			
			$('#logList').append(logList.join(''));
		} else{
			$('#logList').append('<tr><td colspan=5 class=text-center>로그가 없습니다.</td></tr>');
		}
	}).fail(() => {
		$('#logList').append('<tr><td colspan=5 class=text-center>로그를 조회하지 못했습니다.</td></tr>');
	});
}

$(document).ready(function() {
	$(logList);
});
</script>

<div class='h-100'>
	<%@ include file='../include/header.jsp' %>
	
	<div id='underHead' class='row w-100'>
	
	<%@ include file='../include/gnb.jsp' %>
	
		<div class='col' id='adminBody'>
			<div class='row'>
				<div class='col text-nowrap' id='logView'>
					<div class='row'>
						<div class='col'>
							<div id='logTitle'>
								<strong>로그 조회</strong><hr>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='row mr-0' id='downButton'>
								<button type='button' id='btnExcel' class='btn btn-secondary' onclick='modal("로그", "내려받기", "성공"); downExcel("allList")'>
									<i class="fas fa-download small"></i> 내려받기
								</button>
							</div>
							<div class='row'>
								<nav class='nav nav-tabs' id='buttonBar'>
									<a class='nav-link btn btn-outline-secondary active' data-toggle='tab' href='#allList'>전체</a>
									<a class='nav-link btn btn-outline-secondary' data-toggle='tab' href='#infoList'>USER </a>
									<a class='nav-link btn btn-outline-secondary' data-toggle='tab' href='#errorList'>ADMIN </a> 
								</nav>
							</div>
							<div class='row' id='logTable'>
								<div class='col'>
									<div class='tab-content'>
										<div class='tab-pane fade show active' id='allList'>
											<table id='allTable' class='table table-hover table-sm table-secondary'>
												<thead>
													<tr>
														<th width='15%'>타입</th>
														<th width='15%'>유형</th>
														<th width='15%'>업무</th>
														<th>일시</th>
														<th width='25%'>변경된 업무ID</th>
													</tr>
												</thead>
												<tbody class='border' id='logList'>
													
												</tbody>
											</table>
										</div>
										<div class='tab-pane fade' id='infoList'>
											<table class='table table-hover table-sm table-secondary'>
												<thead>
													<tr>
														<th width='15%'>타입</th>
														<th width='15%'>유형</th>
														<th width='15%'>업무</th>
														<th>일시</th>
														<th width='25%'>DB상의 ID</th>
													</tr>
												</thead>
												<tbody id='userList'>
													
												</tbody>
											</table>
										</div>
										<div class='tab-pane fade' id='errorList'>
											<table class='table table-hover table-sm table-secondary'>
												<thead>
													<tr>
														<th width='15%'>타입</th>
														<th width='15%'>유형</th>
														<th width='15%'>업무</th>
														<th>일시</th>
														<th width='25%'>DB상의 ID</th>
													</tr>
												</thead>
												<tbody id='adminList'>
													
												</tbody>
											</table>
										</div>
										<div class='tab-pane fade' id='checkTable'>
											<table class='table'>
												<!-- 여기에 excel로 출력을 위해서 체크된 값만으로 보이지않는 table을 만들예정-->
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class='row'>
								<div class='col-4'>
									<form id='searchBar'>
										<div class='d-flex'>
											<input type="text" class="form-control" placeholder="회원ID" id='clsNameIn' oninput='clsNameInChk()'>
											<button type="button" class="btn btn-secondary" id='srchClsBtn' title='2글자 이상 입력해주세요' disabled>검색</button>
										</div>
									</form>
								</div>
								<div class='col-4'>
									<ul class='pagination justify-content-center' id='pagination'>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>&lt;</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>1</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>2</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>3</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>4</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>5</a></li>
										<li class='page-item'><a class='page-link border-0 text-dark' href='#'>&gt;</a></li>
									</ul>
								</div>
								<div class='col-4'>
									<form id='searchBar'>
										<div class='d-flex'>
											<input type="text" class="form-control" placeholder="조회내용" id='clsNameIn2' oninput='clsNameInChk2()'>
											<button type="button" class="btn btn-secondary" id='srchClsBtn2' title='2글자 이상 입력해주세요' disabled>조회</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class='col' id='logSetting'>
					<div class='row'>
						<div class='col'>
							<div id='logTitle'>
								<strong>로그 설정</strong><hr>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div id='logButton'>
								<button type='button' class='btn btn-secondary' id='fixBtn'><i class="fas fa-edit"></i> 수정</button>
								<button type='button' class='btn btn-outline-secondary' id='cancelBtn' onclick='modal("로그설정", "수정", "중단")'><i class="fas fa-save"></i> 취소</button>
								<button type='button' class='btn btn-secondary' id='saveBtn' onclick='modal("로그 설정", "수정", "완료")'><i class="fas fa-save"></i> 저장</button>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<form>
								<div class='row'>
									<div class='col'>
										<p><strong>로그 저장 위치 </strong><input class='form-control' type='text' value='C:\Program Files\LOG' disabled/><span></span></p>
									</div>
								</div>
								<div class='row' id='timeShow'>
									<div class='col'>
										<p><strong>로그 파일 이름 </strong><input class='form-control' type='text' id='logFileName' oninput='fnExcelReport(id)' value='' disabled/><span>.xml</span></p>
									</div>
								</div>
								<div class='row'>
									<div class='col'>
										<p><input type='checkbox' id='checkbox' disabled/> 덮어쓰기
										<input type='checkbox' id='checkbox' disabled/> 백업하기</p>
									</div>
								</div>
								<div class='row' id='timeShow'>
									<div class='col'>
										<p><strong>백업 파일 이름 </strong><input class='form-control' type='text' id='text' disabled/><span>.xml</span></p>
									</div>
								</div>
								<div class='row' id='timeShow'>
									<div class='col '>
										<p><strong>로그 백업 주기 </strong><input class='form-control' type='text' id='ms' oninput='printHour()' disabled/><span id='result'>86400 = 24시간</span></p>
									</div>
								</div>
							</form>
						</div>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 모달 -->
<div id='bFResultModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h6 id='modalTitle'></h6>
				<h6><button type='button' class='btn btn-sm' data-dismiss='modal'>
					<i class="fas fa-times"></i>
				</button></h6>
			</div>
			<div class='modal-body text-center' id='modalContent'>
			</div>
			<div class='modal-footer justify-content-center' id='modalBtn'>
			</div>
		</div>
	</div>
</div>