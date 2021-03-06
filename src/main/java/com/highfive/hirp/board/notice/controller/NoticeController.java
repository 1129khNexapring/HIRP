package com.highfive.hirp.board.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.highfive.hirp.alarm.domain.Alarm;
import com.highfive.hirp.alarm.service.AlarmService;
import com.highfive.hirp.board.common.BoardAttachedFile;
import com.highfive.hirp.board.common.BoardPagination;
import com.highfive.hirp.board.common.SaveMultipartFile;
import com.highfive.hirp.board.department.domain.DepartmentBoard;
import com.highfive.hirp.board.department.service.DepartmentBoardService;
import com.highfive.hirp.board.notice.domain.NoticeBoard;
import com.highfive.hirp.board.notice.service.NoticeBoardService;
import com.highfive.hirp.board.reply.domain.Reply;
import com.highfive.hirp.common.PageInfo;

import com.highfive.hirp.common.Search;
import com.highfive.hirp.employee.domain.Employee;
import com.highfive.hirp.employee.service.EmployeeAdminService;

@Controller
public class NoticeController {

	@Autowired
	public NoticeBoardService nService;
	
	@Autowired
	public DepartmentBoardService dService;
	
	@Autowired
	public AlarmService aService;
	
	@Autowired
	public EmployeeAdminService eaService;

