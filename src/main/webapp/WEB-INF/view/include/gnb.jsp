<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<style>


#gnb {
	background: #0367A6;
 	color: #F2F2F2;
}

.dropdown .dropdown-menu {
    display: block;
	visibility: hidden;
	opacity: 0;
 	border-radius: 0;
 	transition-duration: .25s;
 	transition-timing-function: ease-in-out;
}

.dropdown:hover {
    background-color: #034C8C;
 	color: #F2F2F2;
 	transition-duration: .2s;
 	transition-timing-function: ease-in-out;
	cursor: default;
}

.dropdown:hover thead {
 	color: #84B1D9;
	transition-duration: .2s;
	transition-timing-function: ease-in-out;
}

.dropdown:hover .dropdown-menu {
    display: block;
	visibility: visible;
    margin-top: 0;
    background-color: #034C8C;
 	border: 1px solid #0367A6;
 	color: #F2F2F2;
 	opacity: 0.8;
 	border-radius: 0;
 	transition-duration: .25s;
 	transition-timing-function: ease-in-out;
}

.dropdown:hover .dropdown-menu a:hover {
	cursor: pointer;
 	text-decoration: none;
	transition-duration: .2s;
	transition-timing-function: ease-in-out;
}


.dropdown td {
	width: 20rem;
}
</style>
<div class='container-fluid' id='gnb'>
	<div class='row'>
		<div class='col'>
			<div class='row dropdown py-3'>
				<table class='text-light'>
					<thead>
						<tr class='text-left'>
							<td></td>
							<td>&nbsp;&nbsp;&nbsp;가이드</td>
							<td>&nbsp;&nbsp;&nbsp;콘텐츠</td>
							<td>&nbsp;&nbsp;&nbsp;고객센터</td>
							<td></td>
						</tr>
					</thead>
				</table>
				<div class='dropdown-menu w-100'>
					<table>
						<tbody>
							<tr>
								<td></td>
								<td><a href='/godgamez.selfdevelopment/guide/aboutUs' class='text-light'>&nbsp;&nbsp;&nbsp;갓겜이란?</a></td>
								<td><a href='/godgamez.selfdevelopment/quest/board' class='text-light'>&nbsp;&nbsp;&nbsp;퀘스트</a></td>
								<td><a href='mailto:godlife.gamez@gmail.com'
									onclick='window.open(this.href, "_blank", "width=500px, height=800px, toolbars=no, scrollbars=yes"); return false;'
									class='text-light'>&nbsp;&nbsp;&nbsp;문의하기</a></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><a href='/godgamez.selfdevelopment/guide/aboutUs#classGuide' class='text-light'>&nbsp;&nbsp;&nbsp;클래스 소개</a></td>
								<td><a href='/godgamez.selfdevelopment/coupon/shop' class='text-light'>&nbsp;&nbsp;&nbsp;쿠폰 상점</a></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><a href='/godgamez.selfdevelopment/guide/aboutUs#contentsGuide' class='text-light'>&nbsp;&nbsp;&nbsp;콘텐츠 소개</a></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>