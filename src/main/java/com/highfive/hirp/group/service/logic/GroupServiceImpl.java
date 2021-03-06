package com.highfive.hirp.group.service.logic;

import java.lang.reflect.Member;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.dept.domain.Dept;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.group.domain.Group;
import com.highfive.hirp.group.service.GroupService;
import com.highfive.hirp.group.store.GroupStore;
import com.highfive.hirp.reservation.store.ReservationStore;

@Service
public class GroupServiceImpl implements GroupService {
	
	@Autowired
	private SqlSession sqlSession; // 얘때문에 (sqlSession)가능
	
	@Autowired
	private GroupStore gStore;

	// 조직도 조회
	@Override
	public List<Dept> printAllGroup() {
		List<Dept> dList = gStore.selectAllGroup(sqlSession);
		return dList;
	}

	// 회원 검색
	@Override
	public List<Group> searchAllGroup(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	// 상세 회원 정보 열람
	@Override
	public Member detailGroupMember(String emplId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//회원 전체 조회
	@Override
	public List<Employee> selectAllGroupMember(String emplId) {
		List<Employee> emplList = gStore.selectAllGroupMember(sqlSession, emplId);
		return emplList;
	}
}