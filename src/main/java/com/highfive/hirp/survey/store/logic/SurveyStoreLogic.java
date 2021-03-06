package com.highfive.hirp.survey.store.logic;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.survey.domain.Survey;
import com.highfive.hirp.survey.domain.SurveyAnswer;
import com.highfive.hirp.survey.domain.SurveyQuest;
import com.highfive.hirp.survey.domain.SurveyQuestCh;
import com.highfive.hirp.survey.domain.SurveySearch;
import com.highfive.hirp.survey.domain.SurveySub;
import com.highfive.hirp.survey.domain.SurveyUpdate;
import com.highfive.hirp.survey.store.SurveyStore;

@Repository
public class SurveyStoreLogic implements SurveyStore{

	//설문조사 리스트 조회
	//전체 리스트 조회(최신)
	@Override
	public List<Survey> selectAllSurvey(SqlSession sqlSession, String emplId) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectAllSurvey", emplId);
		return surveyList;
	}
	//진행중인 리스트 조회
	@Override
	public List<Survey> selectProceedSurvey(SqlSession sqlSession, String emplId) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectProceedSurvey", emplId);
		return surveyList;
	}
	//마감된 설문리스트 조회
	@Override
	public List<Survey> selectClosedSurvey(SqlSession sqlSession, String emplId) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectClosedSurvey", emplId);
		return surveyList;
	}
	//내가 작성한 설문 리스트 조회
	@Override
	public List<Survey> selectWroteSurvey(SqlSession sqlSession, String emplId) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectWroteSurvey", emplId);
		return surveyList;
	}
	//내가 대상자이면서 응답하지 않은 것 중 진행중인 설문 리스트 조회
	@Override
	public List<Survey> selectSubSurveyById(SqlSession sqlSession, String emplId) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectSubSurveyById", emplId);
		return surveyList;
	}
	//설문조사 대상자 가져오기 (응답여부 확인 가능)
	@Override
	public List<SurveySub> selectSurveySubByNo(SqlSession sqlSession, int surveyNo) {
		List<SurveySub> surveySubList = sqlSession.selectList("SurveyMapper.selectSurveySubByNo", surveyNo);
		return surveySubList;
	}
	

	//설문조사 등록
	//설문 추가
	@Override
	public int insertSurvey(SqlSession sqlSession, Survey survey) {
		int result = sqlSession.insert("SurveyMapper.insertSurvey", survey);
		return result;
	}
	//응답자 검색
	@Override
	public List<Employee> selectSearchEmplList(SqlSession sqlSession, String emplSearchKeyword) {
		List<Employee> emplList = sqlSession.selectList("EmployeeAdminMapper.selectSearchEmplList", emplSearchKeyword);
		return emplList;
	}
	//설문 문항 추가
	@Override
	public int insertSurveyQuest(SqlSession sqlSession, SurveyQuest surveyQuest) {
		int result = sqlSession.insert("SurveyMapper.insertSurveyQuest", surveyQuest);
		return result;
	}
	//설문 보기 추가 (날짜/객관식의 경우)
	@Override
	public int insertSurveyQuestCh(SqlSession sqlSession, SurveyQuestCh qCh) {
		int result = sqlSession.insert("SurveyMapper.insertSurveyQuestCh", qCh);
		return result;
	}
	//설문 대상자 추가
	@Override
	public int insertSurveySub(SqlSession sqlSession, SurveySub subList) {
		int result = sqlSession.insert("SurveyMapper.insertSurveySub", subList);
		return result;
	}
	//현재 설문조사 시퀀스 번호 가져오기
	public int selectSurveySeqNo(SqlSession sqlSession) {
		int result = sqlSession.selectOne("SurveyMapper.selectSurveySeqNo");
		return result;
	}

	
	//설문조사 상세
	//설문조사 정보 가져오기
	@Override
	public Survey selectSurveyByNo(SqlSession sqlSession, int surveyNo) {
		Survey survey = sqlSession.selectOne("SurveyMapper.selectSurveyByNo", surveyNo);
		return survey;
	}
	//설문조사에 포함된 설문 문항 리스트 가져오기 (보기까지)
	@Override
	public List<SurveyQuest> selectAllSurveyQuestByNo(SqlSession sqlSession, int surveyQuestNo) {
		List<SurveyQuest> surveyQuestList = sqlSession.selectList("SurveyMapper.selectAllSurveyQuestByNo", surveyQuestNo);
		return surveyQuestList;
	}
	//설문조사 번호로 설문조사 응답 가져오기
	@Override
	public List<SurveyAnswer> selectSurveyAnswerByNo(SqlSession sqlSession, int surveyNo) {
		List<SurveyAnswer> surveyAnswerList = sqlSession.selectList("SurveyMapper.selectSurveyAnswerByNo", surveyNo);
		return surveyAnswerList;
	}
	//설문조사 번호, 내 아이디로 나의 응답 가져오기
	@Override
	public List<SurveyAnswer> selectSurveyMyAnswerByNo(SqlSession sqlSession, SurveyUpdate ssUpdate) {
		List<SurveyAnswer> surveyAnswerList = sqlSession.selectList("SurveyMapper.selectSurveyMyAnswerByNo", ssUpdate);
		return surveyAnswerList;
	}
	//emplId, surveyNo 담아서 넘겨줌.

	//설문조사 수정
	//설문조사 정보 수정
	@Override
	public int updateSurvey(SqlSession sqlSession, Survey survey) {
		int result = sqlSession.update("SurveyMapper.updateSurvey", survey);
		return result;
	}
	//설문조사 상태 수정
	@Override
	public int updateSurveyStatus(SqlSession sqlSession, int surveyNo) {
		int result = sqlSession.update("SurveyMapper.updateSurveyStatus", surveyNo);
		return result;
	}
	//설문조사 대상자 리스트 삭제
	@Override
	public int deleteSurveySubList(SqlSession sqlSession, int surveyNo) {
		int result = sqlSession.delete("SurveyMapper.deleteSurveySubByNo", surveyNo);
		return result;
	}
	
	//설문조사 삭제
	//설문조사 정보 삭제
	@Override
	public int deleteSurvey(SqlSession sqlSession, int surveyNo) {
		int result = sqlSession.delete("SurveyMapper.deleteSurvey", surveyNo);
		return result;
	}


	//설문조사 응답
	//설문조사 응답 내용 추가
	@Override
	public int insertSurveySubAnswer(SqlSession sqlSession, SurveyAnswer surveyAnswer) {
		int result = sqlSession.insert("SurveyMapper.insertSurveySubAnswer", surveyAnswer);
		return result;
	}
	//설문조사 응답자 응답상태 변경
	@Override
	public int updateSubAnswerStatus(SqlSession sqlSession, SurveyUpdate ssUpdate) {
		int result = sqlSession.update("SurveyMapper.updateSubAnswerStatus", ssUpdate);
		return result;
	}
	//설문조사 응답 수정
	@Override
	public int updateSurveySubAnswer(SqlSession sqlSession, SurveyAnswer surveyAnswer) {
		int result = sqlSession.update("SurveyMapper.updateSurveySubAnswer", surveyAnswer);
		return result;
	}
	
	
	//설문조사 검색
	@Override
	public List<Survey> selectSearchSurvey(SqlSession sqlSession, SurveySearch surveySearch) {
		List<Survey> surveyList = sqlSession.selectList("SurveyMapper.selectSearchSurvey", surveySearch);
		return surveyList;
	}


	
}
