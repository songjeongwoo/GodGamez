<title>갓겜:회원 조회</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
.header {
	background: #0367A6;
	color: #F2F2F2;
}

.clsIcon {
	width: 25%;
}

#usrClsIcon {
	width: 8rem;
	height: 8rem;
}

.usrInfo {
	width: 75%;
}

#usrQstIcon {
	width: 5rem;
	height: 5rem;
	margin-right: 1.8rem;
}

#usrQst th {
	width: 6rem;
}

ul {
    list-style: none;
}

li[name="clsName"] {
	float: left;
	margin-left: 0;
    margin-right: 1rem;
}

.modal-body #qstImgDetail {
	width: 28rem;
	height: 28rem;
	object-fit: cover;
}

.modal-body img {
	cursor: zoom-out;
}
</style>
<script>
function whosPage() {
	usrCode = document.location.href.replace(/[^0-9]/g, "");
	
	if(usrCode.length > 0)
	$.ajax({
		url: "/godgamez.selfdevelopment/user/get",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({
			usrCode: usrCode
		}),
        success: function(target) {
        	if(target != null) {
        		$('#usrClsIcon').attr("src", "/godgamez.selfdevelopment/res/user/icon/" + target.usrIcon + ".jpg");
        		$('#nickname').text(target.nickname);
        		$('#usrLv').text(parseInt(target.usrLv));
        		exp = (target.usrLv - parseInt(target.usrLv)) * 100;
        		$('#expPoint').append("<progress id='expPoint' max='100' title='" + exp + "%' value='" + exp + "'></progress>");
        		getUsrqsts(target.usrCode);
        		getUsrclss(target.usrCode);
        	} else modal("회원", "조회", "실패10", "존재하지 않는 회원입니다.");
        }, fail: function() {
        	modal("회원", "조회", "실패10", "회원을 조회할 수 없습니다.");
        }
	})
}

/* 회원 클래스 */
function getUsrclss(usrCode) {
	$('#usrCls').empty();
	
	$.ajax({
		url: "/godgamez.selfdevelopment/user/class/list",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(usrCode),
		success: function(usrclss) {
        	if(usrclss.length) {
				let usrclsList = [];
        		
        		$.each(usrclss, (idx, usrcls) => {
					if(usrclss.length < 5) usrclsList.push(`<li name='clsName'>\${usrcls.cls.clsName}</li>`);
					else {
						restClss = usrclss.length - 5;
						if(idx != usrclss.length - 1) {
							if(idx < 4) usrclsList.push(`<li name='clsName'>\${usrcls.cls.clsName}</li>`);
							else if(idx == 4)
								usrclsList.push(
										`<li name='clsName'>
											\${usrcls.cls.clsName}
											<span class='btn btn-sm small text-light' id='unfoldUsrClsBtn' title='펼치기' onclick='unfoldUsrCls()'>
												<i class="fas fa-plus small"> \${restClss}</i>
											</span>
										</li>`
									);
							else if(idx == 5) usrclsList.push(`<br><li id='folderble' name='clsName' hidden=true>\${usrcls.cls.clsName}</li>`);
							else usrclsList.push(`<li id='folderble' name='clsName' hidden=true>\${usrcls.cls.clsName}</li>`);
						} else
							usrclsList.push(
								`<li id='folderble' name='clsName' hidden=true>
									\${usrcls.cls.clsName}
									<span class='btn btn-sm small text-light' id='foldUsrClsBtn' title='접기' onclick='foldUsrCls()' hidden>
										<i class="fas fa-minus small"></i>
									</span>
								</li>`);
					}
				});
				$('#usrCls').append(usrclsList.join(''));
        	}
        }, fail: function() {
        	modal("회원 클래스", "조회", "실패10", "회원님의 클래스를 조회할 수 없습니다.");
        }
	})
}

function unfoldUsrCls() {
	$('li[id="folderble"]').removeAttr("hidden");
	$('#foldUsrClsBtn').removeAttr("hidden");
	$('#unfoldUsrClsBtn').attr("hidden", true);
}

function foldUsrCls() {
	$('li[id="folderble"]').attr("hidden", true);
	$('#foldUsrClsBtn').attr("hidden", true);
	$('#unfoldUsrClsBtn').removeAttr("hidden");
}

