<title>갓겜:마이페이지</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
.header {
	background: #0367A6;
	color: #F2F2F2;
}

/* imgBtn */
.imgBtn {
  display: inline-block;
  text-align: center;
  vertical-align: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
  cursor: pointer;
}
  
@media (prefers-reduced-motion: reduce) {
  .imgBtn {
    transition: none;
  }
}

.imgBtn:focus, .btn.focus {
  outline: 0;
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* 헤더 */
.clsIcon {
	width: 25%;
}

#usrClsIcon {
	width: 6.5rem;
	height: 6.5rem;
}

.usrInfo {
	width: 75%;
}

#usrQstIcon,
#usrCpnIcon {
	width: 4.2rem;
	height: 4.2rem;
	margin-right: 0.2rem;
}

#usrQst th,
#usrCpnAndGold #coupon,
#usrCpnAndGold #gold {
	width: 10rem;
}

ul {
    list-style: none;
}

#clsName {
	float: left;
	margin-left: 0;
    margin-right: 0.3rem;
}

#unfoldUsrClsBtn {
	cursor: zoom-in;
}

#foldUsrClsBtn {
	cursor: zoom-out;
}

/* 마이 쿠폰 */
#usrCpnImg {
	position: relative;
	width: 13.33333rem;
	height: 10rem;
	border: 1px solid #0367A6;
}

#usrCpnImg #availability {
	position: absolute;
	top: 0;
	left: 0;
	margin: 0;
	padding: 0;
	width: 13.33333rem;
	height: 10rem;
	background-color: rgba(132, 177, 217, 0.2);
	text-align: center;
	font-weight: 700;
	font-size: 1.55rem;
	z-index: 99;
	cursor: default;
}

#usrCpnImg span {
	z-index: 100;
	cursor: pointer;
}

#availability span {
	position: absolute;
	top: 40%;
	left: 26.7%;
	cursor: default;
}

#usrCpnImg #usrCpnDetail {
	position: absolute;
	right: 0.8rem;
	bottom: 0.3rem;
	
    -webkit-text-stroke-width: 1.5px;
    -webkit-text-stroke-color: #FFFFFF;
    -webkit-text-fill-color: #A8A8A8;
    text-shadow: 3px 3px 0px #BFBFBF;
}

/* 모달 */
.modal-body #qstImgDetail {
	width: 28rem;
	height: 28rem;
	object-fit: cover;
}

#cpnImgDetailParent {
	position: relative;
	width: 28rem;
	height: 21rem;
}

#cpnImgDetailParent #fadeCode {
	position: absolute;
	top: 13%;
	left: 13%;
	margin: 0;
	padding: 5;
	z-index: 99999;
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	text-align: center;
	font-weight: bolder;
	width: 75%;
	height: 75%;
}

#cpnImgDetailParent #cpnImgDetail {
	position: absolute;
	top: 0;
	left: 0;
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#showCpnIcon {
	cursor: pointer;
}
</style>
<script>
$(document).ready(function() {
	$(myPageData);
	
	$('#doneQstImgDetailModal #delDoneQstImgBtn').click(function() {
		param = $(this).attr("name");
		
		modal("제출 이미지", "삭제", "확인");
		$('#sureBtn').attr("onclick", "delDoneQstImg(" + param + ")");
	})
	
	$('#seeCpnCodeBtn').click(function() {
		useCouponTime();
		
		$('#showCpnIcon').click(function() {
			clearInterval(cntDown);
			clearTimeout(timeout);
			
			useCouponTime();
		})
	})
	
	$('#cpnDetailModal #useCpnBtn').click(function() {
		param = $(this).attr("name");
		
		modal("쿠폰", "사용", "확인");
		$('#sureBtn').attr("onclick", "useCpn(" + param + ")");
	})
})

function myPageData() {
	let sessionUser = getConnectedUser();
	
	if(sessionUser && sessionUser.usrCode) {
		if(sessionUser.position == 'NOOB') {
			$('#doneUsrqstImgList').attr("hidden", true);
			$('#accptUsrqstImgList').attr("hidden", true);
			$('#usrCpnImgList').attr("hidden", true);
			$('#authPlease').removeAttr('hidden');
			$('#sendAuthMailBtn').attr("onclick", "sendVerification('" + sessionUser.usrId + "', '" + sessionUser.usrName + "', '" + sessionUser.nickname + "')");
		} else {
			$('#authPlease').remove();
			$('#doneUsrqstImgList').removeAttr('hidden');
			$('#accptUsrqstImgList').removeAttr('hidden');
			$('#usrCpnImgList').removeAttr('hidden');
		}
		$('#usrClsIcon').attr("src", "/godgamez.selfdevelopment/res/user/icon/" + sessionUser.usrIcon + ".jpg");
		$('#nickname').text(sessionUser.nickname);
		$('#gold').text(sessionUser.gold);
		$('#usrGold').text(sessionUser.gold);
		$('#usrLv').text(parseInt(sessionUser.usrLv));
		exp = (sessionUser.usrLv - parseInt(sessionUser.usrLv)) * 100;
		$('#expPoint').attr("value", exp);
		$('#expPoint').attr("title", exp + "%");
	    
		//coupon
		
		getUsrclss(sessionUser.usrCode);
		getUsrqsts(sessionUser.usrCode);
		getCoupons(sessionUser.usrCode);
	} else modal("", "", "실패6")
}

