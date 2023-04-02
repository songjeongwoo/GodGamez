<title>갓겜:회원정보변경</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>

<style>
#clsIcon {
	width: 7.5rem;
	height: 7.5rem;
}

#switchClsIconBtn {
	left: 5.85rem;
}
 
#usrClsSetting label {
	width: 5rem;
}
</style>

<script>
let sessionUser = getConnectedUser();

$(document).ready(function() {
	$(chkToday);
	$(clsLimit);
	$(fixUserData);
})

function fixUserData() {
	userCode = sessionUser.usrCode;
	
	if(sessionUser && userCode) {
		$('#usrIn #usrId').val(sessionUser.usrId);
		$('#usrIn #usrName').val(sessionUser.usrName);
		$('#usrIn #usrNick').val(sessionUser.nickname);
		$('#usrIn #usrPhone').val(sessionUser.phoneNum);
		$('#usrClsSetting #clsIcon').attr('name', sessionUser.usrIcon);
		$('#usrClsSetting #clsIcon').attr('src', '/godgamez.selfdevelopment/res/user/icon/' + sessionUser.usrIcon + '.jpg');
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/class/list",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(userCode),
			success: function(usrclss) {
				if(usrclss.length) {
					$('#usrClsSetting #usrClsList1').empty();
    				$('#usrClsSetting #usrClsList2').empty();
    				$('#usrClsSetting #usrClsList3').empty();
    				
    				$.each(usrclss, (idx, usrcls) => {
	    				appendContent =
	    					"<label for='" + usrcls.cls.clsName + "'>" +
	    						"<input type='checkbox' name='usrClsName' value='" + usrcls.cls.clsName + "'>" +
	    						usrcls.cls.clsName +
	    						"<input type='text' value=" + usrcls.cls.clsId + " name='usrClsId' hidden=true readonly>" +
   							"</label>";
	    				
    					if(document.querySelectorAll('#usrClsList1 label').length < 3)
	    					$('#usrClsList1').append(appendContent)
						else if(document.querySelectorAll('#usrClsList2 label').length < 3)
	    					$('#usrClsList2').append(appendContent)
						else if(document.querySelectorAll('#usrClsList3 label').length < 3)
	    					$('#usrClsList3').append(appendContent)
						else modal("회원 클래스", "조회", "실패");
    				})
				} else modal("회원 클래스", "조회", "실패");
			}, fail: function() {
				modal("회원 클래스", "조회", "실패10", "회원을 조회할 수 없습니다.");
			}
		})
	} else modal("", "", "실패6");
}

/* 회원 수정 */
function fixUser() {
	if(sessionUser.usrCode) {
		if(sessionUser.usrPw != $('#usrIn #usrPw').val())
			pw = $('#usrIn #usrPw').val();
		else {
			$('#usrIn #usrPw').val(""); $('#usrIn #usrPwAgain').val("");
			$('#usrPwChk').empty(); $('#usrPwAgainChk').empty();
			pw = sessionUser.usrPw;
		}
		
		if(sessionUser.nickname != $('#usrIn #usrNick').val())
			nick = $('#usrIn #usrNick').val();
		else {
			$('#usrIn #usrNick').val(""); $('#usrNickChk').empty();
			nick = sessionUser.nickname;
		}
		
		if(sessionUser.phoneNum != $('#usrIn #usrPhone').val())
			tel = $('#usrIn #usrPhone').val();
		else {
			$('#usrIn #usrPhone').val(""); $('#usrPhoneChk').empty();
			tel = sessionUser.phoneNum;
		}
		
		if(sessionUser.usrIcon != $('#usrClsSetting #clsIcon').attr('name'))
			icon = $('#usrClsSetting #clsIcon').attr('name');
		else icon = sessionUser.usrIcon;
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/fix",
			type: "PUT",
	        contentType: "application/json",
			data: JSON.stringify({
				usrCode: sessionUser.usrCode,
				position: sessionUser.position,
				usrId: sessionUser.usrId,
				usrPw: pw,
				usrName: sessionUser.usrName,
				nickname: nick,
				birthday: sessionUser.birthday,
				phoneNum: tel,
				usrLv: sessionUser.usrLv,
				gold: sessionUser.gold,
				regDate: sessionUser.regDate,
				usrIcon: icon
			}),
			success: function(result) {
				if(result) addClsFor(sessionUser.usrCode);
			    else modal("회원 정보", "변경", "실패");
			}, fail: function() {
				modal("회원 정보", "변경", "실패");
			}
		})
	}
}

