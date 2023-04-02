<title>갓겜:회원 관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>
<style>
#usrSrchOpt {
	height: 2.3rem;
	width: 6rem;
}

#usrSrchBtn {
	height: 2.3rem;
	border-bottom-left-radius: 0;
	border-top-left-radius: 0;
}

#usrSrchIn {
	height: 2.3rem;
	border-radius: 0;
	width: 10rem;
}

#pUsrBtn, #outUsrBtn, #noobUsrBtn, #gmUsrBtn {
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	width: 2.8rem;
	text-align: center;
}

.btn-group .btn {
	border-top: 0;
	border-top-right-radius: 0;
	border-top-left-radius: 0;
}

.modal-dialog .modal-fullsize {
	max-width: 120%;
	height: 50%;
	margin: 0;
	padding: 0;
}

.modal .modal-center {
	text-align: center;
}

@media screen and (min-width: 768px) { 
	.modal .modal-center:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}

.modal-dialog .modal-center {
	display: inline-block;
	text-align: left;
	vertical-align: middle; 
}

#usrClsList {
	position: relative;
	height: 5rem;
}

#usrClsList label {
	margin-right: 1.5rem;
}

#usrClsList #addClsBtn {
	position: absolute;
	top: 0;
	right: 0;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	width: 2.5rem;
	height: 2.5rem;
}

#usrClsList #rmvClsBtn {
	position: absolute;
	top: 2.5rem;
	right: 0;
	border-top-right-radius: 0;
	border-top-left-radius: 0;
	width: 2.5rem;
	height: 2.5rem;
}

textarea {
	resize: none;
}

#usrDetail {
	cursor: pointer;
}

#srchClsModal {
	z-index: 1051;
}

#bFResultModal {
	z-index: 1052;
}
</style>
<script>
/* 전체 플레이어 조회 */
function getAllPlayers() {
	$('#pTbody').empty();
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'PLAYERS'}),
		success: function(players) {
			if(players.length) {
				$('#usrSrchCnt').text("총 " + players.length + " 건");
				let playerList = [];
				$.each(players, (idx, player) => {
					pLv = parseInt(player.usrLv);
					playerList.push(
						`<tr id='usrDetail'>
							<td id='checkCol'>
								<input type='checkbox' name='check1' id='usrCode' value='\${player.usrCode}'>
							</td>
							<td id='code' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.usrCode}</td>
							<td id='usrPosition' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.position}</td>
							<td id='usrId' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.usrId}</td>
							<td id='usrName' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.usrName}</td>
							<td id='nickname' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.nickname}</td>
							<td id='usrBirthday' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.birthday}</td>
							<td id='usrLv' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${pLv}</td>
							<td id='gold' onclick='getUser(\${player.usrCode}); getUserClasses(\${player.usrCode});'>\${player.gold}</td>
						</tr>`);
					});
				$('#pTbody').append(playerList.join(''));
			} else $('#pTbody').append('');
		}, fail: function() {
			$('#pTbody').append('<tr><td colspan="9" class="text-center">회원이 없습니다.</td></tr>');
		}
	})
}

/* 탈퇴 신청 조회 */
function getOuts() {
	$('#oTbody').empty();
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'OUT'}),
		success: function(outs) {
			if(outs.length) {
				$('#usrSrchCnt').text("총 " + outs.length + " 건");
				let outList = [];
				$.each(outs, (idx, out) => {
					oLv = parseInt(out.usrLv);
					outList.push(
						`<tr id='usrDetail'>
							<td id='checkCol'>
								<input type='checkbox' name='check2' id='usrCode' value='\${out.usrCode}'>
							</td>
							<td id='code' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.usrCode}</td>
							<td id='usrPosition' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.position}</td>
							<td id='usrId' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.usrId}</td>
							<td id='usrName' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.usrName}</td>
							<td id='nickname' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.nickname}</td>
							<td id='usrBirthday' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.birthday}</td>
							<td id='usrLv' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${oLv}</td>
							<td id='gold' onclick='getUser(\${out.usrCode}); getUserClasses(\${out.usrCode});'>\${out.gold}</td>
						</tr>`);
					});
				$('#oTbody').append(outList.join(''));
			} else $('#oTbody').append('');
		}, fail: function() {
			$('#oTbody').append('<tr><td colspan="9" class="text-center">탈퇴 신청 회원이 없습니다.</td></tr>');
		}
	})
}

/* 신규 가입 회원 조회 */
function getNoobs() {
	$('#nTbody').empty();
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'NOOB'}),
		success: function(noobs) {
			if(noobs.length) {
				$('#usrSrchCnt').text("총 " + noobs.length + " 건");
				let noobList = [];
				$.each(noobs, (idx, noob) => {
					nLv = parseInt(noob.usrLv);
					noobList.push(
							`<tr id='usrDetail'>
								<td id='checkCol'>
									<input type='checkbox' name='check3' id='usrCode' value='\${noob.usrCode}'>
								</td>
								<td id='code' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.usrCode}</td>
								<td id='usrPosition' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.position}</td>
								<td id='usrId' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.usrId}</td>
								<td id='usrName' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.usrName}</td>
								<td id='nickname' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.nickname}</td>
								<td id='usrBirthday' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.birthday}</td>
								<td id='usrLv' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${nLv}</td>
								<td id='gold' onclick='getUser(\${noob.usrCode}); getUserClasses(\${noob.usrCode});'>\${noob.gold}</td>
							</tr>`);
						});
				$('#nTbody').append(noobList.join(''));
			} else $('#nTbody').append('');
		}, fail: function() {
			$('#nTbody').append('<tr><td colspan="9" class="text-center">신규 회원이 없습니다.</td></tr>');
		}
	})
}

/* 관리자 회원 조회 */
function getGms() {
	$('#gmTbody').empty();
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'GM'}),
		success: function(gms) {
			if(gms.length) {
				$('#usrSrchCnt').text("총 " + gms.length + " 건");
				let gmList = [];
				$.each(gms, (idx, gm) => {
					gLv = parseInt(gm.usrLv);
					gmList.push(
							`<tr id='usrDetail'>
								<td id='checkCol'>
									<input type='checkbox' name='check4' id='usrCode' value='\${gm.usrCode}'>
								</td>
								<td id='code' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.usrCode}</td>
								<td id='usrPosition' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.position}</td>
								<td id='usrId' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.usrId}</td>
								<td id='usrName' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.usrName}</td>
								<td id='nickname' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.nickname}</td>
								<td id='usrBirthday' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.birthday}</td>
								<td id='usrLv' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gLv}</td>
								<td id='gold' onclick='getUser(\${gm.usrCode}); getUserClasses(\${gm.usrCode});'>\${gm.gold}</td>
							</tr>`);
						});
				$('#gmTbody').append(gmList.join(''));
			} else $('#gmTbody').append('');
		}, fail: function() {
			$('#gmTbody').append('<tr><td colspan="9" class="text-center">관리자가 없습니다.</td></tr>');
		}
	})
}

