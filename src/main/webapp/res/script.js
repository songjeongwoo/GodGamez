$(document).ready(function() {
	$(footerPosition);
	$(window).resize(function() {
		$(footerPosition);
	})
	
	/* 전체선택 알고리즘 */
	$('#checkCol input[id^="checkall"]').click(function() {
		if($(this).prop('checked'))
			$('input[name=check' + $(this).attr('id').substring(8) + ']').prop('checked', true);
		else
			$('input[name=check' + $(this).attr('id').substring(8) + ']').prop('checked', false);
	})
});

function footerPosition() {
	$('footer').attr('style', 'position: fixed; bottom: 0;');
	if($('header').height() + $('#gnb').height() + $('#body').height() + $('footer').height() >=  $(window).height())
		$('footer').removeAttr('style', '');
}

function getConnectedUser() { //로그인 한 유저값
	let user;
	
	$.ajax({
		url: '/godgamez.selfdevelopment/isLogined',
        contentType: "application/json",
		async: false
	}).done(usr => {
		if(usr) user = usr;
	}).fail(() => {user = null;})
	
	return user;
}

function isPossible(inputData) {
	isPsb = false;
	$.ajax({
		url: '/godgamez.selfdevelopment/user/get',
		type: 'post',
		contentType: "application/json",
		data: JSON.stringify(inputData),
		async: false,
		success: function(u) {
			if(u.length == 0) isPsb =  true;
			else isPsb =  false;
		}, fail: function() {
			modal("중복값", "확인", "실패");
			isPsb =  false;
		}
	})
	return isPsb;
}

function chkToday() {
	$('#usrBDate').attr('max', new Date().toISOString().substring(0, 10));
}

function idChk(job) {
	switch(job) {
		case 1: msg = '사용'; break;
		case 2: msg = '조회';
	}
	
	id = $('#usrId').val();
	
	if(id.length) {
		if(id.search(/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,4}$/) < 0 || !isPossible({usrId:id})) 
			$('#usrIdChk').html('<span class="text-danger">' + msg + ' 불가</span>');
		else $('#usrIdChk').html('<span class="text-success">' + msg + ' 가능</span>');
	} else $('#usrIdChk').empty();
}

