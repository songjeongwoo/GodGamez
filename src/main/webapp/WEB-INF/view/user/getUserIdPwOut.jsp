<title>갓겜:아이디와 비밀번호 찾기</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<script>
$(document).ready(function() {
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) location.href = '/godgamez.selfdevelopment/';

	$(checkWork);
})

function checkWork() {
	if(sessionStorage.getItem('work') == 'findId') {
		$('#workName').text('아이디 찾기');
		$('#workContent').html('회원님의 ID는 ' + sessionStorage.getItem('findId') + ' 입니다.');
		$('#workTip').remove();
		sessionStorage.removeItem('findId');
	} else if(sessionStorage.getItem('work') == 'getPw') {
		$('#workName').text('비밀번호 재발급');
		id = sessionStorage.getItem('getPw').split(",")[0];
		pw = sessionStorage.getItem('getPw').split(",")[1];
		sendTempPw(id, pw);
		$('#workContent').html('회원님의 이메일로 임시 비밀번호를 발급했습니다.<br>빠른 시일 내에 비밀번호를 변경하여 주세요.');
		$('#workTip').html('<small class="mr-5">메일함에서 확인되지 않는다면 스팸 메일함을 확인해주세요.<br></small>' +
			'<a href="#" class="small text-dark font-weight-bold font-italic mr-5" onclick="sendTempPw(\'' + id + '\', \'' + pw + '\')">' +
			'<i class="far fa-paper-plane"></i> 메일 재발송</a>');
		sessionStorage.removeItem('getPw');
	}
	sessionStorage.removeItem('work');
}

/* 임시비번발급 메일 보내기 */
function sendTempPw(userId, userPw) {
	tempPwData = {
		to: userId,
		subject: "[갓겜즈] 임시 비밀번호가 발급되었습니다.",
		text: "<a href='http://localhost/godgamez.selfdevelopment/user/login'>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/1K1TeHVfSy2IBq5QqQ94sd5YKLE6O5geP=w1190-h1142-iv1' style='margin: 0;'/>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<div style='margin: 0; float:left;'>"+
						"<img src='https://lh3.google.com/u/2/d/1-1UwAkCnOODrf7ZUGvkiziykVFHjPldr=w1190-h1142-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<div style='margin: 0; width: 183px; height: 28px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							userId +
						"</h3></div>"+
						"<div style='margin: 0; width: 183px; height: 33px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							userPw +
						"</h3></div>"+
					"</div>"+
					"<div style='margin: 0;'>"+
						"<img src='https://lh3.google.com/u/2/d/1WRgValy0okEEgMEUmKPBzH1rxSGv1Wzv=w1190-h1142-iv1' style='margin: 0;'/>"+
					"</div>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/194Y3m7GjY8Y1YTBAMaMXj0uPWCORw3Dm=w1190-h1142-iv1' style='margin: 0;'/>"+
				"</div>"+
			"</a>"
	};
	sendMail(tempPwData, "");
}
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='container'>
		<div class='row mt-5'>
			<div class='col'>
				<div class='row'>
					<h1 id='workName' class='mt-4 my-3'></h1>
				</div>
				<hr>
				<div class='row mt-5 mx-5 mb-3'>
					<div class='col'>
						<h4 class='font-weight-bold text-center my-3' id='workContent'></h4>
						<h6 class='text-right mt-4 mx-5' id='workTip'></h6>
					</div>
				</div>
				<div class='row mt-5 mb-4 mx-3 justify-content-around'>
					<a class='btn btn-outline-secondary col mr-1' href='/godgamez.selfdevelopment/'>메인</a>
					<a class='btn btn-secondary col' href='/godgamez.selfdevelopment/user/login'>로그인</a>
				</div>
				<hr>
			</div>
		</div>
	</div>
</div>

<%@ include file='../include/footer.jsp' %>