/* 검색 */
/* 가끔 안될 때 있음 이상함, 그리고 선택기본값 검색조건 해제해야함 */
function searchUsrs(usrSrchData, checkboxName) {
	$('#usrSrchIn').val('');
	$('#usrSrchOpt option[value="default"]').attr('selected', true);	
	
	switch(checkboxName) {
	case "check1": targets = 'player'; break;
	case "check2": targets = 'out'; break;
	case "check3": targets = 'noob'; break;
	case "check4": targets = 'gm';
	}
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/findUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(usrSrchData),
		success: function(users) {
			if(users.length) {
				let userSrchCnt = 0;
				let userList = [];
				
				if(targets == 'player') {
					$.each(users, (idx, user) => {
						uLv = parseInt(user.usrLv);
						
						if(user.position != 'GM') {
							userSrchCnt++;
							
							userList.push(
								`<tr id='usrDetail'>
									<td id='checkCol'>
										<input type='checkbox' name='check1' id='usrCode' value='\${user.usrCode}'>
									</td>
									<td id='code' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrCode}</td>
									<td id='usrPosition' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.position}</td>
									<td id='usrId' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrId}</td>
									<td id='usrName' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrName}</td>
									<td id='nickname' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.nickname}</td>
									<td id='usrBirthday' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.birthday}</td>
									<td id='usrLv' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${uLv}</td>
									<td id='gold' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.gold}</td>
								</tr>`);
						}
					});
					if(userList.length > 0) {
						$('#pTbody').empty();
						$('#pTbody').append(userList.join(''));
						$('#usrSrchCnt').text("총 " + userSrchCnt + " 건");
					}
					else modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
				} else if(targets == 'out') {
					$.each(users, (idx, user) => {
						uLv = parseInt(user.usrLv);
						
						if(user.position == 'OUT') {
							userSrchCnt++;
							
							userList.push(
								`<tr id='usrDetail'>
									<td id='checkCol'>
										<input type='checkbox' name='check2' id='usrCode' value='\${user.usrCode}'>
									</td>
									<td id='code' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrCode}</td>
									<td id='usrPosition' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.position}</td>
									<td id='usrId' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrId}</td>
									<td id='usrName' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrName}</td>
									<td id='nickname' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.nickname}</td>
									<td id='usrBirthday' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.birthday}</td>
									<td id='usrLv' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${uLv}</td>
									<td id='gold' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.gold}</td>
								</tr>`);
						}
					});
					if(userList.length > 0) {
						$('#oTbody').empty();
						$('#oTbody').append(userList.join(''));
						$('#usrSrchCnt').text("총 " + userSrchCnt + " 건");
					}
					else modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
				} else if(targets == 'noob') {
					$.each(users, (idx, user) => {
						uLv = parseInt(user.usrLv);
						
						if(user.position == 'NOOB') {
							userSrchCnt++;
							
							userList.push(
								`<tr id='usrDetail'>
									<td id='checkCol'>
										<input type='checkbox' name='check3' id='usrCode' value='\${user.usrCode}'>
									</td>
									<td id='code' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrCode}</td>
									<td id='usrPosition' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.position}</td>
									<td id='usrId' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrId}</td>
									<td id='usrName' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrName}</td>
									<td id='nickname' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.nickname}</td>
									<td id='usrBirthday' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.birthday}</td>
									<td id='usrLv' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${uLv}</td>
									<td id='gold' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.gold}</td>
								</tr>`);
						}
					});
					if(userList.length > 0) {
						$('#nTbody').empty();
						$('#nTbody').append(userList.join(''));
						$('#usrSrchCnt').text("총 " + userSrchCnt + " 건");
					}
					else modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
				} else if(targets == 'gm') {
					$.each(users, (idx, user) => {
						uLv = parseInt(user.usrLv);
						
						if(user.position == 'GM') {
							userSrchCnt++;
							
							userList.push(
								`<tr id='usrDetail'>
									<td id='checkCol'>
										<input type='checkbox' name='check4' id='usrCode' value='\${user.usrCode}'>
									</td>
									<td id='code' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrCode}</td>
									<td id='usrPosition' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.position}</td>
									<td id='usrId' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrId}</td>
									<td id='usrName' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.usrName}</td>
									<td id='nickname' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.nickname}</td>
									<td id='usrBirthday' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.birthday}</td>
									<td id='usrLv' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${uLv}</td>
									<td id='gold' onclick='getUser(\${user.usrCode}); getUserClasses(\${user.usrCode});'>\${user.gold}</td>
								</tr>`);
						}
					});
					if(userList.length > 0) {
						$('#gmTbody').empty();
						$('#gmTbody').append(userList.join(''));
						$('#usrSrchCnt').text("총 " + userSrchCnt + " 건");
					}
					else modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
				}
			} else modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
		}, fail: function() {
			modal("회원", "검색", "실패10", "'" + usrSrchDataVal + "'에 대한 검색 결과가 없습니다.");
		}
	})
}

function getUser(userCode) {
	targetData = {usrCode: userCode}
	
	$.ajax({
		url: "/godgamez.selfdevelopment/user/get",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(targetData),
        success: function(user) {
        	if(user != null) {
        		$('#getUsrModal #usrCode').text(user.usrCode);
        		$('#getUsrModal #position').text(user.position);
        		$('#getUsrModal #regDate').text(user.regDate + " 가입");
        		$('#getUsrModal input[id="usrId"]').val(user.usrId);
        		$('#getUsrModal input[id="usrPw"]').val(user.usrPw);
        		$('#getUsrModal input[id="usrName"]').val(user.usrName);
        		$('#getUsrModal input[id="nickname"]').val(user.nickname);
        		$('#getUsrModal input[id="birthday"]').val(user.birthday);
        		$('#getUsrModal #newBirthday').attr('max', user.regDate);
        		$('#getUsrModal input[id="phoneNum"]').val(user.phoneNum);
        		$('#getUsrModal #usrLv').val(parseInt(user.usrLv));
        		$('#getUsrModal #usrExp').val(Math.floor(((user.usrLv - parseInt(user.usrLv)) * 100) * 100) / 100 + "%");
        		$('#getUsrModal #usrClsName').val('hidden');
        		
        		$('#getUsrModal #addClsBtn').attr('onclick', 'listCls(' + user.usrCode + ')');
        		$('#getUsrModal #rmvClsBtn').attr('onclick', 'rmvClsFor(' + user.usrCode + ')');
        		$('#getUsrModal #addClsBtn').removeAttr("disabled");
        		$('#getUsrModal #rmvClsBtn').removeAttr("disabled");

        		$('#srchClsForUsrBtn').attr('onclick', "srchClsList(" + user.usrCode + ")");
        		$('#addChoosenClsBtn').attr('onclick', 'addClsFor(' + user.usrCode + ')');
        		
        		$('#fixUsrInBtn').attr('onclick', "fixProc(" + user.usrCode + ")");
        		$('#getUsrModal').modal('show');
        	} else modal("회원", "조회", "실패10", "존재하지 않는 회원입니다.");
        }, fail: function() {
        	modal("회원", "조회", "실패10", "회원을 조회할 수 없습니다.");
        }
	})
}

function getUserClasses(userCode) {
	$('#getUsrModal #usrClsListDiv').empty();
	$('#getUsrModal #addClsBtn').removeAttr("disabled");
	$('#getUsrModal #rmvClsBtn').removeAttr("disabled");
	
	$.ajax({
		url: "/godgamez.selfdevelopment/user/class/list",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(userCode),
		success: function(usrclss) {
        	if(usrclss.length) {
        		if(usrclss.length >= 9) {
        			$('#getUsrModal #addClsBtn').attr("disabled", true);
        		} else if(usrclss.length <= 1) {
        			$('#getUsrModal #rmvClsBtn').attr("disabled", true);
        		}
        		let usrclsList = [];
        		
    			$.each(usrclss, (idx, usrcls) => {
    				if(usrclss.length - idx != 5) {
        				usrclsList.unshift(
        					`<label for='\${usrcls.cls.clsName}'>
    							<input type='checkbox' name='\${usrcls.usr.usrCode}' value='\${usrcls.cls.clsId}' id='usrclsClsId'>
    							\${usrcls.cls.clsName}
    						</label>`
        				)
    				} else {
        				usrclsList.unshift(
        					`<label for='\${usrcls.cls.clsName}'>
    							<input type='checkbox' name='\${usrcls.usr.usrCode}' value='\${usrcls.cls.clsId}' id='usrclsClsId'>
   								\${usrcls.cls.clsName}
    						</label><br>`
        				)
    				}
    			})
    			$('#getUsrModal #usrClssCnt').text("현재 " + usrclss.length + "개");
    			$('#getUsrModal #usrClsListDiv').append(usrclsList.join(''));
        	} else {
    			$('#getUsrModal #addClsBtn').removeAttr("disabled");
       			$('#getUsrModal #rmvClsBtn').attr("disabled", true);
        		$('#getUsrModal #usrClsListDiv').html("등록된 유저 클래스가 없습니다.<br>클래스를 추가해주세요.");
        	}
        }, fail: function() {
        	modal("회원 클래스", "조회", "실패10", "회원을 조회할 수 없습니다.");
        }
	})
}

/* 클래스 리스트 */
function listCls(userCode) {
	$('#srchClsModal').modal("show");
	$('#srchClsForUsrBtn').text("검색");
	$('#srchClsForUsrBtn').attr("onclick", "srchClsList(" + userCode + ")");
	
	$('#choosenClsId:checked').prop('checked', false);
	$('#srchClsTBody').empty();
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/class/list/' + userCode,
		method: 'post'
	}).done(clss => {
		if(clss.length) {
			let clsList = [];
			$('#srchClsCnt').text("총 " + clss.length + "건")
			$('#srchClsTBody').empty();
			
			$.each(clss, (idx, cls) => {
				clsList.push(
					`<tr id='clsDetail'>
						<td id='checkCol'><input type='checkbox' id='choosenClsId' name='check10' value='\${cls.clsId}'></td>
		  				<td id='mainCtg'>\${cls.mainCtg}</td>
		  				<td id='subCtg'>\${cls.subCtg}</td>
		  				<td id='clsName'>\${cls.clsName}</td>
		  			</tr>`);
				});
			$('#srchClsTBody').append(clsList.join(''))
		} else
			$('#srchClsTBody').html('<tr><td colspan="4" class="text-center">클래스가 존재하지 않습니다.</td></tr>')
	}).fail(() => {
		$('#srchClsTBody').html('<tr><td colspan="4" class="text-center">클래스를 조회하지 못했습니다.</td></tr>')
	})
}

