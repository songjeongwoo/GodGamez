<title>갓겜:가이드</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../include/lib.jsp' %>

<style>
body {
	background: linear-gradient(to bottom, #F2F2F2 25%, #0367A6);
} 

#guideTitle{
	margin-top:1rem;
	font-size:20;
}

#banner{
	border:none;
	height: 20rem;
	min-width:100%;
	min-height: 100%;
	margin-top:3rem;
	object-fit: cover;
}

#article{
	margin-top:5rem;
}

#cards img {
	max-height: 100%;
	max-width: 100%;
	object-fit: cover;
}

.card {
	text-align: center;
	height:27rem;
	width:20rem;
	border: 0;
}

.card-body {
	overflow: hidden;
	padding: 0;
	border: 0;
}

.card-footer {
	color: white;
	background-color: #034C8C;
	border: 0;
}

#content, #class{
	margin-top:7rem;
	margin-bottom:10rem;
}

#backGround{
	margin-top:9rem;
}

#topBtn {
	position: fixed;
	right: 3rem;
	bottom: 3rem;
	display:none;
	z-index:9;
	background-color: white;
	border-radius: 50%;
	border: 0;
}

textarea {
	resize: none;
	border: none;
	height: 17rem;
	scroll: none;
	overflow: hidden;
	background-color: transparent;
}

textarea:focus {
	outline: none;
}
</style>

<script>
$(function() {
	$(window).scroll(function(){
		if($(this).scrollTop() > 50) {
			$('#topBtn').fadeIn()}
		else { $('#topBtn').fadeOut();}
		});
	$('#topBtn').click(function(){
		$('html, body').animate({scrollTop:0},300);
	return false;});
});
</script>

<%@ include file='../include/header.jsp' %>
<%@ include file='../include/gnb.jsp' %>

<a id='topBtn' class='titleColor h1 font-weight-bold' href='#'>
	<i class="fas fa-arrow-alt-circle-up"></i>
</a>

<div id='body'>
	<div class='container my-5'>
		<div class='row'>
			<div class='col'>
				<div id='guideTitle'>
					<h1 class='font-weight-bolder font-italic text-secondary'>GUIDE</h1>
					<hr>
				</div>
			</div>
		</div>
		<div class='row'>
			<div class='col'>
				<nav class='nav'>
					<a class='mr-3 titleColor' href='#godgameGuide'>갓겜이란?</a>|
					<a class='mr-3 ml-3 titleColor'href='#classGuide'>클래스 소개</a>|
					<a class='ml-3 titleColor' href='#contentsGuide'>콘텐츠 소개</a> 
				</nav>
			</div>
		</div>
	</div>
	<div class='container-fluid'>
		<div class='row' id='godgameGuide'>
			<img src='/godgamez.selfdevelopment/res/guide/guide_banner.png' alt='배너이미지' id='banner'>
		</div>
	</div>
	<div class='container'>
		<div class='row' id='article'>
			<div class='col-5 text-right titleColor'>
				<h3>더 나은 내일의</h3>
				<h2><b>"나"</b>를 위해</h2>
			</div>
			<div class='col pl-5 ml-3 mr-5'><textarea class='titleColor w-100' readonly>
"갓겜즈"는 갓생살기게임즈의 약어로,
오늘의 나에 머무르지 않고 끊임없는 자기개발을 통해 발전하는
현생의 플레이어들을 위한 서비스입니다.
갓겜즈에서 퀘스트를 수행하여 레벨을 올리면,
다음 단계로 올라갈 때마다 추가적으로 골드를 얻습니다.
이 게임을 자기개발의 출발점으로 삼아
내일의 나를 만들 수 있는 여러분이 될수 있기를 바랍니다.</textarea>
			</div>	
		</div>
		<div class='row py-5 mb-0' id='backGround'>
			<div class='container'>
				<div id='classGuide'>
					<div class='row mt-3 mb-5' id='cards'>
						<div class='col d-flex justify-content-center'>
							<div class='card'>
								<div class='card-body'>
									<img alt='공부도구 이미지' src='/godgamez.selfdevelopment/res/guide/guide_study.png'>
								</div>
								<div class='card-footer'>
									<div class='row'>
										<div class='col d-flex justify-content-start'>
											<span>&nbsp;&nbsp;&nbsp;</span>
											<span>• 취미&nbsp;&nbsp;&nbsp;</span>
											<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
											<span>• 언어</span>
										</div>
									</div>
									<div class='row'>
										<div class='col d-flex justify-content-start'>
											<span>&nbsp;&nbsp;&nbsp;</span>
											<span>• 코딩&nbsp;&nbsp;&nbsp;</span>
											<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
											<span>• 자격증</span>
										</div>
									</div>
								</div>
							</div>			
						</div>
						<div class='col'>
							<div class='row justify-content-center mt-5'>
								<h1 class='font-weight-bolder text-secondary'>
									CLASS
								</h1>
							</div>
							<div class='row d-flex justify-content-center mt-5'>
								<div class='card mt-5'>
									<div class='card-body'>
										<img alt='운동도구 이미지' src='/godgamez.selfdevelopment/res/guide/guide_sports.png'>
									</div>
									<div class='card-footer'>
										<div class='row'>
											<div class='col d-flex justify-content-start'>
												<span>&nbsp;&nbsp;&nbsp;</span>
												<span>• 무산소&nbsp;&nbsp;&nbsp;</span>
												<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
												<span>• 유산소</span>
											</div>
										</div>
										<div class='row'>
											<div class='col d-flex justify-content-start'>
												<span>&nbsp;&nbsp;&nbsp;</span>
												<span>• 스포츠&nbsp;&nbsp;&nbsp;</span>
												<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
												<span>• 취미</span>
											</div>
										</div>
									</div>
								</div>	
							</div>		
						</div>
					</div>
				</div>
				<div id='contentsGuide'>
					<div class='row mt-5' id='cards'>
						<div class='col d-flex justify-content-center'>
							<div class='card'>
								<div class='card-body'>
									<img alt='퀘스트 이미지' src='/godgamez.selfdevelopment/res/guide/guide_quest.png'>
								</div>
								<div class='card-footer text-center'>
									<h4 class='font-weight-bold'>Quest</h4>
									<a>퀘스트를 클리어해서 레벨을 올리세요</a>
								</div>
							</div>			
						</div>
						<div class='col'>
							<div class='row justify-content-center mt-5'>
								<h1 class='font-weight-bolder text-secondary'>
									CONTENTS
								</h1>
							</div>
							<div class='row d-flex justify-content-center mt-5'>
								<div class='card mt-5'>
									<div class='card-body'>
										<img alt='보상 이미지' src='/godgamez.selfdevelopment/res/guide/guide_reward.png'>
									</div>
									<div class='card-footer text-center'>
										<h4 class='font-weight-bold'>Reward</h4>
										<a>목표를 달성해 보상을 받으세요</a>
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