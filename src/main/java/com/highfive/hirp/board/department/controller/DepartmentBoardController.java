package com.highfive.hirp.board.department.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.highfive.hirp.alarm.domain.Alarm;
import com.highfive.hirp.alarm.service.AlarmService;
import com.highfive.hirp.board.anonymous.domain.AnonymousBoard;
import com.highfive.hirp.board.common.BoardAttachedFile;
import com.highfive.hirp.board.common.BoardPagination;
import com.highfive.hirp.board.common.SaveMultipartFile;
import com.highfive.hirp.board.department.domain.DepartmentBoard;
import com.highfive.hirp.board.department.service.DepartmentBoardService;
import com.highfive.hirp.board.reply.domain.Reply;
import com.highfive.hirp.common.PageInfo;
import com.highfive.hirp.common.Search;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.employee.service.EmployeeAdminService;

@CrossOrigin(origins = "http://127.0.0.1:8889, http://192.168.0.76:8887")
@Controller
public class DepartmentBoardController {

	@Autowired
	private DepartmentBoardService dService;

	@Autowired
	public AlarmService aService;

	@Autowired
	public EmployeeAdminService eaService;

	@RequestMapping(value = "department/writeView.hirp")
	public String DepartmentWriteView(ModelAndView mv) {
		return "board/departmentBoard/departmentWriteView";
	}

