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
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
<script src="${path}/resources/js/alarm.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
   <script>

function fnAlarm(){
	
      let category="${category}";
      let caller="";
      let callerNo="";
      let message="";
      let receiverNo="";
      let bascket="";
      if(category=="delivery") {
         //배송도착 - 구매확정 메세지
    	  caller="관리자";
          callerNo="M0";
          message="주문하신 '${bascket}'상품은 잘 받으셨나요? 무사히 받으셨다면 구매를 확정해주세요.";
          receiverNo="${receiverNo}";
          bascket="${orderNo}";
          
      }else if(category=="oneQna") {
         //1:1문의 답변완료 메세지
         console.log("도착");
         
         caller="관리자";
         callerNo="M0";
         message="1:1문의글에 답변이 등록되었습니다.";
         receiverNo="${receiverNo}";
 
      }else if(category=="productQna") {
         //상품문의 답변완료 메세지
         caller="관리자";
         callerNo="M0";
         receiverNo="${receiverNo}";
         bascket="${bascket}";
         message="'"+bascket+"'상품에 대한 상품문의글에 답변이 등록되었습니다.";
         
      }else if(category=="communityOut") {
         //커뮤니티 권한 박탈
         //tmpMsg=new TextMessage("커뮤니티 권한이 박탈되었습니다.");
      }else if(category=="communityComment"){
         //커뮤니티 댓글 여부 
         //tmpMsg=new TextMessage(caller+"님이 회원님의  '"+bascket+"' 글에 댓글을 달았습니다.");
      }else if(category=="stamp") {
         //스탬프 10개 달성 여부 
         //tmpMsg=new TextMessage("스탬프 10개 달성하였습니다. 선물을 받으러 가세요!");
      }   
      if(category!="" && message!=""){
         sockSend(category,caller, callerNo, message, receiverNo, bascket);
         console.log("보낸다"+category+caller+callerNo+ message+ receiverNo+ bascket);
      }
   }
      
   //알림저장, 소켓전송 함수
   function sockSend(category, caller, callerNo, message, receiverNo, bascket){
      $.ajax({
             type : 'post',
             url : '${path}/member/insertAlarm',
             data : {receiverNo:receiverNo,message:message}, 
             dataType : 'json',
             success : function(data){
                console.log("ajax성공"+data);
                if(data===true){
                   console.log("sock:"+sock);
                   if(sock){
                      if(bascket==""||bascket==null){bascket="0"};
                      let socketMsg = category+","+caller+","+callerNo+","+receiverNo+","+bascket;
                      console.log("msg.jsp알림전송내역 : " + socketMsg);
                      sock.send(socketMsg);
                   }
                }
             },
             error : function(err){
                console.log(err);
             }
          });
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