/* 클래스 검색 */
function srchClsList(userCode) {
	$('#choosenClsId:checked').prop('checked', false);
	let srchOpt = $('#clsSrchOpt option:selected').val();
	let keyword = $('#srchClsModal #srchClsIn').val();
	let srchClsCnt = 0;
	
	$('#clsSrchOpt option[value="srchCondition"]').prop('selected', true);
	$('#srchClsModal #srchClsIn').val('');
	
	if(keyword == null || keyword == '') {
		listCls(userCode);
	} else if(srchOpt != 'srchCondition') {
		$('#srchClsForUsrBtn').text("초기화");
		$('#srchClsForUsrBtn').attr("onclick", "listCls(" + userCode + ")");
		
		let srchClsList = [];
		let isSrch = false;
		
		$('#srchClsTBody #clsDetail').each(function() {
			clsId = $(this).find('#checkCol #choosenClsId').val();
			mainCtg = $(this).find('#mainCtg').text();
			subCtg = $(this).find('#subCtg').text();
			clsName = $(this).find('#clsName').text();
			
			if(srchOpt == "mainCtg" && keyword == mainCtg) {
				srchClsCnt++;
				isSrch = true;
			} else if(srchOpt == "subCtg" && keyword == subCtg) {
				srchClsCnt++;
				isSrch = true;
			} else if(srchOpt == "clsName" && keyword == clsName) {
				srchClsCnt++;
				isSrch = true;
			} else isSrch = false;
			
			if(isSrch) {
				srchClsList.push(
					"<tr id='clsDetail'>" +
						"<td id='checkCol'><input type='checkbox' id='choosenClsId' name='check10' value=" + clsId + "></td>" +
		  				"<td id='mainCtg'>" + mainCtg + "</td>" +
		  				"<td id='subCtg'>" + subCtg + "</td>" +
		  				"<td id='clsName'>" + clsName + "</td>" +
		  			"</tr>");
			}
		});

		$('#srchClsTBody').empty();
		$('#srchClsCnt').text("총 " + srchClsCnt + "건");
		
		if(srchClsList.length > 0) {
			$('#srchClsTBody').append(srchClsList.join(''));
		} else {
			$('#srchClsTBody').html(
				'<tr><td colspan="4"><span class="text-danger font-weight-bold">' +
					'「' + keyword + '」</span>에 대한 검색결과가 없습니다. 초기화를 눌러주세요.' +
				'</td></tr>'
			)
		}
	} else {
		$('#srchClsTBody').html(
			'<tr><td colspan="4">' +
				'조건을 선택한 후 검색을 눌러주세요. 초기화를 눌러주세요.' +
			'</td></tr>'
		)
	}
}

/* 클래스 선택 시 해당 클래스 추가 */
function addClsFor(userCode) {
	if(!$('#choosenClsId:checked').length) modal("회원 클래스", "추가", "실패3");
	else {
		addClsSucCnt = 0;
		addClsFailCnt = 0;
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/class/list",
			type: "POST",
	        contentType: "application/json",
			data: JSON.stringify(userCode),
			async: false,
			success: function(usrclss) {
				possibleCls = usrclss.length;
	        	if($('#choosenClsId:checked').length + possibleCls > 9) {
	        		modal("회원 클래스", "추가", "실패10", "회원 클래스는 9개 이상 등록할 수 없습니다.");
	        	} else {
	        		$('#choosenClsId:checked').each(function() {
	        			clsId = $(this).val();
	        			
	        			$.ajax({
	            			url: "/godgamez.selfdevelopment/user/class/add",
	            			type: "POST",
	            			data: JSON.stringify({
	            				userCode: userCode,
	            				classId: clsId
	            			}),
	            	        contentType: "application/json"
	            		}).done(result => {
	          				if(result) addClsSucCnt++;
	          				else addClsFailCnt++;
	          			}).fail(() => {
	          				addClsFailCnt++;
	          			})
	        		})
	        		
	        		if(addClsFailCnt != 0) modal("회원 클래스", "추가", "실패10", 
	        				"요청하신 " + (addClsSucCnt + addClsFailCnt) + " 건의 클래스 추가 작업 중 " + addClsFailCnt + " 건을 실패했습니다.");
	        		else modal("회원 클래스", "추가", "성공");

	    			getUserClasses(userCode);
	    			$('#usrClsName:checked').prop('checked', false);
	    			$('#srchClsModal').modal('hide');
	        	}
	        }, fail: function() {
	        	modal("회원 클래스", "조회", "실패10", "회원을 조회할 수 없습니다.");
	        }
		})
	}
}

/* 클래스 선택 시 해당 클래스 삭제 */
function rmvClsFor(userCode) {
	if($('#usrclsClsId:checked').length != 0) {
		addClsSucCnt = 0;
		addClsFailCnt = 0;
		
		$('#usrclsClsId:checked').each(function() {
			clsId = $(this).val();
			
			$.ajax({
				url: "/godgamez.selfdevelopment/user/class/del",
				type: "POST",
				data: JSON.stringify({
					userCode: userCode,
					classId: clsId
				}),
		        contentType: "application/json"
			}).done(result => {
					if(result) addClsSucCnt++;
					else addClsFailCnt++;
			}).fail(() => {
				addClsFailCnt++;
			})
		})
		
		if(addClsFailCnt != 0) modal("회원 클래스", "제외", "실패10", 
				"요청하신 " + (addClsSucCnt + addClsFailCnt) + " 건의 클래스 제외 작업 중 " + addClsFailCnt + " 건을 실패했습니다.");
		else modal("회원 클래스", "제외", "성공");

		getUserClasses(userCode);
	} else  modal("회원 클래스", "제외", "실패3");
}

/* 각종 input 및 btn 활성화 */
function fixProc(userCode) {
	$('#getUsrModal input[id="usrId"]').attr('hidden', true);
	$('#getUsrModal input[id="usrPw"]').attr('hidden', true);
	$('#getUsrModal input[id="usrName"]').attr('hidden', true);
	$('#getUsrModal input[id="nickname"]').attr('hidden', true);
	$('#getUsrModal input[id="birthday"]').attr('hidden', true);
	$('#getUsrModal input[id="phoneNum"]').attr('hidden', true);

	$('#getUsrModal #newUsrId').attr('placeholder', $('#getUsrModal input[id="usrId"]').val());
	$('#getUsrModal #newUsrPw').attr('placeholder', $('#getUsrModal input[id="usrPw"]').val());
	$('#getUsrModal #newUsrName').attr('placeholder', $('#getUsrModal input[id="usrName"]').val());
	$('#getUsrModal #newNickname').attr('placeholder', $('#getUsrModal input[id="nickname"]').val());
	$('#getUsrModal #newBirthday').attr('placeholder', $('#getUsrModal input[id="birthday"]').val());
	$('#getUsrModal #newPhoneNum').attr('placeholder', $('#getUsrModal input[id="phoneNum"]').val());

	$('#getUsrModal #newUsrId').removeAttr('hidden');
	$('#getUsrModal #newUsrPw').removeAttr('hidden');
	$('#getUsrModal #newUsrName').removeAttr('hidden');
	$('#getUsrModal #newNickname').removeAttr('hidden');
	$('#getUsrModal #newBirthday').removeAttr('hidden');
	$('#getUsrModal #newPhoneNum').removeAttr('hidden');
	
	$('#getUsrModal #getUsrModalBtn').html(
		"<button type='button' class='btn btn-outline-secondary' id='fixUsrCnclBtn' onclick='fixUserCancel(" + userCode + ")'>취소</button>" +
		"<button type='button' class='btn btn-secondary' id='fixUsrBtn' onclick='fixUser(" + userCode + ")'>저장</button>"
	);
}

function checkIsOverlapped(usrSrchData) {
	let isOverlapped = false;
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/findUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(usrSrchData),
		async: false,
		success: function(users) {
			isOverlapped = users.length > 0;
		}
	})
	
	return isOverlapped;
}

