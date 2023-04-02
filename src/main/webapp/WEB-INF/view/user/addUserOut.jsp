<title>갓겜:회원가입</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>

<script>
$(document).ready(function() {
	let sessionUser = getConnectedUser();
	if(sessionUser && sessionUser.usrCode) location.href="/godgamez.selfdevelopment/";
})
</script> 

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='container'>
		<div class='row'>
			<div class='col'>
				<div class='row mt-5'>
					<p class='text-muted font-weight-bold'>회원가입 STEP 3</p>
				</div>
				<div class='row my-1'>
					<h2 class='text-muted'>약관 동의 > 정보 입력 ></h2><pre> </pre>
					<h2 class='font-weight-bold'> 가입 완료</h2>
				</div>
				<hr>
				<div class='row mt-5 mx-5 mb-3'>
					<div class='col'>
						<h2 class='font-weight-bold text-center my-3'>회원가입이  완료되었습니다.</h2>
						<h5 class='text-center mt-4'>갓생살기게임즈에 가입해주셔서 감사합니다.</h5>
					</div>
				</div>
				<div class='row my-4 mx-3 justify-content-around'>
					<a class='btn btn-outline-secondary col mr-1' href='/godgamez.selfdevelopment/'>메인</a>
					<a class='btn btn-secondary col' href='/godgamez.selfdevelopment/user/login'>로그인</a>
				</div>
				<hr>
				<div class='row'>
					<div class='col d-flex justify-content-center'>
						<p class='text-center'>
							가입하신 이메일 주소로 인증번호를 발송했습니다.<br>
							서비스 이용을 위해 메일 인증을 완료해주세요.<br>
							메일 인증에 대한 내용은 
							<a class='text-dark' href='/godgamez.selfdevelopment/user/mypage'>MyPage <i class="fas fa-external-link-alt"></i></a>
							에서 확인할 수 있습니다.
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file='../include/footer.jsp' %>