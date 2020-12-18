<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="reserved" value="${reservedSeat}" />
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<script src="${path}/resources/js/alarm.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script>

	
		let category="${category}";
		if(category=="delivery") {
			//배송시작 메세지
			//tmpMsg=new TextMessage("주문하신 상품이 배송 시작되었습니다.");
			
		}else if(category=="review") {
			//리뷰 작성 촉구 메세지
			//tmpMsg=new TextMessage("구매확정되었습니다. 리뷰를 작성해주세요.");
			
		}else if(category=="oneQna") {
			//1:1문의 답변완료 메세지
			console.log("도착");
			 
			//알림 DB저장
	 	   	$.ajax({
	 	   		type : 'post',
	 	   		url : '${path}/member/insertAlarm',
	 	   		data : {receiverNo:"${basket}",message:"1:1문의글에 답변이 등록되었습니다."}, 
	 	   		dataType : 'json',
	 	   	 	async: false,
	 	   		success : function(data){
	 	   			console.log("ajax성공"+data);
	 	   			if(data===true){
	 	   				if(sock){
	 	   				let socketMsg = "oneQna,관리자,M0,"+"${basket}" +","+"0";
	 	   				console.log("알림전송내역3 : " + socketMsg);
	 	   				sock.send(socketMsg);
	 	   				}
	 	   			}
	 	   		},
	 	   		error : function(err){
	 	   			console.log(err);
	 	   		}
	 	   	});
		 	
			
		}else if(category=="productQna") {
			//상품문의 답변완료 메세지
			//tmpMsg=new TextMessage("상품문의글에 답변이 등록되었습니다.");
		}else if(category=="communityOut") {
			//커뮤니티 권한 박탈
			//tmpMsg=new TextMessage("커뮤니티 권한이 박탈되었습니다.");
		}else if(category=="communityLike"){
			//커뮤니티 게시글 좋아요
			//tmpMsg=new TextMessage(caller+"님이 회원님의 '"+bascket+"' 글을 좋아합니다.");
		}else if(category=="communityComment"){
			//커뮤니티 댓글 여부 
			//tmpMsg=new TextMessage(caller+"님이 회원님의  '"+bascket+"' 글에 댓글을 달았습니다.");
		}else if(category=="stamp") {
			//스탬프 10개 달성 여부 
			//tmpMsg=new TextMessage("스탬프 10개 달성하였습니다. 선물을 받으러 가세요!");
		}	
		
		
		
		
	swal({
		  title: "${title}",
		  text: "${msg}",
		  icon:"${icon}", //icon 종류 : success,error,warning
		  button:"확인",
		  closeOnClickOutside: false,
		}).then(function(){
			${opener};
			${script}; 		
			location.replace("${pageContext.request.contextPath}${loc}");
		});
		
	</script>
</body>
</html>