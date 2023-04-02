<title>갓겜:쿠폰</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>
<style>
#modalImg {
	width: 100%;
	height: 10rem;
}

#modalX {
	float: right;
}

.modal-body {
	text-align: center;
}

.card {
	margin: 0.3rem;
}

.card-img {
	width: 100%;
	height: 100%;
}

.radius {
	border-radius: 0rem;
}

.card-body {
	padding: 0rem;
}
</style>
<script>
$(document).ready(function() {
	let sessionUser = getConnectedUser();
	
	if(sessionUser) $('#myGold').text(sessionUser.gold + ' 골드');
	else $('#myGold').text('');
	
	$('#cpnSetting #redeemCpnModalBtn').click(function() {
		$('#cpnDetailModal #store').text("");
		$('#cpnDetailModal #dcPer').text("");
		$('#cpnDetailModal #modalImg').removeAttr("src");
		
		parent = $(this).closest('#cpnSetting');
		storeVal = $(this).closest('div').attr("id");
		
		store = parent.find('#store').text();
		dcPer = parent.find('#dcPer').text();
		minLv = parent.find('#minLevel').text();
		price = parent.find('#price').text();
		
		if(sessionUser) {
			if(sessionUser.usrLv < minLv)
				modal("쿠폰", "발급", "실패10", "회원님의 레벨이 쿠폰 발급 제한 레벨보다 낮습니다.");
			else if(sessionUser.gold < price)
				modal("쿠폰", "발급", "실패10", "골드가 부족합니다.");
			else {
				$('#cpnDetailModal #store').text(store);
				$('#cpnDetailModal #dcPer').text(dcPer);
				$('#cpnDetailModal #modalImg').attr("src", "/godgamez.selfdevelopment/res/coupon/" + storeVal + ".jpg");
				$('#cpnDetailModal #useDetail').attr("name", storeVal);
				$('#cpnDetailModal').modal('show');
			}
		} else modal("","","실패8");
	})
})

