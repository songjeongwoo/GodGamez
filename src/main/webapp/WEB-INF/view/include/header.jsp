<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<style>
#startImage:hover {
	transition: 0.5s;
	filter : invert(1);
}
</style>
<script>
$(document).ready(function() {
	$(setHeader);
})

function setHeader() {
	$('header #rightSide').empty();
	$('header #leftSide').empty();
	
	let sessionUser = getConnectedUser();
	
	if(sessionUser) {
		$('header #rightSide').html("<a href='/godgamez.selfdevelopment/user/mypage' id='mypageLink'>"+
				"<small class='text-light font-weight-bold mr-3'>" + sessionUser.nickname +
				" <span class='badge text-primary'>LV " + parseInt(sessionUser.usrLv) + "</span></small></a>"+
				"<a href='/godgamez.selfdevelopment/user/logout' id='logOutLink'><small class='mr-3'>Log out</small></a>");
				
			if(sessionUser.position == "GM")
				$('header #leftSide').html("<a href='/godgamez.selfdevelopment/admin' class='text-light'>관리페이지</a>");
			else if(sessionUser.position != "OUT")
				$('header #leftSide').html(parseInt(Math.abs(new Date() - new Date(sessionUser.regDate))/(1000*60*60*24)) + 1 + "일 째 달리는 중");
			else $('header #leftSide').html("잠시 쉬어가는 중");
	} else {
		$('header #rightSide').html("<a href='/godgamez.selfdevelopment/user/join/step1'><small class='text-light mr-3'>Join us</small></a>"+
			"<a href='/godgamez.selfdevelopment/user/login'><small class='text-light mr-3'>Log in</small></a>");
		$('header #leftSide').html("더 나은 내일의 나를 위해");
	}
}
</script>
<header class='container-fluid  headerFooter text-light'>
	<div class='row justify-content-between'>
		<div class='col-15'>
			<a class='btn' href='/godgamez.selfdevelopment/'>
				<img src='/godgamez.selfdevelopment/res/logo/logo_light.jpg' id='logoImg' alt='로고이미지'>
			</a>
		</div>
		<div class='col align-self-center'>
			<small class='text-left font-weight-bold' id='leftSide'>
			</small>
		</div>
		<div class='col align-self-center'>
			<div class='row justify-content-end' id='rightSide'>
			</div>
		</div>
		<div class='col-15'>
			<a class='btn' href='/godgamez.selfdevelopment/quest/board'>
				<img src='/godgamez.selfdevelopment/res/main/start_button.png' id='startImage' alt='START' class='border-0'>
			</a>
		</div>
	</div>
</header>
