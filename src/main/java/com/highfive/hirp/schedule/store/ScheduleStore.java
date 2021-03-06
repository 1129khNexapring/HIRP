package com.highfive.hirp.schedule.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.schedule.domain.Schedule;

public interface ScheduleStore {
	public List<Schedule> selectAllCompanySchedule(SqlSession sqlSession);
	public List<Schedule> selectAllTeamSchedule(SqlSession sqlSession, Schedule schedule);
	public List<Schedule> selectAllSchedule(SqlSession sqlSession, String loginUser);
	public List<Schedule> selectSearchSchedule(SqlSession sqlSession, Search search);
	
	public int insertCompanySchedule(SqlSession sqlSession, Schedule schedule);
	public int insertSchedule(SqlSession sqlSession, Schedule schedule);
	public int insertScheduleToSub(SqlSession sqlSession, Schedule schedule);
	
	public int updateSchedule(SqlSession sqlSession, Schedule schedule);
	public int updateCompanySchedule(SqlSession sqlSession, Schedule schedule);
	
	public int deleteSchedule(SqlSession sqlSession, int scheduleNo);
	public int deleteCompanySchedule(SqlSession sqlSession, int scheduleNo);
}
