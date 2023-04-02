<title>갓겜:클래스관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>
<style>
#searchCls select {
	height: 2.5rem;
	width: 22%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}
#searchCls input {
	height: 2.5rem;
	width: 62%;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
#searchCls button {
	height: 2.5rem;
	width: 16%;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
#allClsBoard table thead,
#stdClsBoard table thead,
#excClsBoard table thead {
	border-top: 0.1rem solid;
	border-color: secondary;
}
#addClsBtn,
#delClsBtn  {
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	width: 4rem;
}
</style>
<script>
//클래스 목록 조회
function getClss(address) {
	$('#allClsTBody').empty()
	$.ajax({
		url: address
	}).done(clss => {
		if(clss.length) {
			let clsList = []
			let useQstCnt
			$.each(clss, (idx, cls) => {
				//클래스 - 사용퀘스트
				$.ajax({
					url: '/godgamez.selfdevelopment/class/getInUseCls',
					async: false,
					data: {clsId: cls.clsId}
				}).done(cls => useQstCnt = cls.length)
				clsList.push(
					`<tr id='clsDetail'>
		  				<td><input type='checkbox' id='clsChk' name='check1' value='\${cls.clsId}'></td>
		  				<td id='clsId'>\${cls.clsId}</td>
		  				<td id='mainCtg'>\${cls.mainCtg}</td>
		  				<td id='subCtg'>\${cls.subCtg}</td>
		  				<td id='clsName'>\${cls.clsName}</td>
		  				<td id='useQstCnt'>\${useQstCnt}</td>
		  			</tr>`)
				})
			$('#clsQty').text('총 ' + clss.length + '건')
			$('#allClsTBody').append(clsList.join(''))
		} else
			$('#allClsTBody').append('<tr><td colspan="6" class="text-center">클래스가 존재하지 않습니다.</td></tr>')
	}).fail(() => $('#allClsTBody').append('<tr><td colspan="6" class="text-center">클래스를 조회하지 못했습니다.</td></tr>'))
}

//클래스 검색
function searchClass() {
	let srchOpt = $('#clsSrchOpt option:selected').val()
	let keyword = $('#searchCls #srchClsIn').val()
	searchData = {}
	if(srchOpt != null) {
		switch(srchOpt) {
		case "mainCtg" : searchData = {mainCtg: keyword}; break;
		case "subCtg" : searchData = {subCtg: keyword}; break;
		case "clsName" : searchData = {clsName: keyword};
		}
		if(keyword.length > 1) {
			$('#allClsTBody').empty()
			$.ajax({
				url: '/godgamez.selfdevelopment/class/search',
				method: 'post',
				data: JSON.stringify(searchData),
				contentType: 'application/json'
			}).done(clss => {
				if(clss.length) {
					let clsList = []
					let useQstCnt
					$.each(clss, (idx, cls) => {
						//클래스 - 사용퀘스트
						$.ajax({
							url: '/godgamez.selfdevelopment/class/getInUseCls',
							async: false,
							data: {clsId: cls.clsId}
						}).done(cls => useQstCnt = cls.length)
						clsList.push(
							`<tr id='clsDetail'>
				  				<td><input type='checkbox' id='clsChk' name='check1' value='\${cls.clsId}'></td>
				  				<td id='clsId'>\${cls.clsId}</td>
				  				<td id='mainCtg'>\${cls.mainCtg}</td>
				  				<td id='subCtg'>\${cls.subCtg}</td>
				  				<td id='clsName'>\${cls.clsName}</td>
				  				<td id='useQstCnt'>\${useQstCnt}</td>
				  			</tr>`)
						})
					$('#clsQty').text('총 ' + clss.length + '건')
					$('#allClsTBody').append(clsList.join(''))
				} else
					$('#allClsTBody').append('<tr><td colspan="6" class="text-center">검색된 클래스가 없습니다.</td></tr>')
			}).fail(() => $('#allClsTBody').append('<tr><td colspan="6" class="text-center">클래스를 검색할 수 없습니다</td></tr>'))
		} else modal("클래스", "검색", "실패10", "2글자 이상 입력하세요.")
	} else modal("클래스", "검색", "실패10", "검색 조건을 선택하세요.")
}

