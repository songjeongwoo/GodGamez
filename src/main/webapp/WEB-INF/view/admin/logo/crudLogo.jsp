<title>갓겜:이미지 관리</title>
<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ include file='../../include/lib.jsp' %>

<style>
#logoTable, #addLogo{
	margin:1rem;
	width: 100%;
}

#logoTitle{
	font-size:20;
}

#logoButton {
	float:right;
}

#logo{
	margin-top: 0.5rem;
	margin-bottom: 0.5rem;
	background-color:#e9e9e9;
	border:0.01rem solid lightgrey;
	height: 4rem;
	width: 6rem;
}

#logoListTable {
	min-width: 25rem;
}

#adminBody #logoListTable th, td{
	min-width: 25rem;
	text-align:center;
}

#addLogoButton {
	margin: 0;
}

#previewImg{
	margin: 1.8rem;
	margin-top: 0;
	height: 20rem;
	width: calc(100% - 3.6rem);
}

#fileButton{
	padding-left: 1rem;
	margin-left:2rem;
	margin-top:1rem;
}

#addLogo th{
	min-width: 5rem;
	text-align:center;
}

#addLogo td{
	min-width: 20rem;
	width: 100%;
}

#addLogo input {
	margin: 1rem;
	width: calc(100% - 2rem);
	border: none;
	background: transparent;
}

#addLogo input::placeholder{
	color: #D2D2D2;
}

#modalPreviewImg, #fixPreviewImg {
	margin: 1rem;
	height: 10rem;
	max-width: 90%;
}

#modalFileButton {
	margin: 1rem;
}

#modalTable {
	width: 100%;
}

#modalTable th {
	padding-left: 0.3rem;
	width: 15%;
	height: 3rem;
}

#modalTable input{
	margin: 1%;
	margin-left: 5%;
	width: 90%;
	border: none;
	background: transparent;
}

@media (max-width: 768px) {
	#adminGnb {
		height: calc(100% + 27rem);
	}
}

.btnLike {
	cursor: pointer;
}
</style>

<script>
/*
이미지 로드 ajax로 이미지 추가(?) 일단보류
function loadLogo(){
	$.ajax({
        method: 'post',
        url:"${pageContext.request.contextPath}/admin/logo",
        success: result => {
           if(result != "") {
           	$('#previewImg').show();
           	var filePlace = "/res/"+result;
           	var srcValue = `<c:url value="/res/\${result}"/>`
           	$('#previewImg').attr('src', srcValue);
           } else {
           	$('#previewImg').hide();
           }
        }
     })
} 

	$('#addLogoBtn').click(() => {
		if(isVal($('#inputMoveUrl')) && isVal($('#inputAltText')) && uploadedImg == 1) {
			let data = $('form')[0];
			let formData = new FormData(data);
		
		$.ajax({
			url: '/godgamez.selfdevelopment/logo/upload',
			method: 'POST',
			data,
	        processData: false,
	        contentType: false,
	        success: function(fileName) {
	        	console.log(fileName);
	        	if(fileName.length > 0) {
		        	console.log("이미지 업로드 성공");
	        	} else modal("이미지", "추가", "실패");
	        }, fail: function() {
	        	modal("이미지", "추가", "실패");
	        }
		});
	}	
});
*/

let uploadedImg = 0;
let fixImg = 0;
/*수정모달 이미지 미리보기*/
function showFixImg(input) {
	if(input.files[0]) {
		let reader = new FileReader();
		reader.readAsDataURL(input.files[0]);
		
		reader.addEventListener('load', () => {
			$('#fixPreviewImg').attr('src', reader.result)
		}, false)
		fixImg = 1;
	}
}

/*이미지 추가 미리보기*/
function showImg(input) {
	console.log(input.files)
	if(input.files[0]) {
		let reader = new FileReader();
		reader.readAsDataURL(input.files[0]);
		
		reader.addEventListener('load', () => {
			$('#previewImg').attr('src', reader.result)
		}, false)
		uploadedImg = 1;
	}
}

