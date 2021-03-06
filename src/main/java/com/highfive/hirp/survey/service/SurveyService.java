package com.highfive.hirp.survey.service;

import java.util.HashMap;
import java.util.List;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.survey.domain.Survey;
import com.highfive.hirp.survey.domain.SurveyAnswer;
import com.highfive.hirp.survey.domain.SurveyQuest;
import com.highfive.hirp.survey.domain.SurveyQuestCh;
import com.highfive.hirp.survey.domain.SurveySearch;
import com.highfive.hirp.survey.domain.SurveySub;
import com.highfive.hirp.survey.domain.SurveyUpdate;

public interface SurveyService {
	//리스트 조회
	//전체 리스트 조회(최신)
	public List<Survey> selectAllSurvey(String emplId);	
	//진행중인 리스트 조회
	public List<Survey> selectProceedSurvey(String emplId); 
	//마감된 설문 리스트 조회
	public List<Survey> selectClosedSurvey(String emplId); 
	//마감된 설문 리스트까지 surveyMyStatus 타입으로 변경
	//내가 작성한 설문 리스트 조회
	public List<Survey> selectWroteSurvey(String emplId); 
	//내가 대상자이면서 응답하지 않은 것 중 진행중인 설문조사 리스트 조회
	public List<Survey> selectSubSurveyById(String emplId); 
	//sql문 작성해놓음.
	//설문조사 대상자 리스트 가져오기 (응답여부 확인 가능)
	public List<SurveySub> selectSurveySubByNo(int surveyNo); 
	
	//설문 등록
	//설문 추가
	public int insertSurvey(Survey survey);	
	//응답자 검색 (mapper만 employeeAdmin 것 사용)
	public List<Employee> selectSearchEmplList(String emplSearchKeyword);
	//설문 대상자 추가
	public int insertSurveySub(SurveySub subList);
	//설문 문항 추가
	public int insertSurveyQuest(SurveyQuest surveyQuest); 
	//설문 보기 추가 (날짜/객관식의 경우)
	public int insertSurveyQuestCh(SurveyQuestCh qCh); 
	//현재 설문조사 시퀀스 번호 가져오기
	public int selectSurveySeqNo();
	
	//설문 상세
	//설문조사 정보 가져오기
	public Survey selectSurveyByNo(int surveyNo); 
	//설문조사에 포함된 설문 문항 리스트 가져오기 (보기까지)
	public List<SurveyQuest> selectAllSurveyQuestByNo(int surveyQuestNo);
	//설문조사 번호로 설문조사 응답 가져오기
	public List<SurveyAnswer> selectSurveyAnswerByNo(int surveyNo);
	//설문조사 번호, 내 아이디로 나의 응답 가져오기
	public List<SurveyAnswer> selectSurveyMyAnswerByNo(SurveyUpdate ssUpdate);
	//emplId, surveyNo 담아서 넘겨줌.
	
	//설문 수정(문항 수정 불가!)
	//설문조사 정보 수정 (시작안내문구)
	public int updateSurvey(Survey survey); 
	//설문조사 상태 수정 (마감)
	public int updateSurveyStatus(int surveyNo);
	//설문조사 대상자 리스트 삭제
	public int deleteSurveySubList(int surveyNo);
	
	//설문조사 삭제
	//설문조사 정보 삭제
	public int deleteSurvey(int surveyNo);
	//해당 설문조사 관련 데이터 자동 삭제
	
	//응답
	//설문조사 응답 내용 추가
	public int insertSurveySubAnswer(SurveyAnswer surveyAnswer);
	//설문조사 응답자 응답상태 변경 (회원 아이디, 설문조사 번호로 where 사용해서 status 변경)
	public int updateSubAnswerStatus(SurveyUpdate ssUpdate); 
	//설문조사 응답 수정
	public int updateSurveySubAnswer(SurveyAnswer surveyAnswer);
	
	//설문조사 검색
	public List<Survey> printSeartchSurvey(SurveySearch surveySearch);
}
