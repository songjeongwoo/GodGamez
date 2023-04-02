<title>갓겜:관리자 메인</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#usrUnregBtn,
#usrPlayerBtn,
#cnclOutBtn {
	border-top: 0;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
</style>
<script>
function getNoobs() {
	$('#noobTbody').empty();
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'NOOB'}),
		success: function(noobs) {
			if(noobs.length) {
				let noobList = [];
				$.each(noobs, (idx, noob) => {
					noobList.push(
						`<tr id='noobDetail'>
							<td id='checkCol'>
								<input type='checkbox' name='check1' id='usrCode' value='\${noob.usrCode}'>
							</td>
							<td id='position'>\${noob.position}</td>
							<td id='usrId'>\${noob.usrId}</td>
							<td id='regDtae'>\${noob.regDate}</td>
						</tr>`);
					});
				$('#noobTbody').append(noobList.join(''));
				
				$('#noobUsrCnt').each(function () {
					$(this).prop('Counter',0).animate({
						Counter: noobs.length
					}, {
						duration: 800,
						easing: 'swing',
						step: function (now) {
						$(this).text(Math.ceil(now));
						}
					});
				})
			} else {
				$('#noobTbody').append('<tr><td colspan="4" class="text-center">신규 회원이 없습니다.</td></tr>');
				$('#noobUsrCnt').text("0");
			}
		},
		fail: function() {
			$('#noobTbody').append('<tr><td colspan="4" class="text-center">신규 회원을 조회하지 못했습니다.</td></tr>');
		}
	})
}

function getOuts() {
	$('#outTbody').empty();
	
	$.ajax({
		url: '/godgamez.selfdevelopment/user/listUsers',
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify({position: 'OUT'}),
		success: function(outs) {
			if(outs.length) {
				$('#outCntBox #outUsrCnt').text(outs.length);
				let outList = [];
				$.each(outs, (idx, out) => {
					outList.push(
						`<tr id='outDetail'>
							<td id='checkCol'>
								<input type='checkbox' name='check2' id='usrCode' value='\${out.usrCode}'>
							</td>
							<td id='position'>&nbsp;&nbsp;\${out.position}</td>
							<td id='usrId'>\${out.usrId}</td>
						</tr>`);
					});
				$('#outTbody').append(outList.join(''));
				
				$('#outUsrCnt').each(function () {
					$(this).prop('Counter',0).animate({
						Counter: outs.length
					}, {
						duration: 800,
						easing: 'swing',
						step: function (now) {
						$(this).text(Math.ceil(now));
						}
					});
				});
			} else {
				$('#outTbody').append('<tr><td colspan="3" class="text-center">탈퇴 신청 회원이 없습니다.</td></tr>');
				$('#outUsrCnt').text("0");
			}
		},
		fail: function() {
			$('#outTbody').append('<tr><td colspan="3" class="text-center">탈퇴 신청 회원을 조회하지 못했습니다.</td></tr>');
		}
	})
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
        				}, complete: function() {
            				getNoobs();
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
            			}, complete: function() {
            				getOuts();
            			}
            		});
            	}
        	}
        }, fail: function() {
        	modal("회원", "수정", "실패10", "회원을 조회할 수 없습니다.");
        }
	})
}

$(document).ready(function() {
	getNoobs();
	getOuts();
	
	$('#usrPlayerBtn').click(function() {
		noobsCode = $('#noobDetail #usrCode:checked').val();
		if(noobsCode == null) modal("신규 회원", "등급 상승", '실패3');
		else {
			$('#noobDetail #usrCode:checked').each(function() {
				noobCode = $(this).val();
				bePlayer(noobCode);
			})
		}
		$(getNoobs);
	})
	
	$('#cnclOutBtn').click(function() {
		outsCode = $('#outDetail #usrCode:checked').val();
		if(outsCode == null) modal("탈퇴 신청 회원", "복구", '실패3');
		else {
			$('#outDetail #usrCode:checked').each(function() {
				outCode = $(this).val();
				bePlayer(outCode);
			})
		}
		$(getOuts);
	})
	
	$('#usrUnregBtn').click(function() {
		outsCode = $('#outDetail #usrCode:checked').val();
		if(outsCode == null) modal("탈퇴 신청 회원", "삭제", '실패3');
		else {
			modal("탈퇴 신청 회원", "삭제", "확인");
			
			$('#modalBtn #sureBtn').click(function() {
				$('#outDetail #usrCode:checked').each(function() {
					outCode = $(this).val();
					$('#delRst').empty();
					
					$.ajax({
						url: "/godgamez.selfdevelopment/user/del/" + outCode,
						type: "DELETE",
						complete: function(result) {
		    			   $('#delRst').append(`<tr><td>\${result.userCode}</td><td class='text-success'>\${result.isDone}</td></tr>`);
						}
			    	})
			    })
				
				$('#bFResultModal').modal('hide');
				$('#delRstModal').modal('show');
				$('#delRstModal button').click(function() {
					$(getOuts);
				})
			})
		}
	})
})
</script>

