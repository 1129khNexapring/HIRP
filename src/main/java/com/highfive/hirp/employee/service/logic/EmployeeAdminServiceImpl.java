package com.highfive.hirp.employee.service.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.highfive.hirp.employee.domain.Career;
import com.highfive.hirp.employee.domain.Certification;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.employee.domain.JobRole;
import com.highfive.hirp.employee.domain.Language;
import com.highfive.hirp.employee.domain.Military;
import com.highfive.hirp.employee.service.EmployeeAdminService;
import com.highfive.hirp.employee.store.EmployeeAdminStore;

@Service
public class EmployeeAdminServiceImpl implements EmployeeAdminService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private EmployeeAdminStore eAStore;

	@Override
	public List<Employee> printBirthdayList() {
		List<Employee> birthdayList = eAStore.selectBirthdayList(sqlSession);
		return birthdayList;
	}
	
	@Override
	public List<Employee> printAllEmployee() {
		List<Employee> eList = eAStore.selectAllEmployee(sqlSession);
		return eList;
	}
	
	@Override
	public List<Employee> printAllEmployeeWithName() {
		List<Employee> eList = eAStore.selectAllEmployeeWithName(sqlSession);
		return eList;
	}
	
	//직원 검색.
	@Override
	public List<Employee> selectSearchEmplList(String keyword) {
		List<Employee> eList = eAStore.selectSearchEmplList(sqlSession, keyword);
		return eList;
	}
	
	//하위부서까지
	@Override
	public List<Employee> printAllEmployeeWithDeptCode(String deptCode) {
		List<Employee> eList = eAStore.selectAllEmployeeWithDeptCode(sqlSession, deptCode);
		return eList;
	}
	
	//내 소속 부서만
	@Override
	public List<Employee> printEmployeeWithDeptCode(String deptCode) {
		List<Employee> eList = eAStore.selectEmployeeWithDeptCode(sqlSession, deptCode);
		return eList;
	}

	@Override
	public List<Employee> printAllRetiree() {
		List<Employee> rList = eAStore.selectAllRetiree(sqlSession);
		return rList;
	}

	@Override
	public List<Employee> printAllTempEmployee() {
		List<Employee> tList = eAStore.selectTempEmployee(sqlSession);
		return tList;
	}	

	@Override
	public Employee printEmployeeInfo(String emplId) {
		Employee emp = eAStore.selectOneEmployee(sqlSession, emplId);
		return emp;
	}

	@Override
	public List<JobRole> selectAllJobById(String emplId) {
		List<JobRole> jList = eAStore.selectAllJobById(sqlSession, emplId);
		return jList;
	}

	@Override
	public List<Career> selectAllCareerById(String emplId) {
		List<Career> caList = eAStore.selectAllCareerById(sqlSession, emplId);
		return caList;
	}

	@Override
	public List<Language> selectAllLanguageById(String emplId) {
		List<Language> lList = eAStore.selectAllLanguageById(sqlSession, emplId);
		return lList;
	}

	@Override
	public List<Certification> selectAllCertById(String emplId) {
		List<Certification> cList = eAStore.selectAllCertById(sqlSession, emplId);
		return cList;
	}

	@Override
	public List<Military> selectAllMilitaryById(String emplId) {
		List<Military> mList = eAStore.selectAllMilitaryById(sqlSession, emplId);
		return mList;
	}

	@Override
	public int modifyEmployeeInfo(Employee employee) {
		int result = eAStore.modifyEmployeeInfo(sqlSession, employee);
		return result;
	}

	@Override
	public int resignEmployee(String emplId) {
		int result = eAStore.resignEmployee(sqlSession, emplId);
		return result;
	}

	@Override
	public int modifyLevelEmployee(Employee employee) {
		int result = eAStore.updateLevelEmployee(sqlSession, employee);
		return result;
	}

	@Override
	public int removeInfoAboutJob(int jobNo) {
		int result = eAStore.deleteInfoAboutJob(sqlSession, jobNo);
		return result;
	}

	@Override
	public int removeInfoAboutCareer(int infoNo) {
		int result = eAStore.deleteInfoAboutCareer(sqlSession, infoNo);
		return result;
	}

	@Override
	public int removeInfoAboutLang(int infoNo) {
		int result = eAStore.deleteInfoAboutLang(sqlSession, infoNo);
		return result;
	}

	@Override
	public int removeInfoAboutCert(int infoNo) {
		int result = eAStore.deleteInfoAboutCert(sqlSession, infoNo);
		return result;
	}

	@Override
	public int removeInfoAboutMilitary(int infoNo) {
		int result = eAStore.deleteInfoAboutMilitary(sqlSession, infoNo);
		return result;
	}

	@Override
	public int registerJobRole(JobRole jobRole) {
		int result = eAStore.insertJobRole(sqlSession, jobRole);
		return result;
	}

	@Override
	public int registerCareer(Career career) {
		int result = eAStore.insertCareer(sqlSession, career);
		return result;
	}

	@Override
	public int registerCert(Certification cert) {
		int result = eAStore.insertCert(sqlSession, cert);
		return result;
	}

	@Override
	public int registerLang(Language lang) {
		int result = eAStore.insertLang(sqlSession, lang);
		return result;
	}

	@Override
	public int registerMilitary(Military military) {
		int result = eAStore.insertMilitary(sqlSession, military);
		return result;
	}
	
	@Override
	public int modifyTopInfo(Employee employee) {
		int result = eAStore.updateTopInfo(sqlSession, employee);
		return result;
	}

	@Override
	public int modifyJobRole(JobRole jobRole) {
		int result = eAStore.updateJobRole(sqlSession, jobRole);
		return result;
	}

	@Override
	public int modifyCareer(Career career) {
		int result = eAStore.updateCareer(sqlSession, career);
		return result;
	}

	@Override
	public int modifyCert(Certification cert) {
		int result = eAStore.updateCert(sqlSession, cert);
		return result;
	}

	@Override
	public int modifyLang(Language lang) {
		int result = eAStore.updateLang(sqlSession, lang);
		return result;
	}

	@Override
	public int modifyMilitary(Military military) {
		int result = eAStore.updateMilitary(sqlSession, military);
		return result;
	}
}