//이미지 목록
function logoList() {
	$('#logoList').empty()

	$.ajax('/godgamez.selfdevelopment/logo/list')
	.done(logos => {
		console.log(logos);
		console.log(logos.length);
		if(logos.length) {
			let logoList =[]
		
			$.each(logos, (idx, logo) => {
				logoList.unshift(
					`<tr id='selectTable'>
						<td id='checkCol'>
							<input type='checkbox' class='mt-4' name='check1' id='logoCheckIn' value='\${logo.logoId}'>
						</td>
						<td class='btnLike' title='logo.jpg' onclick='logoDetail(\${logo.logoId})'>
							<img id='logo' name='\${logo.logoId}' src='/godgamez.selfdevelopment/res/logo/\${logo.fileName}.jpg'>
						</td>
						<td class='btnLike' title='파일명' id='fileName' onclick='logoDetail(\${logo.logoId})'>
							\${logo.fileName}
						</td>
						<td class='btnLike' title='클릭 시 이동할 페이지' id='linkUrl' onclick='logoDetail(\${logo.logoId})'>
							\${logo.linkUrl}
						</td>
						<td class='btnLike' title='이미지 대체 문구' onclick='logoDetail(\${logo.logoId})'>
							\${logo.altText}
						</td>
					</tr>`
				);
			});
			
			$('#logoList').append(logoList.join(''));
		} else{
			$('#logoList').append('<tr><td colspan=5 class=text-center>이미지가 없습니다.</td></tr>');
		}
	}).fail(() => {
		$('#logoList').append('<tr><td colspan=5 class=text-center>이미지를 조회하지 못했습니다.</td></tr>');
	});
}

function isVal(field) {
	let check = false;
	if(field.length && field.val()) check = true;
	
	return check;
}

//추가
function addLogo() {
	$('#addLogo #fileButton').change(function() {
	      showImg(this);
	   });
	
	$('#addLogoBtn').click(() => {
		if(isVal($('#inputMoveUrl')) && isVal($('#inputAltText')) && uploadedImg == 1) {
			let data = new FormData($('form')[0]);
			
			$.ajax({
				url: '/godgamez.selfdevelopment/logo/add',
				method: 'post',
				contentType: 'application/json',
				data: JSON.stringify({
					fileName: $('#fileNameIn').val() + "",
					linkUrl: $('#inputMoveUrl').val(),
					altText: $('#inputAltText').val()
				}),
				success: result => {
					$('#completeModal').modal();
				}
			}).done(() => {
				modal("이미지", "추가", "성공");
				logoList();
			})
		} else if(isVal($('#inputMoveUrl')) != true || isVal($('#inputAltText')) != true || uploadedImg != 1) {
			modal("이미지", "추가", "실패");
		}
	});
}

//수정
function fixLogo() {
	$.ajax("/godgamez.selfdevelopment/logo/list/" + $('#logoCheckIn:checked').val())
	.done((logo) => {
		if($('#logoCheckIn:checked').length == 1) {
			getSrc = "/godgamez.selfdevelopment/res/logo/" + logo.fileName + '.jpg';
			getFileName = logo.fileName;
			getLinkUrl = logo.linkUrl;
			getAltText = logo.altText;

			$('#fixProcModal #fixPreviewImg').empty();
			$('#fixProcModal #fixPreviewImg').attr("src", getSrc);
			$('#fixProcModal #fixUrl').val(getLinkUrl);
			$('#fixProcModal #fixText').val(getAltText);
			$('#fixProcModal #fixFileName').val(getFileName);
			$('#fixProcModal').modal('show');
			
		} else isChecked("이미지", "수정", "logoCheckIn");
	}).fail(() => {
		isChecked("이미지", "수정", "logoCheckIn"); 
	})
	
	$('#fixProcModal #modalFileButton').change(function() {
		showFixImg(this);
		//$('#fixFileName').val(document.getElementById('modalFileButton').files[0].name)
	});
	
	$('#fixOkBtn').click(() => {
		if(isVal($('#fixUrl')) && isVal($('#fixText')) && fixImg == 1) {
			let data = new FormData($('form')[0]);
			$.ajax({
				url: '/godgamez.selfdevelopment/logo/fix',
				method: 'put',
				data: JSON.stringify({
					logoId: $('#logoCheckIn:checked').val(),
					fileName: $('#fixFileName').val(),
					linkUrl: $('#fixUrl').val(),
					altText: $('#fixText').val()
				}),
				contentType: 'application/json'
			}).done(() => {
				$('#fixProcModal').modal('hide');
				modal("이미지", "수정", "성공");
			});
		} else {
			modal("이미지", "수정", "실패");
		};
	})
}

