<title>갓겜:회원가입</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#clsIcon {
	width: 10rem;
	height: 10rem;
}

#switchClsIconBtn {
	top: 0rem;
	left: 7.45rem;
}

#usrClsSetting label {
	width: 6rem;
	margin-left: 1rem;
}

#srchClsModal {
	z-index: 99998;
}

#bFResultModal {
	z-index: 99999;
}
</style>

<script>
$(document).ready(function() {
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) location.href="/godgamez.selfdevelopment/";
	
	$(chkToday);
	$(clsLimit);
})

/* 회원 추가 */
function addUser() {
	userId= $('#usrIn #usrId').val();
	
	userAddData = {
		usrCode : 0,
  		position : 'NOOB',
  		usrId : userId,
  		usrPw : $('#usrIn #usrPw').val(),
  		usrName : $('#usrIn #usrName').val(),
  		nickname : $('#usrIn #usrNick').val(),
  		birthday : $('#usrIn #usrBDate').val(),
  		phoneNum : $('#usrIn #usrPhone').val(),
  		usrLv : 0,
  		gold : 0,
  		regDate : new Date().toISOString().substring(0, 10),
  		usrIcon : $('#usrClsSetting #clsIcon').attr('name')
  	}
	
	$.ajax({
		url: "/godgamez.selfdevelopment/user/add",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(userAddData),
		success: function(result) {
			if(result) {
	     		$.ajax({
	     			url: "/godgamez.selfdevelopment/user/get",
	     			type: "POST",
	     	        contentType: "application/json",
	     			data: JSON.stringify({usrId : userId}),
	     	        success: function(user) {
		   	        	if(user != null) {
		   	        		addClsFor(user.usrCode);
		   	        	} else reset(user.usrCode);
	     	        }, fail: function() {
	     	        	reset(user.usrCode);
		     		}
		     	})
		    } else reset(user.usrCode);
		}, fail: function() {
			modal("회원", "가입", "실패");
		}
	})
}

/* 클래스 선택 시 해당 클래스 추가 */
function addClsFor(userCode) {
	let classes = document.querySelectorAll("label input[name='usrClsId']");
	let addClsSucCnt = 0;
	let addClsFailCnt = 0;
	
	classes.forEach(function(cls) {
		let classId = cls.value;
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/class/add",
			type: "POST",
			data: JSON.stringify({userCode: userCode, classId: classId}),
	        contentType: "application/json",
	        async: false,
	        success: function(result) {
	        	if(result) addClsSucCnt++;
				else addClsFailCnt++;
 	        }, fail: function() {
 	        	addClsFailCnt++;
     		}
		})
	})
	
	if(addClsFailCnt == 0) sendMails(userCode);
	else reset(userCode);
}

/* 회원 추가 이상할 때 리셋 */
function reset(userCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/user/del/" + userCode,
		type: "DELETE",
	})
	modal("회원", "가입", "실패");
}