function closeNoob() {
	$('#authPlease').remove();
}

/* 회원 클래스 */
function getUsrclss(usrCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/user/class/list",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(usrCode),
		success: function(usrclss) {
        	if(usrclss.length) {
				let usrclsList = [];
        		
        		$.each(usrclss, (idx, usrcls) => {
					if(usrclss.length < 5) {
						if(idx == usrclss.length - 1) usrclsList.push(`<span>\${usrcls.cls.clsName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>`);
						else if(idx != usrclss.length - 1) usrclsList.push(`<span>\${usrcls.cls.clsName}&nbsp;&nbsp;</span>`);
						else usrclsList.push(`<span>\${usrcls.cls.clsName}</span>`);
					} else {
						restClss = usrclss.length - 5;
						if(idx != usrclss.length - 1) {
							if(idx < 4) usrclsList.push(`<span>\${usrcls.cls.clsName}&nbsp;&nbsp;</span>`);
							else if(idx == 4) 
								usrclsList.push(
									`<span>\${usrcls.cls.clsName}</span>
									<span class='btn btn-sm small text-light' id='unfoldUsrClsBtn' title='펼치기' onclick='unfoldUsrCls()'>
										<i class="fas fa-plus small"> \${restClss}</i>
									</span>`
								);
							else if(idx == 5) usrclsList.push(`<br><span id='folderble' hidden>\${usrcls.cls.clsName}&nbsp;&nbsp;</span>`);
							else usrclsList.push(`<span id='folderble' hidden>\${usrcls.cls.clsName}&nbsp;&nbsp;</span>`);
						} else usrclsList.push(
								`<span id='folderble' hidden>\${usrcls.cls.clsName}</span>
								<span class='btn btn-sm small text-light' id='foldUsrClsBtn' title='접기' onclick='foldUsrCls()' hidden>
									<i class="fas fa-minus small"></i>
								</span>`
							);
					}
				});
				$('#clsName').append(usrclsList.join(''));
        	}
        }, fail: function() {
        	modal("회원 클래스", "조회", "실패10", "회원님의 클래스를 조회할 수 없습니다.");
        }
	})
}

function unfoldUsrCls() {
	$('span[id="folderble"]').removeAttr("hidden");
	$('#foldUsrClsBtn').removeAttr("hidden");
	$('#unfoldUsrClsBtn').attr("hidden", true);
}

function foldUsrCls() {
	$('span[id="folderble"]').attr("hidden", true);
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
        		let doneUsrqsts = [];
        		let accptUsrqsts = [];
        		
        		$.each(usrqsts, (idx, usrqst) => {
        			if(usrqst.procStep == "ACCEPTED") accptUsrqsts.push(usrqst);
        			else if(usrqst.handInImg != null && usrqst.procStep == "DONE") doneUsrqsts.push(usrqst);
				});
        		
        		if(accptUsrqsts.length) getAccptQsts(accptUsrqsts);
        		else $('#accptUsrqstItems').html("<div class='text-center'><h4>현재 진행중인 퀘스트가 없습니다.</h4></div>");
        		if(doneUsrqsts.length) getDoneQsts(doneUsrqsts);
        		else $('#doneUsrqstItems').html("<div class='text-center'><h4>수행 완료한 퀘스트 혹은 제출한 이미지가 없습니다.</h4></div>");
        		
        		$('#accptQst').text(accptUsrqsts.length);
        		$('#doneQst').text(doneUsrqsts.length);
        	} else {
        		$('#accptUsrqstItems').html("<div class='text-center'><h4>현재 진행중인 퀘스트가 없습니다.</h4></div>");
        		$('#doneUsrqstItems').html("<div class='text-center'><h4>수행 완료한 퀘스트 혹은 제출한 이미지가 없습니다.</h4></div>");
        	}
        }, fail: function() {
        	modal("회원 퀘스트", "조회", "실패10", "회원님의 퀘스트를 조회할 수 없습니다.");
        }
	})
}