//삭제
function delB() {
	checkVal = $('#logoCheckIn:checked').val();
	
	$('#logoCheckIn:checked').each(function() {
		checkVal = $(this).val();
		$.ajax({
			url: '/godgamez.selfdevelopment/logo/del/' + checkVal,
			method: 'delete' 
		})
	})
	$(logoList);
	modal("이미지", "삭제", "성공");
}

//클릭시 조회
function logoDetail(logoId) {
	$.ajax("/godgamez.selfdevelopment/logo/list/" + logoId)
		.done((logo) => {
			if(logo != null) {
				getSrc = "/godgamez.selfdevelopment/res/logo/" + logo.fileName + '.jpg';
				getFileName = logo.fileName; 
				getLinkUrl = logo.linkUrl;
				getAltText = logo.altText;

				$('#getModal #modalPreviewImg').empty();
				$('#getModal #modalPreviewImg').attr("src", getSrc);
				$('#getModal #linkUrlView').val(getLinkUrl);
				$('#getModal #altText').val(getAltText);
				$('#getModal #fileName').val(getFileName);
				$('#getModal').modal('show');
			} else modal("이미지", "조회", "실패");
		}).fail(() => {
			modal("이미지", "조회", "실패");
		})
}

$(document).ready(function() {
	$(logoList);
	$(addLogo);
});
</script>

<div class='h-100'>
	<%@ include file='../include/header.jsp' %>
	
	<div id='underHead' class='row w-100'>
	
	<%@ include file='../include/gnb.jsp' %>	
		
		<div class='col' id='adminBody'>
			<div class='row'>
				<div class='col' id='logoTable'>
					<div class='row'>
						<div class='col'>
							<div id='logoTitle'>
								<strong>이미지 목록</strong><hr>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<div class='btn-group m-0 mb-1' id='logoButton'>
								<button id='fix' class='btn btn-secondary' onclick='fixLogo()'>수정</button>
								<button id='del' class='btn btn-secondary' onclick='isChecked("이미지", "삭제", "logoCheckIn")'>삭제</button>
							</div>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<form>
								<table class='table table-sm table-secondary table-hover' id='logoListTable'>
									<thead class='border'>
										<tr>
											<th id='checkCol'><input type='checkbox' id='checkall1'/> </th>
											<th width='25%'>이미지</th>
											<th width='25%'>파일명</th>
											<th width='25%'>연결 URL</th>
											<th width='35%'>대체 문구</th>
										</tr>
									</thead>
									<tbody class='border' id=logoList>
										
									</tbody>
								</table>
							</form>
						</div>
					</div>
					<div class='row'>
						<div class='col'>
							<ul class='pagination justify-content-center' id='pagination'>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>&laquo;</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>1</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>2</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>3</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>4</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>5</a></li>
								<li class='page-item'><a class='page-link border-0 text-dark' href='#'>&raquo;</a></li>
							</ul>
						</div>
					</div>
				</div>
				
				<div class='col' id='addLogo'>
					<div class='row'>
						<div class='col ml-0 mr-3'>
							<div id='logoTitle'>
								<strong>이미지 추가</strong><hr>
							</div>
							<form id='addLogo' method='post' encType='multipart/form-data' action='/godgamez.selfdevelopment/logo/attach'> <!--  encType='multipart/form-data' -->
								<table class='text-nowrap'>
									<thead class='border-0'>
										<tr>
											<th>
											</th>
											<td id='addLogoButton'>
												<button type='submit' id='addLogoBtn' class='btn btn-secondary m-0 mb-1 float-right'>
													추가
												</button> <!-- 나중에 이거 add 버튼 누를 시 스크립트에서 서브밋 및 모달 함수 파라미터 투입값 변화 주기 -->
											</td>
										</tr>
									</thead>
									<tbody class='border'>
										<tr title='사용할 이미지를 넣어주세요.'>
											<th class='bg-secondary text-white'>이미지</th>
											<td>
												<input type='file' name='attachFile' id='fileButton' accept='logo/jpeg, logo/png' required>
											</td>
										</tr>
										<tr>
											<th class='bg-secondary text-white'></th>
											<td><img class='border' id='previewImg'></td>
										</tr>
										<tr title='클릭 시 이동할 페이지의 URL을 입력하세요.'>
											<th class='bg-secondary text-white'>URL</th>
											<td>
												<input type='text' id='inputMoveUrl' placeholder='클릭 시 이동할 페이지의 URL을 입력하세요.' required>
											</td>
										</tr>
										<tr>
											<th class='bg-secondary text-white'>파일명</th>
											<td>
												<input type='text' id='fileNameIn' placeholder='저장할 파일의 이름을 입력하세요.' name='fileNameIn' required>
											</td>
										</tr>
										<tr title='이미지 설명을 입력하세요.'>
											<th class='bg-secondary text-white'>대체 문구</th>
											<td>
												<input type='text' id='inputAltText' placeholder='이미지 설명을 입력하세요.' required>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 -->
