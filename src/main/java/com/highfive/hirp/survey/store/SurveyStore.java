package com.highfive.hirp.survey.store;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.survey.domain.Survey;
import com.highfive.hirp.survey.domain.SurveyAnswer;
import com.highfive.hirp.survey.domain.SurveyQuest;
import com.highfive.hirp.survey.domain.SurveyQuestCh;
import com.highfive.hirp.survey.domain.SurveySearch;
import com.highfive.hirp.survey.domain.SurveySub;
import com.highfive.hirp.survey.domain.SurveyUpdate;

public interface SurveyStore {

	//설문조사 리스트 조회
	//전체 리스트 조회(최신)
	public List<Survey> selectAllSurvey(SqlSession sqlSession, String emplId);
	//진행중인 리스트 조회
	public List<Survey> selectProceedSurvey(SqlSession sqlSession, String emplId);
	//마감된 설문리스트 조회
	public List<Survey> selectClosedSurvey(SqlSession sqlSession, String emplId);
	//내가 작성한 설문 리스트 조회
	public List<Survey> selectWroteSurvey(SqlSession sqlSession, String emplId);
	//내가 대상자인 것 중 진행 중이면서 응답하지 않은 설문 리스트 조회
	public List<Survey> selectSubSurveyById(SqlSession sqlSession, String emplId);
	//설문조사 대상자 가져오기 (응답여부 확인 가능)
	public List<SurveySub> selectSurveySubByNo(SqlSession sqlSession, int surveyNo);

	//설문조사 등록
	//설문 추가
	public int insertSurvey(SqlSession sqlSession, Survey survey);
	//응답자 검색
	public List<Employee> selectSearchEmplList(SqlSession sqlSession, String emplSearchKeyword);
	//설문 문항 추가
	public int insertSurveyQuest(SqlSession sqlSession, SurveyQuest surveyQuest);
	//설문 보기 추가 (날짜/객관식의 경우)
	public int insertSurveyQuestCh(SqlSession sqlSession, SurveyQuestCh qCh);
	//설문 대상자 추가
	public int insertSurveySub(SqlSession sqlSession, SurveySub subList);
	//현재 설문조사 시퀀스 번호 가져오기
	public int selectSurveySeqNo(SqlSession sqlSession);

	//설문조사 상세
	//설문조사 정보 가져오기
	public Survey selectSurveyByNo(SqlSession sqlSession, int surveyNo);
	//설문조사에 포함된 설문 문항 리스트 가져오기 (보기까지)
	public List<SurveyQuest> selectAllSurveyQuestByNo(SqlSession sqlSession, int surveyQuestNo);
	//설문조사 번호로 설문조사 응답 가져오기
	public List<SurveyAnswer> selectSurveyAnswerByNo(SqlSession sqlSession, int surveyNo);
	//설문조사 번호, 내 아이디로 나의 응답 가져오기
	public List<SurveyAnswer> selectSurveyMyAnswerByNo(SqlSession sqlSession, SurveyUpdate ssUpdate);
	//emplId, surveyNo 담아서 넘겨줌.

	//설문조사 수정
	//설문조사 정보 수정
	public int updateSurvey(SqlSession sqlSession, Survey survey);
	//설문조사 상태 수정
	public int updateSurveyStatus(SqlSession sqlSession, int surveyNo);
	//설문조사 대상자 리스트 삭제
	public int deleteSurveySubList(SqlSession sqlSession, int surveyNo);
	
	//설문조사 삭제
	//설문조사 정보 삭제
	public int deleteSurvey(SqlSession sqlSession, int surveyNo);

	//설문조사 응답
	//설문조사 응답 내용 추가
	public int insertSurveySubAnswer(SqlSession sqlSession, SurveyAnswer surveyAnswer);
	//설문조사 응답자 응답상태 변경
	public int updateSubAnswerStatus(SqlSession sqlSession, SurveyUpdate ssUpdate);
	//설문조사 응답 수정
	public int updateSurveySubAnswer(SqlSession sqlSession, SurveyAnswer surveyAnswer);
	
	//설문조사 검색
	public List<Survey> selectSearchSurvey(SqlSession sqlSession, SurveySearch surveySearch);

}