	// ??????????????? ?????? ????????? ??????
	@RequestMapping(value = "/department/list.hirp", method = RequestMethod.GET)
	public ModelAndView departmentListView(ModelAndView mv,
			@RequestParam(value = "page", required = false) Integer page) {
		int currentPage = (page != null) ? page : 1;
		int totalCount = dService.getListCount();
		PageInfo pi = BoardPagination.getPageInfo(currentPage, totalCount);
		// ??????????????? ????????? ??????
		List<DepartmentBoard> dList = dService.printAllDepartment(pi);
		if (!dList.isEmpty()) {
			mv.addObject("dList", dList);
			mv.addObject("pi", pi);
			mv.setViewName("board/departmentBoard/departmentListView");
		} else {
			mv.addObject("msg", "??????????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// ??????????????? ????????? ??????
	@RequestMapping(value = "/department/detail.hirp", method = RequestMethod.GET)
	public ModelAndView departmentDetailView(ModelAndView mv, @RequestParam("deptNo") int deptNo) {
		DepartmentBoard departmentboard = dService.printOneDepartment(deptNo);
		Integer DepartmentViewCount = dService.viewCount(deptNo);
		if (departmentboard != null) {
			mv.addObject("dept", departmentboard);
			mv.setViewName("board/departmentBoard/departmentDetail");
		} else {
			mv.addObject("msg", "????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// ??????????????? ?????? ????????? ??????
	@RequestMapping(value = "/department/searchList.hirp", method = RequestMethod.GET)
	public ModelAndView departmentSearchList(ModelAndView mv, @ModelAttribute Search search) {
		try {
			List<DepartmentBoard> searchList = dService.printSearchDepartment(search);
			if (!searchList.isEmpty()) {
				mv.addObject("dList", searchList);
				mv.setViewName("board/DepartmentBoard/DepartmentListView");
			} else {
				mv.addObject("msg", "???????????? ??????");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.toString());
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	// ????????? ??????
	@RequestMapping(value = "/department/register.hirp", method = RequestMethod.POST)
	public ModelAndView registerDepartment(ModelAndView mv, @ModelAttribute DepartmentBoard departmentboard,
			@RequestParam(value = "uploadFiles", required = false) List<MultipartFile> multipartfile,
			HttpServletRequest request) {

		HttpSession session = request.getSession();
		String emplId = (String) session.getAttribute("emplId");
		String deptCode = (String) session.getAttribute("deptCode");
		departmentboard.setEmplId(emplId);
		departmentboard.setDeptCode(deptCode);

		// ?????? ??????, oracle date????????? ???????????? ????????? ????????? ???.
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(date);
		System.out.println("today: " + today);

		// ?????? ????????? ??????
		int result = dService.registerDepartment(departmentboard);
		if (multipartfile.size() > 0 && !multipartfile.get(0).getOriginalFilename().equals("")) {

			List<Map<String, String>> fileList = SaveMultipartFile.saveFile(multipartfile, request);
			for (int i = 0; i < multipartfile.size(); i++) {
				String fileName = fileList.get(i).get("fileName");
				String fileRename = fileList.get(i).get("fileRename");
				String filePath = fileList.get(i).get("filePath");
				// ???????????? ????????? ??????
				BoardAttachedFile boardFile = new BoardAttachedFile();
				boardFile.setBoardCode(departmentboard.getBoardCode());
				boardFile.setFileName(fileName);
				boardFile.setFileRename(fileRename);
				boardFile.setFilePath(filePath);

				int fileResult = dService.registerDepartmentFile(boardFile);
			}
		}
		try {
			if (result > 0) {
				// ?????? ????????? ??????
//						  List<Employee> deptEmplList = eaService.printEmployeeWithDeptCode(deptCode);
//						  if(!deptEmplList.isEmpty()) {
//								for(int i=0; i<deptEmplList.size(); i++) {
//									if(!deptEmplList.get(i).getEmplId().equals(emplId)) {
//										//??????????????? ?????? ??????
//										Alarm alarm = new Alarm(deptEmplList.get(i).getEmplId(), today, "[???????????????] '"+departmentboard.getDeptTitle()+"' ?????? ?????????????????????.",
//												"10", "N", emplId);
//										int result2 = aService.insertAlarm(alarm);
//										if(result2 > 0) {
//											System.out.println(departmentboard.getDeptTitle()+"?????? ????????? ?????????????????????.");
//										}
//									}
//								}
//							}
				mv.setViewName("redirect:/department/list.hirp");
			} else {
				mv.addObject("msg", "?????????????????? ??????");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.setViewName("common/errorPage");
			mv.addObject("msg", e.toString());
		}
		return mv;
	}

	// ????????? ?????? ?????????
	@RequestMapping(value = "/department/modifyView.hirp", method = RequestMethod.GET)
	public ModelAndView departmentUpdateView(ModelAndView mv, @RequestParam("deptNo") int deptNo) {
		DepartmentBoard departmentboard = dService.printOneDepartment(deptNo);
		if (departmentboard != null) {
			mv.addObject("department", departmentboard);
			mv.setViewName("board/departmentBoard/departmentModifyView");
		} else {
			mv.addObject("msg", "?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	// ????????? ??????
	@RequestMapping(value = "/department/modify.hirp", method = RequestMethod.POST)
	public ModelAndView modifyDepartment(ModelAndView mv, @ModelAttribute DepartmentBoard departmentboard,
			@RequestParam(value = "reloadFile", required = false) List<MultipartFile> reloadFile,
			HttpServletRequest request) {
		try {
			// ???????????? ????????? ?????? ??????(reloadFile, request),???????????? ???????????? ????????? ?????????
			if (reloadFile.size() > 0 && !reloadFile.get(0).getOriginalFilename().equals("")) {
				// reloadFile.get(0).getOriginalFilename() != ""

				List<BoardAttachedFile> dList = dService.printOneFile(departmentboard);
				// ?????? ?????? ??????(?????? ?????? ?????? ??????)
				for (int i = 0; i < dList.size(); i++) {
					int fileNo = dList.get(i).getFileNo();
					System.out.println(fileNo);
					int result = dService.removeBoardFile(fileNo);
					String filePath = dList.get(i).getFilePath();
					SaveMultipartFile.deleteFile(filePath, request);
				}
				List<Map<String, String>> fileList = SaveMultipartFile.saveFile(reloadFile, request);
				BoardAttachedFile bFile = new BoardAttachedFile();
				for (int i = 0; i < reloadFile.size(); i++) {
					String fileName = fileList.get(i).get("fileName");
					String fileRename = fileList.get(i).get("fileRename");
					String filePath = fileList.get(i).get("filePath");
					// ???????????? ????????? ??????
					bFile.setBoardCode(departmentboard.getBoardCode());
					bFile.setBoardNo(departmentboard.getDeptNo());
					bFile.setFileName(fileName);
					bFile.setFileRename(fileRename);
					bFile.setFilePath(filePath);

					int fileResult = dService.modifyDepartmentFile(bFile);
				}
			}

			// ????????? ?????? ????????? ??????
			int result = dService.modifyDepartment(departmentboard);

			if (result > 0) {
				mv.setViewName("board/departmentBoard/departmentDetail");
			} else {
				// ??????
				mv.addObject("msg", "???????????? ?????? ??????");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.toString());
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	// ????????? ??????
	@RequestMapping(value = "/department/remove.hirp", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView removeDepartment(ModelAndView mv, @RequestParam("deptNo") int deptNo) {
		int result = dService.removeDepartment(deptNo);
		if (result > 0) {
			mv.setViewName("redirect:/department/list.hirp");
		} else {
			mv.addObject("msg", "???????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	// ??????
	@ResponseBody
	@RequestMapping(value = "/board/statistic.hirp", method = RequestMethod.GET)
	public String departmentBoardStatistic(@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate,
			@RequestParam("callback") String callback,
			HttpServletResponse response, HttpServletRequest request)
			throws JsonIOException, IOException {
		SimpleDateFormat fmt= new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");        
		//????????? IP??????
		String remoteAddr = request.getRemoteAddr();
		//????????? ????????? ??????
		String remoteDateTime = fmt.format(new Date());
		//????????? ??????
		String remoteDate = remoteDateTime.substring(0, 10);
		//????????? ??????
		String remoteTime = remoteDateTime.substring(10, 18);
		System.out.println("RemoteAddr >>>>>>>>>>>>>>>>> " + remoteAddr +" "+ remoteDate +" "+ remoteTime);
		Map<String, Object> addrMap = new HashMap();
		addrMap.put("remoteAddr", remoteAddr);
		addrMap.put("remoteDate", remoteDate);
		addrMap.put("remoteTime", remoteTime);
		int addrResult = dService.registerRemoteAddrInfo(addrMap);
		
		Map<String, Object> dateMap = new HashMap();
		dateMap.put("startDate", startDate); // ????????? ???????????? ?????? ???????????? ??????
		dateMap.put("endDate", endDate);
		List<Map<String, Object>> dList = dService.departmentStatistic(dateMap);
		
		List<Map<String, Object>> mapList = new ArrayList();
		for (int i = 0; i < dList.size(); i++) {
			String emplId = dList.get(i).get("EMPL_ID").toString();
			String statisticCount = dList.get(i).get("STATISTIC_COUNT").toString();
			Map<String, Object> map = new HashMap();
			map.put("emplId", emplId);
			map.put("statisticCount", statisticCount);
			mapList.add(map);
		}
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		result = mapper.writeValueAsString(mapList);
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
//		gson.toJson(mapList, response.getWriter());
		
		return callback+"(" + result +")";
	}

	@ResponseBody
	@RequestMapping(value="/remoteAppr/list.hirp",method=RequestMethod.GET)
	public String remoteApprInfoList(@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchValue") String searchValue,@RequestParam("callback") String callback
			,HttpServletResponse response, HttpServletRequest request) throws JsonIOException, IOException {
		
		Map<String, Object> dataMap = new HashMap();
		dataMap.put("searchCondition", searchCondition); // ????????? ???????????? ?????? ???????????? ??????
		dataMap.put("searchValue", searchValue);
		List<Map<String, Object>> dList = dService.remoteApprInfoList(dataMap);
		
		List<Map<String, Object>> mapList = new ArrayList();
		for (int i = 0; i < dList.size(); i++) {
			String addrNo = dList.get(i).get("REMOTE_ADDR_NO").toString();
			String addr = dList.get(i).get("REMOTE_ADDR").toString();
			String addrDate = dList.get(i).get("ACCESS_DATE").toString();
			String addrTime = dList.get(i).get("ACCESS_TIME").toString();
			Map<String, Object> map = new HashMap();
			map.put("addrNo", addrNo);
			map.put("addr", addr);
			map.put("addrDate", addrDate);
			map.put("addrTime", addrTime);
			mapList.add(map);
		}
		String result = null;
		ObjectMapper mapper = new ObjectMapper();
		result = mapper.writeValueAsString(mapList);
		
		return callback+"(" + result +")";
	}
	
	
	
}