function pwChk(job) {
	pw = $('#usrPw').val();
	
	switch(job) {
		case 1: msg = '사용'; break;
		case 2: msg = '조회'; break;
		case 3: msg = '변경';
	}
	
	if(pw.length) {
		if(pw.length < 6 || 10 < pw.length || pw.search(/\s/) != -1 || pw.search(/[ㄱ-ㅎㅏ-ㅣ가-힣]/) != -1 
				|| pw.search(/[0-9]/) < 0 || pw.search(/[a-zA-Z]/) < 0 || pw.search(/[,./~!@#$%^&*()_+=<>?:;{}]/) < 0)
			$('#usrPwChk').html('<span class="text-danger">' + msg + ' 불가</span>');
		else $('#usrPwChk').html('<span class="text-success">' + msg + ' 가능</span>');
	} else if(pw.length == 0) $('#usrPwChk').html('<span class="text-danger">필수 입력</span>');
	else $('#usrPwChk').empty();
}

function pwAgainChk(job) {	
	if($('#usrPw').val().length && $('#usrPwAgain').val().length) {
		if($('#usrPwAgain').val() == $('#usrPw').val())
			$('#usrPwAgainChk').html('<span class="text-success">일치</span>');
		else
			$('#usrPwAgainChk').html('<span class="text-danger">불일치</span>');
	} else if($('#usrPwAgain').val().length) {
		$('#usrPwAgainChk').html('<span class="text-danger">불일치</span>');
		$('#usrPwChk').empty();
	} else if($('#usrPw').val().length == 0) $('#usrPwAgainChk').html('<span class="text-danger">필수 입력</span>');
	else $('#usrPwAgainChk').empty();
}

function phoneChk(job) {
	switch(job) {
		case 1: msg = '사용'; break;
		case 2: msg = '조회'; break;
		case 3: msg = '변경';
	}

	$('#usrPhone').val($('#usrPhone').val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
	telNum = $('#usrPhone').val();
	
	if(telNum.length) {
		if((8 < telNum.length && telNum.length < 12 && telNum.startsWith('0') && isPossible({phoneNum:telNum})) 
				|| (9 < telNum.length && telNum.length < 12 && telNum.startsWith('01')))
			$('#usrPhoneChk').html('<span class="text-success">' + msg + ' 가능</span>');
		else
			$('#usrPhoneChk').html('<span class="text-danger">' + msg + ' 불가</span>');
	} else if(telNum.length == 0) {
		$('#usrPhoneChk').html('<span class="text-danger">필수 입력</span>');
	} else $('#usrPhoneChk').empty();
}

function nameChk(job) {
	switch(job) {
		case 1: msg = '사용'; break;
		case 2: msg = '조회';
	}
	name = $('#usrName').val();
	
	if(name.length) {
		if(name.length < 2 || name.search(/\s/) != -1 || name.search(/[가-힣]/) < 0 
				|| name.search(/[ㄱ-ㅎㅏ-ㅣ0-9a-zA-Z,./~!@#$%^&*()_+=<>?:;{}]/) != -1)
			$('#usrNameChk').html('<span class="text-danger">' + msg + ' 불가</span>');
		else $('#usrNameChk').html('<span class="text-success">' + msg + ' 가능</span>');
	} else $('#usrNameChk').empty();
}

function nickChk(job) {
	$('#usrNickChk').empty();
	nick = $('#usrNick').val();
	
	switch(job) {
		case 1: msg = '사용'; break;
		case 2: msg = '변경';
	}
	
	if(nick.length) {
		if(nick.length >= 2 && nick.search(/[가-힣0-9a-zA-Z]/) != -1 && 6 >= nick.length && isPossible({nickname:nick})
				&& nick.search(/[ㄱ-ㅎㅏ-ㅣ,./~!@#$%^&*()_+=<>?:;{}]/) < 0 && nick.search(/\s/) < 0 && !nick.startsWith('GM')) 
			 $('#usrNickChk').append('<span class="text-success">' + msg + ' 가능</span>');
		else $('#usrNickChk').append('<span class="text-danger">' + msg + ' 불가</span>');
	} else if(nick.length == 0) {
		$('#usrNickChk').html('<span class="text-danger">필수 입력</span>');
	} else $('#usrNickChk').empty();
}

function switchClsIcon() {
	if($('#usrClsSetting #clsIcon').attr('name') == 'EXERCISE') {
		$('#usrClsSetting #clsIcon').attr('name', 'STUDY');
		$('#usrClsSetting #clsIcon').attr('src', '/godgamez.selfdevelopment/res/user/icon/STUDY.jpg');
		$('#usrClsSetting #clsIcon').attr('alt', '공부 아이콘');
	} else {
		$('#usrClsSetting #clsIcon').attr('name', 'EXERCISE');
		$('#usrClsSetting #clsIcon').attr('src', '/godgamez.selfdevelopment/res/user/icon/EXERCISE.jpg');
		$('#usrClsSetting #clsIcon').attr('alt', '운동 아이콘');
	}
}

function clsLimit() { //보유 클래스 수가 9개면 검색 버튼 비활성화, 0개라면 빼기 버튼 비활성화
	$('#usrClsNameChk').html('&nbsp;');
	$('#srchClsBtn').attr('disabled', true);
	$('#clsRmvBtn').attr('disabled', true);
	
	if($('div[id^="usrClsList"] label').length == 9) {
		$('#usrClsNameChk').append('<span class="text-success">등록 가능한 수의 클래스를 전부 등록했습니다.</span>');
		$('#clsRmvBtn').removeAttr('disabled');
	} else if($('div[id^="usrClsList"] label').length == 0) {
		$('#usrClsNameChk').append('<span class="text-danger">클래스를 1개 이상 등록하세요.</span>');
		$('#srchClsBtn').removeAttr('disabled');
	} else {
		$('#clsRmvBtn').removeAttr('disabled');
		$('#srchClsBtn').removeAttr('disabled');
	}
}

/* 인풋값 이상있는 지 없는 지 */
function chkInput(num) { //input 값 봤을 때 이상 없는 지.
	$('#nextStepBtn').attr('disabled', true); 
	allInput = document.querySelectorAll('h6 span').length;
	goodInput = document.querySelectorAll('h6 .text-success').length;
	wrongInput = document.querySelectorAll('h6 .text-danger').length;
	
	if(allInput - goodInput == 0 && wrongInput < 1 && num <= allInput)
		$('#nextStepBtn').removeAttr('disabled');
}

/*
b = business 업무	(회원, 클래스, 퀘스트, 보상)
f = function 기능	(추가, 수정, 삭제, 신고)
result = 결과		(성공, 실패, 확인, 중단, 중단확인)
id = 체크박스 아이디

예)
b = usr / f = add / result = suc
유저 추가 성공
*/

/* b를 가지고 f 작업을 하기 전에 id 값의 체크박스가 체크되어있는 지 */
/* 나중에 여기에 펑션값에 database 리턴값 관련 파라미터 넣기 */
function isChecked(b, f, id) {
	switch(f) {
	case "추가":
		$("#" + id + ":checked").prop('checked', false); break;
	case "수정":
		if($("#" + id + ":checked").length != 1)
			modal(b, f, '실패2');
		else if(b == "내가 쓴 게시글" || b == "내가 쓴 댓글")
			modal(b, f, '진행');
		else $("#fixProcModal").modal('show'); break;
	case "신고": case "삭제":
		if($("#" + id + ":checked").length == 0)
			modal(b, f, '실패3');
		else modal(b, f, '확인'); break;
	default:
		if($("#" + id + ":checked").length == 0)
			modal(b, f, '실패3');
		else {
			modal(b, f, '성공'); break;
		}
	}
}

function isRadioChecked(b, f, id, id2) {
	if($("#" + id + ":checked").length != 1 || $("#" + id2 + ":checked").length != 1)
		modal(b, f, '실패9');
	else modal(b, f, '완료');
}

/*
b를 가지고 f 작업을 했을 때 result에 따라 모달 내용이 바뀐다.
진행 : 특정 작업을 진행하기 위해 이동 - 예를 들어 마이페이지에서 내가 쓴 게시글 수정
성공, 실패 : 기본적인 성공 실패 모달
실패2 : 수정 시 체크를 0개 혹은 2개 이상 했을 때
실패3 : 삭제, 신고 등 여러 작업 시 체크를 0개 했을 때
실패4 : 선택항목 중 존재하지 않는 게 포함되어 있을 때
실패5 : 진행하고자 하는 작업이 이미 완료된 항목이 선택에 포함되어있을 때
실패6 : 회원이 활동 정지 당한 상태일 때
실패7 : 회원이 뉴비일 때 (메일인증 받지 않았을 때)
실패8 : 가입하지 않은 사용자일 때
실패9 : admin의 쿠폰 발급 선택값 없을 때
확인 : 삭제, 신고 등의 작업을 다시 한번 묻기
완료 : 보상 쿠폰 사용 완료, 퀘스트 제출 완료와 같이 특정 업무에 사용
중단 : 이전으로 돌아가거나 수정/추가 등의 작업을 캔슬할 때 사용
중단2 : '중단'에 대한 부차적인 모달로, 직접 사용은 지양
 */
function modal(b, f, result, ...msg) {
	$('#bFResultModal #modalTitle').empty();
	$('#bFResultModal #modalContent').empty();
	$('#bFResultModal #modalBtn').empty();
	
	modalTitle = b + '&nbsp;' + f + '&nbsp;' + result;
	modalContent = '<h5 class="mt-2">' + b;
	
	modalBtn = "#bFResultModal #modalBtn"; /* 모달 버튼이 들어갈 자리 */
	modalBtnMove = "<button class='btn btn-outline-secondary' onclick='moveTo(\"" + b + "\", \"" + f + "\")'> 확 인 </button>"; /* 클릭 시 이동하는 버튼 */
	modalBtnClose = "<button class='btn btn-outline-secondary' data-dismiss='modal' id='okCloseBtn'> 확 인 </button>"; /* 클릭 시 모달 닫기만 하는 버튼 */
	modalBtnProc = "<button class='btn btn-outline-secondary' data-dismiss='modal' id='doneBBtn'> 확 인 </button>"; /* 클릭 시 업무를 완료하는 버튼 */
	
	switch(result) {
	case "진행":
		modalContent += ' 페이지로 이동합니다.</h5>';
		$(modalBtn).html(modalBtnMove); break;
	case "성공":
		modalContent += '&nbsp;' + f + '에 ' + result + '하였습니다.</h5>';		
		if(f == "발급")
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/user/mypage'>마이 페이지로 이동 <i class='fas fa-gamepad'></i></a>");
		else if(f == "인증") {
			modalContent = '<p>인증이 완료되었습니다!</p><p>지금 바로 퀘스트에 도전하세요!</p>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/'>메인으로</a><a class='btn btn-secondary' href='/godgamez.selfdevelopment/quest/board'>퀘스트 하러가기</a>")
		} else $(modalBtn).html(modalBtnProc); break;
	case "실패": case "실패2": case "실패3": case "실패4": case "실패5": case "실패6": case "실패7": case "실패8": case "실패9": case "실패10":
		modalTitle = b + '&nbsp;' + f + ' 실패';
		modalContent += '&nbsp;' + f + '에 실패하였습니다.</h5> <h6 class="text-danger mt-2">'
		$(modalBtn).html(modalBtnClose);
		if(result == "실패")
			modalContent = '<h5 class="mt-2">' + b + '&nbsp;' + f + '에 실패하였습니다.</h5>';
		else if(result == "실패2")
			modalContent += '수정할 항목 <b><u>하나를</u></b> 선택하세요.</h6>';
		else if(result == "실패3")
			modalContent += f + '할 항목을  <b><u>하나 이상</u></b> 선택하세요.</h6>';
		else if(result == "실패4")
			modalContent += '존재하지 않는 항목이 선택에 포함되어 있습니다.</h6>';
		else if(result == "실패5")
			modalContent += '이미 ' + f + ' 처리된 항목이 선택에 포함되어 있습니다.</h6>';
		else if(result == "실패6") {
			modalTitle = '서비스 이용 불가';
			modalContent = '<h5 class="mt-2">비정상적인 접근입니다.<br>로그인 화면으로 이동합니다.</h5>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/user/login'>확 인 <i class='fas fa-exclamation-circle'></i></a>");
		} else if(result == "실패7") {
			modalTitle = '메일을 인증해주세요!';
			modalContent = '<h5 class="mt-2">해당 서비스를 이용하기 위해<br>메일을 인증해주세요.</h5>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/user/verifiy'>인증하기 <i class='fas fa-external-link-alt'></i></a>");
		} else if(result == "실패8") {
			modalTitle = '용사님! 이세계로 돌아오세요!';
			modalContent = '<h5 class="mt-2">해당 서비스를 이용하기 위해<br>갓생살기 게임즈에 로그인하세요!</h5>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/user/login'>로그인하기</a>" +
					"<a class='btn btn-secondary' href='/godgamez.selfdevelopment/user/join/step1'>가입하기</a>");
		} else if(result == "실패9")
			modalContent += '발급할 쿠폰과 발급받을 대상을 <b><u>하나씩</u></b> 선택하세요.</h6>';
		else modalContent += msg + '</h6>'; break;
	case "확인":
		$(modalBtn).html(
				"<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
				"<button class='btn btn-secondary' data-dismiss='modal' onclick='finBusiness(\"" + b + "\", \"" + f + "\")'> 확 인 </button>");
		if(b == '클래스' || b == '퀘스트' || b.search("이미지") != -1) {
			modalContent += '를 정말 ' + f + '하시겠습니까?</h5>';
			/*$(modalBtn).html("<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
					"<button class='btn btn-secondary' onclick='delB()' id='sureBtn'> 예 </button>");*/
		} else if(b.search("회원") != -1 || b.search("쿠폰") != -1) {
			modalContent += '을 ' + f + '하시겠습니까?</h5>';
			$(modalBtn).html(
				"<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
				"<button class='btn btn-secondary' id='sureBtn'> 확 인 </button>");
		} else modalContent += '을 정말 ' + f + '하시겠습니까?</h5>'; break;
	case "완료":
		if(b != '클래스' || b != '퀘스트' || b != '로고' || b != '이미지' || b != '로그')
			modalContent += '을 ' + f + '하였습니다.</h5>';
		else modalContent += '를 ' + f + '하였습니다.</h5>';
		if(b == '게시글' || b == '댓글') $(modalBtn).html(modalBtnProc);
		else $(modalBtn).html(modalBtnClose); break;
	case "중단":
		modalTitle = b + '&nbsp;' + f + ' 중단 확인';
		modalContent += '&nbsp;' + f + ' 작업을 정말 중단 하시겠습니까?</h5>' +
						'<h6 class="text-danger mt-2">중단할 시 작업 중인 내용이 저장되지 않습니다.</h6>';
		$(modalBtn).html(
			"<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
			"<button class='btn btn-secondary' onclick='modal(\"" + b + "\", \"" + f + "\", \"중단2\")'> 예 </button>"); break;
	case "중단2":
		modalTitle = b + '&nbsp;' + f + ' 중단';
		modalContent += '&nbsp;' + f + ' 작업을 중단하였습니다.</h5>';
		if(f == '추가' || f == '수정') {
			$(modalBtn).html(modalBtnMove);
			if(f == '추가') $("#addProcModal").modal('hide');
			else $("#fixProcModal").modal('hide');
		} else
			$(modalBtn).html(modalBtnMove);
	}
	$('#bFResultModal #modalTitle').html(modalTitle);
	$('#bFResultModal #modalContent').html(modalContent);
	
	$('#bFResultModal').modal('show');
}

function finBusiness(b, f) {
	arr = ['회원', '메일', '클래스', '퀘스트', '쿠폰', '게시글', '댓글', '로고', '이미지', '로그', '약관'];
	
	for(i = 0; i < 11; i++) {
		b2 = arr[i];
		if(b.includes(b2)) {
			doBusiness(b2, f); return;
		}
	}
}

/*
진행 과 중단2 에 사용되는 함수이다.
 */
function moveTo(b, f) {
	switch(b) {
		case "메일": case "회원":
			if(f != "가입") location.href = "/godgamez.selfdevelopment/user/mypage";
			else location.href = "/godgamez.selfdevelopment/"; break;
		default: location.reload();
	}
}

/* 메일 보내기 */
function sendMail(msgData, redirectUrl) {
	$.ajax({
		url: "/godgamez.selfdevelopment/mail",
		type: "POST",
		data: JSON.stringify(msgData),
		contentType: "application/json",
		async: false,
		success: function() {
			if(redirectUrl.length) location.href = "/godgamez.selfdevelopment/" + redirectUrl;
		}, fail: function() {
			modal("메일", "발송", "실패");
		}
	})
}

/* 인증 메일 보내기 */
function sendVerification(userId, userName, nickname) {
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
			to: userId,
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
							"<div style='margin: 0; width: 209px; height: 26px; background-color: #f2f2f2; vertical-align: bottom;'><h3 style='margin: 0;'>"+
								userId +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 29px; background-color: #f2f2f2; vertical-align: bottom;'><h3 style='margin: 0;'>"+
								userName +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 27px; background-color: #f2f2f2; vertical-align: bottom;'><h3 style='margin: 0;'>"+
								nickname +
							"</h3></div>"+
							"<div style='margin: 0; width: 209px; height: 26px; background-color: #f2f2f2;'></div>"+
							"<div style='margin: 0; width: 209px; height: 27px; background-color: #f2f2f2; vertical-align: bottom;'><h3 style='margin: 0;'>"+
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
		sendMail(verifyData, "");
		modal("메일", "발송", "성공");
	} else modal("메일", "발송", "실패10", "인증 코드 발송 작업이 실패했습니다.<br>다시 시도해주세요.<br><small>위 문제가 반복해서 발생하면 문의해주세요.</small>")
}

/* 등급 상승 메일 보내기 */
function sendPosiUp(userId, userName, nickname) {
	let now = new Date();

	positionUpData = {
		to: userId,
		subject: "[갓겜즈] 회원 등급 상승 안내",
		text: "<a href='http://localhost/godgamez.selfdevelopment/'>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/1k3ZHL3NFMP5Wcl9SillIUEx1NnKEQ6O3=w1012-h1142-iv1' style='margin: 0;'/>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<div style='margin: 0; float:left;'>"+
						"<img src='https://lh3.google.com/u/2/d/1n-GyDfltNhRcEe_d4jCIn8SJca9MK06W=w1012-h1142-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<div style='margin: 0; width: 226px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							userId +
						"</h3></div>"+
						"<div style='margin: 0; width: 226px; height: 32px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							userName +
						"</h3></div>"+
						"<div style='margin: 0; width: 226px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							nickname +
						"</h3></div>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<img src='https://lh3.google.com/u/2/d/1Z7JQ-N2GiJYH0O7tqZlIaLJctutztiIU=w1012-h1142-iv1' style='margin: 0;'/>"+
					"</div>"+
					"<div style='margin: 0; float:left;'>"+
						"<div style='margin: 0; width: 226px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							"회원 등급 상승" +
						"</h3></div>"+
						"<div style='margin: 0; width: 226px; height: 32px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate() +
						"</h3></div>"+
						"<div style='margin: 0; width: 226px; height: 27px; background-color: #f2f2f2;'><h3 style='margin: 0;'>"+
							now.getHours() + "시 " + now.getMinutes() + "분" +
						"</h3></div>"+
					"</div>"+
					"<div style='margin: 0;'>"+
						"<img src='https://lh3.google.com/u/2/d/11Q6cns5h9Lg0Qu5mhOMvTkU7rromLxgm=w1012-h1142-iv1' style='margin: 0;'/>"+
					"</div>"+
				"</div>"+
				"<div style='margin: 0;'>"+
					"<img src='https://lh3.google.com/u/2/d/1l65rnXn53ixSKxLsv1uikGp6EJ8ATc9O=w1012-h1142-iv1' style='margin: 0;'/>"+
				"</div>"+
			"</a>"
	};
	sendMail(positionUpData, "");
}

/* 클래스 리스트 */
function listCls() {
	$('#srchClsModal').modal("show");
	$('#srchClsForUsrBtn').text("검색");
	$('#srchClsForUsrBtn').attr("onclick", "srchClsList()");
	
	$('#choosenClsId:checked').prop('checked', false);
	$('#srchClsTBody').empty();
	
	$.ajax({
		url: '/godgamez.selfdevelopment/class/list',
		method: 'get'
	}).done(clss => {
		if(clss.length) {
			let clsList = [];
			$('#srchClsCnt').text("총 " + clss.length + "건")
			$('#srchClsTBody').empty();
			
			$.each(clss, (idx, cls) => {
				clsList.push(
					"<tr id='clsDetail'>"+
						"<td id='checkCol'><input type='checkbox' id='choosenClsId' name='check10' value="+ cls.clsId +"></td>"+
		  				"<td id='mainCtg'>"+ cls.mainCtg +"</td>"+
		  				"<td id='subCtg'>"+ cls.subCtg +"</td>"+
		  				"<td id='clsName'>"+ cls.clsName +"</td>"+
		  			"</tr>");
				});
			$('#srchClsTBody').append(clsList.join(''))
		} else
			$('#srchClsTBody').html('<tr><td colspan="4" class="text-center">클래스가 존재하지 않습니다.</td></tr>')
	}).fail(() => {
		$('#srchClsTBody').html('<tr><td colspan="4" class="text-center">클래스를 조회하지 못했습니다.</td></tr>')
	})
}

/* 클래스 검색 */
function srchClsList() {
	let srchOpt = $('#srchClsOpt option:selected').val()
	let keyword = $('#srchClsModal #srchClsIn').val()
	searchData = {};
	
	if(srchOpt != 'srchCondition') {
		switch(srchOpt) {
		case "mainCtg" : searchData = {mainCtg: keyword}; break;
		case "subCtg" : searchData = {subCtg: keyword}; break;
		case "clsName" : searchData = {clsName: keyword}
		}
		
		$.ajax({
			url: '/godgamez.selfdevelopment/class/search',
			method: 'post',
			data: JSON.stringify(searchData),
			contentType: 'application/json'
		}).done(clss => {
			if(clss.length) {
				let clsList = []
				$('#srchClsCnt').text("총 " + clss.length + "건 검색");
				$('#srchClsTBody').empty()
				
				$.each(clss, (idx, cls) => {
					clsList.push(
						"<tr id='clsDetail'>"+
							"<td id='checkCol'><input type='checkbox' id='choosenClsId' name='check10' value="+ cls.clsId +"></td>"+
			  				"<td id='mainCtg'>"+ cls.mainCtg +"</td>"+
			  				"<td id='subCtg'>"+ cls.subCtg +"</td>"+
			  				"<td id='clsName'>"+ cls.clsName +"</td>"+
			  			"</tr>");
					});
				$('#srchClsTBody').append(clsList.join(''))
			} else {
				$('#srchClsTBody').html(
						'<tr><td colspan="4"><span class="text-danger font-weight-bold">' +
							'「' + keyword + '」</span>에 대한 검색결과가 없습니다.' +
						'</td></tr>')
			}
		}).fail( function() {
			$('#srchClsTBody').html('')
			$('#srchClsTBody').append('<tr><td colspan="3" class="text-center">클래스를 검색할 수 없습니다.</td></tr>')
		})
	} else if(srchOpt == 'srchCondition') {
		$('#srchClsTBody').html('<tr><td colspan="3" class="text-center">검색 조건을 선택하세요.</td></tr>')
	}
}

/* 클래스 선택 시 해당 클래스 추가 */
function addClsPre() {
	if(!$('#choosenClsId:checked').length) modal("회원 클래스", "추가", "실패3");
	else {
		let myCls = $('#usrClsSetting').text();
		let choosenClss = checkCls(myCls);
		
		if(choosenClss.length) {
			choosenClss.forEach(function(clsIdName) {
				clsId = clsIdName.split("|")[0];
				clsName = clsIdName.split("|")[1];
				
				appendContent =
					"<label for=" + clsName + ">" +
						"<input type='checkbox' name='usrClsName' value=" + clsName + ">" +
						clsName +
						"<input type='text' value=" + clsId + " name='usrClsId' hidden=true readonly>" +
					"</label>";
				
				if(document.querySelectorAll('#usrClsList1 label').length < 3)
					$('#usrClsList1').append(appendContent)
				else if(document.querySelectorAll('#usrClsList2 label').length < 3)
					$('#usrClsList2').append(appendContent)
				else if(document.querySelectorAll('#usrClsList3 label').length < 3)
					$('#usrClsList3').append(appendContent)
				else modal("클래스", "등록", "실패");
			})
		} else modal("클래스", "등록", "실패10", "추가할 클래스가 없습니다.<br><span class='small'>클래스를 중복해서 선택했는 지 확인하세요.</small>");
		$('#srchClsModal').modal('hide');
	}
}

/* 클래스 추가 시 제약사항 */
function checkCls(myCls) {
	let choosenClss = [];
	$('#choosenClsId:checked').each(function() {
		selectClsId = $(this).val();
		selectClsName = $(this).parents('tr').find('#clsName').text();
		selectClass = $(this).val() + "|" + $(this).parents('tr').find('#clsName').text();
		/* 중복 검사 */
		if(myCls.search(selectClsName) == -1) choosenClss.push(selectClass);
	})
	let selectClsSize = choosenClss.length;
	/* 갯수 검사 */
	if(selectClsSize + document.querySelectorAll('#usrClsName').length > 9) {
		modal("클래스", "등록", "실패10", "현재 등록 가능한 클래스 수보다<br>선택한 클래스 수가 더 많습니다.");
		return [];
	} else return choosenClss;
}

/* 클래스 선택 시 해당 클래스 삭제 */
function rmvCls() {
	$('#usrClsNameChk').html('&nbsp;');
	$('#srchClsBtn').removeAttr('disabled');
	
	if($('input[name="usrClsName"]:checked').length)
		$('input[name="usrClsName"]:checked').parent('label').remove();
	else $('#usrClsNameChk').append('<span class="text-danger">클래스를 1개 이상 선택해주세요.</span>');
}