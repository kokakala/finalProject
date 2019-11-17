<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.replyForm_imgDiv{
		width: 10%; height: 10%; border-radius: 50%;
	}
	.replyForm_img{
		width: 70%; height: 70%; border-radius: 50%;
	}
	.replyForm_contentDiv{
		width: 90%; height: 90%;
	}
	
</style>
</head>
<body>

	<jsp:include page="../includes/header.jsp" />


	<!-- Page Content -->
	<div class="container" style="margin-top: 150px; margin-bottom: 70px;">

		<div class="row">

			<!-- 왼쪽부분 -->
			<div class="col-lg-8">

				<!-- Title -->
				<h1 class="mt-4">Style Posting</h1>
				<!-- Author -->
				<p class="lead">
					by <a href="#">Style Blending</a>
				</p>

				<hr>
				<br><br>
				
				<!-- 이미지 -->
				<div style="width: 500px; height: 600px;">
					<img class="img-fluid rounded" style="width: 100%; height: 100%;"
						src="${ pageContext.servletContext.contextPath }/resources/upload/posting/${p.renameImg}" alt="">
				</div>
				<!-- 좋아요,신고-->
				<div>
					<!-- 좋아요아이콘 -->
					<!-- 댓글 아이콘 -->
					<!-- 신고 아이콘 -->
				</div>
				
				<hr>
				
				<!-- Post Content -->
				<p>${p.content }</p>
				
				<hr>

				<!-- 댓글 -->
				<p>View all <b id="rCount">4</b> comments</p>
				<br>
				
				<!-- for문 돌릴떄, 전index랑 같으면  -->
				<div id="replyForm" class="replyForm">
					<!-- <div class="media mb-4 replyForm_div">
						<div class="replyForm_imgDiv">
							<img class="replyForm_img" src="http://placehold.it/50x50">
						</div>
						
						<div class="replyForm_contentDiv">
							닉네임
							<h5 class="mt-0 replyForm_nickname"></h5>
							댓글내용
							<span class="replyForm_content"></span>
							대댓글달기 
							<br>
							<span class="replyForm_likecount"></span>
							<i class="fas fa-caret-up"></i>
							· <a href="#" class="rrBtn"><i style="color: gray;">reply</i></a>
							· <span class="replyForm_date"></span> day ago
						</div>
					</div> -->
	
					<!-- 댓글 -->
					<!-- <div class="media mb-4">
						<img class="d-flex mr-3 rounded-circle"
							src="http://placehold.it/50x50" alt="">
						<div class="media-body">
							<h5 class="mt-0">Commenter Name</h5>
							Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
							scelerisque ante sollicitudin. Cras purus odio, vestibulum in
							vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
							nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
	
							
							대댓글
							<div class="media mt-4">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/50x50" alt="">
								<div class="media-body">
									<h5 class="mt-0">Commenter Name</h5>
									Cras sit amet nibh libero, in gravida nulla. Nulla vel metus
									scelerisque ante sollicitudin. Cras purus odio, vestibulum in
									vulputate at, tempus viverra turpis. Fusce condimentum nunc ac
									nisi vulputate fringilla. Donec lacinia congue felis in
									faucibus.
								</div>
							</div>
	
						</div>
					</div> --> 
		
 				</div>  <!-- #replyForm end -->
 
				<!-- 댓글 달기 폼 : 마우스로 textarea클릭시, 로그인 안되있으면 로그인해달라는 alert띄우기 -->
 				<div id="replyTextarea">
					<div class="card my-4">
						<div class="card-body">
							<div class="form-group">
								<textarea class="form-control" rows="3" id="rContent" placeholder="Post comment.."
										style="resize: none;"></textarea>
							</div>
							<button class="btn btn-dark" id="rBtn" disabled>Post comment</button>
						</div>
					</div>
				</div> <!-- #replyTextarea end -->
				
			</div> <!-- col-lg-8 end -->
			
			
			
			
