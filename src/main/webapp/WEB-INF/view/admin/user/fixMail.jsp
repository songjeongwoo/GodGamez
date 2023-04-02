<title>갓겜:자동 메일</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>

<style>
#mailContent {
	height: 40rem;
	resize: none;
}
</style>

<div class='h-100'>
	<%@ include file='../include/header.jsp' %>

	<div id='underHead' class='row w-100'>
		
		<%@ include file='../include/gnb.jsp' %>
		
		<div class='col-7 m-5' id='adminBody'>
			<div class='row mb-3'>
				<h4>자동 메일</h4>
			</div>
			<form>
				<div class='row'>
					<div class='col-3'>
						<select class='form-control'>
							<option disabled selected>메일종류</option>
							<option value='usrAddMail'>회원가입 안내</option>
							<option value='usrAuthMail'>E-mail 인증번호 발송</option>
							<option value='usrPwMail'>임시 비밀번호 발급</option>
							<option value='usrOutMail'>탈퇴처리 안내</option>
						</select>
					</div>
					<div class='col-9'>
						<input type='text' class='form-control' value='[갓겜] 탈퇴처리 안내'>
					</div>
				</div>
				<div class='row mt-2'>
					<div class='col'>
						<textarea class='form-control' id='mailContent'>
<div style=’text-align: center;>
	<a href=’사이트 주소’>
		<img src=’로고이미지’>
	</a>
</div>
<br>
<h3 style=’text-align: center;’>
	E-mail 인증 안내
</h3>
<br>
<h6 style=’text-align: center;’>
	E-mail 인증번호 입력란에 아래 인증번호를 입력해주세요.
</h6>
<br><br>
<div style=’border:1px solid #c0c0c0; height: 300px; width: 600px; text-align: left;’>
	<strong>인증 정보</strong>
	<br><br>
	<pre>
		계정	:  {user_id}
		인증번호	:  {random_code}
	</pre>
</div>
						</textarea>
					</div>
				</div>
				<div class='row justify-content-end mt-2 mr-1'>
					<button type='button' class='w-10 btn btn-outline-secondary mr-2' data-toggle='modal' data-target='#cnclMailModal'>
						취소
					</button>
					<button type='button' class='w-10 btn btn-secondary' data-toggle='modal' data-target='#fixMailModal'>
						저장
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 모달 -->
<div id='cnclMailModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>메일 폼 작성 취소</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<div class='modal-body text-center'>
				<p>메일 폼 작성을 취소하시겠습니까?</p>
			</div>
			<div class='modal-footer justify-content-center'>
				<button class='btn btn-outline-secondary' data-dismiss='modal'>아니요</button>
				<a href='/godgamez.selfdevelopment/admin/users/mail' class='btn btn-secondary'>&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;</a>
			</div>
		</div>
	</div>
</div>

<div id='fixMailModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>메일 폼 저장</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<div class='modal-body text-center'>
				<p>저장되었습니다.</p>
			</div>
			<div class='modal-footer justify-content-center'>
				<button class='btn btn-outline-secondary' data-dismiss='modal'>확인</button>
			</div>
		</div>
	</div>
</div>