function checkInput(j) {
	let isOkay = 0;
	
	if(j == "fix") {
		$('#getUsrModal #fixUsrIdChk').removeAttr("class"); $('#getUsrModal #fixUsrIdChk').text("이메일 - 유일값");
		$('#getUsrModal #fixUsrPwChk').removeAttr("class"); $('#getUsrModal #fixUsrPwChk').text("6~10자, 영문 + 특수문자 + 숫자 혼합");
		$('#getUsrModal #fixUsrNameChk').removeAttr("class"); $('#getUsrModal #fixUsrNameChk').text("2자 이상의 한글");
		$('#getUsrModal #fixNicknameChk').removeAttr("class"); $('#getUsrModal #fixNicknameChk').text("2~6자, 한글 + 영문 + 숫자 가능 - 유일값");
		$('#getUsrModal #fixBirthdayChk').removeAttr("class"); $('#getUsrModal #fixBirthdayChk').text("가입일 이전의 날짜");
		$('#getUsrModal #fixPhoneNumChk').removeAttr("class"); $('#getUsrModal #fixPhoneNumChk').text("10~11자 - 숫자");
		
		newUsrId = $('#getUsrModal #newUsrId').val();
		newUsrPw = $('#getUsrModal #newUsrPw').val();
		newUsrName = $('#getUsrModal #newUsrName').val();
		newNickname = $('#getUsrModal #newNickname').val();
		newBirthday = $('#getUsrModal #newBirthday').val();
		newPhoneNum = $('#getUsrModal #newPhoneNum').val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); $('#getUsrModal #newPhoneNum').val(newPhoneNum);
		
		oldUsrId = $('#getUsrModal input[id="usrId"]').val();
		oldUsrPw = $('#getUsrModal input[id="usrPw"]').val();
		oldUsrName = $('#getUsrModal input[id="usrName"]').val();
		oldNickname = $('#getUsrModal input[id="nickname"]').val();
		oldBirthday = $('#getUsrModal input[id="birthday"]').val();
		oldPhoneNum = $('#getUsrModal input[id="phoneNum"]').val();
		
		if(newUsrId == oldUsrId && newUsrPw == oldUsrPw && newUsrName == oldUsrName && newNickname == oldNickname && newPhoneNum == oldPhoneNum)
			return 0;
		
		if(newUsrId.length && newUsrId != oldUsrId) {
			$('#getUsrModal #fixUsrIdChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(newUsrId.search(/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,4}$/) < 0)
				$('#getUsrModal #fixUsrIdChk').text("변경 불가] 이메일 형식으로 입력하세요.");
			else if(checkIsOverlapped({usrId: newUsrId})) {
				$('#getUsrModal #fixUsrIdChk').text("변경 불가] 존재하는 아이디입니다.");
			} else {
				$('#getUsrModal #fixUsrIdChk').attr("class", "text-success");
				$('#getUsrModal #fixUsrIdChk').text("변경 가능");
				isOkay = 2;
			}
		}
		
		if(newUsrPw.length && newUsrPw != oldUsrPw) {
			$('#getUsrModal #fixUsrPwChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(newUsrPw.length < 6 || 10 < newUsrPw.length)
				$('#getUsrModal #fixUsrPwChk').text("변경 불가] 6자 이상 10자 이하로 입력하세요.");
			else if(newUsrPw.search(/\s/) != -1)
				$('#getUsrModal #fixUsrPwChk').text("변경 불가] 띄어쓰기가 포함되어 있습니다.");
			else if(newUsrPw.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/) != -1)
				$('#getUsrModal #fixUsrPwChk').text("변경 불가] 한글을 입력할 수 없습니다.");
			else if(newUsrPw.search(/[0-9]/) < 0 || newUsrPw.search(/[a-zA-Z]/) < 0 || newUsrPw.search(/[~!@#$%^&*()_+|<>?:{}]/) < 0)
				$('#getUsrModal #fixUsrPwChk').text("변경 불가] 영문, 특수문자, 숫자를 모두 입력하세요.");
			else {
				$('#getUsrModal #fixUsrPwChk').attr("class", "text-success");
				$('#getUsrModal #fixUsrPwChk').text("변경 가능");
				isOkay = 2;
			}
		}
		
		if(newUsrName.length && newUsrName != oldUsrName) {
			$('#getUsrModal #fixUsrNameChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(newUsrName.length < 2)
				$('#getUsrModal #fixUsrNameChk').text("변경 불가] 2자 이상 입력하세요.");
			else if(newUsrName.search(/\s/) != -1)
				$('#getUsrModal #fixUsrNameChk').text("변경 불가] 띄어쓰기가 포함되어있습니다.");
			else if(newUsrName.search(/[가-힣]/) < 0 || newUsrName.search(/[ㄱ-ㅎㅏ-ㅣ0-9a-zA-Z~!@#$%^&*()_+|<>?:{}]/) != -1)
				$('#getUsrModal #fixUsrNameChk').text("변경 불가] 한글만 입력하세요.");
			else {
				$('#getUsrModal #fixUsrNameChk').attr("class", "text-success");
				$('#getUsrModal #fixUsrNameChk').text("변경 가능");
				isOkay = 2;
			}
		}
		
		if(newNickname.length && newNickname != oldNickname) {
			$('#getUsrModal #fixNicknameChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(newNickname.length < 2 || 6 < newNickname.length)
				$('#getUsrModal #fixNicknameChk').text("변경 불가] 2자 이상 6자 이하로 입력하세요.");
			else if(newNickname.search(/\s/) != -1)
				$('#getUsrModal #fixNicknameChk').text("변경 불가] 띄어쓰기가 포함되어있습니다.");
			else if(newNickname.search(/[ㄱ-ㅎㅏ-ㅣ~!@#$%^&*()_+|<>?:{}]/) != -1)
				$('#getUsrModal #fixNicknameChk').text("변경 불가] 한글, 영어, 숫자만 입력하세요.");
			else if(newNickname.search(/[가-힣0-9a-zA-Z]/) < 0)
				$('#getUsrModal #fixNicknameChk').text("변경 불가] 한글, 영어, 숫자를 입력하세요.");
			else if(checkIsOverlapped({nickname: newNickname}))
				$('#getUsrModal #fixNicknameChk').text("변경 불가] 존재하는 닉네임입니다.");
			else {
				$('#getUsrModal #fixNicknameChk').attr("class", "text-success");
				$('#getUsrModal #fixNicknameChk').text("변경 가능");
				isOkay = 2;
			}
		}
		
		if(newBirthday.length && newBirthday != oldBirthday) {
			if(newBirthday < $('#getUsrModal #regDate').val()) {
				$('#getUsrModal #fixBirthdayChk').attr("class", "text-success");
				$('#getUsrModal #fixBirthdayChk').text("변경 가능");
				isOkay = 2;
			} else {
				$('#getUsrModal #fixBirthdayChk').attr("class", "text-danger");
				isOkay = 1;
			}
		}
		
		if(newPhoneNum.length && newPhoneNum != oldPhoneNum) {
			$('#getUsrModal #fixPhoneNumChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(newPhoneNum.length < 9 || 11 < newPhoneNum.length)
				$('#getUsrModal #fixPhoneNumChk').text("변경 불가] 8자 이상 11자 이하로 입력하세요.");
			else if(!newPhoneNum.startsWith('0'))
				$('#getUsrModal #fixPhoneNumChk').text("변경 불가] 올바른 전화번호를 입력하세요.");
			else {
				$('#getUsrModal #fixPhoneNumChk').attr("class", "text-success");
				$('#getUsrModal #fixPhoneNumChk').text("변경 가능");
				isOkay = 2;
			}
		}
	} else if(j == "add") {
		$('#addUsrModal #addUsrIdChk').removeAttr("class"); $('#addUsrModal #addUsrIdChk').text("이메일 - 유일값");
		$('#addUsrModal #addUsrPwChk').removeAttr("class"); $('#addUsrModal #addUsrPwChk').text("6~10자, 영문 + 특수문자 + 숫자 혼합");
		$('#addUsrModal #addUsrNameChk').removeAttr("class"); $('#addUsrModal #addUsrNameChk').text("2자 이상의 한글");
		$('#addUsrModal #addNicknameChk').removeAttr("class"); $('#addUsrModal #addNicknameChk').text("2~6자, 한글 + 영문 + 숫자 가능 - 유일값");
		$('#addUsrModal #addBirthdayChk').removeAttr("class"); $('#addUsrModal #addBirthdayChk').text("가입일 이전의 날짜");
		$('#addUsrModal #addPhoneNumChk').removeAttr("class"); $('#addUsrModal #addPhoneNumChk').text("10~11자 - 숫자");

		inPosition = $('#positionOpt option:selected').val();
		if(inPosition.length) isOkay = 2;
		
		if($('#addUsrModal #inUsrId').val().length) {
			inUsrId = $('#addUsrModal #inUsrId').val();
			console.log(inUsrId)
			$('#addUsrModal #addUsrIdChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(inUsrId.search(/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,4}$/) < 0)
				$('#addUsrModal #addUsrIdChk').text("사용 불가] 이메일 형식으로 입력하세요.");
			else if(checkIsOverlapped({usrId: inUsrId})) {
				$('#addUsrModal #addUsrIdChk').text("사용 불가] 존재하는 아이디입니다.");
			} else {
				$('#addUsrModal #addUsrIdChk').attr("class", "text-success");
				$('#addUsrModal #addUsrIdChk').text("사용 가능");
				isOkay = 2;
			}
		}
		
		if($('#addUsrModal #inUsrPw').val().length) {
			inUsrPw = $('#addUsrModal #inUsrPw').val();
			$('#addUsrModal #addUsrPwChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(inUsrPw.length < 6 || 10 < inUsrPw.length)
				$('#addUsrModal #addUsrPwChk').text("사용 불가] 6자 이상 10자 이하로 입력하세요.");
			else if(inUsrPw.search(/\s/) != -1)
				$('#addUsrModal #addUsrPwChk').text("사용 불가] 띄어쓰기가 포함되어 있습니다.");
			else if(inUsrPw.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/) != -1)
				$('#addUsrModal #addUsrPwChk').text("사용 불가] 한글을 입력할 수 없습니다.");
			else if(inUsrPw.search(/[0-9]/) < 0 || inUsrPw.search(/[a-zA-Z]/) < 0 || inUsrPw.search(/[~!@#$%^&*()_+|<>?:{}]/) < 0)
				$('#addUsrModal #addUsrPwChk').text("사용 불가] 영문, 특수문자, 숫자를 모두 입력하세요.");
			else {
				$('#addUsrModal #addUsrPwChk').attr("class", "text-success");
				$('#addUsrModal #addUsrPwChk').text("사용 가능");
				isOkay = 2;
			}
		}
		
		if($('#addUsrModal #inUsrName').val().length) {
			inUsrName = $('#addUsrModal #inUsrName').val();
			$('#addUsrModal #addUsrNameChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(inUsrName.length < 2)
				$('#addUsrModal #addUsrNameChk').text("사용 불가] 2자 이상 입력하세요.");
			else if(inUsrName.search(/\s/) != -1)
				$('#addUsrModal #addUsrNameChk').text("사용 불가] 띄어쓰기가 포함되어있습니다.");
			else if(inUsrName.search(/[가-힣]/) < 0 || inUsrName.search(/[ㄱ-ㅎㅏ-ㅣ0-9a-zA-Z~!@#$%^&*()_+|<>?:{}]/) != -1)
				$('#addUsrModal #addUsrNameChk').text("사용 불가] 한글만 입력하세요.");
			else {
				$('#addUsrModal #addUsrNameChk').attr("class", "text-success");
				$('#addUsrModal #addUsrNameChk').text("사용 가능");
				isOkay = 2;
			}
		}
		
		if($('#addUsrModal #inNickname').val().length) {
			inNickname = $('#addUsrModal #inNickname').val();
			$('#addUsrModal #addNicknameChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(inNickname.length < 2 || 6 < inNickname.length)
				$('#addUsrModal #addNicknameChk').text("사용 불가] 2자 이상 6자 이하로 입력하세요.");
			else if(inNickname.search(/\s/) != -1)
				$('#addUsrModal #addNicknameChk').text("사용 불가] 띄어쓰기가 포함되어있습니다.");
			else if(inNickname.search(/[ㄱ-ㅎㅏ-ㅣ~!@#$%^&*()_+|<>?:{}]/) != -1)
				$('#addUsrModal #addNicknameChk').text("사용 불가] 한글, 영어, 숫자만 입력하세요.");
			else if(inNickname.search(/[가-힣0-9a-zA-Z]/) < 0)
				$('#addUsrModal #addNicknameChk').text("사용 불가] 한글, 영어, 숫자를 입력하세요.");
			else if(checkIsOverlapped({nickname: inNickname}))
				$('#addUsrModal #addNicknameChk').text("사용 불가] 존재하는 닉네임입니다.");
			else {
				$('#addUsrModal #addNicknameChk').attr("class", "text-success");
				$('#addUsrModal #addNicknameChk').text("사용 가능");
				isOkay = 2;
			}
		}
		
		inBirthday = $('#addUsrModal #inBirthday').val();
		if(inBirthday.length) isOkay = 2;
		
		if($('#addUsrModal #inPhoneNum').val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').length) {
			$('#addUsrModal #inPhoneNum').val($('#addUsrModal #inPhoneNum').val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
			inPhoneNum = $('#addUsrModal #inPhoneNum').val();
			$('#addUsrModal #addPhoneNumChk').attr("class", "text-danger");
			isOkay = 1;
			
			if(inPhoneNum.length < 9 || 11 < inPhoneNum.length)
				$('#addUsrModal #addPhoneNumChk').text("사용 불가] 8자 이상 11자 이하로 입력하세요.");
			else if(!inPhoneNum.startsWith('0'))
				$('#addUsrModal #addPhoneNumChk').text("사용 불가] 올바른 전화번호를 입력하세요.");
			else {
				$('#addUsrModal #addPhoneNumChk').attr("class", "text-success");
				$('#addUsrModal #addPhoneNumChk').text("사용 가능");
				isOkay = 2;
			}
		}
	}
	
	return isOkay;
}

/* 회원 수정 */
function fixUser(userCode) {
	if(checkInput("fix") == 2) {
		targetData = {usrCode: userCode}
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/get",
			type: "POST",
	        contentType: "application/json",
			data: JSON.stringify(targetData),
	        success: function(user) {
	        	if(user != null) {
	        		userFixData = {
	           				usrCode : user.usrCode,
	                   		position : user.position,
	                   		usrId : newUsrId,
	                   		usrPw : newUsrPw,
	                   		usrName : newUsrName,
	                   		nickname : newNickname,
	                   		birthday : newBirthday,
	                   		phoneNum : newPhoneNum,
	                   		usrLv : user.usrLv,
	                   		gold : user.gold,
	                   		regDate : user.regDate,
	                   		usrIcon : user.usrIcon
               		}
	        		
               		$.ajax({
               			url: "/godgamez.selfdevelopment/user/fix",
               			type: "PUT",
               	        contentType: "application/json",
               			data: JSON.stringify(userFixData),
               	        success: function(result) {
               	        	if(result) {
               	        		modal("회원", "수정", "성공");
               	        		getUser(userCode);
               	        	} else modal("회원", "수정", "실패");
               	        }, fail: function() {
               	        	modal("회원", "수정", "실패");
               	        }
               		})
	        	} else {
	        		modal("회원", "수정", "실패10", "존재하지 않는 회원입니다.");
	            	$('#getUsrModal').modal("hide");
	            	$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	        	}
	        }, fail: function() {
	        	modal("회원", "수정", "실패10", "회원을 조회할 수 없습니다.");
	        	$('#getUsrModal').modal("hide");
	        	$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	        }
		})
		
		$(disableFixUserIn);
		$('#getUsrModal #getUsrModalBtn').html(
			"<button type='button' class='btn btn-outline-secondary' id='fixUsrInBtn' onclick='fixProc(" + userCode + ")'>수정</button>"
		);
	} else if(checkInput("fix") == 1)
		modal("회원", "수정", "실패10", "입력값을 확인하세요.");
	else
		modal("회원", "수정", "실패10", "변경된 내용이 없습니다.");
}

function fixUserCancel(userCode) {
	$(disableFixUserIn);

	$('#getUsrModal #getUsrModalBtn').html(
		"<button type='button' class='btn btn-outline-secondary' id='fixUsrInBtn' onclick='fixProc(" + userCode + ")'>수정</button>"
	);
}

/* 각종 input 및 btn 비활성화 */
function disableFixUserIn() {
	$('#getUsrModal #fixUsrIdChk').removeAttr("class"); $('#getUsrModal #fixUsrIdChk').text("이메일 - 유일값");
	$('#getUsrModal #fixUsrPwChk').removeAttr("class"); $('#getUsrModal #fixUsrPwChk').text("6~10자, 영문 + 특수문자 + 숫자 혼합");
	$('#getUsrModal #fixUsrNameChk').removeAttr("class"); $('#getUsrModal #fixUsrNameChk').text("2자 이상의 한글");
	$('#getUsrModal #fixNicknameChk').removeAttr("class"); $('#getUsrModal #fixNicknameChk').text("2~6자, 한글 + 영문 + 숫자 가능 - 유일값");
	$('#getUsrModal #fixBirthdayChk').removeAttr("class"); $('#getUsrModal #fixBirthdayChk').text("가입일 이전의 날짜");
	$('#getUsrModal #fixPhoneNumChk').removeAttr("class"); $('#getUsrModal #fixPhoneNumChk').text("10~11자 - 숫자");
	
	$('#getUsrModal input[id="usrId"]').removeAttr('hidden');
	$('#getUsrModal input[id="usrPw"]').removeAttr('hidden');
	$('#getUsrModal input[id="usrName"]').removeAttr('hidden');
	$('#getUsrModal input[id="nickname"]').removeAttr('hidden');
	$('#getUsrModal input[id="birthday"]').removeAttr('hidden');
	$('#getUsrModal input[id="phoneNum"]').removeAttr('hidden');

	$('#getUsrModal #newUsrId').attr('hidden', true);
	$('#getUsrModal #newUsrPw').attr('hidden', true);
	$('#getUsrModal #newUsrName').attr('hidden', true);
	$('#getUsrModal #newNickname').attr('hidden', true);
	$('#getUsrModal #newBirthday').attr('hidden', true);
	$('#getUsrModal #newPhoneNum').attr('hidden', true);
}

/* 회원 추가 모달 초기화 */
function resetAddUsrModal() {
	$('#addUsrModal #addUsrIdChk').removeAttr("class"); $('#addUsrModal #addUsrIdChk').text("이메일 - 유일값");
	$('#addUsrModal #addUsrPwChk').removeAttr("class"); $('#addUsrModal #addUsrPwChk').text("6~10자, 영문 + 특수문자 + 숫자 혼합");
	$('#addUsrModal #addUsrNameChk').removeAttr("class"); $('#addUsrModal #addUsrNameChk').text("2자 이상의 한글");
	$('#addUsrModal #addNicknameChk').removeAttr("class"); $('#addUsrModal #addNicknameChk').text("2~6자, 한글 + 영문 + 숫자 가능 - 유일값");
	$('#addUsrModal #addBirthdayChk').removeAttr("class"); $('#addUsrModal #addBirthdayChk').text("가입일 이전의 날짜");
	$('#addUsrModal #addPhoneNumChk').removeAttr("class"); $('#addUsrModal #addPhoneNumChk').text("10~11자 - 숫자");
	
	$('#positionOpt option[value="none"]').prop('selected', true);
	$('#addUsrModal #inUsrId').val("");
	$('#addUsrModal #inUsrPw').val("");
	$('#addUsrModal #inUsrName').val("");
	$('#addUsrModal #inNickname').val("");
	$('#addUsrModal #inBirthday').val("");
	$('#addUsrModal #inPhoneNum').val("");
}

/* 회원 추가 */
function addUser() {
	if(checkInput("add") == 2) {
		userAddData = {
   				usrCode : 0,
           		position : inPosition,
           		usrId : inUsrId,
           		usrPw : inUsrPw,
           		usrName : inUsrName,
           		nickname : inNickname,
           		birthday : inBirthday,
           		phoneNum : inPhoneNum,
           		usrLv : 0,
           		gold : 0,
           		regDate : new Date().toISOString().substring(0, 10),
           		usrIcon : 'STUDY'
   		}
		
		$.ajax({
			url: "/godgamez.selfdevelopment/user/add",
   			type: "POST",
   	        contentType: "application/json",
   			data: JSON.stringify(userAddData),
   	        success: function(result) {
	        	if(result) {
	        		modal("회원", "추가", "성공");
	        		
	        		$.ajax({
	        			url: "/godgamez.selfdevelopment/user/get",
	        			type: "POST",
	        	        contentType: "application/json",
	        			data: JSON.stringify({usrId : inUsrId}),
	        	        success: function(user) {
	        	        	if(user != null) {
	        	        		$('#addUsrModal').modal('hide');
	        	        		getUser(user.usrCode);
	        	        		getUserClasses(user.usrCode);
	        	        	}
	        	        }
	        		})
	        		
	        	    $(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	        		resetAddUsrModal();
	        	} else {
	        		modal("회원", "추가", "실패");
	        	}
	        }, fail: function() {
	        	modal("회원", "추가", "실패");
	        }
		})
	} else if(checkInput("fix") == 1)
		modal("회원", "추가", "실패10", "입력값을 확인하세요.");
}

/* 신규 회원 인증 처리 및 탈퇴 신청 회원 복구 처리 */
function bePlayer(usrCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/user/get",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({usrCode: usrCode}),
        success: function(usr) {
        	if(usr != null) {
        		uP = usr.position;
            	if(uP.search("NOOB") != -1) {
            		$.ajax({
            			url: "/godgamez.selfdevelopment/user/bePlayer",
            			type: "PATCH",
            	        contentType: "application/json",
            			data: JSON.stringify(usr),
            			success: function(result) {
               				if(result) modal("회원", "등급 상승", "성공");
               				else modal("회원", "등급 상승", "실패");
               			}, fail: function() {
               				modal("회원", "등급 상승", "실패");
        				}
            		});
            		$(getNoobs);
            	} else if(uP.search("OUT") != -1) {
            		$.ajax({
            			url: "/godgamez.selfdevelopment/user/bePlayer",
            			type: "PATCH",
            	        contentType: "application/json",
            			data: JSON.stringify(usr),
            			success: function(result) {
            				if(result) modal("회원", "탈퇴 복구", "성공");
            				else modal("회원", "탈퇴 복구", "실패");
            			}, fail: function() {
            				modal("회원", "탈퇴 복구", "실패");
            			}
            		});
            	}
        	}
        }, fail: function() {
        	modal("회원", "수정", "실패10", "회원을 조회할 수 없습니다.");
        }
	})
	$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
}

$(document).ready(function() {
	$(getAllPlayers);
	$('#listUsrsBtn').click(function() {
		$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	})
	
	$('#usrSrchBtn').click(function() {
		usrSrchDataVal = $('#usrSrchIn').val();
		opt = $('#usrSrchOpt option:selected').val();	
		chkbxNm = $('div[class="tab-pane fade show active"]').find('table').find('tbody').find('#usrDetail').find('td').children('input').attr('name');
		
		if(usrSrchDataVal.length < 1 || opt == "none") {
			modal("회원", "검색", "실패10", "조건을 선택하고 2자 이상 입력하세요.")
		} else {
			switch(opt) {
			case "usrCode": searchUsrs({usrCode: usrSrchDataVal}, chkbxNm); break;
			case "usrId": searchUsrs({usrId: usrSrchDataVal}, chkbxNm); break;
			case "usrName": searchUsrs({usrName: usrSrchDataVal}, chkbxNm); break;
			case "nickname": searchUsrs({nickname: usrSrchDataVal}, chkbxNm);
			}
		}
	})
	
	$('#usrPlayerBtn').click(function() {
		noobsCode = $('#usrCode:checked').val();
		if(noobsCode == null) modal("신규 회원", "등급 상승", '실패3');
		else {
			$('#usrCode:checked').each(function() {
				noobCode = $(this).val();
				bePlayer(noobCode);
			})
		}
		$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	})
	
	$('#cnclOutBtn').click(function() {
		outsCode = $('#usrCode:checked').val();
		if(outsCode == null) modal("탈퇴 신청 회원", "복구", '실패3');
		else {
			$('#usrCode:checked').each(function() {
				outCode = $(this).val();
				bePlayer(outCode);
			})
		}
		$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
	})
	
	$('#usrUnregBtn').click(function() {
		usrsCode = $('#usrCode:checked').val();
		if(usrsCode == null) modal("회원", "삭제", '실패3');
		else {
			modal("회원", "삭제", "확인");
			
			$('#modalBtn #sureBtn').click(function() {
				$('#usrCode:checked').each(function() {
					usrCode = $(this).val();
					$('#delRst').empty();
					
					$.ajax({
						url: "/godgamez.selfdevelopment/user/del/" + usrCode,
						type: "DELETE",
						complete: function(result) {
		    			   $('#delRst').append(`<tr><td>\${result.userCode}</td><td class='text-success'>\${result.isDone}</td></tr>`);
						}
			    	})
			    })
				
				$('#bFResultModal').modal('hide');
				$('#delRstModal').modal('show');
				$('#delRstModal button').click(function() {
					$(getAllPlayers); $(getNoobs); $(getOuts); $(getGms);
				})
			})
		}
	})
})
</script>
<div class='h-100'>
	<%@ include file='../include/header.jsp' %>
	<div id='underHead' class='row w-100'>
	<%@ include file='../include/gnb.jsp' %>
		<div class='col' id='adminBody'>
			<div class='row mt-3 mx-3 justify-content-between'>
				<h4>
					회원 목록
					<a type='button' class='small text-muted' id='listUsrsBtn'>
						<i class='fas fa-redo'></i>
					</a>
				</h4>
				<small class='text-muted' id='usrSrchCnt'></small> <!-- 이거 숫자 구해서 넣기 totPlyrsCnt -->
			</div>
			<hr>
			<div class='row mt-2'>
				<div class='col-6 d-flex justify-content-start'>
					<nav class='nav nav-tabs border-0'>
						<a id='pUsrBtn' data-toggle='tab' href='#pUsrBoard' class='nav-link btn btn-outline-secondary active border-0 text-nowrap' title='PLAYER' onclick='getAllPlayers()'>P</a>
						<a id='oUsrBtn' data-toggle='tab' href='#oUsrBoard' class='nav-link btn btn-outline-secondary border-0 text-nowrap' title='OUT' onclick='getOuts()'>O</a>
						<a id='nUsrBtn' data-toggle='tab' href='#nUsrBoard' class='nav-link btn btn-outline-secondary border-0 text-nowrap' title='NOOB' onclick='getNoobs()'>N</a>
						<a id='mUsrBtn' data-toggle='tab' href='#mUsrBoard' class='nav-link btn btn-outline-secondary border-0 text-nowrap' title='GM' onclick='getGms()'>GM</a>
					</nav>
				</div>
				<div class='col-6 d-flex justify-content-end text-nowrap' id=usrSrchDiv>
					<select class="form-select" aria-label="usrSrchOpt" id='usrSrchOpt'>
					  <option value="none" selected disabled>검색 조건</option>
					  <option value="usrCode">코드</option>
					  <option value="usrId">ID</option>
					  <option value="usrName">이름</option>
					  <option value="nickname">별명</option>
					</select>
					<input type='text' class='form-control' placeholder='2글자 이상 입력하세요.' id='usrSrchIn'>
					<button type='button' class='btn btn-secondary' id='usrSrchBtn'>
						<i class="fas fa-search"></i> 검색
					</button>
				</div>
			</div>
			<div class='row mt-0'>
				<div class='col'>
					<div class='tab-content'>
						<div class='tab-pane fade show active' id='pUsrBoard'>
							<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
								<thead>
									<tr class='text-nowrap text-center'>
										<th id='checkCol'>
											<input type='checkbox' id='checkall1'>
										</th>
										<th width='4%'>코드</th>
										<th width='8%'>포지션</th>
										<th width='15%'>ID</th>
										<th width='10%'>이름</th>
										<th width='15%'>별명</th>
										<th width='12%'>생년월일</th>
										<th width='8%'>레벨</th>
										<th width='10%'>골드</th>
									</tr>
								</thead>
							<tbody class='small' id='pTbody'>
							</tbody>
						</table>
							<div class='row text-nowrap'>
								<div class='col-5'>
									<div class='btn-group'>
										<button class='btn btn-outline-secondary' id='usrUnregBtn'>삭제</button>
										<button class='btn btn-outline-secondary' id='usrPlayerBtn'>인증</button>
										<button class='btn btn-outline-secondary' id='cnclOutBtn'>복구</button>
									</div>
								</div>
								<div class='col-2 d-flex justify-content-center'>
									<ul class='pagination' id='pUsrPagination'>
										<!-- 페이지네이션 추가 부분 -->
									</ul>
								</div>
								<div class='col-5'>
									<div class='btn-group float-right'>
										<button class='btn btn-secondary' data-toggle='modal' data-target='#addUsrModal'>추가</button>
									</div>
								</div>
							</div>
						</div>
						<div class='tab-pane fade show' id='oUsrBoard'>
							<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
								<thead>
									<tr class='text-nowrap text-center'>
										<th id='checkCol'>
											<input type='checkbox' id='checkall2'>
										</th>
										<th width='4%'>코드</th>
										<th width='8%'>포지션</th>
										<th width='15%'>ID</th>
										<th width='10%'>이름</th>
										<th width='15%'>별명</th>
										<th width='12%'>생년월일</th>
										<th width='8%'>레벨</th>
										<th width='10%'>골드</th>
									</tr>
								</thead>
								<tbody class='small' id='oTbody'>
								</tbody>
							</table>
							<div class='row text-nowrap'>
								<div class='col-5'>
									<div class='btn-group'>
										<button class='btn btn-outline-secondary' id='usrUnregBtn'>삭제</button>
										<button class='btn btn-outline-secondary' id='cnclOutBtn'>복구</button>
									</div>
								</div>
								<div class='col-2 d-flex justify-content-center'>
									<ul class='pagination'>
										<li class='page-item'> 
											<a class='page-link' href='#' tabindex='-1'>
												<span class='text-dark'>&laquo;</span> 
											</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>1</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>2</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>3</a>
										</li>
										<li class='page-item'> 
											<a class='page-link' href='#'>
												<span class='text-dark'>&raquo;</span> 
											</a>
										</li>
									</ul>
								</div>
								<div class='col-5'>
									<div class='btn-group float-right'>
										<button class='btn btn-secondary' data-toggle='modal' data-target='#addUsrModal'>추가</button>
									</div>
								</div>
							</div>
						</div>
						<div class='tab-pane fade show' id='nUsrBoard'>
							<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
								<thead>
									<tr class='text-nowrap text-center'>
										<th id='checkCol'>
											<input type='checkbox' id='checkall3'>
										</th>
										<th width='4%'>코드</th>
										<th width='8%'>포지션</th>
										<th width='15%'>ID</th>
										<th width='10%'>이름</th>
										<th width='15%'>별명</th>
										<th width='12%'>생년월일</th>
										<th width='8%'>레벨</th>
										<th width='10%'>골드</th>
									</tr>
								</thead>
								<tbody class='small' id='nTbody'>
								</tbody>
							</table>
							<div class='row text-nowrap'>
								<div class='col-5'>
									<div class='btn-group'>
										<button class='btn btn-outline-secondary' id='usrPlayerBtn'>인증</button>
									</div>
								</div>
								<div class='col-2 d-flex justify-content-center'>
									<ul class='pagination'>
										<li class='page-item'> 
											<a class='page-link' href='#' tabindex='-1'>
												<span class='text-dark'>&laquo;</span> 
											</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>1</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>2</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>3</a>
										</li>
										<li class='page-item'> 
											<a class='page-link' href='#'>
												<span class='text-dark'>&raquo;</span> 
											</a>
										</li>
									</ul>
								</div>
								<div class='col-5'>
									<div class='btn-group float-right'>
										<button class='btn btn-secondary' data-toggle='modal' data-target='#addUsrModal'>추가</button>
									</div>
								</div>
							</div>
						</div>
						<div class='tab-pane fade show' id='mUsrBoard'>
							<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
								<thead>
									<tr class='text-nowrap text-center'>
										<th id='checkCol'>
											<input type='checkbox' id='checkall4'>
										</th>
										<th width='4%'>코드</th>
										<th width='8%'>포지션</th>
										<th width='15%'>ID</th>
										<th width='10%'>이름</th>
										<th width='15%'>별명</th>
										<th width='12%'>생년월일</th>
										<th width='8%'>레벨</th>
										<th width='10%'>골드</th>
									</tr>
								</thead>
								<tbody class='small' id='gmTbody'>
								</tbody>
							</table>
							<div class='row text-nowrap'>
								<div class='col-5'>
									<div class='btn-group'>
										<button class='btn btn-outline-secondary' id='usrUnregBtn'>삭제</button>
									</div>
								</div>
								<div class='col-2 d-flex justify-content-center'>
									<ul class='pagination'>
										<li class='page-item'> 
											<a class='page-link' href='#' tabindex='-1'>
												<span class='text-dark'>&laquo;</span> 
											</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>1</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>2</a>
										</li>
										<li class='page-item'>
											<a class='page-link text-dark' href='#'>3</a>
										</li>
										<li class='page-item'> 
											<a class='page-link' href='#'>
												<span class='text-dark'>&raquo;</span> 
											</a>
										</li>
									</ul>
								</div>
								<div class='col-5'>
									<div class='btn-group float-right'>
										<button class='btn btn-secondary' data-toggle='modal' data-target='#addUsrModal'>추가</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 -->
<div id='addUsrModal' class='modal fade modal-fullsize modal-center' tabindex='-1'>
	<div class='modal-dialog modal-fullsize'>
		<div class='modal-content modal-fullsize'>
			<div class='modal-header'>
				<h6>회원 추가</h6>
				<div class='justify-content-end'>
					<select class="form-select" aria-label="positionOpt" id='positionOpt' onblur="checkInput('add')">
					  <option value="none" selected disabled>포지션</option>
					  <option value="NOOB">NOOB</option>
					  <option value="PLAYER">PLAYER</option>
					  <option value="GM">GM</option>
					</select>
				</div>
			</div>
			<div class='modal-body'>
				<div class='row'>
					<div class='col'>
						<table class='border-0 small text-nowrap w-100'>
							<tr>
								<td width='10%'>
									<label for='usrId'>ID </label>
								</td>
								<td width='25%' id='usrId'>
									<input type='email' class='form-control' id='inUsrId' onblur="checkInput('add')">
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='usrPw'>PW </label>
								</td>
								<td width='50%' id='usrPw'>
									<input type='text' class='form-control' id='inUsrPw' onblur="checkInput('add')">
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='addUsrIdChk'>이메일 - 유일값</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='addUsrPwChk'>6~10자, 영문 + 특수문자 + 숫자 혼합</small>
								</td>
							</tr>
							<tr>
								<td width='10%'>
									<label for='usrName'>이름 </label>
								</td>
								<td width='25%' id='usrName'>
									<input type='text' class='form-control' id='inUsrName' onblur='checkInput("add")'>
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='nickname'>별명 </label>
								</td>
								<td width='50%' id='nickname'>
									<input type='text' class='form-control' id='inNickname' onblur='checkInput("add")'>
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='addUsrNameChk'>2자 이상의 한글</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='addNicknameChk'>2~6자, 한글 + 영문 + 숫자 가능 - 유일값</small>
								</td>
							</tr>
							<tr>
								<td width='10%'>
									<label for='birthday'>생일 </label>
								</td>
								<td width='25%' id='birthday'>
									<input type='date' class='form-control' id='inBirthday' onblur="checkInput('add')">
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='phoneNum'>전화 </label>
								</td>
								<td width='50%' id='phoneNum'>
									<input type='tel' class='form-control' id='inPhoneNum' onblur="checkInput('add')">
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='addBirthdayChk'>오늘 이전의 날짜</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='addPhoneNumChk'>10~11자 - 숫자</small>
								</td>
							</tr>
						</table>
						<div class='row justify-content-end mt-3 mr-1' id='addUsrModalBtn'>
							<button type='button' class='btn btn-outline-secondary' id='addUsrInBtn' onclick="addUser()">추가</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id='getUsrModal' class='modal fade modal-fullsize modal-center' tabindex='-1'>
	<div class='modal-dialog modal-fullsize'>
		<div class='modal-content modal-fullsize'>
			<div class='modal-header'>
				<h6>회원 조회 및 수정</h6>
				<div class='justify-content-end'>
					<small id='usrCode' class='mr-2'></small>
					<small id='position' class='mr-2'></small>
					<small id='regDate' class='mr-2'></small>
				</div>
			</div>
			<div class='modal-body'>
				<div class='row'>
					<div class='col'>
						<table class='border-0 small text-nowrap w-100'>
							<tr>
								<td width='10%'>
									<label for='usrId'>ID </label>
								</td>
								<td width='25%' id='usrId'>
									<input type='email' class='form-control' id='usrId' disabled>
									<input type='email' class='form-control' id='newUsrId' onblur="checkInput('fix')" hidden='true'>
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='usrPw'>PW </label>
								</td>
								<td width='50%' id='usrPw'>
									<input type='text' class='form-control' id='usrPw' disabled>
									<input type='text' class='form-control' id='newUsrPw' onblur="checkInput('fix')" hidden='true'>
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='fixUsrIdChk'>이메일 - 유일값</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='fixUsrPwChk'>6~10자, 영문 + 특수문자 + 숫자 혼합</small>
								</td>
							</tr>
							<tr>
								<td width='10%'>
									<label for='usrName'>이름 </label>
								</td>
								<td width='25%' id='usrName'>
									<input type='text' class='form-control' id='usrName' disabled>
									<input type='text' class='form-control' id='newUsrName' onblur="checkInput('fix')" hidden='true'>
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='nickname'>별명 </label>
								</td>
								<td width='50%' id='nickname'>
									<input type='text' class='form-control' id='nickname' disabled>
									<input type='text' class='form-control' id='newNickname' onblur="checkInput('fix')" hidden='true'>
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='fixUsrNameChk'>2자 이상의 한글</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='fixNicknameChk'>2~6자, 한글 + 영문 + 숫자 가능 - 유일값</small>
								</td>
							</tr>
							<tr>
								<td width='10%'>
									<label for='birthday'>생일 </label>
								</td>
								<td width='25%' id='birthday'>
									<input type='date' class='form-control' id='birthday' disabled>
									<input type='text' class='form-control' id='newBirthday' onfocus='(this.type="date")' onblur='checkInput("fix"); (this.type="text")' hidden='true'>
								</td>
								<td width='5%'></td>
								<td width='10%'>
									<label for='phoneNum'>전화 </label>
								</td>
								<td width='50%' id='phoneNum'>
									<input type='tel' class='form-control' id='phoneNum' disabled>
									<input type='tel' class='form-control' id='newPhoneNum' onblur="checkInput('fix')" hidden='true'>
								</td>
							</tr>
							<tr>
								<td width='35%' colspan='2' class='text-right'>
									<small id='fixBirthdayChk'>가입일 이전의 날짜</small>
								</td>
								<td width='5%'></td>
								<td width='50%' colspan='2' class='text-right'>
									<small id='fixPhoneNumChk'>10~11자 - 숫자</small>
								</td>
							</tr>
							<tr>
								<td width='10%'>
									<label for='usrLv'>레벨 </label>
								</td>
								<td width='30%' id='usrLv'>
									<input type='text' class='form-control' id='usrLv' readonly>
								</td>
								<td width='10%'></td>
								<td width='10%'>
									<label for='usrExp'>&nbsp;&nbsp;경험치</label>
								</td>
								<td width='30%' id='usrExp'>
									<input type='text' class='form-control' id='usrExp' readonly>
								</td>
							</tr>
						</table>
						<div class='row justify-content-end mt-3 mr-1' id='getUsrModalBtn'>
							<button type='button' class='btn btn-outline-secondary' id='fixUsrInBtn'>수정</button>
						</div>
						<hr>
						<table class='border-0 small text-nowrap w-100'>
							<tr>
								<td colspan='5'>
									<label for='usrClss'>클래스명 </label>
									<small id='usrClssCnt' class='float-right font-weight-bold mr-1'></small>
								</td>
							</tr>
							<tr>
								<td colspan='5'>
									<div class='form-control' id='usrClsList'>
										<div id='usrClsListDiv' class='small'>
										</div>
										<button type='button' class='btn btn-secondary' id='addClsBtn'>
											<i class="fas fa-plus"></i>
										</button>
										<button type='button' class='btn btn-outline-secondary' id='rmvClsBtn'>
											<i class="fas fa-minus"></i>
										</button>
									</div>
									<small id='fixUsrClsChk'>1개 이상 9개 이하 선택 가능</small>
								</td>
							</tr>
						</table>
					</div>
				</div>
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
					<select class="form-select ml-3" aria-label="clsSrchOpt" id='clsSrchOpt'>
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
					<button type='button' class='btn btn-secondary' id='addChoosenClsBtn'>추가</button>
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

<div id='delRstModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h6>회원 삭제 작업 결과</h6>
				<h6><button type='button' class='btn btn-sm' data-dismiss='modal'>
					<i class="fas fa-times"></i>
				</button></h6>
			</div>
			<div class='modal-body'>
				<table class='table table-sm border-0'>
					<thead class='text-center'>
						<tr><th>회원 코드</th><th>작업 성공 여부</th></tr>
					</thead>
					<tbody class='text-center' id='delRst'></tbody>
				</table>
			</div>
			<div class='modal-footer justify-content-center'>
				<button class='btn btn-outline-secondary' data-dismiss='modal'> 확 인 </button>
			</div>
		</div>
	</div>
</div>