/* 메일폼 정리 */
function sendMails(userCode) {
	let now = new Date();
	
	welcomeData = {
		to: $('#usrIn #usrId').val(),
		subject: "[갓겜즈] 가입해주셔서 감사합니다!",
		text: "<a href='http://localhost/godgamez.selfdevelopment/'>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/1ob3PYgClOVyWRlIA1Z1uL36xZhiOklRr=w1231-h1146-iv1' style='margin: 0;'/>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<div style='margin: 0; float:left;'>"+
						"<img src='https://lh3.google.com/u/2/d/1spoIkuWdfEv6JeFToMgl9COqpffbpKuV=w1231-h1146-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<div style='margin: 0; width: 224px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							$('#usrIn #usrId').val() +
						"</h3></div>"+
						"<div style='margin: 0; width: 224px; height: 26px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							$('#usrIn #usrName').val() +
						"</h3></div>"+
						"<div style='margin: 0; width: 224px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							$('#usrIn #usrNick').val() +
						"</h3></div>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<img src='https://lh3.google.com/u/2/d/1DuaaJGLZq2WCKwDHSi16lAy30U6rfTLb=w1231-h1146-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<div style='margin: 0; width: 220px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							"회원 가입" +
						"</h3></div>"+
						"<div style='margin: 0; width: 220px; height: 26px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate() +
						"</h3></div>"+
						"<div style='margin: 0; width: 220px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							now.getHours() + "시 " + now.getMinutes() + "분" +
						"</h3></div>"+
					"</div>"+
					"<div style='margin: 0;'>"+
						"<img src='https://lh3.google.com/u/2/d/1flqNkaokgW12yxgUB7kAoHqIB-nFTdgr=w1231-h1146-iv1' style='margin: 0;'/>"+
					"</div>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/1fVa1K1gro6RALLIoDmUe0nsSDYFL93g3=w1231-h1146-iv1' style='margin: 0;'/>"+
				"</div>"+
			"</a>"
	};
	sendMail(welcomeData, "");
	
	let authcode = "";
	$.ajax({
		url: "/godgamez.selfdevelopment/make/authCode",
		type: "GET",
        contentType: "application/json",
        async: false,
		success: function(authCode) {
			if(authCode.length) authcode = authCode;
		}
	})
	
	if(authcode.length) {
		verifyData = {
			to: $('#usrIn #usrId').val(),
			subject: "[갓겜즈] 메일 인증 안내",
			text: "<a href='http://localhost/godgamez.selfdevelopment/'>"+
					"<div style='margin: 0;'>"+
						"<img src='https://lh3.google.com/u/2/d/1cslEdAtr0j3j1Y3v3KtXkMaSHIdlitX7=w1740-h1146-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0;'>"+
						"<div style='margin: 0; float:left;'>"+
							"<img src='https://lh3.google.com/u/2/d/151xayCxybidDrweVeW6Cnf30jXKdP8TJ=w979-h1146-iv1' style='margin: 0;'/>"+
						"</div>"+
						"<div style='margin: 0; float:left;'>"+
							"<div style='margin: 0; width: 209px; height: 26px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
								$('#usrIn #usrId').val() +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 29px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
								$('#usrIn #usrName').val() +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
								$('#usrIn #usrNick').val() +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 26px; background-color: #f2f2f2;'></div>"+
							"<div style='margin: 0; width: 209px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
								authcode +
							"</h3></div>"+
						"</div>"+
						"<div style='margin: 0;'>"+
							"<img src='https://lh3.google.com/u/2/d/1ymWAIp8g8iyCxkiGSd9dbAOH6M1bwFUB=w979-h1146-iv1' style='margin: 0;'/>"+
						"</div>"+
					"</div>"+
					"<div style='margin: 0;'>"+
						"<img src='https://lh3.google.com/u/2/d/1D4QbEHy5h3Xf17F2lMdEUxEZYONDuxUZ=w979-h1146-iv1' style='margin: 0;'/>"+
					"</div>"+
				"</a>"
		};
		sendMail(verifyData, "user/join/step3");
	} else reset(userCode);
}
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='container' onmousemove='phoneChk(1); nameChk(1); pwChk(1); pwAgainChk(1); idChk(1); nickChk(1); clsLimit(); chkInput(5);'>
		<div class='row'>
			<div class='col'>
				<div class='row mt-5'>
					<p class='text-muted font-weight-bold'>회원가입 STEP 2</p>
				</div>
				<div class='row my-1'>
					<h2 class='text-muted'>약관 동의 > </h2><pre> </pre>
					<h2 class='font-weight-bold'>정보 입력</h2><pre> </pre>
					<h2 class='text-muted'> > 가입 완료</h2>
				</div>
				<hr>
				<div class='row mt-1 ml-3 justify-content-between text-nowrap'>
					<h4>ACCOUNT</h4>
					<h6 class='small font-wieght-bold mr-3'>＊ = 필수입력사항</h6>
				</div>
				<div class='row mx-5'>
					<div class='col mt-4'>
						<div class='row mb-4' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='text' class='form-control' name='usrIn' id='usrId' value='cxttxnballing@gmail.com'
								placeholder=' ID로 사용할 이메일 주소를 입력하세요.' onchange='idChk(1); chkInput(5);' required>
							<h6 class='font-wieght-bold' id='usrIdChk'></h6>
						</div>
						<div class='row mb-2' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='password' class='form-control' name='usrIn' id='usrPw' value='user.!12'
								placeholder=' 비밀번호를 입력하세요.' onchange='pwChk(1); pwAgainChk(1); chkInput(5);' required>
							<h6 class='font-wieght-bold' id='usrPwChk'></h6>
							<small class='text-dark ml-2'>
								- 영문 대소문자, 숫자, 특수문자를 혼합하여 6~10자의 비밀번호를 입력해주세요. (띄어쓰기 금지)
							</small>
						</div>
						<div class='row mb-2' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='password' class='form-control' name='usrIn' id='usrPwAgain' value='user.!12'
								placeholder=' 위에 입력한 비밀번호와 동일한 비밀번호를 입력해주세요.' onchange='pwAgainChk(1); chkInput(5);' required>
							<h6 class='font-wieght-bold' id='usrPwAgainChk'></h6>
						</div>
					</div>
				</div>
				<hr>
				<div class='row mt-1 ml-3 justify-content-between'>
					<h4>PERSONAL INFO</h4>
					<h6 class='small font-wieght-bold mr-3'>＊ = 필수입력사항</h6>
				</div>
				<div class='row mx-5'>
					<div class='col mt-4 mr-3'>
						<div class='row mb-2' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='text' class='form-control' name='usrIn' id='usrName' value='권채린'
								placeholder=' 이름을 입력하세요.' onchange='nameChk(1); chkInput(5);' required>
							<h6 class='font-wieght-bold' id='usrNameChk'></h6>
							<small class='text-dark ml-2'>
								- 2자 이상의 한글을 입력하세요.<br>
								- 띄어쓰기를 입력하지 마세요.
							</small>
						</div>
						<div class='row mb-2' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='text' class='form-control' onfocus='(this.type="date")' onblur='(this.type="text")' value='1993-11-24'
								name='usrIn' id='usrBDate' placeholder=' 생년월일을 입력하세요.' onchange='chkInput(5)' required>
						</div>
					</div>
					<div class='col mt-4 ml-3'>
						<div class='row mb-2' id='usrIn'>
							<input type='text' class='form-control' name='usrIn' id='usrNick' value='겉쩌리'
								placeholder=' 별명을 입력하세요.' onchange='nickChk(1); chkInput(5);'>
							<h6 class='font-wieght-bold' id='usrNickChk'></h6>
							<small class='text-dark ml-2'>
								- 한글, 영어, 숫자를 2~6자 입력하세요.<br>
								- 미입력 시 이름 + 랜덤문자열이 별명이 됩니다.
							</small>
						</div>
						<div class='row mb-2' id='usrIn'>
							<h6 class='font-wieght-bold' id='must'>*</h6>
							<input type='tel' class='form-control' name='usrIn' id='usrPhone' value='01074987412'
								placeholder=' 전화번호를 입력해주세요.' onchange='phoneChk(1); chkInput(5);' required>
							<h6 class='font-wieght-bold' id='usrPhoneChk'></h6>
						</div>
					</div>
				</div>
				<hr>
				<div class='row mt-1 pl-2 justify-content-between'>
					<h4>＊CLASS</h4>
					<h6><a class='small font-wieght-bold text-dark font-italic mr-3' href='/godgamez.selfdevelopment/guide/aboutUs#classGuide' target='_blank'>
						클래스란? >
					</a></h6>
				</div>
				<small class='text-dark ml-3'>
					- 최대 9개 선택 가능합니다.
				</small>
				<div class='row mx-5'>
					<div class='col mt-4 mb-4'>
						<div class='row' id='usrClsSetting' onmousedown='clsLimit(); chkInput(5);'>
							<div class='col ml-0 pl-0 w-25'>
								<img class='border' id='clsIcon'
									 alt='공부 아이콘' name='STUDY' src='/godgamez.selfdevelopment/res/user/icon/STUDY.jpg'>
								<button type='button' class='btn btn-secondary' id='switchClsIconBtn' onclick='switchClsIcon()'>
									<i class='fas fa-arrows-alt-h'></i>
								</button>
							</div>
							<div class='col-3' id='usrClsList1'>
								<label for="줄넘기">
									<input type='checkbox' name='usrClsName' value='줄넘기'>
									줄넘기
									<input type='text' value='1' name='usrClsId' hidden=true readonly>
								</label>
							</div>
							<div class='col-3' id='usrClsList2'>
							</div>
							<div class='col-3' id='usrClsList3'>
							</div>
							<div class='col align-self-end mx-2'>
								<button type='button' class='btn btn-secondary text-center float-right d-inline-block'
									data-toggle='modal' data-target='#srchClsModal' id='srchClsBtn'
									onclick='listCls(); clsLimit(); chkInput(5);' disabled>
									<i class='fas fa-plus'></i>
								</button>
								<button type='button' class='btn btn-outline-secondary text-center float-right d-inline-block'
									onclick='rmvCls(); chkInput(5);' id='clsRmvBtn' disabled>
									<i class='fas fa-minus'></i>
								</button>
							</div>
						</div>
						<div class='row justify-content-end'>
							<h6 class='font-wieght-bold mr-4 mt-1 mb-0' id='usrClsNameChk'>&nbsp;</h6>
						</div>
					</div>
				</div>
				<hr>
				<div class='row mx-3 justify-content-around'>
					<button class='btn btn-outline-secondary col mr-1' data-toggle='modal' data-target='#addUsrCnclModal'>이전</button>
					<button class='btn btn-secondary col' id='nextStepBtn' title='필수사항 입력 후 다음 단계로 진행할 수 있습니다.' onclick='addUser()' disabled>다음</button>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>

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

