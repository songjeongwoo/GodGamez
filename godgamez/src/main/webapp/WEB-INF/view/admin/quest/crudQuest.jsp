<title>갓겜:퀘스트 관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>
<%@ page import='java.util.Date' %>
<style>
/* gnd 길이조정 */
@media (max-width: 768px) {
	#adminGnb {
		height: calc(100% + 30rem);
	}
}
#previewImg {
	background-color: #e9e9e9;
	margin: 1em;
	width: calc(100% - 3.6rem);
	height: 15em;
}
#qstSrch button {
	width: 35%;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
#usrQstSrch select {
	height: 2.5rem;
	width: 22%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}
#usrQstSrch input {
	height: 2.5rem;
	width: 62%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
#usrQstSrch button {
	height: 2.5rem;
	width: 16%;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
#qstSrch input {
	width: 65%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}
#qstBoard table thead,
#accpUsrQstBoard table thead,
#doneUsrQstBoard table thead {
	border-top: 0.1rem solid;
	border-color: secondary;
}
#addQstBtn,
#delQstBtn,
#doUsrQstBtn  {
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	width: 4rem;
}
#delUsrQstImgBtn {
	border-top-right-radius: 0;
	border-top-left-radius: 0;
	border-top: 0;
	width: 6rem;
}
#modalTable {
	text-align:center;
	margin-top:1em;
}
#modalTable th{
	margin-top:1em;
	min-width: 6rem;
}
#srchClsModal {
	z-index: 1051;
}
</style>
<script>
//퀘스트 조회
function getQsts(address) {
	$.ajax({
		url: address
	}).done(qsts => {
		if(qsts.length) {
			let qstList = []
			let actpdQstCnt
			$.each(qsts, (idx, qst) => {
				//퀘스트조회 수행중
				$.ajax({
					url: '/godgamez/quest/userQuest/ActpdQstCnt',
					async: false, //ajax는 비동기방식, false로 쓰면 동기방식이 되기때문에 //전역변수에 ajax통신 값을 저장해서 블록 밖에서도 쓸 수 있게 해준다.
					data: {
						qstId: qst.qstId
					}
				}).done(quests => actpdQstCnt = quests.length) //async: false를 써줘서 블록 밖에서도 사용가능하다.
				
				$('#qstList').empty()
				qstList.unshift(
					`<tr class='qstDetail'>
						<td class='checkCol'><input type='checkbox' id='qstChk' name='check1'></td>
						<td width='5%' class='qstId' onclick='qstDetail()'>
							\${qst.qstId}
						</td>
						<td width='50%' id='qstName' onclick='qstDetail()'>
							\${qst.qstName}
						</td>
						<td width='20%' id='qstClsName' onclick='qstDetail()'>
							\${qst.cls.clsName}
						</td>
						<td width='10%' class='actpdQstCnt' onclick='qstDetail()'>
							\${actpdQstCnt}
						</td>
					</tr>`)
			})
			$('#qstQty').text('총 ' + qstList.length + '건')
			$('#qstList').append(qstList.join(''))
		} else {
			$('#qstList').empty()
			$('#qstList').append('<tr><td colspan="5" class="text-center"><b>퀘스트가 존재하지 않습니다.</b></td></tr>')
		}
	})
}

