<title>갓겜:퀘스트완료</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#usrQstId {
	visibility:hidden;
}
#previewImg {
	background-color: #e9e9e9;
	margin:1.5rem;
	height:19rem;
	width:30rem;
}
</style>
<script>
let questId = ${param.qstId}

$(() => {
	let sessionUser = getConnectedUser();
	doQstData(sessionUser);
	
	$('#fileBtn').change(function() {
		showImg(this)
	})
})

function doQstData(sessionUser) {
	if(sessionUser) {
		let procStep
		//수락퀘스트 체크
		$.ajax({
			url: '/godgamez.selfdevelopment/quest/chckAcptdQst',
			method: 'post',
			data: JSON.stringify({
				usr: {usrCode: sessionUser.usrCode},
				qst: {qstId: questId}
			}),
			contentType: 'application/json',
			async: false
		}).done(function(usrQst) {
			if(usrQst && usrQst.usr && usrQst.qst) {
				let d = usrQst.qst.difficulty;
				let lv = parseInt(sessionUser.usrLv);
				let expPoint = sessionUser.usrLv - lv;
				let expectedExpPoint = (lv%d * d^3 * lv) / ((1 / d) * lv * lv);
				
				if(expectedExpPoint + expPoint >= 1) expectedExpPoint = 1 - expPoint;
				
				$('#nickname b').text(usrQst.usr.nickname);
				$('#usrLv').text("LV " + lv);
				$('#nowExp').attr("style", "width:" + (usrQst.usr.usrLv - lv) * 100 + "%");
				$('#expectedExp').attr("style", "width:" + expectedExpPoint * 100 + "%");
				
				if(usrQst.procStep == 'ACCEPTED') {
					$('#qstName').html('<b>' + usrQst.qst.qstName + '</b>')
					$('#qstClsName').html('<b>' + usrQst.qst.cls.mainCtg + ' > ' + usrQst.qst.cls.subCtg + ' > ' + usrQst.qst.cls.clsName + '</b>')
					
					let difficulty = "";
					for(i = 1; i <= 5; i++) i <= usrQst.qst.difficulty ? difficulty += '★' : difficulty += '☆';
					$('#difficulty').attr("name", usrQst.qst.difficulty);
					$('#difficulty').text(difficulty);
				} else if(usrQst.procStep == 'DONE') {
					modal("퀘스트", "수행", "실패10", "이미 수행한 퀘스트입니다. 마이 페이지로 이동합니다.");
					$('#okCloseBtn').attr('onclick', 'location.href="/godgamez.selfdevelopment/user/mypage"');
				} else {
					modal('퀘스트', '조회', '실패10', '비정상적인 접근입니다.');
					$('#okCloseBtn').attr('onclick', 'location.href="/godgamez.selfdevelopment/quest/board"');
				}
			} else {
				modal('퀘스트', '조회', '실패10', '비정상적인 접근입니다.');
				$('#okCloseBtn').attr('onclick', 'location.href="/godgamez.selfdevelopment/quest/board"');
			}
		})
	} else modal("", "", "실패6")
}

//이미지 미리보기
function showImg(input) {
	if(input.files[0]) {
		let reader = new FileReader()
		reader.readAsDataURL(input.files[0])
		
		reader.addEventListener('load', () => {
			$('#previewImg').attr('src', reader.result)
		}, false)
	}
}

//퀘스트 제출
function finBusiness(b, f) {
	if($('#previewImg').attr('src') != undefined) {
		let oldUser = getConnectedUser();
		let d = $('#difficulty').attr("name");
		let newUser = doQst();

		let olLv = parseInt(oldUser.usrLv);
		
		if(newUser) {
			if(olLv < parseInt(newUser.usrLv)) {
				let bonus = parseInt((oldUser.usrLv - newUser.usrLv + (olLv%d * d^3 * olLv)/(1/d * olLv*olLv)) * d);
				
				modalContent = "축하합니다! 레벨이 상승하였습니다!<br>" +
							parseInt(newUser.usrLv) + " 레벨이 되어 " + (newUser.gold - oldUser.gold - bonus) +
							" +" + bonus + " 골드를 얻었습니다!";
			} else modalContent = '이미지를 제출하여 퀘스트를 완료하였습니다!<br>' +
								(newUser.gold - oldUser.gold) + " 골드를 얻었습니다!";
			
			$('#bFResultModal #modalTitle').html(b + f + "성공");
			$('#bFResultModal #modalContent').html(modalContent);
			$('#bFResultModal #modalBtn').html(
					"<a class='btn btn-outline-secondary' href='/godgamez.selfdevelopment/user/mypage#doneUsrqstImgList'>완료 퀘스트 확인</a>"+
					"<a class='btn btn-secondary' href='/godgamez.selfdevelopment/coupon/shop'>쿠폰 상점</a>");
			$('#bFResultModal').modal('show');
			$(setHeader);
		} else modal('퀘스트', '완료', '실패');
	} else modal('퀘스트', '완료', '실패10', '이미지를 선택하세요.')
}

