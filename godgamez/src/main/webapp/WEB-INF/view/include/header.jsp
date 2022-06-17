<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<style>
#startImage:hover {
	transition: 0.5s;
	filter : invert(1);
}
</style>

<header class='container-fluid  headerFooter text-light'>
	<div class='row justify-content-between'>
		<div class='col-15'>
			<a class='btn' href='/godgamez/'>
				<img src='/godgamez/res/logo/logo_light.jpg' id='logoImg' alt='로고이미지'>
			</a>
		</div>
		<div class='col align-self-center'>
		<c:choose>
			<c:when test="${sessionScope.user != null && sessionScope.user.position eq 'GM'}">
				<small class='text-left font-weight-bold'>
					<a href='/godgamez/admin' class='text-light'>관리페이지</a>
				</small>
			</c:when>
			<c:when test="${sessionScope.user != null}">
				<small class='text-left font-weight-bold'>
					<c:out value="${sessionScope.user.regDate}"/>
					부터 달리는 중
				</small>
			</c:when>
			<c:otherwise>
				<small class='text-left font-weight-bold'>더 나은 내일의 나를 위해</small>
			</c:otherwise>
		</c:choose>
		</div>
		<div class='col align-self-center'>
			<div class='row justify-content-end'>
				<c:choose>
					<c:when test="${sessionScope.user != null}">
						<a href="/godgamez/user/mypage" id="mypageLink">
							<small class="text-light font-weight-bold mr-3">
								<c:out value="${sessionScope.user.nickname}"/>
								<c:out value="${sessionScope.user.usrLv}"/>
							</small>
						</a>
						<a href="/godgamez/user/logout" id="logOutLink">
							<small class="mr-3">Log out</small>
						</a>
					</c:when>
					<c:otherwise>
						<a href='/godgamez/user/join/step1'>
							<small class='text-light mr-3'>Join us</small>
						</a>
						<a href='/godgamez/user/login'>
							<small class='text-light mr-3'>Log in</small>
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class='col-15'>
			<a class='btn' href='/godgamez/quest/board'>
				<img src='/godgamez/res/main/start_button.png' id='startImage' alt='START' class='border-0'>
			</a>
		</div>
	</div>
</header>