/* 회원 퀘스트 */
function getUsrqsts(usrCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/user/quest/list",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(usrCode),
		success: function(usrqsts) {
        	if(usrqsts.length) {
        		let accptUsrqsts = [];
        		let doneUsrqsts = [];
        		
        		$.each(usrqsts, (idx, usrqst) => {
        			if(usrqst.procStep == "ACCEPTED") accptUsrqsts.push(usrqst);
        			else if(usrqst.handInImg != null && usrqst.procStep == "DONE") doneUsrqsts.push(usrqst);
				});
        		
        		if(doneUsrqsts.length) getDoneQsts(doneUsrqsts);
        		else $('#doneUsrqstItems').html("<div class='text-center'><h4>수행 완료한 퀘스트 혹은 제출한 이미지가 없습니다.</h4></div>");
        		
        		$('#usrAcceptedQstCnt').text(accptUsrqsts.length);
        		$('#usrDoneQstCnt').text(doneUsrqsts.length);
        	} else {
        		$('#doneUsrqstItems').html("<div class='text-center'><h4>수행 완료한 퀘스트 혹은 제출한 이미지가 없습니다.</h4></div>");
        	}
        }, fail: function() {
        	modal("회원 퀘스트", "조회", "실패");
        }
	})
}

function getDoneQsts(doneUsrqsts) {
	$('#doneUsrqstImgList #indicators').attr("hidden", true);
	$('#doneUsrqstImgList #prevBtn').attr("hidden", true);
	$('#doneUsrqstImgList #nextBtn').attr("hidden", true);
	
	$('#doneUsrqstItems').empty();
	$('#doneUsrqstImgList #indicators').empty();
	
	let doneTot = doneUsrqsts.length;
	let donePage = 0;
	let donePageList = [];
	let doneIndicatorList = [];
	
	if(doneTot%8 != 0) donePage = parseInt(doneTot/8) + 1;
	else donePage = parseInt(doneTot/8);
	
	donePageList.push(
		"<div class='carousel-item active'>" +
			"<div class='d-flex justify-content-center'>" +
				"<table id='doneQstImg0'>" +
					"<tr id='first'></tr>" +
					"<tr id='second'></tr>" +
				"</table>" +
			"</div>" +
		"</div>");
	doneIndicatorList.push(`<li data-target='#doneUsrqstImgList' data-slide-to='0' class='active'></li>`);
	
	for(i = 1; i < donePage; i++) {
		donePageList.push(
			"<div class='carousel-item'>" +
				"<div class='d-flex justify-content-center'>" +
					"<table id='doneQstImg" + i + "'>" +
						"<tr id='first'></tr>" +
						"<tr id='second'></tr>" +
					"</table>" +
				"</div>" +
			"</div>");
		doneIndicatorList.push(`<li data-target='#doneUsrqstImgList' data-slide-to='\${i}'></li>`);
	}
	$('#doneUsrqstItems').append(donePageList.join(''));
	$('#doneUsrqstImgList #indicators').append(doneIndicatorList.join(''));
	
	let doneUsrqstList = [];
	let doneUsrqstCnt = 0;
	
	if(donePage - 1) {
		$('#doneUsrqstImgList #indicators').removeAttr("hidden");
		$('#doneUsrqstImgList #prevBtn').removeAttr("hidden");
		$('#doneUsrqstImgList #nextBtn').removeAttr("hidden");
		
		$.each(doneUsrqsts, (idx, done) => {
			let pushItem = 
				`<td id='doneQstImg' onclick='getDoneDetail("\${done.modDate}", \${done.qst.qstId}, \${done.usr.usrCode}, "\${done.qst.qstName}")'>
					<img src='/godgamez.selfdevelopment/res/userQuest/\${done.usr.usrCode}_\${done.qst.qstId}.jpg' alt='퀘스트 제출 이미지' name='doneQstImg' title='크게 보기'>
					<span id='doneDate'>\${done.modDate}</span>
				</td>`;
							
			if(idx + 1 == doneTot) {
				doneUsrqstCnt++;
				doneUsrqstList.push(pushItem);
				
				if(doneUsrqstCnt%8 == 0) {
					$('#doneQstImg0').find('#second').append(doneUsrqstList.join(''));
					doneUsrqstCnt = 0;
					doneUsrqstList = [];
				} else if(doneUsrqstCnt%4 == 0) {
					$('#doneQstImg0').find('#first').append(doneUsrqstList.join(''));
					doneUsrqstList = [];
				}
			} else if((idx + 1) % 8) {
				doneUsrqstCnt++;
				doneUsrqstList.push(pushItem);
				if(doneUsrqstCnt%4 == 0) {
					p = "doneQstImg" + parseInt(idx / 4);
					$('#' + p).find('#first').append(doneUsrqstList.join(''));
					doneUsrqstList = [];
				}
			} else {
				doneUsrqstCnt++;
				doneUsrqstList.push(pushItem);
				doneUsrqstCnt = 0;
				p = "doneQstImg" + parseInt(idx / 8);
				$('#' + p).find('#second').append(doneUsrqstList.join(''));
				doneUsrqstList = [];
			}
		});
		
		p = "doneQstImg" + (donePage - 1);
		if(8*donePage - doneTot) {
			for(i = 0; i < 8*donePage - doneTot; i++) {
				doneUsrqstList.push(
					`<td id='doneQstImg'>
						<img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='doneQstImg'>
					</td>`);
				doneUsrqstCnt++;

				if(doneUsrqstCnt%8 == 0) {
					$('#' + p).find('#second').append(doneUsrqstList.join(''));
					doneUsrqstCnt = 0;
					doneUsrqstList = [];
				} else if(doneUsrqstCnt%4 == 0) {
					$('#' + p).find('#first').append(doneUsrqstList.join(''));
					doneUsrqstList = [];
				}
			}
		} else {
			if(doneUsrqstCnt%8 == 0) {
				$('#' + p).find('#second').append(doneUsrqstList.join(''));
				doneUsrqstCnt = 0;
				doneUsrqstList = [];
			} else if(doneUsrqstCnt%4 == 0) {
				$('#' + p).find('#first').append(doneUsrqstList.join(''));
				doneUsrqstList = [];
			}
		}
	} else {
		$.each(doneUsrqsts, (idx, done) => {
			doneUsrqstList.push(
				`<td id='doneQstImg' onclick='getDoneDetail("\${done.modDate}", \${done.qst.qstId}, \${done.usr.usrCode}, "\${done.qst.qstName}")'>
					<img src='/godgamez.selfdevelopment/res/userQuest/\${done.usr.usrCode}_\${done.qst.qstId}.jpg' alt='퀘스트 제출 이미지' name='doneQstImg' title='크게 보기'>
					<span id='doneDate'>\${done.modDate}</span>
				</td>`);
			doneUsrqstCnt++;
			
			if(doneUsrqstCnt%8 == 0) {
				$('#doneQstImg0').find('#second').append(doneUsrqstList.join(''));
				doneUsrqstCnt = 0;
				doneUsrqstList = [];
			} else if(doneUsrqstCnt%4 == 0) {
				$('#doneQstImg0').find('#first').append(doneUsrqstList.join(''));
				doneUsrqstList = [];
			}
		});
		
		for(i = 0; i < 8 - doneTot; i++) {
			doneUsrqstList.push(
				`<td id='doneQstImg'>
					<img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='doneQstImg'>
				</td>`);
			doneUsrqstCnt++;
			
			if(doneUsrqstCnt%8 == 0) {
				$('#doneQstImg0').find('#second').append(doneUsrqstList.join(''));
				doneUsrqstCnt = 0;
				doneUsrqstList = [];
			} else if(doneUsrqstCnt%4 == 0) {
				$('#doneQstImg0').find('#first').append(doneUsrqstList.join(''));
				doneUsrqstList = [];
			}
		}
	}
}