function redeemCpn() {
	let sessionUser = getConnectedUser();
	
	if(sessionUser) {
		$.ajax({
			url: '/godgamez.selfdevelopment/user/useGold',
			method: 'patch',
			data: JSON.stringify($('#cpnDetailModal #dcPer').text()/10),
			contentType: 'application/json',
			success: function(result) {
				if(result) {
					$.ajax({
						url: '/godgamez.selfdevelopment/coupon/add',
						method: 'post',
				        data: JSON.stringify({
							cpnCode: 0,
							usrCode: sessionUser.usrCode,
							availability: 1,
							store: $('#cpnDetailModal #useDetail').attr("name"),
							dcPer: $('#cpnDetailModal #dcPer').text() / 100
						}),
				       	contentType: "application/json"
				    }).done(result => {
				    	if(result) modal('쿠폰', '발급', '성공')
				    	else modal('쿠폰', '발급', '실패')
				    }).fail(() => {modal('쿠폰', '발급', '실패')})
				} else modal('쿠폰', '발급', '실패');
			}, fail: function() {
				modal('쿠폰', '발급', '실패');
			}
		})
	} else modal("","","실패8");
}
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<div id='body'>
	<div class='container my-5'>
		<div class='row	my-5'>
			<div class='col'>
				<div id='title'>
					<h4><strong>쿠폰 목록</strong></h4><hr>
				</div>
				<div hidden='true' id='userDom'>${sessionScope.user};</div>
				<p style='text-align: right;' id='gold'>보유 골드: <strong><a href='/godgamez.selfdevelopment/user/mypage' id='myGold'></a></strong></p>
			</div>
		</div>
		<div class='row justify-content-center mt-4'>
			<div class='col card-deck'>
				<div class='card ml-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/BOOKSTORE.jpg' alt='보상 서점 이미지' class='card-img' id='bookImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>서점</span>&nbsp;<span id='dcPer'>10</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>10</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>1</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn' data-toggle='modal' data-target='#cpnDetailModal'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/BOOKSTORE.jpg' alt='보상 서점 이미지' class='card-img' id='bookImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>서점</span>&nbsp;<span id='dcPer'>20</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>20</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>2</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card mr-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/BOOKSTORE.jpg' alt='보상 서점 이미지' class='card-img' id='bookImg'>
								<span id='imgId' hidden='true'><!-- 이미지아이디 --></span>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>서점</span>&nbsp;<span id='dcPer'>30</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='BOOKSTORE'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>30</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>3</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div> 
				</div>
			</div>
		</div>
		<div class='row justify-content-center mt-3'>
			<div class='col card-deck'>
				<div class='card ml-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/ONLINECLASS.jpg' alt='보상 인터넷 강의 이미지' class='card-img' id='onlineImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store' class='text-nowrap'>강의</span>&nbsp;<span id='dcPer'>10</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<p class='card-text text-muted'>&nbsp;&nbsp;&nbsp; <span id='minLevel'>10</span> 이상</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/ONLINECLASS.jpg' alt='보상 인터넷 강의 이미지' class='card-img' id='onlineImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store' class='text-nowrap'>강의</span>&nbsp;<span id='dcPer'>20</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<p class='card-text text-muted'>&nbsp;&nbsp;&nbsp; <span id='minLevel'>20</span> 이상</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card mr-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/ONLINECLASS.jpg' alt='보상 인터넷 강의 이미지' class='card-img' id='onlineImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store' class='text-nowrap'>강의</span>&nbsp;<span id='dcPer'>30</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='ONLINECLASS'>
										<p class='card-text text-muted'>&nbsp;&nbsp;&nbsp; <span id='minLevel'>30</span> 이상</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div> 
			</div>
		</div>
		<div class='row justify-content-center mt-3'>
			<div class='col card-deck'>
				<div class='card ml-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/SPORTSHOP.jpg' alt='보상 스포츠 이미지' class='card-img' id='sportsImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>스포츠샵</span>&nbsp;<span id='dcPer'>10</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>10</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>1</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/SPORTSHOP.jpg' alt='보상 스포츠 이미지' class='card-img' id='sportsImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>스포츠샵</span>&nbsp;<span id='dcPer'>20</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>20</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>2</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='card mr-0'>
					<div class='card-body' id='cpnSetting'>
						<div class='row'>
							<div class='col pr-0'>
								<img src='/godgamez.selfdevelopment/res/coupon/SPORTSHOP.jpg' alt='보상 스포츠 이미지' class='card-img' id='sportsImg'>
							</div>
							<div class='col'>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<h4 class='card-title mt-1'>&nbsp;<span id='store'>스포츠샵</span>&nbsp;<span id='dcPer'>30</span>%</h4>
									</div>
								</div>
								<div class='row'>
									<div class='col pl-0' id='SPORTSHOP'>
										<p class='card-text text-muted'>
											&nbsp;&nbsp;&nbsp;LV <span id='minLevel'>30</span> 이상
											&nbsp;&nbsp;&nbsp;<span id='price'>3</span> GOLD
										</p>
										<button type="button" class="btn btn-secondary btn-block radius" id='redeemCpnModalBtn'>받기</button>
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
<%@ include file='../include/footer.jsp' %>

<!-- Modal -->
<div id='cpnDetailModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='mr-3' id ='modalX'>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<div class='modal-body'>
				<div class='container'>
					<div class='row'>
						<div class='col'>
							<div class='row'>
								<img id='modalImg'>
							</div>
							<div class='row pr-0' id='useDetail'>
								<p><span id='store'><!-- 인터넷 강의 --></span> <span id='dcPer'><!-- 20 --></span>% 할인 쿠폰</p>
							</div>
						</div>
						<div class='col col-7' style='text-align: left;'>
							<strong>사용 방법</strong><br>
							<p><small>마이 페이지에서 쿠폰을 클릭하여 사용한다.</small></p>
							<strong>혜택 내용</strong>
							<p><small>결제금액의 일정 퍼센트를 할인받는다.</small></p>
							<button type='button' class='btn btn-secondary btn-block' onclick="redeemCpn()">&nbsp;&nbsp;&nbsp;쿠폰 받기&nbsp;&nbsp;&nbsp;</button>
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