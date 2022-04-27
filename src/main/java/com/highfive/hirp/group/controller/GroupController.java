package com.highfive.hirp.group.controller;

import java.lang.reflect.Member;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.group.domain.Group;
import com.highfive.hirp.group.service.GroupService;

@Controller
public class GroupController {
	
	@Autowired
	private GroupService gService;

	// 조직도 조회
	public ModelAndView groupView (ModelAndView mv, HttpServletRequest request) {
		List<Group> grouptList = gService.printAllGroup(); // <Group>받아오는것 // ()불러오는것.불러올땐 괄호 비워둬도 됨
		return mv;
	}
	
	// 회원 검색
	public ModelAndView groupSearchView (ModelAndView mv, @ModelAttribute Search search) { // 파람하나, 모델통째로(도메인으로묶인것)
		List<Group> membertList = gService.searchAllGroup(search); // ()안에 검색어, 검색조건(Search안에 적혀있음) // <>여러명의그룹
		return mv;
	}
	
	// 상세 회원 정보 열람
	public ModelAndView groupDetailView (ModelAndView mv, @RequestParam("emplId") String emplId) {
		Member member = gService.detailGroupMember(emplId);  // 둘쨰줄 설명 String->문자받을때 // int->결과확인 // 한명의그룹이어서<>아님 // 위에있는것가져와야함
		return mv;		
	}
}

// insert, update, delete -> int result(등록)
// select -> 여러개List<Group>,하나Group group