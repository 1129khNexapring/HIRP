package com.highfive.hirp.alarm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.highfive.hirp.alarm.domain.Alarm;
import com.highfive.hirp.alarm.domain.AlarmCode;
import com.highfive.hirp.alarm.domain.AlarmSetting;
import com.highfive.hirp.alarm.service.AlarmService;
import com.highfive.hirp.employee.domain.Employee;

@Controller
public class AlarmController {
	
	@Autowired
	private AlarmService aService;

	//알림 설정 페이지로 이동
	@RequestMapping(value="/alarm/settingPage", method=RequestMethod.GET)
	public ModelAndView alarmSettingPage(ModelAndView mv) {
		return mv;
	}
	//회원가입 후 관리자 승인 시에 insertAlarmSetting 해주기
	
	//알림 설정 정보 업데이트
	@RequestMapping(value="/alarm/setting_update", method=RequestMethod.POST)
	public ModelAndView updateAlarmSetting(
			ModelAndView mv
			, @ModelAttribute AlarmSetting alarmSetting
			, HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		Employee employee = (Employee) session.getAttribute("loginMember");
//		String emplId = employee.getEmplId();
		String emplId = "사용자 아이디";
		//alarmSetting.setEmplId(userId); //필요하먼 넣기
		
		int result = aService.updateAlarmSetting(alarmSetting);
		
		return mv;
	}
	
	//전체 알림 가져오기
	public ModelAndView printAllAlarm(
			ModelAndView mv,
			HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		Employee employee = (Employee) session.getAttribute("loginMember");
//		String emplId = employee.getEmplId();
		String emplId = "사용자 아이디";
		List<Alarm> allAlarm = aService.selectAllAlarm(emplId);
		
		return mv;
	}
	
	//코드별로 알림 가져오기
	public ModelAndView printAlarmByCode(
			ModelAndView mv
			,HttpServletRequest request
			,@RequestParam("alarmCode") String alarmCode) {
		
//		HttpSession session = request.getSession();
//		Employee employee = (Employee) session.getAttribute("loginMember");
//		String emplId = employee.getEmplId();
		String emplId = "사용자 아이디";
		
		List<Alarm> alarmList = aService.selectAlarmByCode(emplId, alarmCode);
		//화면에서 나눠진 항목을 클릭할 때 alarmCode를 같이 넘겨주어 조회
		
//		List<Alarm> mailAlarm = aService.selectAlarmByCode(emplId, "00");
//		List<Alarm> allBoardAlarm = aService.selectAlarmByCode(emplId, "1%");
//		List<Alarm> noticeBoardAlarm = aService.selectAlarmByCode(emplId, "10");
//		List<Alarm> freeBoardAlarm = aService.selectAlarmByCode(emplId, "11");
//		List<Alarm> anonymousBoardAlarm = aService.selectAlarmByCode(emplId, "12");
//		List<Alarm> deptBoardAlarm = aService.selectAlarmByCode(emplId, "13");
//		List<Alarm> allScheduleAlarm = aService.selectAlarmByCode(emplId, "2%");
//		List<Alarm> everyScheduleAlarm = aService.selectAlarmByCode(emplId, "20");
//		List<Alarm> deptScheduleAlarm = aService.selectAlarmByCode(emplId, "21");
//		List<Alarm> myScheduleAlarm = aService.selectAlarmByCode(emplId, "23");
//		List<Alarm> allPayAlarm = aService.selectAlarmByCode(emplId, "3%");
//		List<Alarm> payArriveAlarm = aService.selectAlarmByCode(emplId, "30");
//		List<Alarm> payCancleAlarm = aService.selectAlarmByCode(emplId, "31");
//		List<Alarm> payCompanionAlarm = aService.selectAlarmByCode(emplId, "32");
//		List<Alarm> payCompleteAlarm = aService.selectAlarmByCode(emplId, "33");
//		List<Alarm> surveyAlarm = aService.selectAlarmByCode(emplId, "40");
		
		//게시판, 일정, 전자결제 전체 알림 가져올 때 like 사용할 생각
		//잘 안되면 service나 store 하나 더 만들어서 따로 사용하기
		//한번에 가져와서 화면에서 나누어서 뿌려주기
		
		return mv;
	}
	
	//안읽은 알림 가져오기(종 누르면 설정한 알림만 보는 거)
	public ModelAndView printUnReadAlarm(
			ModelAndView mv) {
//		HttpSession session = request.getSession();
//		Employee employee = (Employee) session.getAttribute("loginMember");
//		String emplId = employee.getEmplId();
		String emplId = "사용자 아이디";
		AlarmSetting alarmSetting = aService.selectAlarmSetting(emplId);
		//안 읽은 알림 띄워주기
		List<Alarm> unreadAlarm = aService.selectUnreadAlarm(alarmSetting);
		//알림 읽음으로 상태 변경하기
		
		return mv;
	}
	
	
	//알림 추가
	//여기에 따로 만들게 아니라 다른 사람들 한 거에서 실행될 때마다 나오도록 해야할 듯.
	
	//전체 알림 삭제
	public ModelAndView deleteAllAlarm(ModelAndView mv) {
//		HttpSession session = request.getSession();
//		Employee employee = (Employee) session.getAttribute("loginMember");
//		String emplId = employee.getEmplId();
		String emplId = "사용자 아이디";
		
		//아이디 넘겨서 전체 알림 삭제하기
		return mv;
	}
	
	//특정 알림 삭제
	public ModelAndView deleteAlarmByNo(ModelAndView mv
			,@RequestParam("alarmNo") int alarmNo) {
		
		//알림 번호로 알림 삭제
		return mv;
	}
	
	
}