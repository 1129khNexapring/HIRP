package com.highfive.hirp.employee.store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.highfive.hirp.employee.domain.Career;
import com.highfive.hirp.employee.domain.Certification;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.employee.domain.JobRole;
import com.highfive.hirp.employee.domain.Language;
import com.highfive.hirp.employee.domain.Military;
import com.highfive.hirp.employee.store.EmployeeAdminStore;
import com.nexacro17.xapi.data.DataSet;

@Repository
public class EmployeeAdminStoreLogic implements EmployeeAdminStore {
	@Override
	public List<Employee> selectBirthdayList(SqlSession sqlSession) {
		List<Employee> birthdayList = sqlSession.selectList("EmployeeAdminMapper.selectBirthdayList");
		return birthdayList;
	}
	
	@Override
	public List<Employee> selectAllEmployee(SqlSession sqlSession) {
		List<Employee> eList = sqlSession.selectList("EmployeeAdminMapper.selectAllEmployee");
		return eList;
	}
	
	@Override
	public List<Employee> selectAllEmployeeWithName(SqlSession sqlSession) {
		List<Employee> eList = sqlSession.selectList("EmployeeAdminMapper.selectAllEmployeeWithName");
		return eList;
	}
	
	//직원 검색
	@Override
	public List<Employee> selectSearchEmplList(SqlSession sqlSession, String emplSearchKeyword) {
		List<Employee> eList = sqlSession.selectList("EmployeeAdminMapper.selectSearchEmplList", emplSearchKeyword);
		return eList;
	}
	
	//하위부서까지
	@Override
	public List<Employee> selectAllEmployeeWithDeptCode(SqlSession sqlSession, String deptCode) {
		List<Employee> eList = sqlSession.selectList("EmployeeAdminMapper.selectAllEmployeeWithDeptCode", deptCode);
		return eList;
	}
	
	//내 소속 부서만
	@Override
	public List<Employee> selectEmployeeWithDeptCode(SqlSession sqlSession, String deptCode) {
		List<Employee> eList = sqlSession.selectList("EmployeeAdminMapper.selectEmployeeWithDeptCode", deptCode);
		return eList;
	}
	
	@Override
	public List<Employee> selectAllRetiree(SqlSession sqlSession) {
		List<Employee> rList = sqlSession.selectList("EmployeeAdminMapper.selectAllRetiree");
		return rList;
	}

	@Override
	public List<Employee> selectTempEmployee(SqlSession sqlSession) {
		List<Employee> tList = sqlSession.selectList("EmployeeAdminMapper.selectTempEmployee");
		return tList;
	}

	@Override
	public Employee selectOneEmployee(SqlSession sqlSession, String emplId) {
		Employee employee = sqlSession.selectOne("EmployeeAdminMapper.selectOneEmployee", emplId);
		return employee;
	}

	@Override
	public List<JobRole> selectAllJobById(SqlSession sqlSession, String emplId) {
		List<JobRole> jList = sqlSession.selectList("EmployeeAdminMapper.selectAllJobById", emplId);
		return jList;
	}

	@Override
	public List<Career> selectAllCareerById(SqlSession sqlSession, String emplId) {
		List<Career> caList = sqlSession.selectList("EmployeeAdminMapper.selectAllCareerById", emplId);
		return caList;
	}

	@Override
	public List<Language> selectAllLanguageById(SqlSession sqlSession, String emplId) {
		List<Language> lList = sqlSession.selectList("EmployeeAdminMapper.selectAllLanguageById", emplId);
		return lList;
	}

	@Override
	public List<Certification> selectAllCertById(SqlSession sqlSession, String emplId) {
		List<Certification> cList = sqlSession.selectList("EmployeeAdminMapper.selectAllCertById", emplId);
		return cList;
	}

	@Override
	public List<Military> selectAllMilitaryById(SqlSession sqlSession, String emplId) {
		List<Military> mList = sqlSession.selectList("EmployeeAdminMapper.selectAllMilitaryById", emplId);
		return mList;
	}