function getDoneDetail(modDate, qstId, usrCode, qstName) {
	$('#doneQstImgDetailModal #doneName').text(qstName);
	$('#doneQstImgDetailModal #doneDate').text(modDate + " 완료");
	$('#doneQstImgDetailModal #qstImgDetail').attr("src", "/godgamez.selfdevelopment/res/userQuest/" + usrCode + "_" + qstId + ".jpg");
	$('#doneQstImgDetailModal').modal("show");
}

$(document).ready(function() {
	whosPage();
	
	$('#doneQstImgDetailModal #qstImgDetail').click(function() {
		$('#doneQstImgDetailModal').modal("hide");
	})
})
</script>
<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>
<div id='body'>
	<div class='header pb-4'>
		<div class='container'>
			<div class='row'>
				<h5 class='mt-4 ml-3'>User Info</h5>
			</div>
			<div class='row mt-3 justify-content-around'>
				<div class='col-3'>
					<img alt='대표 클래스 아이콘' id='usrClsIcon'>
				</div>
				<div class='col-9'>
					<div class='row'>
						<div class='col'>
							<div class='row'>
								<h3 class='font-weight-bold text-left mt-2' id='nickname'></h3>
							</div>
							<div class='row'>
								<ul class='pl-0 ml-1' id='usrCls'>
								</ul>
							</div>
						</div>
						<div class='col d-flex justify-content-end'>
							<table id='usrQst' class='mr-3 text-nowrap'>
								<tr id='usrAcceptedQst'>
									<td rowspan='2'>
										<img src='/godgamez.selfdevelopment/res/user/mypage_quest_icon.png' alt='퀘스트 아이콘' id='usrQstIcon' class='text-light'>
									</td>
									<th class='text-left text-primary'>
										수행 중
									</th>
									<td class='text-right text-light' id='usrAcceptedQstCnt'></td>
								</tr>
								<tr id='userDoneQst'>
									<th class='text-left text-primary'>
										수행 완료
									</th>
									<td class='text-right text-light' id='usrDoneQstCnt'></td>
								</tr>
							</table>
						</div>
					</div>
					<div class='row mt-1'>
						<div class='col-a'>
							<h6 class='mt-1'>
								<span class='badge bg-light text-primary ml-2 mr-0'>LV</span>
								<span class='text-left font-weight-bold' id='usrLv'></span>
							</h6>
						</div>
						<div class='col-b'>
							<div class='row pl-0'>
								<h6 class='text-left small mb-0'>EXP</h6>
							</div>
							<div class='row pl-0 mr-4' id='expPoint'></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class='container usrDetail' oncontextmenu="return false" ondragstart="return false">
		<div class='row mt-5'>
			<div class='col ml-5'>
				<h5 class='ml-5'>QUEST ALBUM</h5>
			</div>
		</div>
		<div class='row mt-4'>
			<div class='col w-100'>
				<div id='doneUsrqstImgList' class='carousel slide pb-5' data-ride='carousel' data-interval=false>
					<div class='carousel-inner '>
						<a href='#doneUsrqstImgList' data-slide='prev' class='carousel-control-prev' id='prevBtn' hidden=true>
							<i class="fas fa-chevron-circle-left"></i>
						</a>
						<div id='doneUsrqstItems'>
						</div>
						<a href='#doneUsrqstImgList' data-slide='next' class='carousel-control-next' id='nextBtn' hidden=true>
							<i class="fas fa-chevron-circle-right"></i>
						</a>
					</div>
					<ul class='carousel-indicators' id='indicators' hidden=true>
					</ul>
				</div>
			</div>
		</div>
		<div class='row mt-4 justify-content-center'>
			<span class='small text-center text-muted'>
				무단 복제 및 도용 방지를 위해 <br>
				마우스 오른쪽 클릭 및 마우스 드래그가 금지되어있습니다.
			</span>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>

<!-- 모달 -->
<div id='doneQstImgDetailModal' class='modal fade' tabindex='-1' oncontextmenu="return false" ondragstart="return false">
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header justify-content-between'>
				<span class='mt-2' id='doneDate'></span>
				<span class='mt-2' id='doneName'></span>
			</div>
			<div class='modal-body'>
				<div class='row'>
					<div class='col d-flex justify-content-center'>
						<img alt='퀘스트 제출 이미지' id='qstImgDetail'>
					</div>
				</div>
				<div class='row mt-2 justify-content-center'>
					<span class='small text-center text-muted'>
						무단 복제 및 도용 방지를 위해 <br>
						마우스 오른쪽 클릭 및 마우스 드래그가 금지되어있습니다.
					</span>
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