package com.highfive.hirp.chat.service;

import java.util.List;
import java.util.Map;

import com.highfive.hirp.chat.domain.ChatFile;
import com.highfive.hirp.chat.domain.ChatList;
import com.highfive.hirp.chat.domain.ChatRoom;
import com.highfive.hirp.chat.domain.ChatRoomJoin;
import com.highfive.hirp.chat.domain.Message;
import com.highfive.hirp.chat.domain.PersonalId;
import com.highfive.hirp.employee.domain.Employee;

public interface ChatService {

	//직원 목록 가져오는 건 employee 합쳐서 만들어진 거 있으면 그쪽에서 가져다 쓰기
	//직원 이름으로 검색해서 직원 목록 가져오기
	//채팅방 추가 (대화 상대, 채팅방 이름 설정)
	public int insertChattingRoom(ChatRoom chatRoom);
	public int insertChatRoomJoin(ChatRoomJoin chatroomJoin);
	
	//채팅방 목록 가져오기
	//내가 참여한 채팅방 목록 가져오기
	public List<ChatRoom> selectMyChattingRoom(String emplId);
	//채팅방 검색 (채팅방 이름, 채팅방 참여자 이름 + 내가 참여한 채팅 중에서)
	public List<ChatRoom> selectMyChattingRoom(Map<String, String> searchMap);
	//나와 상대방이 포함된 개인 채팅방 가져오기
	public ChatRoom selectMyPersonalChattingRoom(PersonalId idList);
	
	//채팅방 번호, 내 아이디로 정보 가져오기
	public ChatRoom selectChatRoomInfoByNo(Map<String, String> searchMap);
	//채팅방 번호로 참여자 정보 가져오기
	public List<ChatRoomJoin> selectChatRoomJoinListByNo(int chatroomNo);
	
	// 채팅방 별로 채팅, 첨부파일 내용 같이 가져오기
	public List<ChatList> selectChatListByRoomNo(int chatroomNo);
	//일단 얘네 두개 남겨놓겠음
	//채팅방 별로 채팅 내용 가져오기
	public List<Message> selectMessageByRoomNo(int chatroomNo);
	//보내진 첨부파일 가져오기
	public ChatFile selectChatFileByMsgNo(int msgNo);
	
	//채팅 추가
	public int insertMessage(Message msg);
	//첨부파일 추가
	public int insertChatFile(ChatFile chatfile);
	
	//채팅방별 첨부파일 리스트 가져오기
//	public List<ChatFile> selectChatFileByChattingRoomNo(int chatroomNo);
	public List<ChatList> selectChatFileListByChatRoomNo(int chatroomNo);
	//첨부파일 + 채팅 = chatList로 가져오는데 대신 첨부파일 있는 것만 가져오면 될 듯
	//내가 받은 첨부파일 리스트 가져오기
//	public List<ChatFile> selectChatFileById(String emplId);
	public List<ChatList> selectChatFileListById(String emplId);
	
	//채팅방 정보 변경 (이름 변경)
	public int updateChatRoomInfo(ChatRoom chatRoom);
	//채팅 대화상대 추가
	public int insertChatRoomJoinOnly(ChatRoomJoin chatRoomJoin);
	//채팅방 나가기 (채팅 대화상대에서 삭제)
	public int deleteMyIdChatRoomJoin(ChatRoomJoin chatRoomJoin);
	//chatroomjoin에 채팅방 번호랑 현재 자신 아이디 넘겨주기
	//채팅방 삭제
	public int deleteChatRoom(int chatroomNo);
}
