<title>갓겜:아이디와 비밀번호 찾기</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#usrIn h6[id$='Chk'] {
	top: 25%;
	right: 3%;
	z-index: 1;
}

.w-90 {
	width: 90%;
}

#findUsrIdBtn,
#getUsrPwBtn {
	font-size: 1.3rem;
}

.form-control {	
	  height: calc(1.8em + 1rem + 2px);
}
</style>
<script>
$(document).ready(function() {
	sessionStorage.removeItem('work');
	
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) location.href = '/godgamez.selfdevelopment/';
	
	$('#findUsrIdBtn').click(function() {
		isYou({usrName : $('#findUsrId #usrName').val(),
				phoneNum: $('#findUsrId #usrPhone').val(),
				birthday: $('#findUsrId #usrBDate').val()}, 'findId');
	})
	
	$('#getUsrPwBtn').click(function() {
		isYou({usrId: $('#getUsrPw #usrId').val(),
				usrName : $('#getUsrPw #usrName2').val(),
				phoneNum: $('#getUsrPw #usrPhone2').val()}, 'getPw');
	})
})

function isYou(inputData, work) {
	if(work == 'findId') {
		$.ajax({
			url: '/godgamez.selfdevelopment/user/get',
			type: 'post',
	        contentType: "application/json",
			data: JSON.stringify({phoneNum: inputData.phoneNum}),
			success: function(usr) {
				if(usr) {
					if(usr.usrName == inputData.usrName && usr.birthday == inputData.birthday) {
						sessionStorage.setItem('work', work);
						sessionStorage.setItem(work, usr.usrId);
						location.href = '/godgamez.selfdevelopment/user/account/step2';
					} else modal('아이디', '찾기', '실패10', '입력값과 회원 정보가 일치하지 않습니다.');
				} else { 
					modal('아이디', '찾기', '실패10', '존재하지 않는 회원입니다.');
				}
			}, fail: function() {
				modal('아이디', '찾기', '실패');
			}
		})
	} else {
		$.ajax({
			url: '/godgamez.selfdevelopment/user/get',
			type: 'post',
	        contentType: "application/json",
			data: JSON.stringify({usrId: inputData.usrId}),
			success: function(usr) {
				if(usr) {
					if(usr.usrName == inputData.usrName && usr.phoneNum == inputData.phoneNum) {
						$.ajax({
							url: '/godgamez.selfdevelopment/make/tmpPw',
							type: 'put',
					        contentType: "application/json",
							data: JSON.stringify(usr),
							success: function(tmpPw) {
								if(tmpPw.length) {
									sessionStorage.setItem('work', work);
									sessionStorage.setItem(work, inputData.usrId + "," + tmpPw);
									location.href = '/godgamez.selfdevelopment/user/account/step2';
								} else modal('임시 비밀번호', '발급', '실패');
							}, fail: function() {
								modal('임시 비밀번호', '발급', '실패');
							}
						})
					} else modal('임시 비밀번호', '발급', '실패10', '입력값과 회원 정보가 일치하지 않습니다.');
				} else modal('임시 비밀번호', '발급', '실패10', '존재하지 않는 회원입니다.');
			}, fail: function() {
				modal('임시 비밀번호', '발급', '실패');
			}
		})
	}
}

function bDateChk() {
	$('#usrBDateChk').empty();
	birthday = $('#usrBDate').val();

	if(birthday.length != 0)
		$('#usrBDateChk').html('<span class="text-success">조회 가능</span>');
	else
		$('#usrBDateChk').html('<span class="text-danger">조회 불가</span>');
}

function name2Chk() {
	$('#usrName2Chk').empty();
	name = $('#usrName2').val();
	
	if(name.length >= 2)
		$('#usrName2Chk').html('<span class="text-success">조회 가능</span>');
	else 
		$('#usrName2Chk').html('<span class="text-danger">조회 불가</span>');
}

