<title>갓겜:로그인</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %> <%-- include file='/WEB-INF/view/include/lib.jsp'--%>
<script>
$(document).ready(function() {
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) location.href = '/godgamez.selfdevelopment/';
	if(localStorage.getItem("rememberId") != null) $('#usrId').val(localStorage.getItem("rememberId"));
})

function loginCheck(){
	usrId = $("#usrId").val();
	usrPw = $("#usrPw").val();
	saveId = $("#saveId:checked").val();
	
	if(saveId != null)
		localStorage.setItem("rememberId", usrId);
	
	loginData = {usrId:usrId, usrPw:usrPw};
	
	$.ajax({
        url: "/godgamez.selfdevelopment/user/loginProc",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(loginData),
        success: function(result) {
        	if(result == 1) location.href = "/godgamez.selfdevelopment/";
        	else if(result == 2) location.href = "/godgamez.selfdevelopment/admin";
        	else modal("", "로그인", "실패10", "로그인에 실패하였습니다. ID와 PW를 확인하세요!");
        }
  	});
}
</script>
<%@ include file='/WEB-INF/view/include/header.jsp' %>
<%@ include file='/WEB-INF/view/include/gnb.jsp' %>
<div id='body'>
	<div class='container'>
		<div class='row my-5'>
			<div class='col'>
				<div class='row my-1'>
					<h1>로그인</h1>
				</div>
				<hr>
				<div class='row mx-5 justify-content-center'>
					<div class='col-7 mx-5'>
						<div class='row mt-3 mb-2'>
							<label for='usrId' class='col-1 pl-1 mt-1 mr-3'>ID</label>
							<input type='text' class='form-control col' id='usrId' name='usrId' required> <!-- <input type='email' class='form-control col' id='usrId' name='usrId' required> -->
						</div>
						<div class='row'>
							<label for='usrPw' class='col-1 pl-1 mt-1 mr-3'>PW</label>
							<input type='password' class='form-control col' id='usrPw' name='usrPw' required>
						</div>
						<div class='row justify-content-end mt-2'>
							<input type='checkbox' id='saveId' name='saveId' class='mt-2 mr-2'>
							<label for='saveId' class='float right'>ID 저장</label>
						</div>
					</div>
				</div>
				<div class='row mx-5 justify-content-center'>
					<button type='button' class='btn btn-secondary col-7 p-2' id='loginBtn' onclick='loginCheck()'>로그인</button>
				</div>
				<div class='row text-center my-3'>
					<a href='/godgamez.selfdevelopment/user/account/step1' class='col text-dark'> 아이디 / 비밀번호 찾기 </a>
				</div>
				<hr>
				<div class='row justify-content-center mt-4'>
					<h4>아직 회원이 아니신가요?</h4>
				</div>
				<div class='row text-center'>
					<a href='/godgamez.selfdevelopment/user/join/step1' class='col mt-2 text-dark'> 회원 가입하기 </a>
				</div>
			</div>
		</div>
	</div>
</div>

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

<%@ include file='/WEB-INF/view/include/footer.jsp' %>