package com.highfive.hirp.approval.user.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.highfive.hirp.approval.admin.domain.ApprForm;
import com.highfive.hirp.approval.user.domain.ApprAccept;
import com.highfive.hirp.approval.user.domain.ApprAttachedFile;
import com.highfive.hirp.approval.user.domain.Approval;
import com.highfive.hirp.approval.user.domain.Reference;
import com.highfive.hirp.common.PageInfo;
import com.highfive.hirp.common.Search;
import com.highfive.hirp.time.user.domain.Vacation;

public interface ApprovalStore {

	//폼 전체 조회
	List<ApprForm> selectAllApprForm(SqlSession sqlSession);

	List<ApprForm> selectSearchApprForm(SqlSession sqlSession, Search search);

	ApprForm selectApprForm(SqlSession sqlSession, int formNo);

	int insertApprover(SqlSession sqlSession, ApprAccept apprAccept);

	int insertReference(SqlSession sqlSession, Reference reference);

	//결재 등록
	int insertAppr(SqlSession sqlSession, Approval approval);

	//임시저장
	int insertTempAppr(SqlSession sqlSession, Approval approval);

	int updateTempAppr(SqlSession sqlSession, Approval approval);

	int deleteTempAppr(SqlSession sqlSession, int apprNo);
	//결재대기함
	List<Approval> selectAllWaitingAppr(SqlSession sqlSession, String emplId);
	//상신문서함
	List<Approval> selectAllMyAppr(SqlSession sqlSession, String emplId);

	//Approval selectOneWaitingAppr(SqlSession sqlSession, int docNo);

	//결재자정보 조회
	List<ApprAccept> selectApprovalStatus(SqlSession sqlSession, int apprNo);

	int modifyApprAccept(SqlSession sqlSession, ApprAccept apprAccept);

	int updateApprovalStatus(SqlSession sqlSession, Approval approval);

	int deleteApproval(SqlSession sqlSession, int apprNo);

	int deleteApprAccept(SqlSession sqlSession, int docNo);

	List<Approval> selectAllWrittenAppr(SqlSession sqlSession, ApprAccept apprAccept);

	List<Approval> selectAllTempAppr(SqlSession sqlSession, String emplId);

	List<Approval> selectAllRejectedAppr(SqlSession sqlSession, String emplId);

	List<Approval> selectAllCompletedAppr(SqlSession sqlSession, String emplId);

	//결재문서 보기
	Approval selectOneAppr(SqlSession sqlSession,int apprNo);

	//양식등록
	int insertApprForm(SqlSession sqlSession, ApprForm apprForm);

	//최근등록한 결재번호 확인
	int selectRecentApprNo(SqlSession sqlSession);

	//결재 첨부파일 등록
	int insertApprAttachedFile(SqlSession sqlSession, ApprAttachedFile apprFile);

	List<Reference> selectAllRefApprList(SqlSession sqlSession, String emplId);

	List<Reference> selectAllViewApprList(SqlSession sqlSession, String emplId);

	List<Approval> selectProceedAppr(SqlSession sqlSession, String emplId);

	//참조자등록
	int insertApprRef(SqlSession sqlSession, Reference reference);

	int insertVacation(SqlSession sqlSession, Vacation vacation);

	int insertVacationAppr(SqlSession sqlSession, Approval approval);

	//결재문서함(전체)
	List<Approval> selectAllAppr(SqlSession sqlSession, String emplId);

	int selectListCount(SqlSession sqlSession);





}