function getAccptQsts(accptUsrqsts) {
	$('#accptUsrqstImgList #indicators').attr("hidden", true);
	$('#accptUsrqstImgList #prevBtn').attr("hidden", true);
	$('#accptUsrqstImgList #nextBtn').attr("hidden", true);
	
	$('#accptUsrqstItems').empty();
	$('#accptUsrqstImgList #indicators').empty();
	
	let accptTot = accptUsrqsts.length;
	let accptPage = 0;
	let accptPageList = [];
	let accptIndicatorList = [];

	if(accptTot%3 != 0) accptPage = parseInt(accptTot/3) + 1;
	else accptPage = parseInt(accptTot/3);
	
	accptPageList.push(
		"<div class='carousel-item active'>" +
			"<div class='d-flex justify-content-center'>" +
				"<table id='accptQstImg0'>" +
					"<tr></tr>" +
				"</table>" +
			"</div>" +
		"</div>");
	accptIndicatorList.push(`<li data-target='#accptUsrqstImgList' data-slide-to='0' class='active'></li>`);
	
	for(i = 1; i < accptPage; i++) {
		accptPageList.push(
			"<div class='carousel-item'>" +
				"<div class='d-flex justify-content-center'>" +
					"<table id='accptQstImg" + i + "'>" +
						"<tr></tr>" +
					"</table>" +
				"</div>" +
			"</div>");
		accptIndicatorList.push(`<li data-target='#accptUsrqstImgList' data-slide-to='\${i}'></li>`);
	}
	$('#accptUsrqstItems').append(accptPageList.join(''));
	$('#accptUsrqstImgList #indicators').append(accptIndicatorList.join(''));
	
	let accptUsrqstList = [];
	let qstName = "";
	
	if(accptPage - 1) {
		$('#accptUsrqstImgList #indicators').removeAttr("hidden");
		$('#accptUsrqstImgList #prevBtn').removeAttr("hidden");
		$('#accptUsrqstImgList #nextBtn').removeAttr("hidden");
		
		$.each(accptUsrqsts, (idx, accpt) => {
			qstName = accpt.qst.qstName;
			qstNameList = qstName.split("");
			if(qstNameList.length > 8) {
				qstName = "";
				for(i=0; i<=8; i++)
					qstName += qstNameList[i];
				qstName += "...";
			}
			
			let pushItem = `<td id='accptQstImg' onclick='location.href="/godgamez.selfdevelopment/quest/quest?qstId=\${accpt.qst.qstId}"'>
								<img src='/godgamez.selfdevelopment/res/quest/\${accpt.qst.qstId}.jpg' alt='수락한 퀘스트' name='accptQstImg' title='수행하러 가기'>
								<span id='accptQstName'>\${qstName}</span>
							</td>`;
			
			if(idx + 1 == accptTot) {
				accptUsrqstList.push(pushItem);
				
				if(accptPage*3 - accptTot)
					for(i=0; i<accptPage*3 - accptTot; i++)
						accptUsrqstList.push(`<td id='accptQstImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='accptQstImg'></td>`);
				
				p = "accptQstImg" + (accptPage - 1) + " tr";
				$('#' + p).append(accptUsrqstList.join(''));
			} else if((idx + 1) % 3) { //페이지 만들기
				accptUsrqstList.push(pushItem);
			} else {
				accptUsrqstList.push(pushItem);
				p = "accptQstImg" + parseInt(idx / 3) + " tr";
				$('#' + p).append(accptUsrqstList.join(''));
				accptUsrqstList = [];
			}
		});
	} else {
		$.each(accptUsrqsts, (idx, accpt) => {
			qstName = accpt.qst.qstName;
			qstNameList = qstName.split("");
			if(qstNameList.length > 8) {
				qstName = "";
				for(i=0; i<=8; i++)
					qstName += qstNameList[i];
				qstName += "...";
			}
			
			accptUsrqstList.push(
				`<td id='accptQstImg' onclick='location.href="/godgamez.selfdevelopment/quest/quest?qstId=\${accpt.qst.qstId}"'>
					<img src='/godgamez.selfdevelopment/res/quest/\${accpt.qst.qstId}.jpg' alt='수락한 퀘스트' name='accptQstImg' title='수행하러 가기'>
					<span id='accptQstName'>\${qstName}</span>
				</td>`
			);
		});
		
		if(accptPage*3 - accptTot)
			for(i=0; i<accptPage*3 - accptTot; i++)
				accptUsrqstList.push(`<td id='accptQstImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='accptQstImg'></td>`);
		
		$('#accptQstImg0 tr').append(accptUsrqstList.join(''));
	}
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
	
	if(doneTot%3 != 0) donePage = parseInt(doneTot/3) + 1;
	else donePage = parseInt(doneTot/3);
	
	donePageList.push(
		"<div class='carousel-item active'>" +
			"<div class='d-flex justify-content-center'>" +
				"<table id='doneQstImg0'>" +
					"<tr></tr>" +
				"</table>" +
			"</div>" +
		"</div>");
	doneIndicatorList.push(`<li data-target='#doneUsrqstImgList' data-slide-to='0' class='active'></li>`);
	
	for(i = 1; i < donePage; i++) {
		donePageList.push(
			"<div class='carousel-item'>" +
				"<div class='d-flex justify-content-center'>" +
					"<table id='doneQstImg" + i + "'>" +
						"<tr></tr>" +
					"</table>" +
				"</div>" +
			"</div>");
		doneIndicatorList.push(`<li data-target='#doneUsrqstImgList' data-slide-to='\${i}'></li>`);
	}
	$('#doneUsrqstItems').append(donePageList.join(''));
	$('#doneUsrqstImgList #indicators').append(doneIndicatorList.join(''));
	
	let doneUsrqstList = [];
	
	if(donePage - 1) {
		$('#doneUsrqstImgList #indicators').removeAttr("hidden");
		$('#doneUsrqstImgList #prevBtn').removeAttr("hidden");
		$('#doneUsrqstImgList #nextBtn').removeAttr("hidden");
		
		$.each(doneUsrqsts, (idx, done) => {
			let pushItem = `<td id='doneQstImg' onclick='getDoneDetail("\${done.modDate}", \${done.qst.qstId}, \${done.usr.usrCode}, "\${done.qst.qstName}")'>
								<img src='/godgamez.selfdevelopment/res/userQuest/\${done.usr.usrCode}_\${done.qst.qstId}.jpg' alt='퀘스트 제출 이미지' name='doneQstImg' title='크게 보기'>
								<span id='doneDate'>\${done.modDate}</span>
							</td>`;
							
			if(idx + 1 == doneTot) {
				doneUsrqstList.push(pushItem);
				
				if(donePage*3 - doneTot)
					for(i=0; i<donePage*3 - doneTot; i++)
						doneUsrqstList.push(`<td id='doneQstImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='doneQstImg'></td>`);
				
				p = "doneQstImg" + (donePage - 1) + " tr";
				$('#' + p).append(doneUsrqstList.join(''));
			} else if((idx + 1) % 3) { //페이지 만들기
				doneUsrqstList.push(pushItem);
			} else {
				doneUsrqstList.push(pushItem);
				p = "doneQstImg" + parseInt(idx / 3) + " tr";
				$('#' + p).append(doneUsrqstList.join(''));
				doneUsrqstList = [];
			}
		});
	} else {
		$.each(doneUsrqsts, (idx, done) => {
			date = done.modDate;
			doneUsrqstList.push(
				`<td id='doneQstImg' onclick='getDoneDetail("\${done.modDate}", \${done.qst.qstId}, \${done.usr.usrCode}, "\${done.qst.qstName}")'>
					<img src='/godgamez.selfdevelopment/res/userQuest/\${done.usr.usrCode}_\${done.qst.qstId}.jpg' alt='퀘스트 제출 이미지' name='doneQstImg' title='크게 보기'>
					<span id='doneDate'>\${done.modDate}</span>
				</td>`);
		});
		
		if(donePage*3 - doneTot)
			for(i=0; i<donePage*3 - doneTot; i++)
				doneUsrqstList.push(`<td id='doneQstImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='doneQstImg'></td>`);
		
		$('#doneQstImg0 tr').append(doneUsrqstList.join(''));
	}
}

