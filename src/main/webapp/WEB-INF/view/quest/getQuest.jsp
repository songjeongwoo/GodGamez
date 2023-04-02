<title>갓겜:퀘스트조회</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#qstImgDiv { 
	position: relative;
	width: 100%;
	padding: 0;
	margin: 0;
}
#qstImgDiv #qstProcessTxt {
	position: absolute;
	right: 0;
	z-index: 3;
	border-radius: 0;
}
#qstImg {
	position: absolute;
	width: 100%;
	height: 18rem;
}
table{
	text-align:center;
}
#qstStop,
#qstEnd {
	width: 40%;
}
</style>
<script>
let sessionUser = getConnectedUser();
let questId = ${param.qstId}

$(() => {
	if(sessionUser && sessionUser.usrCode) {
		$.ajax({
			url: '/godgamez.selfdevelopment/quest/list/${param.qstId}',
			data: {qstId: questId}
		}).done(qst => {
			if(qst) {
				if(qst.qstImg != null) $('#qstImgCardDiv img').attr('src', '/godgamez.selfdevelopment/res/quest/' + qst.qstId + '.jpg')
				else $('#qstImgCardDiv img').attr('alt', '퀘스트 이미지')
				
				$('#qstName').append('<h1><b>' + qst.qstName + '</b></h1>')
				$('#qstClsName').text(qst.cls.mainCtg + ' > ' + qst.cls.subCtg + ' > ' + qst.cls.clsName)
				
				d = "";
				for(i = 1; i <= 5; i++) i <= qst.difficulty ? d += '★' : d += '☆';
				$('#difficulty').text(d);
				
				$('#qstContent').text(qst.qstContent)
			} else modal('퀘스트', '조회', '실패10', '퀘스트가 존재하지 않습니다.')
		}).fail(() => modal('퀘스트', '조회', '실패'))
		
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
		}).done(usrQst => {
			if(usrQst.procStep && usrQst.procStep == 'ACCEPTED') {
				$('#qstProcessTxt').text('수행중')
				$('#button button').replaceWith("<button type='button' class='btn col border mt-1 mb-1 mr-4 ml-4' onclick='abandonQst()'>포기</button>")
				$('#button').append("<a type='button' href='/godgamez.selfdevelopment/quest/report?qstId=" + questId +
									"' class='btn col border mt-1 mb-1 mr-4' id='finishBtn'>완료</a>")
			} else if(usrQst.procStep && usrQst.procStep == 'DONE') {
				$('#qstProcessTxt').text('수행완료')
				$('#button button').replaceWith("<button type='button' class='btn col border mt-1 mb-1 mr-4 ml-4' disabled='disabled'>이미 완료한 퀘스트입니다.</button>")
			}
		})
	} else modal("","","실패8");
})

//퀘스트 수락
function acptQst() {
	if(sessionUser.usrCode) {
		$.ajax({
			url: '/godgamez.selfdevelopment/quest/addUsrQst',
			method: 'post',
			data: JSON.stringify({
				usr: {usrCode: sessionUser.usrCode},
				qst: {qstId: questId}
			}),
			contentType: 'application/json'
		}).done((result) => {
			if(result) {
				$(modal('퀘스트', '수락', '성공'))
				$('#qstProcessTxt').text('수행중')
				$('#button button').replaceWith("<button type='button' class='btn col border mt-1 mb-1 mr-4 ml-4' onclick='abandonQst()'>포기</button>")
				$('#button').append("<a type='button' href='/godgamez.selfdevelopment/quest/report?qstId=" + questId +
						"' class='btn col border mt-1 mb-1 mr-4' id='finishBtn'>완료</a>")
			} else modal('퀘스트', '수락', '실패')
		}).fail(() => modal('퀘스트', '수락', '실패'))
	} else modal("", "", "실패8");
}

//퀘스트 포기
function abandonQst() {
	if(sessionUser.usrCode) {
		$.ajax({
			url: '/godgamez.selfdevelopment/quest/abandonQst',
			method: 'delete',
			data: JSON.stringify({
				qst: {qstId: questId}
			}),
			contentType: 'application/json'
		}).done((result) => {
			if(result) {
				$(modal('퀘스트', '포기', '성공'))
				$('#qstProcessTxt').text('수행가능')
				$('#button').empty()
				$('#button').append("<button type='button' class='btn col border mt-1 mb-1 mr-4 ml-4'" + 
									"data-toggle='modal' data-target='#qstAcptSucModal' id='qstProcBtn' onclick='acptQst()'>수락하기</button>")
			} else modal('퀘스트', '포기', '실패')
		}).fail(() => modal('퀘스트', '포기', '실패'))
	} else modal("", "", "실패8");
}
</script>
<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>
<div id='body'>
	<div class='container mt-5 my-5'> 
		<div class='row	mt-5'>
			<div class='col'>
				<div id='title'>
					<h4><strong>퀘스트 조회</strong></h4><hr>
				</div>
			</div>
		</div>
		<div class='row justify-content-center'>
			<div class='col'>
				<div class='row'>
					<div class='col-6'>
						<div class='card' >
							<div class='card-body' id='qstImgDiv'>
								<div id='qstImgCardDiv'>
									<button id='qstProcessTxt' class='p-1 btn btn-secondary font-weight-bold'>
										수행가능
									</button>
									<img src='#' id='qstImg' class='align-self-center' alt='퀘스트이미지' />
								</div>
							</div>
						</div>
					</div> 
					<div class='col-6 w-100 align-self-end mb-2 pl-5 text-center'>
						<div class='row align-self-center' id='qstName'></div>
						<div class='row align-self-end'>
							<div class='card w-100 border' id='card'>
								<div class='card-header' id='qstClsName'></div>
								<ul class='list-group list-group-flush'>
									<li class='list-group-item' id='difficulty'></li>
									<li class='list-group-item' id='qstContent'></li>
								</ul>
								<div class='row' id='button'>
									<button type='button' class='btn col border mt-1 mb-1 mr-4 ml-4' 
										data-toggle='modal' data-target='#qstAcptSucModal' id='qstProcBtn' onclick='acptQst()'>
											수락하기
									</button>
								</div>
							</div>
						</div>
					</div>
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