<div id='fixProcModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>이미지 수정</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<form id='fixLogo' method='post' encType='multipart/form-data' action='/godgamez.selfdevelopment/logo/attach'>
				<div class='modal-body'>
					<table id='modalTable'>
						<tbody class='text-nowrap'>
							<tr class='border'>
								<th class='bg-secondary text-white'>이미지</th>
								<td>
									<img id='fixPreviewImg' class='border'>
									<br>
									<input class='justify-content-center' type='file' name='attachFile' class='mb-3' id='modalFileButton' accept='logo/jpeg, logo/png' required>
								</td>
							</tr>
							<tr class='border' title='연결된 URL'>
								<th class='bg-secondary text-white'>URL</th>
								<td><input type='text' id='fixUrl' class='text-dark' required></td>
							</tr>
							<tr class='border'>
								<th class='bg-secondary text-white'>대체 문구</th>
								<td><input type='text' id='fixText' class='text-dark' required></td>
							</tr>
							<tr class='border' title='파일명'>
								<th class='bg-secondary text-white'>파일명</th>
								<td><input type='text' id='fixFileName' name='fileNameIn' required></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class='modal-footer justify-content-center pb-0'>
					<button type='button' class='btn btn-outline-secondary' onclick='modal("이미지", "수정", "중단")'>취소</button>
					<button type='submit' class='btn btn-secondary' id='fixOkBtn'>수정</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div id='getModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<strong>이미지 조회</strong>
				<button type='button' class='close' data-dismiss='modal'>
					<span>x</span>
				</button>
			</div>
			<div class='modal-body'>
				<table id='modalTable'>
					<tbody class='text-nowrap'>
						<tr class='border'>
							<th class='bg-secondary text-white'>이미지</th>
							<td>
								<img id='modalPreviewImg' class='border'>
							</td>
						</tr>
						<tr class='border' title='연결된 URL'>
							<th class='bg-secondary text-white'>URL</th>
							<td><input type='text' id='linkUrlView' readonly></td>
						</tr>
						<tr class='border' title='이미지 대체 문구'>
							<th class='bg-secondary text-white'>대체 문구</th>
							<td><input type='text' id='altText' readonly></td>
						</tr>
						<tr class='border' title='파일명'>
							<th class='bg-secondary text-white'>파일명</th>
							<td><input type='text' id='fileName' readonly></td>
						</tr>
					</tbody>
				</table>
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