function getDoneDetail(modDate, qstId, usrCode, qstName) {
	$('#doneQstImgDetailModal #doneName').text(qstName);
	$('#doneQstImgDetailModal #doneDate').text(modDate + " 완료");
	$('#doneQstImgDetailModal #qstImgDetail').attr("src", "/godgamez.selfdevelopment/res/userQuest/" + usrCode + "_" + qstId + ".jpg");
	$('#doneQstImgDetailModal #delDoneQstImgBtn').attr("name", qstId + ", " + usrCode);
	$('#doneQstImgDetailModal').modal("show");
}

function delDoneQstImg(qstId, usrCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/user/quest/del/img",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({
			usrCode: usrCode,
			qstId: qstId
		}),
		success: function(result) {
        	if(result) {
        		modal("제출 이미지", "삭제", "성공");
        		$('#doneQstImgDetailModal').modal("hide");
    			getUsrqsts(usrCode);
        	} else modal("제출 이미지", "삭제", "실패");
        }, fail: function() {
        	modal("제출 이미지", "삭제", "실패");
        }
	})
}

function getCoupons(usrCode) {
	$('#usrCpnImgList #indicators').attr("hidden", true);
	$('#usrCpnImgList #prevBtn').attr("hidden", true);
	$('#usrCpnImgList #nextBtn').attr("hidden", true);
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/coupon/list/' + usrCode,
	}).done(cpns => {
		if(cpns.length) {
			$('#usrCpnItems').empty();
			$('#usrCpnImgList #indicators').empty();
			$('#coupon').text(cpns.length);
			
			let cpnTot = cpns.length;
			let cpnPage = 0;
			let cpnPageList = [];
			let cpnIndicatorList = [];

			if(cpnTot%3 != 0) cpnPage = parseInt(cpnTot/3) + 1;
			else cpnPage = parseInt(cpnTot/3);
			
			cpnPageList.push(
				"<div class='carousel-item active'>" +
					"<div class='d-flex justify-content-center'>" +
						"<table id='usrCpnList0'>" +
							"<tr></tr>" +
						"</table>" +
					"</div>" +
				"</div>");
			cpnIndicatorList.push(`<li data-target='#usrCpnImgList' data-slide-to='0' class='active'></li>`);
			
			for(i = 1; i < cpnPage; i++) {
				cpnPageList.push(
					"<div class='carousel-item'>" +
						"<div class='d-flex justify-content-center'>" +
							"<table id='usrCpnList" + i + "'>" +
								"<tr></tr>" +
							"</table>" +
						"</div>" +
					"</div>");
				cpnIndicatorList.push(`<li data-target='#usrCpnImgList' data-slide-to='\${i}'></li>`);
			}
			$('#usrCpnItems').append(cpnPageList.join(''));
			$('#usrCpnImgList #indicators').append(cpnIndicatorList.join(''));
			
			let cpnList = [];
			let availableCnt = 0;
			
			if(cpnPage - 1) {
				$('#usrCpnImgList #indicators').removeAttr("hidden");
				$('#usrCpnImgList #prevBtn').removeAttr("hidden");
				$('#usrCpnImgList #nextBtn').removeAttr("hidden");
				
				$.each(cpns, (idx, cpn) => {
					let store = cpn.store;
					let storeKor = "";
					switch(store) {
						case"BOOKSTORE": storeKor = "서점"; break;
						case"SPORTSSHOP": storeKor = "스포츠샵"; break;
						case"ONLINECLASS": storeKor = "인터넷강의";
					}
					let dcPer = cpn.dcPer * 100 + "%";
					
					let pushItem;
					if(cpn.availability == 1) {
						availableCnt++;
						pushItem =
							`<td id='usrCpnImg' onclick='getCpnDetail("\${store}", "\${storeKor}", "\${dcPer}", \${cpn.cpnCode}, \${usrCode})'>
								<span id='usrCpnDetail' class='font-weight-bolder h3 text-right'>\${storeKor}<br>\${dcPer}</span>
								<img src='/godgamez.selfdevelopment/res/coupon/\${store}.jpg' class='btn' alt='쿠폰 사용처 이미지' name='usrCpnImg'>
							</td>`
					} else {
						pushItem =
							`<td id='usrCpnImg'>
								<div id='availability'><span>사용 완료</span></div>
								<img class='opacity-50' src='/godgamez.selfdevelopment/res/coupon/\${store}.jpg' alt='쿠폰 사용처 이미지' name='usrCpnImg'>
							</td>`
					}
					
					if(idx + 1 == cpnTot) {
						cpnList.push(pushItem);
						
						if(cpnPage*3 - cpnTot)
							for(i=0; i<cpnPage*3 - cpnTot; i++)
								cpnList.push(`<td id='usrCpnImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='usrCpnImg'></td>`);
						
						p = "usrCpnList" + (cpnPage - 1) + " tr";
						$('#' + p).append(cpnList.join(''));
					} else if((idx + 1) % 3) { //페이지 만들기
						cpnList.push(pushItem);
					} else {
						cpnList.push(pushItem);
						p = "usrCpnList" + parseInt(idx / 3) + " tr";
						$('#' + p).append(cpnList.join(''));
						cpnList = [];
					}
				});
				$('#cpnCnt').text(availableCnt + " / " + cpns.length);
			} else {
				$.each(cpns, (idx, cpn) => {
					cpnList.push(pushItem);
				});
				
				if(cpnPage*3 - cpnTot)
					for(i=0; i<cpnPage*3 - cpnTot; i++)
						cpnList.push(`<td id='usrCpnImg'><img src='/godgamez.selfdevelopment/res/userQuest/none.jpg' name='usrCpnImg'></td>`);
				
				$('#usrCpnList0 tr').append(cpnList.join(''));
			}
			
			$('#availability[name="1"]').each(function() {
				$(this).attr("hidden", true);
			})
			
			$('#availability[name="0"]').each(function() {
				$(this).removeAttr("hidden");
			})
		} else $('#usrCpnItems').html("<div class='text-center'><h4>발급 받은 쿠폰이 없습니다.</h4></div>");
	}).fail(() => {
		modal("쿠폰", "조회", "실패");
	})
}