<div class='h-100'>
	<%@ include file='include/header.jsp' %>
	<div id='underHead' class='row w-100'>
	<%@ include file='include/gnb.jsp' %>
		<div class='col' id='adminBody'>
			<div class='row'>
				<div class='col'>
					<div class='btn-group border w-100 mt-4 mb-2'>
			            <div class='btn bg-secondary text-light py-2 text-center'>
			            	<h1 id='noobCntBox'>
				                &nbsp;<i class="fas fa-user-plus small"></i><br>
				            	<span class='counter font-weight-bolder' id='noobUsrCnt' onclick='getNoobs()'></span>
			            	</h1>
			            </div>
			            <div class='btn text-secondary py-2 text-center'>
				            <h1 id='outCntBox'>
				                &nbsp;<i class="fas fa-user-minus small"></i><br>
				            	<span class='counter font-weight-bolder' id='outUsrCnt' onclick='getOuts()'></span>
			            	</h1>
			            </div>
			        </div>
		        </div>
			</div>
			<hr>
			<div class='row'>
				<div class='col mt-2' id='mainUsrJoin'>
					<h4 class='float-left titleColor'>
						가입 회원<i class="fas fa-redo-alt text-muted small btn" onclick='getNoobs()'></i>
					</h4>
					<small>
						<a href='/godgamez.selfdevelopment/admin/users' class='text-secondary float-right'>
							<br>전체보기 <i class="fas fa-chevron-right text-muted small"></i>
						</a>
					</small>
					<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
						<thead>
							<tr class='text-nowrap text-left'>
								<th id='checkCol'>
									<input type='checkbox' id='checkall1'>
								</th>
								<th width='20%'>포지션</th>
								<th width='40%'>ID</th>
								<th width='25%'>가입일</th>
							</tr>
						</thead>
						<tbody class='small text-left' id='noobTbody'>
						</tbody>
					</table>
					<div class='row text-nowrap'>
						<div class='col d-flex justify-content-end'>
							<button class='btn btn-sm btn-secondary' id='usrPlayerBtn'>등급 업</button>
						</div>
					</div>
				</div>
				
				<div class='col mt-2' id='mainUsrUnreg'>
					<h4 class='float-left titleColor'>
						탈퇴 회원<i class="fas fa-redo-alt text-muted small btn" onclick='getOuts()'></i>
					</h4>
					<small>
						<a href='/godgamez.selfdevelopment/admin/users' class='text-secondary float-right'>
							<br>전체보기 <i class="fas fa-chevron-right text-muted small"></i>
						</a>
					</small>
					<table class='table table-sm table-secondary table-hover border mb-0 text-center'>
						<thead>
							<tr class='text-nowrap text-left'>
								<th id='checkCol'>
									<input type='checkbox' id='checkall2'>
								</th>
								<th width='20%'>포지션</th>
								<th width='50%'>ID</th>
							</tr>
						</thead>
						<tbody class='small text-left' id='outTbody'>
						</tbody>
					</table>
					<div class='row text-nowrap'>
						<div class='col d-flex justify-content-end'>
							<div class='btn-group'>
								<button class='btn btn-outline-secondary btn-sm' id='usrUnregBtn'>삭제</button>
								<button class='btn btn-secondary btn-sm' id='cnclOutBtn'>복구</button>
							</div>
						</div>
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