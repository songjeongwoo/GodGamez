<title>갓겜:회원정보변경</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<script>
function chkInput() {
	if($('#usrPw').val().length) $('#nextStepBtn').removeAttr('disabled');
	else return $('#nextStepBtn').attr('disabled', true);
}

$(document).ready(function() {
	$(chkInput);
	
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) {
		$('#usrId').val(sessionUser.usrId);
		
		$('#nextStepBtn').click(() => {
			pwIn = $('#usrPw').val();
			pw = sessionUser.usrPw;
			
			if(pw == pwIn) location.href = "/godgamez.selfdevelopment/user/modify/step2";
			else modal("본인", "인증", "실패");
		})
	} else modal("", "", "실패6");
})
</script>
<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>
<div id='body'>
	<div class='container'>
		<div class='row my-5'>
			<div class='col'>
				<div class='row my-2'>
					<h2>회원정보변경</h2> 
				</div>
				<hr>
				<div class='row ml-3 mt-4'>
					<h3 class='font-weight-bold'>본인확인</h3><pre> </pre>
					<h3 class='text-muted'> > 정보변경</h3>
				</div>
				<div class='row ml-3 mt-4'>
					<small class='h5'> 회원님의 정보보호를 위해 한 번 더 본인확인을 해주시기 바랍니다.</small>
				</div>
				<div class='row mx-5 justify-content-center' onmousemove='chkInput()'>
					<div class='col-7 mx-5'>
						<div class='row mt-3 mb-2'>
							<label for='usrId' class='col-1 pl-1 mt-1 mr-3'>ID</label>
							<input type='email' class='form-control col' id='usrId' name='usrId' readonly>
						</div>
						<div class='row' id='usrIn'>
							<label for='usrPw' class='col-1 pl-1 mt-1 mr-3'>PW</label>
							<input type='password' class='form-control col' id='usrPw' name='usrPw' required>
						</div>
						<div class='row mt-4 justify-content-around'>
							<button type='button' class='btn btn-outline-secondary col mr-1' onclick='modal("회원", "정보 변경", "중단")'>이전</button>
							<button type='button' class='btn btn-secondary col' id='nextStepBtn' disabled>다음</button>
						</div>
					</div>
				</div>
				<hr>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>

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