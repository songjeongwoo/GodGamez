<title>갓겜:쿠폰 관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>

<style>
#title{
	margin-top:3rem;
	font-size:20;
}

.page-link {
	color: black;
}

#previewImg {
	background-color: #e9e9e9;
	margin:1rem;
	width:25rem;
	height: 20rem;
}

#idSch button {
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

#idSch input {
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}

#idSch2 button[class *= 'outline'] {
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}

#idSch2 input {
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
}

#usedCpnBtn, #nUsedCpnBtn {
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

@media (max-width: 768px) {
	#adminGnb {
		height: calc(100% + 75rem);
	}
}
</style>

<script>
$(document).ready(function() {
	$(getNUsedCpns);
	$(getUsedCpns);
})
//쿠폰 발급
/*
function addCoupon() {
	
}
*/

//쿠폰 사용처리(미완)
/*
function useCoupon() {
	checked = $("#cpnDetail #checkCpn:checked").length;
	
	if(checked != 0) {
		cpnCode = parseInt($("#cpnDetail #checkCpn:checked").closest('#cpnDetail').children('#cpnCode').text());
		
		//쿠폰 코드로 쿠폰 객체 생성하기
		$.ajax({
			url: '/godgamez.selfdevelopment/coupon/get',
			method: 'get',
			data: cpnCode,
		}).done(cpn => {
			if(cpn != null)
				return this;
			else console.log("선택한 쿠폰이 존재하지 않습니다.")
		})
		
		
		cpnData = {
			cpnCode: coupon.cpnCode,
			usrCode: coupon.usrCode,
			availability: coupon.availability,
			store: coupon.store,
			dcPer: coupon.dcPer
		};
		
		$.ajax({
	        url: '/godgamez.selfdevelopment/useCoupon',
	        type: 'PUT',
	        contentType: "application/json",
	        data: JSON.stringify(cpnData),
	        success: function(result) {
	        	if(result) {
	        		console.log(result);
	        		console.log("성공")
	        	} else
	        		modal("쿠폰 사용", "실패10", "쿠폰 사용 실패하였습니다.")
	        }
	  	});
	}
}
*/

//미사용 쿠폰
function getNUsedCpns() {
	$('#nUsedCpn').empty()
	
	$.ajax('/godgamez.selfdevelopment/coupon/listNUsed').done(cpns => {
		if(cpns.length) {
			let cpnList = [];
			
			$.each(cpns, (idx, cpn) => {
				cpnList.push(
						`<tr id='cpnDetail'>
								<td id='checkCol'><input type='checkbox' name='check1' id='checkCpn'/></td>
								<td id='cpnCode'>\${cpn.cpnCode}</td>
								<td id='usrId'>\${cpn.usrCode}</td>
								<td id='store'>\${cpn.store}</td>
								<td id='availabilty'>\${cpn.availability}</td>
							</tr>`
						)
				});
			
			$('#nUsedCpn').append(cpnList.join(''));
			
			avail = $('#nUsedCpn').children('#cpnDetail').children('#availabilty').text();
			
			if(avail.charAt(0) == 1) {
				$('#nUsedCpn').children('#cpnDetail').children('#availabilty').text("사용가능")
			} else if (avail.charAt(0) == 0) {
				$('#nUsedCpn').children('#cpnDetail').children('#availabilty').text("사용완료")
			};
			
		} else
			$('#nUsedCpn').append('<tr><td colspan=4 class=text-center>쿠폰이 없습니다.</td></tr>');
	}).fail(() => {
		$('#nUsedCpn').append('<tr><td colspan=4 class=text-center>쿠폰을 조회하지 못했습니다.</td></tr>');
	});
}