//클래스 추가
function addProcCls() {
	let mainCategory = $('input[type="radio"]:checked').val()
	let subCategory = $('#addProcModal #subCtg').val()
	let className = $('#addProcModal #clsName').val()
	$.ajax({
		url: '/godgamez.selfdevelopment/class/add',
		method: 'post',
		data: JSON.stringify({
			clsId: 0,
			mainCtg: mainCategory,
			subCtg: subCategory,
			clsName: className
		}),
		contentType: 'application/json'
	}).done(result => {
		if(result) modal('클래스', '추가', '성공')
		else modal('클래스', '추가', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
	}).fail(() => modal('클래스', '추가', '실패10', '대분류, 중분류, 클래스명을 확인하세요.'))
}

//클래스 삭제 - script.js 함수명 공통
function delB() {
	let useQstCnt = $('#clsChk:checked').closest('#clsDetail').children('#useQstCnt').text()
	if(useQstCnt == 0) {
		$.ajax({
			url: `/godgamez.selfdevelopment/class/del/\${$('#clsChk:checked').closest('#clsDetail').children('#clsId').text()}`,
			method: 'delete'
		}).done(result => {
			if(result) {
				$(modal('클래스', '삭제', '성공'))
				$('#doneBBtn').click(() => window.location.reload())
			} else modal('클래스', '삭제', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.')
		}).fail(() => modal('클래스', '삭제', '실패10', '체크박스를 1개만 선택하세요.'))
	} else if(useQstCnt > 0) modal('클래스', '삭제', '실패10', '현재 해당 클래스와 연결 된 퀘스트가 존재합니다.')
	else modal('클래스', '삭제', '실패10', '체크박스를 1개만 선택하세요.')
}

$(() => {
	$.ajax({
		url: '/godgamez.selfdevelopment/quest/loginUsr',
	}).done(user => {
		if(user.usrCode == 2) {
			getClss('/godgamez.selfdevelopment/class/list')
			$('#refreshBtn').click(() => {
				let navTab = $('#category').find('.active').text()
				if(navTab == '전체') getClss("/godgamez.selfdevelopment/class/list")
				else if(navTab == '공부') getClss("/godgamez.selfdevelopment/class/list/study")
				else if(navTab == '운동') getClss("/godgamez.selfdevelopment/class/list/exercise")
				$('#clsSrchOpt').val('srchCondition').prop('selected', true)
				$('#srchClsIn').val('')
			})
			$('#addClsBtn').click(() => {
				if($('#clsChk:checked').length) modal('클래스', '추가', '실패10', '체크박스 해제 후 다시 시도하세요.')
				else {
					$('input[type="radio"]').prop('checked', false)
					$('#addProcModal #subCtg').val('')
					$('#addProcModal #clsName').val('')
					$('#addProcModal').modal()
				}
			})
			$('#srchClsBtn').click(() => {
				$('#allTab').attr('class', 'nav-link btn-outline-secondary active')
				$('#stdTab').attr('class', 'nav-link btn-outline-secondary')
				$('#excTab').attr('class', 'nav-link btn-outline-secondary')
				searchClass()
			})
		} else modal('관리자페이지', '로딩', '실패6')
	}).fail(() => modal('관리자페이지', '로딩', '실패6'))
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
								클래스 조회
								<button class='btn btn-sm small text-muted' id='refreshBtn'>
									<i class="fas fa-redo"></i>
								</button>
							</h5>
						</div>
						<div class='small text-muted'>
							<p></p>
							<p class='mr-3 mb-0 float-right'id='clsQty'></p>
						</div>
					</div><hr>
					
					<div class='row mt-1 justify-content-between'>
						<div class='col-5 mb-0'>
							<nav class='nav nav-tabs' id='category'>
								<a class='nav-link btn-outline-secondary active' data-toggle='tab' href='#allClsBoard'
									id='allTab' onclick='getClss("/godgamez.selfdevelopment/class/list")'>전체</a>
								<a class='nav-link btn-outline-secondary' data-toggle='tab' href='#allClsBoard'
									id='stdTab' onclick='getClss("/godgamez.selfdevelopment/class/list/study")'>공부</a>
								<a class='nav-link btn-outline-secondary' data-toggle='tab' href='#allClsBoard'
									id='excTab' onclick='getClss("/godgamez.selfdevelopment/class/list/exercise")'>운동</a>
							</nav>
						</div>
						<div class='col-6 mr-3 mb-0' id='searchCls'>
							<div class='row'>
								<select class="form-select w-25" aria-label="clsSrchOpt" id='clsSrchOpt' required>
									<option value='srchCondition' selected disabled>검색 조건</option>
									<option value='mainCtg'>대분류</option>
									<option value='subCtg'>중분류</option>
									<option value='clsName'>이름</option>
								</select>
								<input type='text' class='form-control w-50' maxlength='10' id='srchClsIn' placeholder='2글자 이상 입력하세요.'> 
								<button type='button' class='btn btn-secondary w-25' id='srchClsBtn'>검색</button>
							</div>
						</div>
					</div>
					<div class='row' id='clsTable'>
						<div class='col'>
							<div class='tab-content'>
								<div class='tab-pane fade show active' id='allClsBoard'>
									<div style="max-height:20rem; overflow-y:auto; overflow-x: hidden;">
										<table class='table table-sm table-secondary border mb-0 table-hover text-center'>
											<thead>
												<tr>
													<th id='checkCol'><input type='checkbox' id='checkall1'/></th>
										   			<th id='clsId'>클래스ID</th>
										     		<th id='mainCtg'>대분류</th>
										     		<th id='subCtg'>중분류</th>
										     		<th id='clsName'>이름</th>
										     		<th id='useQstCnt'>사용퀘스트</th>
											    </tr>
											</thead>
											<tbody id='allClsTBody'>
									  		</tbody>
										</table>
									</div>
									<div class='row mt-0'>
										<div class='col-6 d-flex justify-content-start h-25'>
											<button type='button' id='delClsBtn' class='btn btn-outline-secondary' 
												onClick='isChecked("클래스", "삭제" ,"clsChk")'>삭제</button>
										</div>	
										<div class='col-6 d-flex justify-content-end h-25'>
											<button type='button' id='addClsBtn' class='btn btn-secondary'>추가</button>
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
<div id='addProcModal' class='modal fade' tabindex='-2'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h6 class='modal-title'></h6>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>
			<div class='contatiner ml-3' id='modalTable'>
				<div class='row'>
					<div class='col'>
						<table class='w-100'>
							<tbody>
								<tr>
									<th>대분류</th>
									<td>
										<input type='radio' value='공부' class='text-center ml-3' name='mainCtg' readonly/>공부
										<input type='radio' value='운동' class='text-center ml-3' name='mainCtg' readonly/>운동
									</td>
								</tr>
								<tr>
									<th>중분류</th>
									<td>
										<input type='text' placeholder='2글자 이상의 한글로 입력하세요.'
											class='text-center form-control w-75 ml-3' id='subCtg'/>
									</td>
								</tr>
								<tr>
									<th>클래스명</th>
									<td>
										<input type='text' placeholder='2글자 이상의 한글로 입력하세요.'
											class='text-center form-control w-75 ml-3' id='clsName'/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class='modal-footer justify-content-center'>
				<button type='button' class='btn btn-outline-secondary' onClick='modal("클래스", "추가", "중단")'>취소</button>
				<button type='button' class='btn btn-outline-secondary' onClick='addProcCls()'>추가</button>
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