//퀘스트 조회 - 검색
function srchQstName() {
	let questName = $('#qstSrch').find('input').val()
	if(questName.length > 1) {
		$.ajax({
			url: '/godgamez/quest/admin/srchQstName',
			method: 'post',
			data: JSON.stringify({
				qstName: questName
			}),
			contentType: 'application/json'
		}).done(qsts => {
			$('#qstSrch').find('input').val('')
			let qstList = []
			let actpdQstCnt
			if(qsts.length) {
				$.each(qsts, (idx, qst) => {
					//퀘스트조회 수행중 
					$.ajax({
						url: '/godgamez/quest/userQuest/ActpdQstCnt',
						async: false, //ajax는 비동기방식, false로 쓰면 동기방식이 되기때문에 //전역변수에 ajax통신 값을 저장해서 블록 밖에서도 쓸 수 있게 해준다.
						data: {
							qstId: qst.qstId
						}
					}).done(quests => actpdQstCnt = quests.length) //async: false를 써줘서 블록 밖에서도 사용가능하다.
					
					$('#qstList').empty()
					qstList.unshift(
						`<tr class='qstDetail'>
							<td class='checkCol'><input type='checkbox' id='qstChk' name='check1'></td>
							<td width='5%' class='qstId' onclick='qstDetail()'>
								\${qst.qstId}
							</td>
							<td width='50%' id='qstName' onclick='qstDetail()'>
								\${qst.qstName}
							</td>
							<td width='20%' id='qstClsName' onclick='qstDetail()'>
								\${qst.cls.clsName}
							</td>
							<td width='10%' class='actpdQstCnt' onclick='qstDetail()'>
								\${actpdQstCnt}
							</td>
						</tr>`)
				})
			} else {
				$('#qstList').empty()
				$('#qstList').html('<tr><td colspan="5"><b>해당 퀘스트가 존재하지 않습니다.</b></td></tr>')
			}
			$('#qstQty').text('총 ' + qstList.length + '건');
			$('#qstList').append(qstList.join(''))
		}).fail(() =>  modal('퀘스트', '검색', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
	} else modal('퀘스트', '검색', '실패10', '2글자 이상을 입력하세요.')
}

//퀘스트 추가
function addProcQst() {
	let newQstName = $('#addFixProcModal #qstName').val()
	let newDifficulty = $('input[type="radio"]:checked').val()
	let newQstContent = $('#addFixProcModal #qstContent').val()
	let clsId = $('#addFixProcModal #clsId').val()
	let newClsName = $('#addFixProcModal #cls').val().split('>')[2].replace(" ", "")
	let questDataIn = {}
	$.ajax({
		url: '/godgamez/class/search',
		method: 'post',
		data: JSON.stringify({clsName: newClsName}),
		contentType: 'application/json'
	}).done(clss => {
		let clsObj = clss[0]
		questDataIn = {
			qstId: 0,
			cls: clsObj,
			qstName: newQstName,
			difficulty: newDifficulty,
			qstContent: newQstContent,
			qstImg: clsId + '_' + newQstName //DB에 저장될 네이밍(클래스당 여러 개 퀘스트가 있을 수 있기때문에 이렇게 지음)
		}
		$.ajax({
			url: '/godgamez/quest/add',
			method: 'post',
			data: JSON.stringify(questDataIn),
			contentType: 'application/json'
		}).done(result => {
			if(result) {
				let questId
				$.ajax({
					url: '/godgamez/quest/qstId',
					async: false, //ajax는 비동기방식, false로 쓰면 동기방식이 되기때문에 //전역변수에 ajax통신 값을 저장해서 블록 밖에서도 쓸 수 있게 해준다.
				}).done(qstId => {
					questId = qstId
				})
				$('#curQstId').val(questId)
				
				//퀘스트 추가 시 이미지파일 추가 
				let form = $('#addFixQstImg')[0] //form DOM element
				let formData = new FormData(form)
				$.ajax({
					url: '/godgamez/quest/attach',
					method: 'post',
					data: formData,
					contentType: false, //false로 둘 경우, multipart/form-data로 전송됨
					processData: false //false로 둘 경우, formData를 String으로 변환하지 않음
				})
				modal('퀘스트', '추가', '성공')
				$('#doneBBtn').click(() => {
					window.location.reload()
				})
			} else modal('퀘스트', '추가', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
		}).fail(() => modal('퀘스트', '추가', '실패10', '퀘스트명, 클래스, 난이도, 퀘스트 내용을 입력했는지 확인하세요.'))
	})
}

//클래스 선택 시 해당 클래스 추가
function addCls(clsId, clsFullName) {
	$('#addFixProcModal #clsId').val(clsId)
	$('#addFixProcModal #cls').val(clsFullName)
	$('#srchClsModal').modal('hide')
}

//클래스 리스트 - script.js와 다름, 백틱때문에 .js에 못 넣음
function listCls() {
	$('#srchClsTBody').empty();
	$.ajax({
		url: '/godgamez/class/list'	
	}).done(clss => {
		if(clss.length) {
			let clsList = [];
			$('#srchClsCnt').text("총 " + clss.length + "건")
			$('#srchClsTBody').empty();
			$.each(clss, (idx, cls) => {
				clsList.push(
					`<tr id='clsDetail' onclick='addCls(\${cls.clsId}, "\${cls.mainCtg} > \${cls.subCtg} > \${cls.clsName}")'>
		  				<td id='mainCtg'>\${cls.mainCtg}</td>
		  				<td id='subCtg'>\${cls.subCtg}</td>
		  				<td id='clsName'>\${cls.clsName}</td>
		  			</tr>`)
		  	})
			$('#srchClsTBody').append(clsList.join(''))
		} else $('#srchClsTBody').append('<tr><td colspan="3" class="text-center">클래스가 존재하지 않습니다.</td></tr>')
	}).fail(() => {
		$('#srchClsTBody').html('')
		$('#srchClsTBody').append('<tr><td colspan="3" class="text-center">클래스를 조회하지 못했습니다.</td></tr>')
	})
}

/* 모달 내 클래스 검색 */ 
function srchClsList() {
	let srchOpt = $('#clsSrchOpt option:selected').val()
	let keyword = $('#srchClsModal #srchClsIn').val()
	searchData = {};
	if(srchOpt != 'srchCondition') {
		switch(srchOpt) {
		case "mainCtg" : searchData = {mainCtg: keyword}; break;
		case "subCtg" : searchData = {subCtg: keyword}; break;
		case "clsName" : searchData = {clsName: keyword}
		}
		$.ajax({
			url: '/godgamez/class/search',
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
						`<tr id='clsDetail' onclick='addCls(\${cls.clsId}, "\${cls.mainCtg} > \${cls.subCtg} > \${cls.clsName}")'>
			  				<td id='mainCtg'>\${cls.mainCtg}</td>
			  				<td id='subCtg'>\${cls.subCtg}</td>
			  				<td id='clsName'>\${cls.clsName}</td>
			  			</tr>`)
					})
				$('#srchClsTBody').append(clsList.join(''))
			} else {
				$('#srchClsTBody').html(
						'<tr><td colspan="3"><span class="text-danger font-weight-bold">' +
							'「' + keyword + '」</span>에 대한 검색결과가 없습니다.' +
						'</td></tr>')
			}
		}).fail( function() {
			$('#srchClsTBody').html('')
			$('#srchClsTBody').append('<tr><td colspan="3" class="text-center">클래스를 검색할 수 없습니다.</td></tr>')
		})
	} else if(srchOpt == 'srchCondition') $('#srchClsTBody').html('<tr><td colspan="3" class="text-center">검색 조건을 선택하세요.</td></tr>')
}