function getCpnDetail(store, storeKor, dcPer, cpnCode, usrCode) {
	$('#cpnDetailModal #cpnCode').text(cpnCode);
	$('#cpnDetailModal #cpnImgDetail').attr("src", "/godgamez.selfdevelopment/res/coupon/" + store + ".jpg");
	$('#cpnDetailModal #cpnStore').text(storeKor);
	$('#cpnDetailModal #cpnDcPer').text(dcPer);
	$('#cpnDetailModal #useCpnBtn').attr("name", cpnCode + ", " + usrCode);
	$('#cpnDetailModal').modal("show");
}

function useCpn(cpnCode, usrCode) {
	$.ajax({
		url: "/godgamez.selfdevelopment/coupon/get/" + cpnCode,
	}).done(cpn => {
		$.ajax({
			url: "/godgamez.selfdevelopment/coupon/useCoupon",
			type: "PUT",
	        contentType: "application/json",
			data: JSON.stringify(cpn),
			success: function(result) {
	        	if(result) {
	        		modal("쿠폰", "사용", "성공");
	        		$('#cpnDetailModal').modal("hide");
	        		getCoupons(usrCode);
	        	} else modal("쿠폰", "사용", "실패");
	        }, fail: function() {
	        	modal("쿠폰", "사용", "실패");
	        }
		})
	}).fail(() => {
		modal("쿠폰", "조회", "실패");
	})
}