/* 클래스 선택 시 해당 클래스 추가 */
function addClsFor(userCode) {
	/* 클래스 초기화 */
	$.ajax({
		url: "/godgamez.selfdevelopment/userclass/reset/" + userCode,
		type: "DELETE",
		success: function(result) {
        	if(usrclss.length) {
    			$.each(usrclss, (idx, usrcls) => {
    				classId = usrcls.cls.clsId;
    				
    				$.ajax({
    					url: "/godgamez.selfdevelopment/user/class/del",
    					type: "POST",
    					data: JSON.stringify({
    						userCode: userCode,
    						classId: classId
    					}),
    			        contentType: "application/json"
    				})
    			})
        	}
        }, fail: function() {
        	modal("회원 클래스", "초기화", "실패");
        }
	})
	
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
	
	if(addClsFailCnt == 0) {
		modal("회원 정보", "변경", "성공");
		$(fixUserData);
	} else modal("회원 정보", "변경", "실패");
}
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
					<h3 class='text-muted'>본인확인 ></h3>
					<pre> </pre><h3 class='font-weight-bold'>정보변경</h3>
				</div>
				<div class='row ml-3 mt-4'>
					<small class='h6'> 이름 변경은 직접 메일로 직접 문의주시길 바랍니다. (신분증 첨부 필수)<br> 정보를 변경하고자 하는 정보만 새로 입력하시기 바랍니다.</small>
				</div>
				<div class='row mt-3 mx-5 justify-content-center text-nowrap' id='usrIn' onmousemove='chkInput(2)'>
					<div class='col-5'>
						<div class='row mt-3 mb-2'>
							<label for='usrId' class='col-2 pl-1 mt-1 mr-3 font-weight-bold'>ID</label>
							<input type='text' class='col form-control' name='usrIn' id='usrId' readonly>
						</div>
						<div class='row'>
							<label for='usrName' class='col-2 pl-1 mt-1 mr-3 font-weight-bold'>이름</label>
							<input type='text' class='col form-control' name='usrIn' id='usrName' readonly>
						</div>
						<div class='row justify-content-end mt-1'>
							<a href='mailto:godgamez@gmail.com' onclick='window.open(this.href, "_blank", "width=500px, height=800px, toolbars=no, scrollbars=yes"); return false;'>
								<small class='text-right text-muted ml-2'>
									이름 변경 문의 하기 <i class='far fa-question-circle'></i> 
								</small>
							</a>
						</div>
						<div class='row mt-3' id='usrIn'>
							<label for='usrNick' class='col-2 pl-1 mt-1 mr-3 font-weight-bold'>별명</label>
							<input type='text' class='col form-control' name='usrIn' id='usrNick' onchange='nickChk(2)'>
							<h6 class='font-wieght-bold' id='usrNickChk'></h6>
						</div>
						<div class='row justify-content-end mt-1'>
							<small class='text-right text-muted ml-2'>
								영문 대소문자/숫자/한글 2자 이상
							</small>
						</div>
					</div>
					<div class='col-1'></div>
					<div class='col-5'>
						<div class='row mt-3 mb-2' id='usrIn'>
							<label for='usrPw' class='col-3 pl-1 mt-1 mr-3 font-weight-bold'>PW</label>
							<input type='password' class='col form-control' name='usrIn' id='usrPw' onchange='pwChk(3); pwAgainChk(3);' required>
							<h6 class='font-wieght-bold' id='usrPwChk'></h6>
						</div>
						<div class='row' id='usrIn'>
							<label for='usrPwAgain' class='col-3 pl-1 mt-1 mr-3 font-weight-bold'>PW 확인</label>
							<input type='password' class='col form-control' name='usrIn' id='usrPwAgain' onchange='pwAgainChk(3);' required>
							<h6 class='font-wieght-bold' id='usrPwAgainChk'></h6>
						</div>
						<div class='row justify-content-end mt-1'>
							<small class='text-right text-dark ml-2'>
									영문 대소문자+숫자+특수문자 6~10자
							</small>
						</div>
						<div class='row mt-3' id='usrIn'>
							<label for='usrPwAgain' class='col-3 pl-1 mt-1 mr-3 font-weight-bold'>전화번호</label>
							<input type='tel' class='col form-control' name='usrIn' id='usrPhone' placeholder=' 전화번호를 입력해주세요.' onchange='phoneChk(3)'>
							<h6 class='font-wieght-bold' id='usrPhoneChk'></h6>
						</div>
					</div>
				</div>
				<div class='row mt-3 mx-5 justify-content-around' onmousemove='clsLimit()'>
					<div class='col-11'>
						<div class='row'>
							<label for='usrCls' class='col-2 pl-1 mt-1 mr-3 font-weight-bold'>CLASS</label>
						</div>
						<div class='row ml-5' id='usrClsSetting'>
							<div class='col m-0'>
								<img class='border' id='clsIcon'>
								<button type='button' class='btn btn-secondary' id='switchClsIconBtn' onclick='switchClsIcon()'>
									<i class='fas fa-arrows-alt-h'></i>
								</button>
							</div>
							<div class='col' id='usrClsList1'>
							</div>
							<div class='col' id='usrClsList2'>
							</div>
							<div class='col' id='usrClsList3'>
							</div>
							<div class='col align-self-end'>
								<button type='button' class='btn btn-secondary text-center float-right' onclick='listCls()' 
								data-toggle='modal' data-target='#srchClsModal' id='srchClsBtn' disabled>
									<i class='fas fa-plus'></i>
								</button>
								<button type='button' class='btn btn-outline-secondary text-center float-right' onclick='rmvCls()' id='clsRmvBtn' disabled>
									<i class='fas fa-minus'></i>
								</button>
							</div>
						</div>
						<div class='row justify-content-end'>
							<h6 class='font-wieght-bold mr-3 mt-1' id='usrClsNameChk'>&nbsp;</h6>
						</div>
					</div>
				</div>
				<div class='row mt-4 justify-content-center'>
					<button type='button' class='btn btn-outline-secondary col-5 mr-1' onclick='modal("회원", "정보 변경", "중단")'>
						이전
					</button>
					<button type='button' class='btn btn-secondary col-5' onclick='fixUser()' id='nextStepBtn' disabled>
						변경하기
					</button>
				</div>
				<hr>
				<div class='row mb-5'>
					<div class='col'>
						<h6 class='small text-muted'>이전 단계로 돌아갈 시, 변경사항이 저장되지 않습니다.</h6>
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