	@Override
	public int modifyEmployeeInfo(SqlSession sqlSession, Employee employee) {
		int result = sqlSession.update("EmployeeAdminMapper.modifyEmployeeInfo", employee);
		return result;
	}

	@Override
	public int resignEmployee(SqlSession sqlSession, String emplId) {
		int result = sqlSession.update("EmployeeAdminMapper.resignEmployee", emplId);
		return result;
	}

	@Override
	public int updateLevelEmployee(SqlSession sqlSession, Employee employee) {
		int result = sqlSession.update("EmployeeAdminMapper.updateLevelEmployee", employee);
		return result;
	}

	@Override
	public int deleteInfoAboutJob(SqlSession sqlSession, int jobRoleNo) {
		int result = sqlSession.delete("EmployeeAdminMapper.deleteInfoAboutJob", jobRoleNo);
		return result;
	}

	@Override
	public int deleteInfoAboutCareer(SqlSession sqlSession, int careerNo) {
		int result = sqlSession.delete("EmployeeAdminMapper.deleteInfoAboutCareer", careerNo);
		return result;
	}

	@Override
	public int deleteInfoAboutLang(SqlSession sqlSession, int langNo) {
		int result = sqlSession.delete("EmployeeAdminMapper.deleteInfoAboutLang", langNo);
		return result;
	}

	@Override
	public int deleteInfoAboutCert(SqlSession sqlSession, int certNo) {
		int result = sqlSession.delete("EmployeeAdminMapper.deleteInfoAboutCert", certNo);
		return result;
	}

	@Override
	public int deleteInfoAboutMilitary(SqlSession sqlSession, int militaryNo) {
		int result = sqlSession.delete("EmployeeAdminMapper.deleteInfoAboutMilitary", militaryNo);
		return result;
	}

	@Override
	public int insertJobRole(SqlSession sqlSession, JobRole jobRole) {
		int result = sqlSession.insert("EmployeeAdminMapper.insertJobRole", jobRole);
		return result;
	}

	@Override
	public int insertCareer(SqlSession sqlSession, Career career) {
		int result = sqlSession.insert("EmployeeAdminMapper.insertCareer", career);
		return result;
	}

	@Override
	public int insertCert(SqlSession sqlSession, Certification cert) {
		int result = sqlSession.insert("EmployeeAdminMapper.insertCert", cert);
		return result;
	}

	@Override
	public int insertLang(SqlSession sqlSession, Language lang) {
		int result = sqlSession.insert("EmployeeAdminMapper.insertLang", lang);
		return result;
	}

	@Override
	public int insertMilitary(SqlSession sqlSession, Military military) {
		int result = sqlSession.insert("EmployeeAdminMapper.insertMilitary", military);
		return result;
	}
	
	@Override
	public int updateTopInfo(SqlSession sqlSession, Employee employee) {
		int result = sqlSession.update("EmployeeAdminMapper.updateTopInfo", employee);
		return result;
	}

	@Override
	public int updateJobRole(SqlSession sqlSession, JobRole jobRole) {
		int result = sqlSession.update("EmployeeAdminMapper.updateJobRole", jobRole);
		return result;
	}

	@Override
	public int updateCareer(SqlSession sqlSession, Career career) {
		int result = sqlSession.update("EmployeeAdminMapper.updateCareer", career);
		return result;
	}

	@Override
	public int updateCert(SqlSession sqlSession, Certification cert) {
		int result = sqlSession.update("EmployeeAdminMapper.updateCert", cert);
		return result;
	}

	@Override
	public int updateLang(SqlSession sqlSession, Language lang) {
		int result = sqlSession.update("EmployeeAdminMapper.updateLang", lang);
		return result;
	}

	@Override
	public int updateMilitary(SqlSession sqlSession, Military military) {
		int result = sqlSession.update("EmployeeAdminMapper.updateMilitary", military);
		return result;
	}
}