<!------------------------------------------ 댓글 ajax -------------------------------------->
			<script type="text/javascript">
				$(function() {
					/* 
					getReplyList();
					
					setInterval(function(){
						getReplyList();
					}, 5000); 
					 */
					
					// 댓글폼 클릭시 로그인되있는지 확인
					$("#rContent").on("click", function () {
						var loginUser = "${loginUser.email}";

						if(loginUser == null || loginUser == ""){
							alert("로그인 후 이용 가능하세요");
							return;
							
						}else{ // 로그인 되어있을때
							$("#rBtn").attr("disabled", false);

						}
					});
					
					// 댓글내용 있는지 확인
					$("#rBtn").on("click", function(){
						if($("#rContent").val().length == 0){
							alert("댓글내용을 입력해 주세요");
						}else{
							
							var content = $("#rContent").val();
							var pno = ${p.pno};
							var mno = "${loginUser.mno}"; // var writer = admin;
							
							// 댓글 insert
							$.ajax({
								url:"pReplyInsert.do",
								data:{content:content, 
									  pno:pno,
									  mno:mno},
								success:function(data){
									
									if(data == "success"){
										getReplyList();
										$("#rContent").val("");
									}else{
										alert("댓글 작성 실패");
									}
									
								},error:function(){
									console.log("ajax 통신 실패");
								}
							});
						}
					});
					
				});
				
				//reply 전체리스트 불러오기
				function getReplyList(){
					console.log("select리플 들어옴");
					$.ajax({
						url:"pReplyList.do",
						data:{pno:${p.pno}},
						dataType:"json",
						success:function(data){
							
							console.log(data);

							$replyForm = $("#replyForm");
							$replyForm.html("");
							
							$("#rCount").text(data.length);
							
							if(data.length > 0){ // 댓글이 존재할 경우
								
								// 반복문을 통해서 한 행씩 추가될 수 있도록
								$.each(data, function(index, value){ // value == data[index]
									// 작성자 내용 작성일
									/* $tr = $("<tr></tr>");
									
									$writerTd = $("<td width='100'></td>").text(value.writer);
									$contentTd = $("<td></td>").text(value.content);
									$dateTd = $("<td></td>").text(value.createDate);
									
									$tr.append($writerTd);
									$tr.append($contentTd);
									$tr.append($dateTd);
									
									$tbody.append($tr); */
									console.log("댓글잇움 나와야댄");
									console.log(value.nickName);
									console.log(value.content);
									
									$replyForm_div = $("<div class='media mb-4 replyForm_div'></div>");
									
									$replyForm_imgDiv = $("<div class='replyForm_imgDiv'></div>");	
									$replyForm_contentDiv = $("<div class='replyForm_contentDiv'></div>");
									
									$img = $("<img class='replyForm_img'>").attr("src",'http://placehold.it/50x50');
									$nickname = $("<h5 class='mt-0 replyForm_nickname'></h5>").text(value.nickName);
									$rcontent = $("<span class='replyForm_content'></span><br>").text(value.content);
									$likecount = $("<span class='replyForm_likecount'></span>").text(value.likeCount);
									$likeImg = $("<i class='fas fa-caret-up'></i>");
									$rrBtn = $("<a href=''#' class='rrBtn'><i style='color: gray;'>reply</i></a>");
									$date = $("<span class='replyForm_date'></span>").text(value.enrollDate);
									
									$replyForm_imgDiv.append($img);
									$replyForm_contentDiv.append($nickname).append($rcontent).append($likecount)
													.append($likeImg);
									
									$replyForm_div.append($replyForm_imgDiv).append($replyForm_contentDiv);
									
								});
								
							}else{ // 댓글이 존재하지 않을 경우
								console.log("댓글없움");
								$tr = $("<tr></tr>");
								
								$contentTd = $("<td colspan='3'></td>").text("등록된 댓글이 없습니다.");
								$tr.append($contentTd);
								
								$tbody.append($tr);
							}
							
						},
						error:function(){
							console.log("ajax 통신 실패");
						}
					});
				} //getReplyList end 
				
			</script>
			


			<!-- 오른쪽 -->
			<div class="col-md-4">
			
				<!-- 1. 작성자 정보 -->
				<div class="card my-4" style="padding: 10px;">
					<!-- 작성자 프로필 -->
					<div class="media mb-4" style="margin: 0 !important;">
						<!-- 이미지 -->
						<div style="width: 25%; height: 25%; border-radius: 50%;">
							<img style="width: 80%; height: 80%; border-radius: 50%;"
								src="http://placehold.it/60x60" 
								<%-- src="${ pageContext.servletContext.contextPath }/resources/upload/member/${p.rename_img}" --%>>
						</div>
						<!-- 정보 -->
						<div style="width: 75%; height: 75%;">
							<div >
								<!-- 닉네임 -->
								<h6 style="display: inline-block;">${ p.nickName }</h6>
								<!-- 팬추가 버튼 -->
								<button type="button" class="btn btn-dark btn-sm" 
										style="float: right; margin-right: 20px;">+ fan</button>
							</div>
							<div>
								<!-- 자기소개 -->
								<span style="fint-size:xx-small;">${p.profile }</span> <br>
								<i class="fas fa-map-marker-alt"></i>
								<span style="fint-size:xx-small;">${p.mlocation }</span>
							</div>
							
						</div>
					</div>
				</div>
				
				<!-- 2. 코디 정보 -->
				<div class="card my-4">
					<h5 class="card-header">Clothes stylist</h5>
					<div class="card-body">
						<div class="row">
							<div class="col-lg-12">
								<ul class="list-unstyled mb-0">
									<li>코디정보</li>
								</ul>
								
							</div>
						</div>
					</div>
				</div>
				
				<!-- 3. 촬영위치(지도api) -->
				<div class="card my-4">
					<h5 class="card-header">Location</h5>
					<div class="card-body">
						<div id="map" style="height: 300px;"></div>
						<br>
						<span>${p.location }</span>
					</div>
				</div>
				
				
				<!-- Search Widget -->
				<div class="card my-4">
					<h5 class="card-header">Search</h5>
					<div class="card-body">
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Search for..."> <span
								class="input-group-btn">
								<button class="btn btn-secondary" type="button">Go!</button>
							</span>
						</div>
					</div>
				</div>

				<!-- Categories Widget -->
				<div class="card my-4">
					<h5 class="card-header">Categories</h5>
					<div class="card-body">
						<div class="row">
							<div class="col-lg-6">
								<ul class="list-unstyled mb-0">
									<li><a href="#">Web Design</a></li>
									<li><a href="#">HTML</a></li>
									<li><a href="#">Freebies</a></li>
								</ul>
							</div>
							<div class="col-lg-6">
								<ul class="list-unstyled mb-0">
									<li><a href="#">JavaScript</a></li>
									<li><a href="#">CSS</a></li>
									<li><a href="#">Tutorials</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<!-- Side Widget -->
				<div class="card my-4">
					<h5 class="card-header">Spotlight</h5>
					<div class="card-body">
						<div style="width: 50%; height: 50%; border: 1px solid red;">
							<img style="width: 100%; height: 100%;">
						</div>
						<div style="width: 50%; height: 50%; border: 1px solid red;">
							<img style="width: 100%; height: 100%;">
						</div>
					</div>
				</div>

			</div>

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->
	
	
	
	

	<!-------------------------------------------------------- 지도api  -------------------------------------->


	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ef4b8fd4aebaa69e9172f4cc49921ca&libraries=services"></script>
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3 // 지도의 확대 레벨
		};
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(
			'${p.location}',
				function(result, status) {
	
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
	
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});
	
								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow(
										{
											//content : '<div style="width:150px;text-align:center;padding:6px 0;">${c.cafe_name}</div>'
										});
								infowindow.open(map, marker);
	
								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	</script>
	

	<jsp:include page="../includes/footer.jsp" />

</body>
</html>