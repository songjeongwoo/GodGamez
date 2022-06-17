<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>

<div class='container-fluid' id='gnb'>
	<div class='row'>
		<div class='col'>
			<div class='row dropdown justify-content-center py-3'>
				<table class='text-light'>
					<thead>
						<tr class='text-center'>
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
								<td class='text-center'><a href='/godgamez/guide/aboutUs' class='text-light'>&nbsp;갓겜이란?</a></td>
								<td class='text-center'><a href='/godgamez/quest/board' class='text-light'>&nbsp;&nbsp;&nbsp;퀘스트</a></td>
								<td class='text-center'><a href='mailto:godlife.gamez@gmail.com'
									onclick='window.open(this.href, "_blank", "width=500px, height=800px, toolbars=no, scrollbars=yes"); return false;'
									class='text-light'>&nbsp;&nbsp;&nbsp;문의하기</a></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td class='text-center'><a href='/godgamez/guide/aboutUs#classGuide' class='text-light'>&nbsp;&nbsp;&nbsp;클래스 소개</a></td>
								<td class='text-center'><a href='/godgamez/coupon/shop' class='text-light'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;쿠폰 상점</a></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td class='text-center'><a href='/godgamez/guide/aboutUs#contentsGuide' class='text-light'>&nbsp;&nbsp;&nbsp;콘텐츠 소개</a></td>
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