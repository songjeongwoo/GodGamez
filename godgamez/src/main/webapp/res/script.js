/*
b = business 업무	(회원, 클래스, 퀘스트, 보상)
f = function 기능	(추가, 수정, 삭제, 신고)
result = 결과		(성공, 실패, 확인, 중단, 중단확인)
id = 체크박스 아이디

예)
b = usr / f = add / result = suc
유저 추가 성공

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

/* 진행 과 중단2 에 사용되는 함수 */
function moveTo(b, f) {
	switch(b) {
		case "메일": case "회원":
			if(f != "가입") location.href = "/godgamez/user/mypage";
			else location.href = "/godgamez/"; break;
		default: location.reload();
	}
}

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

function modal(b, f, result, ...msg) {
	$('#bFResultModal #modalTitle').empty();
	$('#bFResultModal #modalContent').empty();
	$('#bFResultModal #modalBtn').empty();
	
	modalTitle = b + '&nbsp;' + f + '&nbsp;' + result;
	modalContent = '<h5 class="mt-2">' + b;
	
	modalBtn = "#bFResultModal #modalBtn"; /* 모달 버튼이 들어갈 자리 */
	modalBtnMove = "<button class='btn btn-outline-secondary' onclick='moveTo(\"" + b + "\", \"" + f + "\")'> 확 인 </button>"; /* 클릭 시 이동하는 버튼 */
	modalBtnClose = "<button class='btn btn-outline-secondary' data-dismiss='modal' id='doneBBtn'> 확 인 </button>"; /* 클릭 시 모달 닫는 버튼 */
	
	switch(result) {
	case "진행":
		modalContent += ' 페이지로 이동합니다.</h5>';
		$(modalBtn).html(modalBtnMove); break;
	case "성공":
		modalContent += '&nbsp;' + f + '에 ' + result + '하였습니다.</h5>';		
		if(f == "발급")
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez/user/mypage'>마이 페이지로 이동 <i class='fas fa-gamepad'></i></button>");
		else if(f == "인증") {
			modalContent = '<p>인증이 완료되었습니다!</p><p>지금 바로 퀘스트에 도전하세요!</p>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez/'>메인으로</a><a class='btn btn-secondary' href='/godgamez/quest/board'>퀘스트 하러가기</a>")
		} else $(modalBtn).html(modalBtnClose); break;
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
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez/user/login'>확 인 <i class='fas fa-exclamation-circle'></i></a>");
		} else if(result == "실패7") {
			modalTitle = '메일을 인증해주세요!';
			modalContent = '<h5 class="mt-2">해당 서비스를 이용하기 위해<br>메일을 인증해주세요.</h5>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez/user/verifiy'>인증하기 <i class='fas fa-external-link-alt'></i></a>");
		} else if(result == "실패8") {
			modalTitle = '용사님! 일어나세요!';
			modalContent = '<h5 class="mt-2">해당 서비스를 이용하기 위해<br>갓생살기 게임즈에 가입하세요!</h5>';
			$(modalBtn).html("<a class='btn btn-outline-secondary' href='/godgamez/user/join/step1'>가입하기 <i class='fas fa-hat-wizard'></i></a>");
		} else if(result == "실패9")
			modalContent += '발급할 쿠폰과 발급받을 대상을 <b><u>하나씩</u></b> 선택하세요.</h6>';
		else modalContent += msg + '</h6>'; break;
	case "확인":
		$(modalBtn).html(
				"<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
				"<button class='btn btn-outline-secondary' data-dismiss='modal' onclick='finBusiness(\"" + b + "\", \"" + f + "\")'> 확 인 </button>");
		if(b == '클래스' || b == '퀘스트' || b.search("이미지") != -1) {
			modalContent += '를 정말 ' + f + '하시겠습니까?</h5>';
			$(modalBtn).html("<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
					"<button class='btn btn-outline-secondary' onclick='delB()' id='sureBtn'> 예 </button>");
		} else if(b.search("회원") != -1 || b.search("쿠폰") != -1) {
			modalContent += '을 ' + f + '하시겠습니까?</h5>';
			$(modalBtn).html(
				"<button class='btn btn-outline-secondary' data-dismiss='modal'> 아니오 </button>" +
				"<button class='btn btn-outline-secondary' id='sureBtn'> 확 인 </button>");
		} else modalContent += '을 정말 ' + f + '하시겠습니까?</h5>'; break;
	case "완료":
		if(b != '클래스' || b != '퀘스트' || b != '로고' || b != '이미지' || b != '로그')
			modalContent += '을 ' + f + '하였습니다.</h5>';
		else modalContent += '를 ' + f + '하였습니다.</h5>';
		if(b == '게시글' || b == '댓글') $(modalBtn).html(modalBtnClose);
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
		if(b == '클래스' && f == '추가') {
			$(modalBtn).html(modalBtnClose);
			$("#addProcModal").modal('hide');			
		}
		else if(f == '추가' || f == '수정') {
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

/* 전체선택 알고리즘 */
$(document).ready(function() {
	$('.checkCol input[id^="checkall"]').click(function() {
		if($(this).prop('checked'))
			$('input[name=check' + $(this).attr('id').substring(8) + ']').prop('checked', true);
		else
			$('input[name=check' + $(this).attr('id').substring(8) + ']').prop('checked', false);
	})
})