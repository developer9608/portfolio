package com.car.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.car.k1.model.ModelServiceImpl;
import com.car.k1.model.ModelVO;
import com.car.k1.rez.RezServiceImpl;
import com.car.k1.rez.RezVO;

@Controller
public class RezController {
	
	@Autowired
	private ModelServiceImpl mservice;
	
	@Autowired
	private RezServiceImpl rservice;
	
	@RequestMapping(value="/rezForm.do")
	public String rezForm(Model model, ModelVO mvo) {
	    ModelVO modelmg = mservice.modelOne(mvo);
        String modelImgStr = modelmg.getModelImgStr();
        if (modelImgStr != null) {
            String[] imageArray = modelImgStr.split(",");
            List<String> modelImageNames = Arrays.asList(imageArray);
            modelmg.setImageNames(modelImageNames); 
        }
        
		ModelVO mvoModelName = mservice.modelOne(mvo);
		
		model.addAttribute("m", modelmg);
		model.addAttribute("mvo", mvoModelName);
	    return "/vehicle/rez/rezForm.jsp";
	}
	
	@RequestMapping(value="/rezFormOK.do")
	public String rezFormOK(RezVO vo) {
		rservice.insertRez(vo);
	    return "/getRezList.do";
	}
	
	@RequestMapping(value="/deleteRez.do")
	public void deleteRez(RezVO vo, 
			HttpServletResponse response) throws IOException{
		
		rservice.deleteRez(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}

	
	@RequestMapping(value="/getRezList.do")
	public String getRezList(Model model, RezVO rvo, ModelVO mvo) {
	    if (rvo.getSearchTitle() == null) {
	        rvo.setSearchTitle("rezNo");
	    }
	    if (rvo.getSearchValue() == null) {
	        rvo.setSearchValue("");
	    }
	    
	    if (rvo.getStartIdx() == 0) {
	        rvo.setStartIdx(1);
	    } else {
	        rvo.setStartIdx(rvo.getStartIdx());
	    }
	    rvo.setEndIdx(rvo.getStartIdx() + 4);
    
	    int totalCount = rservice.totalCount(rvo);
	    int pageSize = 5;
	    int pageListSize = 10;
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
	    int nowPage = rvo.getStartIdx() / pageSize + 1;
	    int endPage = (totalPage - 1) * pageSize + 1;
	    int listStartPage = (nowPage - 1) / pageListSize * pageListSize + 1;
	    int listEndPage = listStartPage + pageListSize - 1;
	    
	    model.addAttribute("startIdx", rvo.getStartIdx());
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("nowPage", nowPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("listStartPage", listStartPage);
	    model.addAttribute("listEndPage", listEndPage);
	    model.addAttribute("searchTitle", rvo.getSearchTitle());
	    model.addAttribute("searchValue", rvo.getSearchValue());
	    
	    List<RezVO> rezList = rservice.getRezList(rvo);
	    Map<RezVO, List<ModelVO>> rezModelMap = new HashMap<>();

	    for (RezVO rez : rezList) {
	        String rName = rez.getRezModelName();
	        mvo.setModelName(rName);
	        List<ModelVO> modelList = mservice.modelRezImg(mvo);
	        for (ModelVO selectedModel : modelList) {
	            String modelImgStr = selectedModel.getModelImgStr();
	            if (modelImgStr != null) {
	                String[] imageArray = modelImgStr.split(",");
	                List<String> modelImageNames = Arrays.asList(imageArray);
	                selectedModel.setImageNames(modelImageNames); 
	            }
	        }
	        rezModelMap.put(rez, modelList);
	    }

	    model.addAttribute("rezModelMap", rezModelMap);
		Date today = new Date();
		model.addAttribute("today", today);
	    model.addAttribute("rli", rservice.getRezList(rvo));

	    return "/vehicle/rez/rezList.jsp";
	}
	
	//  ¸®ºä
	@RequestMapping(value="/rezReview.do")
	public String rezReview(RezVO vo, Model model) {
		model.addAttribute("vo", rservice.getRez(vo));
		return "/vehicle/rez/rezReview.jsp";
	}
	
	@RequestMapping(value="/deleteReview.do")
	public void deleteReview(RezVO vo, HttpServletResponse response) throws IOException {
		rservice.deleteReview(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/insertReview.do")
	public String insertReview(RezVO vo) {
		vo.setWriteReview("Y");
		rservice.updateWriteReview(vo);
		rservice.insertReview(vo);
		return "redirect:/index.jsp";
	}
}
