<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<div class='text-nowrap' id='adminGnb'>
	<div class='col'>
		<div id='sideMenu' class='accordian mt-3'>
			<div>
				<div id='heading1' class='card-header'>
					<h2 class='mb-0'>
						<button type='button' class='btn btn-block text-left text-light' data-toggle='collapse' data-target='#body1'>회원</button>
					</h2>
				</div>
				<div id='body1' class='collapse' data-parent='#sideMenu'>
					<div class='card-body'>
						<ul class='hyphen text-light'>
							<li>
								<a href='/godgamez.selfdevelopment/admin/users'>회원</a>
							</li>
							<li>
								<a href='/godgamez.selfdevelopment/admin/users/mail'>자동 메일</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div>
				<div id='heading2' class='card-header'>
					<h2 class='mb-0'>
						<button type='button' class='btn btn-block text-left text-light' data-toggle='collapse' data-target='#body2'>콘텐츠</button>
					</h2>
				</div>
				<div id='body2' class='collapse' data-parent='#sideMenu'>
					<div class='card-body'>
						<ul class='hyphen text-light'>
							<li>
								<a href='/godgamez.selfdevelopment/admin/classes'>클래스</a>
							</li>
							<li>
								<a href='/godgamez.selfdevelopment/admin/quests'>퀘스트</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div>
				<div id='heading3' class='card-header'>
					<h2 class='mb-0'>
						<button type='button' class='btn btn-block text-left text-light'
							data-toggle='collapse' data-target='#body3'>쿠폰</button>
					</h2>
				</div>
				<div id='body3' class='collapse' data-parent='#sideMenu'>
					<div class='card-body'>
						<ul class='hyphen text-light'>
							<li>
								<a href='/godgamez.selfdevelopment/admin/coupons'>쿠폰</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div>
				<div id='heading4' class='card-header'>
					<h2 class='mb-0'>
						<button type='button' class='btn btn-block text-left text-light' data-toggle='collapse' data-target='#body4'>홈페이지</button>
					</h2>
				</div>
				<div id='body4' class='collapse' data-parent='#sideMenu'>
					<div class='card-body'>
						<ul class='hyphen text-light'>
							<li>
								<a href='/godgamez.selfdevelopment/admin/logos'>로고</a>
							</li>
							<li>
								<a href='/godgamez.selfdevelopment/admin/log'>로그</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>