<div id='addUsrCnclModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>돌아가기</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<div class='modal-body text-center'>
				<p>이전 단계로 돌아가시겠습니까?</p>
				<small>
					이전 단계로 돌아갈 시<br>
					현재 진행단계의 변경사항이 저장되지 않습니다.
				</small>
			</div>
			<div class='modal-footer justify-content-center'>
				<button class='btn btn-outline-secondary' data-dismiss='modal'>아니요</button>
				<a href='/godgamez.selfdevelopment/user/join/step1' class='btn btn-secondary'>&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;</a>
			</div>
		</div>
	</div>
</div>

<!-- srchClsModal -->
<div id='srchClsModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>클래스 검색</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>×</span>
				</button>
			</div>
			<div class='modal-body text-center'>
				<div class='row'>
					<select class="form-select ml-3" aria-label="srchClsOpt" id='srchClsOpt'>
						<option value="srchCondition" selected disabled>검색 조건</option>
						<option value="mainCtg">대분류</option>
						<option value="subCtg">중분류</option>
						<option value="clsName">이름</option>
					</select>
					<input type='text' class='form-control ml-3 w-50' id='srchClsIn' placeholder='2글자 이상 입력하세요'>
					<button type='button' id='srchClsForUsrBtn' class='btn btn-outline-secondary'>검색</button>
				</div>
				<div class='row justify-content-end'>
					<small class='font-wieght-bold text-dark font-italic mr-3' id='srchClsCnt'>
					</small>
				</div>
				<div class='row'>
					<div class='col' style='height:20rem; overflow:auto'>
						<table class='table border text-center'>
							<thead>
								<tr>
									<th id='checkCol'>
										<input type='checkbox' id='checkall10'>
									</th>
									<th>대분류</th>
									<th>중분류</th>
									<th>이름</th>
								</tr>
							</thead>
							<tbody id='srchClsTBody'>
							</tbody>
						</table>
					</div>
				</div>
				<div class='row justify-content-end'>
					<button type='button' class='btn btn-secondary' id='addChoosenClsBtn' onclick='addClsPre()'>추가</button>
				</div>
			</div>
		</div>
	</div>
</div>