//사용완료 쿠폰
function getUsedCpns() {
	$('#usedCpn').empty()
	
	$.ajax('/godgamez.selfdevelopment/coupon/listUsed').done(cpns => {
		if(cpns.length) {
			let cpnList = [];
			
			$.each(cpns, (idx, cpn) => {
				cpnList.push(
						`<tr id='cpnDetail'>
								<td id='cpnCode'>\${cpn.cpnCode}</td>
								<td id='usrId'>\${cpn.usrCode}</td>
								<td id='store'>\${cpn.store}</td>
								<td id='availabilty'>\${cpn.availability}</td>
							</tr>`
						)
				});
			
			$('#usedCpn').append(cpnList.join(''));
			
			avail = $('#usedCpn').children('#cpnDetail').children('#availabilty').text();
			
			if(avail.charAt(0) == 1) {
				$('#usedCpn').children('#cpnDetail').children('#availabilty').text("사용가능")
			} else if (avail.charAt(0) == 0) {
				$('#usedCpn').children('#cpnDetail').children('#availabilty').text("사용완료")
			};
			
		} else
			$('#usedCpn').append('<tr><td colspan=4 class=text-center>쿠폰이 없습니다.</td></tr>');
	}).fail(() => {
		$('#usedCpn').append('<tr><td colspan=4 class=text-center>쿠폰을 조회하지 못했습니다.</td></tr>');
	});
}

function search() {
	var k = $("#schBar").val();
	$("#cpnDetail").closest("#nUsedCpn").children("#cpnDetail").hide();
	val = $("#cpnCode:contains('" + k + "')");
	console.log(val);
	var temp = $("#cpnDetail:contains('" + val + "')")
	console.log(temp);
	$(temp).show();
	
	//if(temp.val == null) {
	//	$("#nUsedCpn").append('<tr><td colspan=4 class=text-center>검색 결과가 없습니다.</td></tr>');
	//}
}

function onSchBtn() {
	if($('#schBar').val().length >= 2)
	      $('#schBtn').removeAttr('disabled');
	   else
	      $('#schBtn').attr('disabled', true);
}

function onSchBtn2() {
	if($('#schBar2').val().length >= 2)
	      $('#schBtn2').removeAttr('disabled');
	   else
	      $('#schBtn2').attr('disabled', true);
}

function radioUncheck() {
	$("input:radio[name='select']").prop('checked', false);
	$("input:radio[name='user']").prop('checked', false);
}

//회원검색
function searchUsrCpn() {
	let usrSrchDataVal = $('#schBar2').val()
	let opt = $('#usrSrchOpt option:selected').val()
	let usrSrchData = {}
	if(usrSrchDataVal.length < 1 || opt == 'srchCondition') {
		modal('회원', '검색', '실패10', '조건을 선택하고 2글자 이상 입력하세요.')
	} else {
		switch(opt) {
		case "usrCode": usrSrchData = {usrCode: usrSrchDataVal}; break;
		case "usrId": usrSrchData = {usrId: usrSrchDataVal}; break;
		case "usrName": usrSrchData = {usrName: usrSrchDataVal}; break;
		case "nickname": usrSrchData = {nickname: usrSrchDataVal};
		}
		$.ajax({
			url: '/godgamez.selfdevelopment/user/findUsers',
			method: 'post',
			data: JSON.stringify(usrSrchData),
			contentType: 'application/json'
		}).done(users => {
			console.log(users)
			$('#srchUsr').empty()
			if(users.length) {
				let usrCpnList = []
				$.each(users, (idx, user) => {
					usrCpnList.unshift(
						`<tr id='pickUsr'>
							<td><input type='radio' id='checkUser' name='user'/></td>
							<td id='usrId'>\${user.usrId}</td>
							<td id='usrLv'>\${user.usrLv}</td>
							<td id='usrGold'>\${user.gold}</td>
						</tr>`)
				})
				$('#srchUsr').append(usrCpnList.join(''))
			} else $('#srchUsr').html("<tr><td colspan='4'>해당 회원이 존재하지 않습니다.</td></tr>")
		}).fail(() => modal('회원', '조회', '실패10', '알 수 없는 이유로 해당 작업에 실패했습니다.'))
	}
}
</script>