function showCpnCode() {
	$('#cpnImgDetailParent #countDown').html('<i class="far fa-clock"></i> 10');
	
	$('#cpnImgDetailParent #fadeCode').attr("class", "d-flex align-items-center");
	$('#cpnImgDetailParent #fadeCode').removeAttr("hidden");
	$('#fadeCode #cpnCode').removeAttr("hidden");
	$('#fadeCode #countDown').removeAttr("hidden");
	
	$('#cpnDetailModal #useCpnBtn').removeAttr("hidden");
	$('#cpnDetailModal #showCpnIcon').attr("hidden", true);
	$('#cpnDetailModal #seeCpnCodeBtn').attr("hidden", true);
}

function resetCpnModal() {
	$('#cpnImgDetailParent #fadeCode').removeAttr("class");
	$('#cpnImgDetailParent #fadeCode').attr("hidden", true);
	$('#fadeCode #cpnCode').attr("hidden", true);
	$('#fadeCode #countDown').attr("hidden", true);
	
	$('#cpnDetailModal #useCpnBtn').attr("hidden", true);
	$('#cpnDetailModal #showCpnIcon').removeAttr("hidden");
	$('#cpnDetailModal #seeCpnCodeBtn').removeAttr("hidden");
}
				
function countDown(cntDownStart) {
	cds = cntDownStart;
	cntDown = setInterval(function() {
		$('#cpnImgDetailParent #countDown').html('<i class="far fa-clock"></i> ' + --cds);
	}, 1000 );
}

function timeoutFn() {
	timeout = setTimeout(function() {
		$('#fadeCode #cpnCode').attr("hidden", true);
		$('#fadeCode #countDown').attr("hidden", true);
		
		$('#cpnDetailModal #useCpnBtn').attr("hidden", true);
		$('#cpnDetailModal #showCpnIcon').removeAttr("hidden");
		$('#cpnDetailModal #seeCpnCodeBtn').removeAttr("hidden");
		
		clearInterval(cntDown);
	}, 11000 )
}

