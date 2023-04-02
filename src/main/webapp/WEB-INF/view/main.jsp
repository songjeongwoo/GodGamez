<title>갓겜즈 | 갓생살기 프로젝트</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='include/lib.jsp' %>
<style>
.card {
	height: 100%;
	width: 100%;
	cursor: pointer;
	width: 12rem;
}

.card-body div {
	height: 100%;
	width: 100%;
	position: relative;
	overflow: hidden;
}

.card-body div video {
	height: 100%;
	position: absolute;
	top: 0;
	left: -6.2rem;
	z-index: 1;
}

.card-body div h6 {
	position: absolute;
	top: 0.4rem; /* 나중에 0.2rem으로 바꿀 예정 */
	left: 0.3rem;
	z-index: 2;
}

#body table {
	height: 100%;
	text-align: center;
	background-color: rgba(255, 255, 255, 0.5);
}

#rankingBoard a {
	cursor: pointer;
	text-decoration: none;
}
#rankingBoard tr:hover {
	transform: rotateX(360deg);
	transition: all ease 1s;
	cursor: pointer;
}
</style>
<script>
$(document).ready(function() {
	$(getRankers);
})

function getRankers() {
	$('#rankingBoard').empty();
	
	$.ajax('/godgamez.selfdevelopment/user/get/rankers')
		.done(rankers => {
			if(rankers.length) { 
				let rankerList = [];
				
				$.each(rankers, (idx, ranker) => {
					if(idx < 10) {
						i = idx + 1;
						rankerLv = parseInt(ranker.usrLv);
						rankerList.push(
							`<tr id='rankerDetail'>
								<td class='font-weight-bolder' id='rank'>\${i}</td>
								<td colspan='3' class='text-left'>
									<a class='titleColor' id='rankerNick' onclick='playerPage("\${ranker.nickname}")'>\${ranker.nickname}</a>
								</td>
								<td colspan='2' class='text-left'>
									<span class='h6 badge badge-sm badge-secondary small mb-0'>LV</span>
									<span class='font-weight-bold p-0 inline-block small' id='rankerLv'>\${rankerLv}</span>
								</td>
							</tr>`);
					}
				});
				$('#rankingBoard').append(rankerList.join(''));
			} else $('#rankingBoard').append('<tr><td colspan="6" class="text-center">회원이 없습니다.</td></tr>');
		}).fail(() => {
			$('#rankingBoard').append('<tr><td colspan="6" class="text-center">회원을 조회하지 못했습니다.</td></tr>');
		})
}

function playerPage(nickname) {
	targetData = {nickname: nickname}
	$.ajax({
		url: "/godgamez.selfdevelopment/user/get",
		type: "POST",
        contentType: "application/json",
		data: JSON.stringify(targetData),
        success: function(target) {
        	if(target != null)
        		location.href="/godgamez.selfdevelopment/user/playerpage/" + target.usrCode;
        	else modal("회원", "조회", "실패10", "존재하지 않는 회원입니다.");
        }, fail: function() {
        	modal("회원", "조회", "실패10", "회원을 조회할 수 없습니다.");
        	$(getRankers);
        }
	})
}
</script>
<%@ include file='include/header.jsp' %>
<%@ include file='include/gnb.jsp' %>
<div class='container d-flex justify-content-center' id='body'>
	<div class='row w-100 h-50 mt-5'>
		<div class='col mt-5'>
			<div class='row my-5'>
				<div class='col d-flex justify-content-end'>
					<div class='card p-0 m-0' onclick='location.href="/godgamez.selfdevelopment/quest/board"' title='현생으로 모험을 떠나보자!'>
						<div class='card-body p-0 m-0'>
							<div>
								<video class='btn p-0 m-0' autoplay loop muted>
							    	<source src="/godgamez.selfdevelopment/res/main/main_quest_btn.mp4" type="video/mp4">
								</video>
								<h6 class='font-italic font-weight-bolder text-white'>현생에서 레벨업!!!</h6>
							</div>
						</div>
						<div class='card-footer p-0 m-0 bg-secondary text-center'>
							<div class='align-self-center p-0 m-0'>
								<h4 class='text-light font-weight-bolder my-3 ml-1'>
									QUEST
									<i class="fas fa-play-circle"></i>
								</h4>
							</div>
						</div>
					</div>
				</div>
				<div class='col d-flex justify-content-center'>
					<table class='border table table-secondary table-sm text-nowrap table-hover'>
						<thead class='text-center py-0'>
							<tr class='py-0'>
								<td colspan='6' class='py-0'>
									<h4 class='font-weight-bolder my-3 mx-2'>RANKING</h4>
								</td>
							</tr>
						</thead>
						<tbody id='rankingBoard'>
						</tbody>
					</table>
				</div>
				<div class='col d-flex justify-content-start'>
					<div class='card p-0 m-0' onclick='location.href="/godgamez.selfdevelopment/coupon/shop"' title='퀘스트를 깨면 어마어마한 보상이...!'>
						<div class='card-body p-0 m-0'>
							<div>
								<video class='btn p-0 m-0' autoplay loop muted>
							    	<source src="/godgamez.selfdevelopment/res/main/main_reward_btn.mp4" type="video/mp4">
								</video>
								<h6 class='font-italic font-weight-bolder text-dark'>
									퀘스트를 깨면<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보상이 와르르!
								</h6>
							</div>
						</div>
						<div class='card-footer p-0 m-0 bg-secondary text-center'>
							<div class='align-self-center p-0 m-0'>
								<h4 class='text-light font-weight-bolder my-3 ml-1'>
									REWARD
									<i class="fas fa-play-circle"></i>
								</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file='include/footer.jsp' %>