<div class='h-100'>
	<%@ include file='../include/header.jsp' %>
	<div id='underHead' class='row w-100'>
	<%@ include file='../include/gnb.jsp' %>
		<div class='col' id='adminBody'>
			<div class='row'>
				<div class='col'>
					<div class='row'>
						<div class='col'>
							<div id='title'>
								<h4>발급 쿠폰 목록</h4><hr>
							</div>
						</div>
					</div>
					<div class='row justify-content-between'>
						<div class='col-6 mb-0'>
							<nav class='nav nav-tabs justify-content-start'>
								<a id='nUsedCpnBtn' class='nav-link btn btn-outline-secondary active' data-toggle='tab' href='#nUsedCpnBoard' onclick='getNUsedCpns()'>미사용</a>
								<a id='usedCpnBtn' class='nav-link btn btn-outline-secondary' data-toggle='tab' href='#UsedCpnBoard'onclick='getUsedCpns()'>사용완료</a>
							</nav>
						</div>
						<form class='col-6 mb-0' id='idSch'>
							<div class='row float-right mr-0'>
								<input type='text' class='form-control w-75' placeholder='회원의 ID를 입력하세요.' id='schBar' title="2글자 이상 입력하세요." oninput='onSchBtn()'/>
								<button type='button' class='btn btn-outline-secondary' id='schBtn' disabled onclick='search()'>검 색</button>
							</div>
						</form>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='tab-content'>
								<div class='tab-pane fade show active' id='nUsedCpnBoard'>
									<table class='table table-sm table-secondary table-hover text-center'>
										<thead>
											<tr>
												<th id='checkCol'><input type='checkbox' id='checkall1'></th>
												<th width='15%'>쿠폰코드</th>
												<th width='35%'>보유자 ID</th>
												<th width='22%'>사용처</th>
												<th width='22%'>사용여부</th>
											</tr>
										</thead>
										<tbody id='nUsedCpn'>
											<tr id='cpnDetail'>
												<th id='checkCol'><input type='checkbox' name='check1' id='checkCpn'/></th>
												<td id='cpnCode'></td>
												<td id='usrId'></td>
												<td id='store'></td>
												<td></td>
											</tr>
										</tbody>
									</table>
									<div class='row justify-content-between'>
										<div class='col-4'>
											&nbsp;
										</div>
										<div class='col-4'>
											<ul class='pagination justify-content-center'>
												<li class="page-item"><a class="page-link border-0" href="#">&laquo;</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">1</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">2</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">3</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">4</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">5</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">&raquo;</a></li>
											</ul>
										</div>
										<div class='col-4'>
											<button type="button" class="btn btn-secondary float-right"
												id='useComplete' onclick="useCoupon()">
												사용&nbsp;<i class="fas fa-check"></i>
											</button>
										</div>
									</div>
								</div>
								<div class='tab-pane fade' id='UsedCpnBoard'>
									<table class='table table-sm table-secondary text-center'>
										<thead>
											<tr>
												<th width='15%'>쿠폰코드</th>
												<th width='35%'>보유자 ID</th>
												<th width='30%'>사용처</th>
												<th width='20%'>사용여부</th>
											</tr>
										</thead>
										<tbody id='usedCpn'>
											<tr id='cpnDetail'>
												<td id='cpnCode'></td>
												<td id='usrId'></td>
												<td id='store'></td>
												<td></td>
											</tr>
										</tbody>
									</table>
									<div class='row justify-content-between'>
										<div class='col-4'>
											&nbsp;
										</div>
										<div class='col-4'>
											<ul class='pagination justify-content-center'>
												<li class="page-item"><a class="page-link border-0" href="#">&laquo;</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">1</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">2</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">3</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">4</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">5</a></li>
												<li class="page-item"><a class="page-link border-0" href="#">&raquo;</a></li>
											</ul>
										</div>
										<div class='col-4'>
											&nbsp;
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 쿠폰 설정 및 발급 -->
				<div class='col'>
					<div id='title'>
						<h4>쿠폰 발급</h4><hr>
					</div>
					<div class='row'>
						<div class='col'>
							<table class='table table-secondary table-hover text-center border my-0' id='cpnSetting'>
								<thead>
									<tr>
										<th>사용처</th>
										<th>할인율(%)</th>
										<th>레벨 제한</th>
										<th>필요 골드</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody>
									<tr id='10'>
										<td rowspan='3'>서점</td>
										<td id='dcPer'>10</td>
										<td id='usrLv'>10</td>
										<td id='gold'>1</td>
										<td><input type='radio' id='selectCpn' value='BOOKSTORE' name='select'/></td>
									</tr>
									<tr id='20'>
										<td id='dcPer'>20</td>
										<td id='usrLv'>20</td>
										<td id='gold'>2</td>
										<td><input type='radio' id='selectCpn' value='BOOKSTORE' name='select'/></td>
									</tr>
									<tr id='30'>
										<td id='dcPer'>30</td>
										<td id='usrLv'>30</td>
										<td id='gold'>3</td>
										<td><input type='radio' id='selectCpn' value='BOOKSTORE' name='select'/></td>
									</tr>
								</tbody>
							</table>
							<table class='table table-secondary table-hover text-center border my-0' id='cpnSetting'>
								<tbody>
									<tr>
										<td rowspan='3'>인터넷<br>강의</td>
										<td>10</td>
										<td>10</td>
										<td>1</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
									<tr>
										<td>20</td>
										<td>20</td>
										<td>2</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
									<tr>
										<td>30</td>
										<td>30</td>
										<td>3</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
								</tbody>
							</table>
							<table class='table table-secondary table-hover text-center border my-0' id='cpnSetting'>
								<tbody>
									<tr>
										<td rowspan='3'>스포츠샵</td>
										<td>10</td>
										<td>10</td>
										<td>1</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
									<tr>
										<td>20</td>
										<td>20</td>
										<td>2</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
									<tr>
										<td>30</td>
										<td>30</td>
										<td>3</td>
										<td><input type='radio' id='selectCpn' name='select'/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<p class='mt-3'>상단에서 발급하기 원하는 쿠폰을 선택하고 아래에 발급 대상의 ID를 적어주세요<br>
									검색된 회원 중 원하는 대상을 1명 선택하여 발급 버튼을 누르세요.</p>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='row'>
								<div class='col-6 d-flex justify-content-start' id='idSch2'>
									<select class="form-select w-25" aria-label="usrSrchOpt" id='usrSrchOpt'>
										<option selected value="srchCondition" disabled>검색 조건</option>
										<option value="usrCode">코드</option>
										<option value="usrId">ID</option>
										<option value="usrName">이름</option>
										<option value="nickname">별명</option>
									</select>
									<input type='text' class='form-control w-50' placeholder='2글자 이상 입력하세요.' id='schBar2' title="2글자 이상 입력하세요." oninput='onSchBtn2()'/>
									<button type='button' class='btn btn-outline-secondary w-25' id='schBtn2' onclick='searchUsrCpn()' disabled>검색</button>
								</div>
								<div class='col-6 d-flex justify-content-end text-nowrap'>	
									<button type='button' class='btn btn-secondary ml-3'
										onclick='isRadioChecked("쿠폰", "발급", "cpnSetting #selectCpn", "srchUsr #checkUser")'>쿠폰 발급</button>
									<button type='button' class='btn btn-secondary ml-3' onclick='radioUncheck()'>선택 해제</button>
								</div>
							</div>
							<div class='row'>
								<div class='col'>
									<table class='m-1 table table-sm table-secondary table-hover text-center'>
										<thead>
											<tr>
												<th id='checkCol'></th>
												<td width='50%'>회원 ID</td>
												<td>레벨</td>
												<td>보유 골드</td>
											</tr>
										</thead>
										<tbody id='srchUsr'>
											<tr id='pickUsr'>
												<td><input type='radio' id='checkUser' name='user'/></td>
												<td id='usrId'>aaa@email.com</td>
												<td id='usrLv'>1</td>
												<td id='usrGold'>0</td>
											</tr>
											<tr>
												<td><input type='radio' id='checkUser' name='user'/></td>
												<td>awekh@email.com</td>
												<td>20</td>
												<td>0</td>
											</tr>
											<tr>
												<td><input type='radio' id='checkUser' name='user'/></td>
												<td>a52153@email.com</td>
												<td>37</td>
												<td>20</td>
											</tr>
											<tr>
												<td><input type='radio' id='checkUser' name='user'/></td>
												<td>284aa@email.com</td>
												<td>12</td>
												<td>4</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class='row mt-0 ml-3 justify-content-center'>
						<ul class='pagination'>
							<li class="page-item"><a class="page-link border-0" href="#">&laquo;</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">1</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">2</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">3</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">4</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">5</a></li>
							<li class="page-item"><a class="page-link border-0" href="#">&raquo;</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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