function useCouponTime() {
	countDown(10);
	timeoutFn();
	
	$('#cpnDetailModal').on('hidden.bs.modal', function () {
		resetCpnModal();
		
		clearInterval(cntDown);
		clearTimeout(timeout);
	})
}
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='header pb-4'>
		<div class='container'>
			<div class='row justify-content-center'>
				<div class='col'>
					<h5 class='mt-4 font-weight-bolder text-light'>My Page</h5>
				</div>
				<div class='col align-self-end'>
					<small class='float-right'>
						<a href='/godgamez.selfdevelopment/user/quit/step1' class='text-light'>회원탈퇴</a> &nbsp;|&nbsp;
						<a href='/godgamez.selfdevelopment/user/modify/step1' class='text-light font-weight-bold'>회원정보수정</a>
					</small>
				</div>
			</div>
			<div class='row mt-3 justify-content-around' oncontextmenu="return false" ondragstart="return false">
				<div class='w-10 align-self-center'>
					<img alt='회원 아이콘' id='usrClsIcon'>
				</div>
				<div class='w-70'>
					<div class='row'>
						<div class='col mb-2'>
							<span class='h4 font-weight-bold text-nowrap float-left mr-5' id='nickname' title='회원 별명'></span>
							<span class='small text-light text-nowrap float-left mt-2' id='clsName' title='회원 클래스'></span>
						</div>
						<div class='col d-flex justify-content-end align-self-end mr-3'>
							<table id='usrQst' class='h-25 mr-3 text-primary'>
								<tr>
									<td rowspan='2'>
										<img src='/godgamez.selfdevelopment/res/user/mypage_quest_icon.png' alt='퀘스트 아이콘' id='usrQstIcon'
											class='imgBtn text-primary' onclick='location.href="/godgamez.selfdevelopment/user/mypage#questAlbum"'>
									</td>
									<th class='text-left text-nowrap small font-weight-bold mr-1 text-primary'>
										수행 중
									</th>
									<td>&nbsp;</td>
									<td class='text-right small text-light' id='accptQst' title='현재 진행 중인 퀘스트 수'></td>
								</tr>
								<tr>
									<th class='text-left text-nowrap small font-weight-bold mr-1 text-primary'>
										수행 완료
									</th>
									<td>&nbsp;</td>
									<td class='text-right small text-light' id='doneQst' title='수행 완료한 퀘스트 수'></td>
								</tr>
							</table>
							<table id='usrCpnAndGold' class='h-25 mr-3 text-primary'>
								<tr>
									<td rowspan='2'>
										<img src='/godgamez.selfdevelopment/res/user/mypage_coupon_icon.png' alt='쿠폰 아이콘' id='usrCpnIcon'
											class='imgBtn' onclick='location.href="/godgamez.selfdevelopment/user/mypage#myCoupon"'>
									</td>
									<th class='text-left text-nowrap small font-weight-bold mr-1'>
										&nbsp;<i class="fas fa-ticket-alt"></i>
									</th>
									<td>&nbsp;</td>
									<td class='text-right small text-light' id='coupon' title='사용 가능한 쿠폰 수'></td>
								</tr>
								<tr>
									<th class='text-left text-nowrap small font-weight-bold mr-1'>
										&nbsp;<i class="fas fa-coins"></i>
									</th>
									<td>&nbsp;</td>
									<td class='text-right small text-light' id='gold' title='보유 골드'></td>
								</tr>
							</table>
						</div>
					</div>
					<div class='row mt-1 justify-content-end'>
						<div class='col col-c p-0 mt-2'>
							<h6 class='text-center'>
								<span class='badge bg-light text-primary ml-2 mr-0'>LV</span>
								<span class='text-left font-weight-bold' id='usrLv'></span>
							</h6>
						</div>
						<div class='col col-d pl-0 m-0'>
							<div class='row ml-3'>
								<h6 class='text-left small mb-0'>EXP</h6>
							</div>
							<div class='row mr-4 ml-3'>
								<progress id='expPoint' max='100'></progress>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class='container usrDetail'>
		<div class='row border d-flex justify-content-between py-3' id='authPlease' hidden='true'>
			<div class="col-6">
				<h5 class="titleColor ml-3">메일로 인증 번호를 발송했습니다. 확인해주세요.</h5>
				<h6 class="text-muted small ml-3">메일 인증 작업을 완료하지 않을 시 사이트 내 활동이 불가합니다.</h6>
			</div>
			<div class="col-5">
				<a class="btn btn-secondary float-right mt-2" href="/godgamez.selfdevelopment/user/verifiy">
					번호 입력하기 <i class="fas fa-external-link-alt"></i>
				</a>
				<button class="btn btn-outline-secondary float-right mt-2" id='sendAuthMailBtn'>
					다시 보내기
				</button>
			</div>
			<div class="col-1 mt-2">
				<h5 class="titleColor">
					<button type='button' class="btn" onclick="closeNoob()">ｘ</button>
				</h5>
			</div>
		</div>
		<div class='row mt-5'><a id='questAlbum'></a>
			<div class='col mt-5 ml-5'>
				<h5 class='font-weight-bolder titleColor'>QUEST ALBUM</h5>
				<h6 class='font-weight-bold text-secondary mt-2'>&nbsp;&nbsp;&nbsp;&nbsp;ACCEPTED</h6>
			</div>
		</div>
		<div class='row mt-4' oncontextmenu="return false" ondragstart="return false">
			<div class='col w-100'>
				<div id='accptUsrqstImgList' class='carousel slide pb-5' data-ride='carousel' data-interval=false>
					<div class='carousel-inner'>
						<a href='#accptUsrqstImgList' data-slide='prev' class='carousel-control-prev' id='prevBtn' hidden=true>
							<i class="fas fa-chevron-circle-left"></i>
						</a>
						<div id='accptUsrqstItems'>
						</div>
						<a href='#accptUsrqstImgList' data-slide='next' class='carousel-control-next' id='nextBtn' hidden=true>
							<i class="fas fa-chevron-circle-right"></i>
						</a>
					</div>
					<ul class='carousel-indicators' id='indicators' hidden=true>
					</ul>
				</div>
			</div>
		</div>
		<div class='row justify-content-center'>
			<small class='text-muted'>이미지 클릭 시 해당 퀘스트 수행 페이지로 이동합니다.</small>
		</div>
					
		<div class='row mt-3'><a id='questAlbum'></a>
			<div class='col mt-5 ml-5'>
				<h6 class='font-weight-bold text-secondary'>&nbsp;&nbsp;&nbsp;&nbsp;DONE</h6>
			</div>
		</div>
		<div class='row mt-4'>
			<div class='col w-100'>
				<div id='doneUsrqstImgList' class='carousel slide pb-5' data-ride='carousel' data-interval=false>
					<div class='carousel-inner'>
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
		<hr>
		<div class='row mt-5' oncontextmenu="return false" ondragstart="return false">
			<a id='myCoupon'></a>
			<div class='col mt-5 ml-5'>
				<h5 class='font-weight-bolder titleColor'>MY COUPON</h5>
			</div>
			<div class='col mt-5 mr-5'>
				<div class='float-right text-secondary small btn' onclick='location.href="/godgamez.selfdevelopment/quest/board"' title='골드 벌러 가기 ☞'>
					<i class="fas fa-coins"></i>&nbsp;&nbsp;
					<span id='usrGold' class='h6'></span>
				</div>
				<div class='float-right text-secondary small btn' onclick='location.href="/godgamez.selfdevelopment/coupon/shop"' title='쿠폰 사러 가기 ☞'>
					<i class="fas fa-ticket-alt"></i>&nbsp;&nbsp;
					<span id='cpnCnt' class='h6' title='사용 가능한 쿠폰 수 / 발급받은 쿠폰 수'></span>
				</div>
			</div>
		</div>
		<div class='row mt-4'>
			<div class='col w-100'>
				<div id='usrCpnImgList' class='carousel slide pb-5' data-ride='carousel' data-interval=false>
					<div class='carousel-inner'>
						<a href='#usrCpnImgList' data-slide='prev' class='carousel-control-prev' id='prevBtn' hidden=true>
							<i class="fas fa-chevron-circle-left"></i>
						</a>
						<div id='usrCpnItems'>
						</div>
						<a href='#usrCpnImgList' data-slide='next' class='carousel-control-next' id='nextBtn' hidden=true>
							<i class="fas fa-chevron-circle-right"></i>
						</a>
					</div>
					<ul class='carousel-indicators' id='indicators' hidden=true>
					</ul>
				</div>
			</div>
		</div>
		<div class='row mb-5 justify-content-center'>
			<small class='text-muted'>이미지를 클릭한 후 사용하기를 눌러 쿠폰을 사용할 수 있습니다.</small>
		</div>
		<hr>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>