function phone2Chk() {
	$('#usrPhone2Chk').empty();
	$('#usrPhone2').val($('#usrPhone2').val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
	telNum = $('#usrPhone2').val();
	
	if(telNum.length >= 10)
		$('#usrPhone2Chk').html('<span class="text-success">조회 가능</span>');
	else
		$('#usrPhone2Chk').html('<span class="text-danger">조회 불가</span>');
}

function findIdChk() {
	allInput = document.querySelectorAll('#findUsrId h6 span').length;
	goodInput = document.querySelectorAll('#findUsrId h6 .text-success').length;
	wrongInput = document.querySelectorAll('#findUsrId h6 .text-danger').length;
	
	if(allInput - goodInput == 0 && wrongInput < 1 && 3 <= allInput)
			$('#findUsrIdBtn').removeAttr('disabled');
}

function getPwChk() {
	allInput = document.querySelectorAll('#getUsrPw h6 span').length;
	goodInput = document.querySelectorAll('#getUsrPw h6 .text-success').length;
	wrongInput = document.querySelectorAll('#getUsrPw h6 .text-danger').length;
	
	if(allInput - goodInput == 0 && wrongInput < 1 && 3 <= allInput)
			$('#getUsrPwBtn').removeAttr('disabled');
}
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='container text-nowrap'>
		<div class='row mt-5'>
			<div class='col mt-4 my-3'>
				<h1>아이디 찾기</h1>
			</div>
			<div class='col mt-4 my-3'>
				<h1>비밀번호 재발급</h1>
			</div>
		</div>
		<div class='row border-top border-bottom'>
			<div class='col border-right'>
				<div class='row m-0 mt-4 justify-content-center'>
					<div id='findUsrId' class='row w-90'>
						<div class='col'>
							<div class='row my-2' id='usrIn'>
								<input type='text' class='form-control' id='usrName'
									placeholder=' 이름' onchange='nameChk(2); findIdChk();'>
								<h6 class='font-wieght-bold' id='usrNameChk'></h6>
							</div>
							<div class='row my-2' id='usrIn'>
								<input type='tel' class='form-control' id='usrPhone'
									placeholder=' 전화번호' onchange='phoneChk(2); findIdChk();'>
								<h6 class='font-wieght-bold' id='usrPhoneChk'></h6>
							</div>
							<div class='row my-2' id='usrIn'>
								<input type='text' class='form-control' onfocus='(this.type="date")'  onblur='(this.type="text")'
									onchange='bDateChk(); findIdChk();' id='usrBDate' placeholder=' 생년월일'>
								<h6 class='font-wieght-bold' id='usrBDateChk'></h6>
							</div>
							<div class='row mt-3 mb-3'>
								<button type='button' class='btn btn-secondary w-100 form-control' id='findUsrIdBtn'
									title='가입 정보와 동일한 이름, 전화번호, 생년월일을 입력하세요.' disabled>
									아이디 찾기
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class='col' onmousemove='getPwChk()'>
				<div class='row m-0 mt-4 justify-content-center'>
					<div id='getUsrPw' class='row w-90'>
						<div class='col'>
							<div class='row my-2' id='usrIn'>
								<input type='email' class='form-control' id='usrId' value='cxttxnballing@gmail.com'
									placeholder=' ID(email@example.com)' onchange='idChk(2)'>
								<h6 class='font-wieght-bold' id='usrIdChk'></h6>
							</div>
							<div class='row my-2' id='usrIn'>
								<input type='text' class='form-control' id='usrName2' placeholder=' 이름' onchange='name2Chk()'>
								<h6 class='font-wieght-bold' id='usrName2Chk'></h6>
							</div>
							<div class='row my-2' id='usrIn'>
								<input type='tel' class='form-control' id='usrPhone2' placeholder=' 전화번호' onchange='phone2Chk()'>
								<h6 class='font-wieght-bold' id='usrPhone2Chk'></h6>
							</div>
							<div class='row mt-3 mb-3'>
								<button type='button' class='btn btn-secondary w-100 form-control' id='getUsrPwBtn' title='가입 정보와 동일한 ID, 이름, 전화번호를 입력하세요.'>
									비밀번호 재발급
								</button>
							</div>
						</div>
					</div>
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