package com.kh.bom.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.bom.member.model.vo.Member;

@Component
public class EchoHandler extends TextWebSocketHandler{
	//로그인 한 전체
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> user = new HashMap<String, WebSocketSession>();
		
	//서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("시작!");
		sessionList.add(session);
		String memNo=getMemberNo(session);
		System.out.println(memNo);
		if(memNo!=null) {
			user.put(memNo,session);
			//연결된 사용자의 해당 아이디가 키값으로 세션이 들어감
			//로그인한 멤버: 자신의 아이디
			//로그인안한 멤버: 세션아이디
		}
		System.out.println(user);
		/*
		 * sessions.add(session);
		 * 
		 * String senderEmail = getEmail(session); userSessionsMap.put(senderEmail ,
		 * session);
		 */
	}
	
	//소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		String senderEmail = getEmail(session);

		
		//protocol : cmd , 댓글작성자, 게시글 작성자 , seq (reply , user2 , user1 , 12)
		System.out.println("메세지");
		//session.getId();
		String memNo=getMemberNo(session);
		System.out.println("회원번호"+memNo);
		String msg=message.getPayload();
		System.out.println("메세지"+msg);
		//모든 유저에게 보낸다 - 브로드 캐스팅
//		for (WebSocketSession sess : sessionList) {
//			sess.sendMessage(new TextMessage(memNo + ": " +  message.getPayload()));
//		}
//		
		if(msg != null) {
			
			String[] strs=msg.split(",");
			System.out.println(strs.toString());
			
			if(strs!= null && strs.length==5) {
				String cmd = strs[0];
				String caller=strs[1];//보낸사람 닉네임
				String callerNo=strs[2];//보낸사람 번로
				String receiverNo = strs[3];//받는회원번호
				String bascket = strs[4];//매개변수값
				
//				WebSocketSession receiverSession = user.get(memNo);
				System.out.println("받는회원번호"+receiverNo);
				WebSocketSession receiverSession = user.get(receiverNo);
				System.out.println("세션확인"+receiverSession);
				TextMessage tmpMsg=null;
				if("adminYn".equals(cmd)&&receiverSession!=null) {
					//관리자 여부 메세지
					if(bascket.equals("Y")) {
						tmpMsg= new TextMessage("축하드립니다.관리자가 되었습니다.");
					}else {
						tmpMsg= new TextMessage("관리자 권한이 회수되었습니다.");
					}
					
				}else if("delivery".equals(cmd)&&receiverSession!=null) {
					//배송시작 메세지
					tmpMsg=new TextMessage("주문하신 상품이 배송 시작되었습니다.");
					
				}else if("review".equals(cmd)&&receiverSession!=null) {
					//리뷰 작성 촉구 메세지
					tmpMsg=new TextMessage("구매확정되었습니다. 리뷰를 작성해주세요.");
					
				}else if("oneQna".equals(cmd)&&receiverSession!=null) {
					//1:1문의 답변완료 메세지
					tmpMsg=new TextMessage("1:1문의글에 답변이 등록되었습니다.");
				}else if("productQna".equals(cmd)&&receiverSession!=null) {
					//상품문의 답변완료 메세지
					tmpMsg=new TextMessage("'"+bascket+"'상품에 대한 상품문의글에 답변이 등록되었습니다.");
				}else if("communityOut".equals(cmd)&&receiverSession!=null) {
					//커뮤니티 권한 박탈
					tmpMsg=new TextMessage("커뮤니티 권한이 박탈되었습니다.");
				}else if("communityLike".equals(cmd)&&receiverSession!=null) {
					//커뮤니티 게시글 좋아요
					tmpMsg=new TextMessage(caller+"님이 회원님의 '"+bascket+"' 글을 좋아합니다.");
				}else if("communityComment".equals(cmd)&&receiverSession!=null) {
					//커뮤니티 댓글 여부 
					tmpMsg=new TextMessage(caller+"님이 회원님의  '"+bascket+"' 글에 댓글을 달았습니다.");
				}else if("communityReComment".equals(cmd)&&receiverSession!=null) {
					//커뮤니티 대댓글 여부 
					tmpMsg=new TextMessage(caller+"님이 회원님의  '"+bascket+"' 글에 대댓글을 달았습니다.");
				}else if("stamp".equals(cmd)&&receiverSession!=null) {
					//스탬프 10개 달성 여부 
					tmpMsg=new TextMessage("스탬프 10개 달성하였습니다. 선물을 받으러 가세요!");
				}
				
				if(receiverSession!=null) {
					receiverSession.sendMessage(tmpMsg);
				}else {
					System.out.println("받는 회원 미접속");
				}
				
				
				
			}
		}
		
		}
		
	
	//연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		System.out.println("연결 해제");
		sessionList.remove(session.getId());
		user.remove(session);
		
	}
	
	
	
	private String getMemberNo(WebSocketSession session) {
		
		Map<String,Object> httpSession=session.getAttributes();

		Member m=(Member)httpSession.get("loginMember");
		if(null==m) {
			return session.getId();
		}else {
			return m.getMemNo();
		}
		
		
		
		
	}
}
