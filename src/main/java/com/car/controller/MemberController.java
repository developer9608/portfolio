package com.car.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.car.k1.member.BCrypt;
import com.car.k1.member.MemberServiceImpl;
import com.car.k1.member.MemberVO;

@Controller
@SessionAttributes({"login_check", "login_id", "login_name", "login_role"})
public class MemberController {
			
	@Autowired
	MemberServiceImpl service;
	
	// 회원 가입 양식 페이지로 이동
	@RequestMapping(value="/joinForm.do")
	public String joinForm(Model model) {
		Date currentDate = new Date();
		model.addAttribute("d", currentDate); 
		return "/vehicle/member/joinForm.jsp";
	}
	
	// 회원 등록 처리
	@RequestMapping(value="/insertMember.do")
	public String insertMember(MemberVO vo) {
		// 비밀번호 암호화 처리
		String password = BCrypt.hashpw(vo.getMemberPassword(), BCrypt.gensalt());
		vo.setMemberEncPassword(password);
		
		service.memberInsert(vo);
	    
	    return "/login.do";
	}
	
	// 아이디 중복 확인 처리
	@RequestMapping("/IdCk.do")
	public void IdCk(HttpServletResponse response, 
			MemberVO vo ) throws Exception   {
	    PrintWriter out=response.getWriter();
	    MemberVO check = service.getMember(vo);
	    if (check != null) {
	    	out.print("T");
	    } else {
	    	out.print("F");	
	    }
	}
	
	// 관리자에 의한 회원 삭제 처리
	@RequestMapping(value="/memberDeleteAdmin.do")
	public void memberDeleteAdmin(MemberVO vo,  HttpServletResponse response) throws IOException {
		vo.setMemberEnabled("N");
		service.memberDelete(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 회원에 의한 회원 삭제 처리 및 세션 초기화
	@RequestMapping(value="/memberDelete.do")
	public void memberDelete(MemberVO vo,  HttpServletResponse response, SessionStatus session) throws IOException {
		vo.setMemberEnabled("N");
		service.memberDelete(vo);
		session.setComplete();
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 회원 권한 변경 처리
	@RequestMapping(value="/memberAuthority.do")
	public void memberAuthority(MemberVO vo,  HttpServletResponse response) throws IOException {
		vo.getMemberRole();
		service.memberAuthority(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 회원 정보 업데이트 처리
	@RequestMapping(value="/memberUpdate.do")
	public String memberUpdate(MemberVO vo) {
		String bcrypt = BCrypt.hashpw(vo.getMemberPassword(), BCrypt.gensalt()); 
		vo.setMemberEncPassword(bcrypt); 
		service.memberUpdate(vo);
		return "redirect:/index.jsp";
	}
	
	// 회원 정보 조회 처리
	@RequestMapping(value="/getMember.do")
	public String getMember(MemberVO vo, Model model) {
		model.addAttribute("vo", service.getMember(vo));
		return "/vehicle/member/getMember.jsp";
	}
	
	// 회원 목록 조회 처리
	@RequestMapping(value="/getMemberList.do")
	public String getMemberList(MemberVO vo, Model model) {
		if (vo.getSearchTitle() == null) {
			vo.setSearchTitle("id");
		}
		if (vo.getSearchValue() == null) {
			vo.setSearchValue("");
		}
		
		if (vo.getStartIdx() == 0) {
			vo.setStartIdx(1);
		} else {
			vo.setStartIdx(vo.getStartIdx());
		}
		vo.setEndIdx(vo.getStartIdx() + 9);
		
		int totalCount = service.totalCount(vo);
		int pageSize = 10;
		int pageListSize = 10;
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		int nowPage = vo.getStartIdx() / pageSize + 1;
		int endPage = (totalPage - 1) * pageSize + 1;
		int listStartPage = (nowPage - 1) / pageListSize * pageListSize + 1;
		int listEndPage = listStartPage + pageListSize - 1;
		
		model.addAttribute("startIdx", vo.getStartIdx());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("listStartPage", listStartPage);
		model.addAttribute("listEndPage", listEndPage);
		
		model.addAttribute("searchTitle", vo.getSearchTitle());
		model.addAttribute("searchValue", vo.getSearchValue());
		model.addAttribute("li", service.getMemberList(vo));
		return "/vehicle/admin/getMemberList.jsp";
	}
	
	// 로그인 페이지로 이동
	@RequestMapping(value = "/login.do")
	public String login(Model model) {
	    return "/vehicle/member/login.jsp";
	}
	
	// 로그인 처리
	@RequestMapping(value="/loginOK.do")
	public String login(MemberVO vo, Model model) {
		MemberVO member = service.getMember(vo);
		
		if (member==null || member.getMemberEnabled().equals("N")) {
			model.addAttribute("login_check", "F");
			return "redirect:/login.do";
		} else {
			if (BCrypt.checkpw(vo.getMemberPassword(), member.getMemberEncPassword())) {
				model.addAttribute("login_check", "T");
				model.addAttribute("login_id", member.getMemberLoginId());
				model.addAttribute("login_name", member.getMemberName());
				model.addAttribute("login_role", member.getMemberRole());
				model.addAttribute("login_Enabled", member.getMemberEnabled());
				return "redirect:/login.do";
			} else {
				model.addAttribute("login_check", "F");
				return "redirect:/login.do";
			}
		}
	}
	
	// 로그아웃 처리 및 세션 종료
	@RequestMapping(value="/logout.do")
	public String logout(SessionStatus session) {
		session.setComplete();
		return "redirect:/index.jsp";
	}
			 
}