function doQst() {
	let newUser;
	
	$('#usrQstId').val("");
	$('#previewImg').removeAttr('src')
	
	let user = getConnectedUser();
	
	$.ajax({
		url: '/godgamez.selfdevelopment/quest/userQuest/finishUserQuest',
		method: 'put',
		data: JSON.stringify({
			handInImg: user.usrCode + '_' + questId,
			usr: {usrCode: user.usrCode},
			qst: {qstId: questId}
		}),
		contentType: 'application/json',
		async: false,
		success: function(result) {
			if(result) {
				$('#usrQstId').val(user.usrCode + '_' + questId);
				
				//이미지파일 추가
				let form = $('#usrQstImgReportForm')[0];
				let formData = new FormData(form);
				$.ajax({
					url: '/godgamez.selfdevelopment/userQuest/attach',
					method: 'post',
					data: formData,
					contentType: false,
					processData: false
				})
				newUser = lvUp($('#difficulty').attr("name"));
			}
		}
	})
	
	return newUser;
}

function lvUp(difficulty) {
	let newUser;
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/earnExpGold',
		method: 'patch',
		data: JSON.stringify(difficulty),
		contentType: 'application/json',
		async: false,
		success: function(usr) {if(usr) newUser = usr}
	})
	
	return newUser;
}
</script>
<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>
<div id='body'>
	<div class='container mt-5 my-5'>
		<div class='row	my-5'>
			<div class='col'>
				<div id='title'>
					<h4><strong>퀘스트 수행</strong></h4><hr>
				</div>
			</div>
		</div>
		<div class='row justify-content-center mt-3'>
			<div class='col'>
				<h1 class='mb-4' id='qstName'></h1>
				<ul class='list-group list-group-horizontal'>
					<li class='list-group-item active bg-secondary border-secondary' id='qstClsName'></li>
					<li class='list-group-item' id='difficulty'></li>
				</ul>
				<br>
				<div class='row justify-content-between'>
					<div class='col-4' id='nickname'><b></b></div>
					<div class='col-4 text-right text-muted'><span class='badge badge-secondary' id='usrLv'></span></div>
				</div>
				<div class='progress'>
					<div class='progress-bar bg-secondary' id='nowExp'></div>
					<div class='progress-bar bg-secondary progress-bar-striped' id='expectedExp'></div>
				</div>
				<!--파일선택 -->
				<form id='usrQstImgReportForm'>
					<div class='justify-content-center mt-4'>
						<div class='row justify-content-between'>
							<input type='file' class='align-self-center ml-3' name='attachFile' id='fileBtn' accept='.jpg, .png'>
							<input type='text' id='usrQstId' name='usrQstId' hidden=true/>
							<h6 class='small ml-3 align-self-center mt-2' id='infoMsg'>2MB 이하의 JPG, PNG파일을 제출해주세요.</h6>
						</div>
						<div class='row'> 
							<button type='button' class='btn btn-lg btn-secondary w-100 mx-3 mt-4' id='completeQstBtn' 
								onclick='modal("퀘스트", "수행", "확인")'> 제출하기 </button>
						</div>
					</div>
				</form>
			</div>
			<!-- 이미지 미리보기위치 -->
			<div class='col'>
				<div class='mt-3'>
					<table>
						<tbody>
							<tr>
								<td class='justify-content-center'><img id='previewImg'/></td>
							</tr>
						</tbody>
					</table>
				</div>
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