	@RequestMapping(value = "board/main.hirp")
	public ModelAndView boardMain(ModelAndView mv) {
		List<NoticeBoard> nList = nService.printNewestNotice();
		List<DepartmentBoard> dList = dService.printNewestDepartment();
		if (!nList.isEmpty()) {
			mv.addObject("nList", nList);
			mv.addObject("dList", dList);
			mv.setViewName("/board/boardMain");
		} else {
			mv.addObject("msg", "?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	@RequestMapping(value = "board/writeView.hirp")
	public String boardWriteView() {
		return "/board/boardWriteView";
	}

	// ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/notice/list.hirp", method = RequestMethod.GET)
	public ModelAndView noticeListView(ModelAndView mv, @RequestParam(value = "page", required = false) Integer page) {
		int currentPage = (page != null) ? page : 1;
		int totalCount = nService.getListCount();
		PageInfo pi = BoardPagination.getPageInfo(currentPage, totalCount);
		// ?????? ????????? ??????
		List<NoticeBoard> nList = nService.printAllNotice(pi);
		if (!nList.isEmpty()) {
			mv.addObject("nList", nList);
			mv.addObject("pi", pi);
			mv.setViewName("board/noticeBoard/noticeListView");
		} else {
			mv.addObject("msg", "??????????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// ???????????? ????????? ????????? ??????
	@RequestMapping(value = "/notice/detail.hirp", method = RequestMethod.GET)
	public ModelAndView noticeDetailView(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		NoticeBoard noticeboard = nService.printOneNotice(noticeNo);
		Integer NoticeViewCount = nService.viewCount(noticeNo);
		if (noticeboard != null) {
			mv.addObject("notice", noticeboard);
			mv.setViewName("board/noticeBoard/noticeDetail");
		} else {
			mv.addObject("msg", "????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/notice/searchList.hirp", method = RequestMethod.GET)
	public ModelAndView noticeSearchList(ModelAndView mv, @ModelAttribute Search search) {
		try {
			List<NoticeBoard> searchList = nService.printSearchNotice(search);
			if (!searchList.isEmpty()) {
				mv.addObject("nList", searchList);
				mv.setViewName("board/noticeBoard/noticeListView");
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

	//??????
	// ????????? ??????
	@RequestMapping(value = "/notice/register.hirp", method = RequestMethod.POST)
	public ModelAndView registerNotice(ModelAndView mv, @ModelAttribute NoticeBoard noticeboard,
			@RequestParam(value = "uploadFiles", required = false) List<MultipartFile> multipartfile,
			HttpServletRequest request) {

		HttpSession session = request.getSession();
		String emplId = (String) session.getAttribute("emplId");
		noticeboard.setEmplId(emplId);

		//?????? ??????, oracle date????????? ???????????? ????????? ????????? ???.
//		Date date = new Date();
//		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		String today = formatter.format(date);
//		System.out.println("today: " + today);
				
		// ?????? ????????? ??????
		int result = nService.registerNotice(noticeboard);
		if (multipartfile.size() > 0 && !multipartfile.get(0).getOriginalFilename().equals("")) {

			List<Map<String, String>> fileList = SaveMultipartFile.saveFile(multipartfile, request);
			for (int i = 0; i < multipartfile.size(); i++) {
				String fileName = fileList.get(i).get("fileName");
				String fileRename = fileList.get(i).get("fileRename");
				String filePath = fileList.get(i).get("filePath");
				// ???????????? ????????? ??????
				BoardAttachedFile boardFile = new BoardAttachedFile();
				boardFile.setBoardCode(noticeboard.getBoardCode());
				boardFile.setFileName(fileName);
				boardFile.setFileRename(fileRename);
				boardFile.setFilePath(filePath);

				int fileResult = nService.registerNoticeFile(boardFile);
			}
		}
		try {
			//??????????????? ?????? ?????? ??? ?????? ??????
			if (result > 0) {
				//??? ?????? ?????? ???????????? ?????? ?????? ???????????? ?????? ??????
				List<Employee> emplList = eaService.printAllEmployee();
				if(!emplList.isEmpty()) {
					for(int i=0; i<emplList.size(); i++) {
						if(!emplList.get(i).getEmplId().equals(emplId)) {
							//??????????????? ?????? ??????
							Alarm alarm = new Alarm(emplList.get(i).getEmplId(), "[???????????????] '"+noticeboard.getNoticeTitle()+"' ?????? ?????????????????????.",
									"10", "N", emplId);
							int result2 = aService.insertAlarm(alarm);
							if(result2 > 0) {
								System.out.println(noticeboard.getNoticeTitle()+"?????? ????????? ?????????????????????.");
							}
						}
					}
				}
				mv.setViewName("redirect:/notice/list.hirp");
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
	@RequestMapping(value = "/notice/modifyView.hirp", method = RequestMethod.GET)
	public ModelAndView noticeUpdateView(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		NoticeBoard noticeboard = nService.printOneNotice(noticeNo);
		if (noticeboard != null) {
			mv.addObject("notice", noticeboard);
			mv.setViewName("board/noticeBoard/noticeModifyView");
		} else {
			mv.addObject("msg", "?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	//??????
	// ????????? ??????
	@RequestMapping(value = "/notice/modify.hirp", method = RequestMethod.POST)
	public ModelAndView modifyNotice(
			ModelAndView mv
			, @ModelAttribute NoticeBoard noticeboard
			, @RequestParam(value = "reloadFile", required = false) List<MultipartFile> reloadFile
			, HttpServletRequest request) {
		try {
			// ???????????? ????????? ?????? ??????(reloadFile, request),???????????? ???????????? ????????? ?????????
			if (reloadFile.size() > 0 && !reloadFile.get(0).getOriginalFilename().equals("")) {
				//reloadFile.get(0).getOriginalFilename() != ""
				
				List<BoardAttachedFile> fList = nService.printOneFile(noticeboard);
				// ?????? ?????? ??????(?????? ?????? ?????? ??????)
				for (int i = 0; i < fList.size(); i++) {
					int fileNo = fList.get(i).getFileNo();
					System.out.println(fileNo);
					int result = nService.removeBoardFile(fileNo);
					String filePath = fList.get(i).getFilePath();
					SaveMultipartFile.deleteFile(filePath, request);
				}
				List<Map<String, String>> fileList = SaveMultipartFile.saveFile(reloadFile, request);
				BoardAttachedFile bFile = new BoardAttachedFile();
				for (int i = 0; i < reloadFile.size(); i++) {
					String fileName = fileList.get(i).get("fileName");
					String fileRename = fileList.get(i).get("fileRename");
					String filePath = fileList.get(i).get("filePath");
					 //???????????? ????????? ??????
					bFile.setBoardCode(noticeboard.getBoardCode());
					bFile.setBoardNo(noticeboard.getNoticeNo());
					bFile.setFileName(fileName);
					bFile.setFileRename(fileRename);
					bFile.setFilePath(filePath);

					int fileResult = nService.modifyNoticeFile(bFile);
				}
			}

			 //????????? ?????? ????????? ??????
			int result = nService.modifyNotice(noticeboard);
			
			
			
				if (result > 0) {
				mv.setViewName("board/noticeBoard/noticeDetail");
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
	@RequestMapping(value = "/notice/remove.hirp", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView removeNotice(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		int result = nService.removeNotice(noticeNo);
		if (result > 0) {
			mv.setViewName("redirect:/notice/list.hirp");
		} else {
			mv.addObject("msg", "???????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

	
	
	//?????? ????????? ??? ??????
	@RequestMapping(value="/written/board.hirp")
	public ModelAndView printAllMyNotice(ModelAndView mv,HttpServletRequest request) {
		HttpSession session = request.getSession();
		String emplId = (String) session.getAttribute("emplId");
		List<NoticeBoard> nList = nService.printMyNotice(emplId);
		
		if (!nList.isEmpty()) {
			mv.addObject("nList", nList);
			mv.setViewName("board/writtenBoard");
		} else {
			mv.addObject("msg", "??????????????? ?????? ??????");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}

}