//퀘스트 추가 시 이미지 미리보기
let readerResult
function showImg(input) {
	if(input.files[0]) {
		let reader = new FileReader()
		reader.readAsDataURL(input.files[0])
		
		reader.addEventListener('load', () => {
			$('#previewImg').attr('src', reader.result)
			readerResult = reader.result
		}, false)
	}
}

//퀘스트 상세 조회 
let qstId //퀘스트 수정 시 사용
function qstDetail() {
	//$(event.currentTarget) //클릭한 요소 읽기(js)
	qstId = $(event.currentTarget).closest('.qstDetail').children('.qstId').text()
	$.ajax({
		url: `/godgamez/quest/list/\${qstId}`
	}).done(qst => {
		let qstName = qst.qstName
		let mainCtg = qst.cls.mainCtg
		let subCtg = qst.cls.subCtg
		let clsName = qst.cls.clsName
		let difficulty = qst.difficulty
		let qstContent = qst.qstContent
		if(!$('#qstChk:checked').length) {
			$('.modal-title').html()
			$('.modal-title').html('<b>퀘스트 상세조회 및 수정</b>')
			$('#addFixProcModal #qstName').val(qstName)
			$('#addFixProcModal #cls').siblings().remove()
			$('#addFixProcModal #cls').attr('class', 'text-center border-0')
			$('#addFixProcModal #cls').val(`\${mainCtg} > \${subCtg} > \${clsName}`)
			switch(difficulty) {
			case 1: $('#one').prop('checked', true); break;
			case 2: $('#two').prop('checked', true); break;
			case 3: $('#three').prop('checked', true); break;
			case 4: $('#four').prop('checked', true); break;
			case 5: $('#five').prop('checked', true);
			}
			$('#addFixProcModal #qstContent').val(qstContent)
			$('.modal-footer #chngBtn').text("수정")
			$('.modal-footer #chngBtn').attr('onclick', 'fixProcQst()')
			$('#addFixProcModal').modal()
			//퀘스트 이미지 불러오기
			$('#msg').html("100MB 이하의 JPG, PNG파일을 제출하세요.")
			$('#previewImg').attr('src', '/godgamez/res/quest/' + qst.qstId + '.jpg')
		} else modal('퀘스트', '상세조회', '실패10', '체크박스 해제 후 다시 시도하세요.')
	}).fail(() => modal('퀘스트', '상세조회', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
}

//퀘스트 수정
function fixProcQst() {
	let newQstName = $('#addFixProcModal #qstName').val()
	let newDifficulty = $('input[type="radio"]:checked').val()
	let newQstContent = $('#addFixProcModal #qstContent').val()
	let clsId = $('#addFixProcModal #clsId').val()
	questDataIn = {
		qstId: qstId,
		qstName: newQstName,
		difficulty: newDifficulty,
		qstContent: newQstContent,
		qstImg: clsId + '_' + newQstName
	}
	$.ajax({
		url: '/godgamez/quest/fix',
		method: 'put',
		data: JSON.stringify(questDataIn),
		contentType: 'application/json'
	}).done(result => {
		if(result) {
			if($('#addFixQstImg img').attr('src') == readerResult) { //cf) 322번째 줄 코드
				$('#curQstId').val(qstId.trim())
				// 퀘스트 수정 시 이미지파일 덮어쓰기
				let form = $('#addFixQstImg')[0] //form DOM element
				let formData = new FormData(form)
				$.ajax({
					url: '/godgamez/quest/attach',
					method: 'post',
					data: formData,
					contentType: false, //false로 둘 경우, multipart/form-data로 전송됨
					processData: false //false로 둘 경우, formData를 String으로 변환하지 않음
				})
				modal('퀘스트', '수정', '성공')
				$('#doneBBtn').click(() => window.location.reload())
			}
			modal('퀘스트', '수정', '성공')
			$('#doneBBtn').click(() => window.location.reload())
		} else modal('퀘스트', '삭제', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
	}).fail(() => modal('퀘스트', '삭제', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
}

//퀘스트 삭제 - script.js 함수명 공통
function delB() {	
	let actpdQstCnt = $('#qstChk:checked').closest('.qstDetail').children('.actpdQstCnt').text().trim()
	let qstId = $('#qstChk:checked').closest('.qstDetail').children('.qstId').text().trim()
	if(actpdQstCnt == 0 || actpdQstCnt == 'undefined') {
		$.ajax({
			url: `/godgamez/quest/del/\${qstId}`,
			method: 'delete'
		}).done(result => {
			if(result) {
				modal('퀘스트', '삭제', '성공')
				$('#doneBBtn').click(() => window.location.reload())
				
				//해당 퀘스트 이미지 삭제
				$.ajax({
					url: '/godgamez/quest/attach/del',
					method: 'delete',
					data: JSON.stringify(qstId),
					contentType: 'application/json'
				}).done(() => {
					console.log('del')
				})
				
			} else modal('퀘스트', '삭제', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
		}).fail(() => modal('퀘스트', '삭제', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
	} else if(actpdQstCnt > 0) modal('퀘스트', '삭제', '실패10', '현재 해당 퀘스트를 수행 중인 회원이 존재합니다.')
	else modal('퀘스트', '삭제', '실패10', '체크박스를 1개만 선택하세요.')
}

/*
//회원퀘스트 리스트 - 수행 중, 수행 완료
function getUsrQsts() {
	$.ajax({
		url: '/godgamez/quest/userquest/list'
	}).done(usrqsts => {
		if(usrqsts.length) {
			$('#accpUsrQstBoard #usrQstList').empty()
			$('#doneUsrQstBoard #usrQstList').empty()
			let accpUsrQstList = []
			let doneUsrQstList = []
			let accpUsrQstCnt = 0
			let doneUsrQstCnt = 0
			$.each(usrqsts, (idx, usrqst) => {
				procStep = usrqst.procStep
				if(procStep != 'DONE') {
					accpUsrQstCnt++
					accpUsrQstList.unshift(
						`<tr class='qstDetail'>
							<td class='checkCol'><input type='checkbox' id='usrqstChk' name='check2'></td>
							<td id='modDate' name='accptdDate'>
								\${usrqst.modDate}
							</td>
							<td id='usrId' class='\${usrqst.usr.usrCode}'>
								\${usrqst.usr.usrId}
							</td>
							<td id='qstName' class='\${usrqst.qst.qstId}'>
								\${usrqst.qst.qstName}
							</td>
						</tr>`)
				} else {
					doneUsrQstCnt++
					doneUsrQstList.unshift(
						`<tr class='qstDetail'>
							<td class='checkCol'><input type='checkbox' id='usrqstChk' name='check3'></td>
							<td id='modDate' name='doneDate'>
								\${usrqst.modDate}
							</td>
							<td id='usrId' class='\${usrqst.usr.usrCode}'>
								\${usrqst.usr.usrId}
							</td>
							<td id='qstName' class='\${usrqst.qst.qstId}'>
								\${usrqst.qst.qstName}
							</td>
							<td id='handInImg'>
								\${usrqst.handInImg}
							</td>
						</tr>`)
				}
			})
			$('#doneUsrQstBoard #usrQstList').append(doneUsrQstList.join(''))
			$('#accpUsrQstBoard #usrQstList').append(accpUsrQstList.join(''))
			$('#accpUsrQstQty').text('수행 중인 퀘스트 : ' + accpUsrQstCnt + '건')
			$('#doneUsrQstQty').text('수행 완료 퀘스트 : ' + doneUsrQstCnt + '건')
		}
	})
}

//회원퀘스트 검색
function searchUsrQst() {
	let usrSrchDataVal = $('#usrQstSrchIn').val()
	let opt = $('#usrSrchOpt option:selected').val()
	let usrSrchData = {}
	if(usrSrchDataVal.length < 1 || opt == null) {
		modal('회원 퀘스트', '검색', '실패10', '조건을 선택하고 2글자 이상 입력하세요.')
	} else {
		switch(opt) {
		case "usrCode": usrSrchData = {usrCode: usrSrchDataVal}; break;
		case "usrId": usrSrchData = {usrId: usrSrchDataVal}; break;
		case "usrName": usrSrchData = {usrName: usrSrchDataVal}; break;
		case "nickname": usrSrchData = {nickname: usrSrchDataVal};
		}
		$.ajax({
			url: '/godgamez/user/findUsers',
			method: 'post',
			data: JSON.stringify(usrSrchData),
			contentType: 'application/json'
		}).done(users => {
			$('#accpUsrQstBoard #usrQstList').empty()
			$('#doneUsrQstBoard #usrQstList').empty()
			if(users.length) {
				$.each(users, (idx, user) => {
					let usrCode = user.usrCode
					$.ajax({
						url: '/godgamez/user/quest/list',
						method: 'post',
						data: JSON.stringify(usrCode),
						contentType: 'application/json'
					}).done(usrqsts => {
						if(usrqsts.length) {
							let accpUsrQstList = []
							let doneUsrQstList = []
							let accpUsrQstCnt = 0
							let doneUsrQstCnt = 0
							$.each(usrqsts, (idx, usrqst) => {
								procStep = usrqst.procStep
								if(procStep != 'DONE') {
									accpUsrQstCnt++;
									accpUsrQstList.unshift(
										`<tr class='qstDetail'>
											<td class='checkCol'><input type='checkbox' id='usrqstChk' name='check2'></td>
											<td id='modDate' name='accptdDate'>
												\${usrqst.modDate}
											</td>
											<td id='usrId' class='\${usrqst.usr.usrCode}'>
												\${usrqst.usr.usrId}
											</td>
											<td id='qstName' class='\${usrqst.qst.qstId}'>
												\${usrqst.qst.qstName}
											</td>
										</tr>`)
								} else {
									doneUsrQstCnt++;
									doneUsrQstList.unshift(
										`<tr class='qstDetail'>
											<td class='checkCol'><input type='checkbox' id='usrqstChk' name='check3'></td>
											<td id='modDate' name='doneDate'>
												\${usrqst.modDate}
											</td>
											<td id='usrId' class='\${usrqst.usr.usrCode}'>
												\${usrqst.usr.usrId}
											</td>
											<td id='qstName' class='\${usrqst.qst.qstId}'>
												\${usrqst.qst.qstName}
											</td>
											<td id='handInImg'>
												\${usrqst.handInImg}
											</td>
										</tr>`)
								}
							})
							$('#doneUsrQstBoard #usrQstList').append(doneUsrQstList.join(''))
							$('#accpUsrQstBoard #usrQstList').append(accpUsrQstList.join(''))
							$('#accpUsrQstQty').text('수행 중인 퀘스트 : ' + accpUsrQstCnt + '건')
							$('#doneUsrQstQty').text('수행 완료 퀘스트 : ' + doneUsrQstCnt + '건')
						} 
					})	
				})
			} else {
				modal('회원 퀘스트', '검색', '실패10', '검색결과가 존재하지 않습니다.')
				$('#doneUsrQstBoard #usrQstList').html("<tr><td colspan='5'></td></tr>")
				$('#accpUsrQstBoard #usrQstList').html("<tr><td colspan='4'></td></tr>")
			}
		}).fail(() => modal('회원 퀘스트', '검색', '실패10', '입력값을 다시 확인하세요.'))
	}
}

//회원퀘스트(수행 중) - 완료버튼 클릭 시
function doUsrQst() {
	let userCode = $('input:checkbox[name="check2"]:checked').closest('tr').children('#usrId').attr('class')
	let questId = $('input:checkbox[name="check2"]:checked').closest('tr').children('#qstName').attr('class')
	if($('#usrqstChk:checked').length == 1) {
		$.ajax({
			url: '/godgamez/quest/userQuest/finishUserQuest',
			method: 'put',
			data: JSON.stringify({
				handInImg: userCode + '_' + questId,
				usr: {usrCode: userCode},
				qst: {qstId: questId}
			}),
			contentType: 'application/json'	
		}).done(result => {
			if(result) {
				modal('선택한 퀘스트', '완료', '성공')
				getUsrQsts()
			} else modal('선택한 퀘스트', '완료', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
		}).fail(() => modal('선택한 퀘스트', '완료', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
	} else modal('선택한 퀘스트', '완료', '실패10', '완료할 항목을 하나만 선택하세요.')
}

//회원퀘스트(수행 완료) - 사진삭제 버튼 클릭 시
function delUsrQstImg() {
	let userCode = $('input:checkbox[name="check3"]:checked').closest('tr').children('#usrId').attr('class')
	let questId = $('input:checkbox[name="check3"]:checked').closest('tr').children('#qstName').attr('class')
	if($('#usrqstChk:checked').length == 1) {
		$.ajax({
			url: '/godgamez/quest/userQuest/deleteUserQuestHandInImg',
			method: 'put',
			data: JSON.stringify({
				usr: {usrCode: userCode},
				qst: {qstId: questId}
			}),
			contentType: 'application/json'	
		}).done(result => {
			if(result)	{
				modal('사진 삭제', '완료', '성공')
				getUsrQsts()
			}
			else modal('사진 삭제', '완료', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
		}).fail(() => modal('사진 삭제', '완료', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
	} else modal('사진 삭제', '완료', '실패10', '사진 삭제할 항목을 하나만 선택하세요.')
}
*/

$(document).ready(function() {
	usrId = localStorage.getItem("usrId")
	usrPw = localStorage.getItem("usrPw")
	loginData = {usrId:usrId, usrPw:usrPw}
	
	$.ajax({
		url: "/godgamez/user/loginProc",
	    type: "POST",
	    contentType: "application/json",
	    data: JSON.stringify(loginData),
	    success: function(result) {
			if(result == 2) {
				getQsts('/godgamez/quest/list')
				$('#refreshBtn').click(() => {
					let navTab = $('#category').find('.active').text()
					if(navTab == '전체') getQsts("/godgamez/quest/list")
					else if(navTab == '공부') getQsts("/godgamez/quest/admin/study")
					else if(navTab == '운동') getQsts("/godgamez/quest/admin/exercise")
				})
				$('#srchQstBtn').click(() => {
					$('#allTab').attr('class', 'nav-link btn-outline-secondary active')
					$('#stdTab').attr('class', 'nav-link btn-outline-secondary')
					$('#excTab').attr('class', 'nav-link btn-outline-secondary')
					srchQstName()
				})
				$('#addQstBtn').click(() => {
					$('#addFixProcModal #cls').attr('class', 'col-9 border-0')
					$('#addFixProcModal #cls').siblings().remove()
					$('#addFixProcModal #div').append('<button type="button" class="col-2 btn border" id="srchClsBtn"><i class="fas fa-search float-right"></i></button>')
					$('.modal-footer #chngBtn').text("추가")
					$('.modal-footer #chngBtn').attr('onclick', 'addProcQst()')
					$('#srchClsBtn').click(() => {
						$('#clsSrchOpt').val('srchCondition').prop('selected', true) //select opt 초기화
						$('#srchClsModal #srchClsIn').val('')
						listCls()
						$('#srchClsModal').modal()
					})
					if($('#qstChk:checked').length) modal('퀘스트', '추가', '실패10', '체크박스 해제 후 다시 시도하세요.')
					else {
						$('.modal-title').html()
						$('.modal-title').html('<b>퀘스트 추가</b>')
						$('#addFixProcModal #qstName').val('')
						$('#addFixProcModal #cls').val('')
						$('input[type="radio"]').prop('checked', false) //체크해제
						$('#addFixProcModal #qstContent').val('')
						$('#msg').html('100MB 이하의 JPG, PNG파일을 제출하세요.')
						$('#previewImg').removeAttr('src')
						$('#addFixProcModal').modal()
					}
				})
				$('#fileBtn').change(function() {
					showImg(this)
				})
				getUsrQsts()
				$('#srchQstBtn').click(() => {
					$('#allTab').attr('class', 'nav-link btn-outline-secondary active')
					$('#stdTab').attr('class', 'nav-link btn-outline-secondary')
					$('#excTab').attr('class', 'nav-link btn-outline-secondary')
					srchQstName()
				})
			}// else modal('관리자페이지', '로딩', '실패6')
	    }
	})//.fail(() => modal('관리자페이지', '로딩', '실패6'))
})
</script>
<div class='h-100'>
	<%@ include file='../include/header.jsp' %>
	<div id='underHead' class='row w-100'>
	<%@ include file='../include/gnb.jsp' %>	
		<div class='col' id='adminBody'>
			<div class='row ml-1 mt-3'>
				<div class='col'>
					<div class='row justify-content-between mb-0'>
						<div class='mt-2'>
							<h5 class='font-weight-bold'>
								퀘스트 조회
								<button class='btn btn-sm small text-muted' id='refreshBtn'>
									<i class="fas fa-redo"></i>
								</button>
							</h5>
						</div>
						<div class='small text-muted'>
							<p></p>
							<p class='mr-3 mb-0 float-right'id='qstQty'></p>
						</div>
					</div><hr>
					<div class='row mt-1 mb-0 justify-content-between'>
						<div class='col-6 mb-0'>
							<nav class='nav nav-tabs' id='category'>
								<a class='nav-link active btn-outline-secondary' href='#qstBoard' data-toggle='tab'
									id='allTab' onclick='getQsts("/godgamez/quest/list")'>전체</a>
								<a class='nav-link btn-outline-secondary' href='#qstBoard' data-toggle='tab'
									id='stdTab' onclick='getQsts("/godgamez/quest/admin/study")'>공부</a>
								<a class='nav-link btn-outline-secondary' href='#qstBoard' data-toggle='tab'
									id='excTab' onclick='getQsts("/godgamez/quest/admin/exercise")'>운동</a>
							</nav>
						</div>
						<div class='col-5 mb-0 mr-3 float-right' id='qstSrch'>
							<div class='row'>
								<input type='text' class='form-control' placeholder='퀘스트명을 입력하세요.'>
								<button type='button' class='btn btn-secondary' id='srchQstBtn'>검색</button>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='tab-content'>
								<div class='tab-pane fade show active' id='qstBoard'>
									<div style="max-height:20rem; overflow-y:auto; overflow-x: hidden;">
										<table class='table table-sm table-hover table-secondary border mb-0 table-hover text-center'>
											<thead>
												<tr>
													<th class='checkCol'>
														<input type='checkbox' id='checkall1'/>
													</th>
													<th>ID</th>
													<th>퀘스트명</th>
													<th>클래스명</th>
													<th>수행 중</th>
												</tr>
											</thead>
											<tbody id='qstList'>
											</tbody>
										</table>
									</div>
									<div class='row mt-0'>
										<div class='col-6 d-flex justify-content-start h-25'>
											<button type='button' id='delQstBtn' class='btn btn-outline-secondary' 
												onClick='isChecked("퀘스트", "삭제" ,"qstChk")'>삭제</button>
										</div>	
										<div class='col-6 d-flex justify-content-end h-25'>
											<button type='button' id='addQstBtn' class='btn btn-secondary'>추가</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='col'>
					<div class='row justify-content-between mb-0'>
						<div class='mt-2'>
							<h5 class='font-weight-bold'>
								회원 퀘스트
								<button class='btn btn-sm small text-muted' id='refreshBtn2' onclick='getUsrQsts()'>
									<i class="fas fa-redo"></i>
								</button>
							</h5>
						</div>
						<div class='small text-muted'>
							<p class='mr-3 mb-0 float-right'id='accpUsrQstQty'></p><br>
							<p class='mr-3 mb-0 float-right'id='doneUsrQstQty'></p>
						</div>
					</div>
					<hr>
					<div class='row mt-1 mb-0 justify-content-between'>
						<div class='col-5 mb-0'>
							<nav class='nav nav-tabs' id='category2'>
								<a id='acceptedUsrQst' data-toggle='tab' href='#accpUsrQstBoard' class='nav-link active btn-outline-secondary'>수행 중</a>
								<a id='doneUsrQst' data-toggle='tab' href='#doneUsrQstBoard' class='nav-link btn-outline-secondary'>수행 완료</a>
							</nav>
						</div>
						<div class='col-6 mb-0 mr-3' id='usrQstSrch'>
							<div class='row'>
								<select class="form-select w-25" aria-label="usrSrchOpt" id="usrSrchOpt">
									<option selected disabled>검색 조건</option>
									<option value="usrCode">코드</option>
									<option value="usrId">ID</option>
									<option value="usrName">이름</option>
									<option value="nickname">별명</option>
								</select>
								<input type='text' class='form-control w-50' placeholder='회원 정보를 2글자 이상 입력하세요.' id='usrQstSrchIn'>
								<button type='button' class='btn btn-secondary w-25' id='usrQstSrchBtn' onclick='searchUsrQst()'>검색</button>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='tab-content'>
								<div class='tab-pane fade show active' id='accpUsrQstBoard'>
									<div style="max-height:20rem; overflow-y:auto; overflow-x: hidden;">
										<table class='table table-sm table-hover table-secondary border mb-0 table-hover text-center'>
											<thead>
												<tr>
													<th class='checkCol'>
														<input type='checkbox' id='checkall2'/>
													</th>
													<th>수락일</th>
													<th>회원ID</th>
													<th>퀘스트명</th>
												</tr>
											</thead>
											<tbody id='usrQstList'>
											</tbody>
										</table>
									</div>
									<div class='row mt-0'>
										<div class='col-3 d-flex justify-content-start h-25'>
											<button type='button' id='doUsrQstBtn' class='btn btn-outline-secondary' onClick='doUsrQst()'>
												완료
											</button>
										</div>
									</div>
								</div>
								<div class='tab-pane fade show' id='doneUsrQstBoard'>
									<div style="max-height:20rem; overflow-y:auto; overflow-x: hidden;">
										<table class='table table-sm table-hover table-secondary border text-nowrap mb-0 text-center'>
											<thead>
												<tr>
													<th class='checkCol'>
														<input type='checkbox' id='checkall3'/>
													</th>
													<th>완료일</th>
													<th>회원ID</th>
													<th>퀘스트명</th>
													<th>제출사진</th>
												</tr>
											</thead>
											<tbody id='usrQstList'>
											</tbody>
										</table>
									</div>
									<div class='row mt-0' id='paginationDiv'>
										<div class='col-3 d-flex justify-content-start h-25'>
											<button type='button' id='delUsrQstImgBtn' class='btn btn-secondary' onClick='delUsrQstImg()'>
												사진 삭제
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
	</div>
</div>
<div id='addFixProcModal' class='modal fade' tabindex='-2'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h6 class='modal-title'></h6>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>
			<form class='modal-body' id='addFixQstImg'>
				<div class='contatiner ml-3 mb-3' id='modalTable'>
					<div class='row'>
						<div class='col'>
							<table>
								<tbody>
									<tr>
										<th></th>
										<td><input type='hidden' id='curQstId' name='curQstId'/></td>
									</tr>
									<tr>
										<th>퀘스트명</th>
										<td>
											<input type='text' placeholder='2글자 이상의 한글로 입력하세요.'
												class='text-center form-control' id='qstName' name='qstName'/>
										</td>
									</tr>
									<tr>
										<th>클래스</th>
										<td>
											<input type='text' id='clsId' hidden='true'/>
											<div id='div' class='text-center form-control'>
												<input type='text' class='border-0' placeholder='1개의 클래스를 선택하세요' id='cls' readonly/>
												<button type='button' class='btn border float-right' id='srchClsBtn'>
													<i class="fas fa-search float-center"></i>
												</button>
											</div>
										</td>
									</tr>
									<tr height='5rem'></tr>
									<tr>
										<th>난이도</th>
										<td>
											<input type='radio' id='one' name='difficulty' class='ml-3' value='1'/>1
											<input type='radio' id='two' name='difficulty' class='ml-3' value='2'/>2
											<input type='radio' id='three' name='difficulty' class='ml-3' value='3'/>3
											<input type='radio' id='four' name='difficulty' class='ml-3' value='4'/>4
											<input type='radio' id='five' name='difficulty' class='ml-3' value='5'/>5
										</td>
									</tr>
									<tr height='5rem'></tr>
									<tr>
										<th>퀘스트 내용</th>
										<td>
											<input type='text' placeholder='50글자 이하의 한글로 입력하세요.'
												class='text-center form-control' id='qstContent'/>
										</td>
									</tr>
									<tr height='5rem'></tr>
									<tr>
										<th rowspan='5'>이미지</th>
										<td>
											<span class='text-muted' id='msg'>
												100MB 이하의 JPG, PNG파일을 제출하세요.
											</span>
										</td>
									</tr>
									<tr height='5rem'></tr>
									<tr>
										<td>
											<input type='file' name='attachFile' id='fileBtn' accept='.jpg, .png'/>
										</td>
									</tr>	
									<tr height='5rem'></tr>
									<tr>
										<td>
											<img id='previewImg' class='w-100 m-0' alt='이미지가 존재하지 않습니다.'/>
										</td>
									</tr>											
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class='modal-footer justify-content-center'>
					<button type='button' class='btn btn-outline-secondary' onClick='modal("퀘스트", "추가", "중단")'>취소</button>
					<button type='button' id='chngBtn' class='btn btn-outline-secondary' onClick='addProcQst()'>추가</button>
				</div>
			</form>
		</div>
	</div>
</div>
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
					<input type='text' class='form-control ml-3 w-50' id='srchClsIn' placeholder='2글자 이상 입력하세요' oninput='srchClsList()'>
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