<!-- 모달 -->
<div id='doneQstImgDetailModal' class='modal fade' tabindex='-1'>
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
				<div class='row justify-content-center'>
					<small class='text-muted mt-3'>
						이미지 저장을 원하시면 우클릭 후 "이미지를 다른 이름으로 저장"을 눌러주세요.
					</small>
				</div>
			</div>
			<div class='modal-footer'>
				<div class='row w-100 justify-content-center'>
					<button class='btn btn-outline-secondary' id='delDoneQstImgBtn'> 삭 제 </button>
					<span>&nbsp;</span>
					<button class='btn btn-secondary'
						data-dismiss='modal' data-toggle='modal' data-target='#doneQstImgDetailModal'> 닫 기 </button>
				</div>
			</div>
		</div>
	</div>
</div>

<div id='cpnDetailModal' class='modal fade' tabindex='-1' oncontextmenu="return false" ondragstart="return false">
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<span class='mt-2'>쿠폰 사용</span>
				<button class='m-0 p-0 btn close float-right' data-dismiss='modal'>×</button>
			</div>
			<div class='modal-body'>
				<div class='row justify-content-center'>
					<div id='cpnImgDetailParent'>
						<div id='fadeCode' hidden=true>
							<div class='h1 w-100 text-center' onclick='showCpnCode()' id='showCpnIcon' hidden=true>
								<i class="fas fa-redo-alt"></i>
							</div>
							<div id='countDown' class='h3 w-100 text-center'></div>
							<div id='cpnCode' class='h1 w-100 text-center font-weight-bolder'></div>
						</div>
						<img alt='쿠폰 사용처 이미지' id='cpnImgDetail'>
					</div>
				</div>
				<div class='row mt-3'>
					<div class='ml-3 col-6 align-self-center'>
						<span class='h5 font-weight-bold text-secondary ml-3 float-left'>
							사용처 &nbsp;
							<span class='text-dark font-weight-light' id='cpnStore'></span>
						</span>
					</div>
					<div class='col-5 align-self-center'>
						<span class='h5 font-weight-bold text-secondary ml-2 float-left'>
							할인율 &nbsp;
							<span class='text-dark font-weight-light' id='cpnDcPer'></span>
						</span>
					</div>
				</div>
			</div>
			<div class='modal-footer text-center justify-content-center'>
				<button class='btn btn-outline-secondary w-25' data-dismiss='modal' data-toggle='modal' data-target='#cpnDetailModal'> 닫&nbsp;&nbsp;기 </button>
				<button class='btn btn-secondary w-25' id='seeCpnCodeBtn' onclick='showCpnCode()'>코드 보기</button>
				<button class='btn btn-secondary w-25' id='useCpnBtn' hidden=true>사용하기</button>
				<span>"코드 보기" 버튼을 눌러 쿠폰 코드를 확인한 후<br>10초 안에 "사용하기" 버튼을 눌러주세요!</span>
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