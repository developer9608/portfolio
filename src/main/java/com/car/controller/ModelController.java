package com.car.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.car.k1.model.ModelServiceImpl;
import com.car.k1.model.ModelVO;

@Controller
public class ModelController {
	
	// 파일 저장 경로 설정
	String path = "";
	
	@Autowired
	ModelServiceImpl service;
	
	@Autowired
	private ServletContext servlet;
	
	@PostConstruct
	public void init() {
		path = servlet.getRealPath("/vehicle/admin/files/");
		System.out.println("#################  "+ path);
	}
	
	// 모델 등록 폼 페이지로 이동
	@RequestMapping(value="/modelForm.do")
	public String modelForm(Model model, ModelVO vo) {
	    return "/vehicle/admin/modelForm.jsp";
	}

	// 모델 등록 처리
	@RequestMapping(value="/insertModel.do")
	public ResponseEntity<String> insertModel(ModelVO vo, 
	        @RequestParam("modelImgList") 
	        List<MultipartFile> modelImgList) throws Exception {
		    StringBuilder imgNames = new StringBuilder(); 
		    
		    for (MultipartFile uploadFile : modelImgList) {
		        long time = System.currentTimeMillis();
		        SimpleDateFormat daytime = new SimpleDateFormat("HHmmss");
		        String timeStr = daytime.format(time);
		        String fileName = uploadFile.getOriginalFilename();
		        File f = new File(path + fileName);
	
		        if (!uploadFile.isEmpty()) {
		            if (f.exists()) {
		                String fName = fileName.substring(0, fileName.lastIndexOf("."));
		                String extention = fileName.substring(fileName.lastIndexOf("."));
		                
		                fileName = fName + "_" + timeStr + extention;
		                System.out.println(fileName);
		            }
		            uploadFile.transferTo(new File(path + fileName));
		        } else {
		            fileName = "space.png";
		        }
		        if (imgNames.length() > 0) {
		            imgNames.append(","); 
		        }
		        imgNames.append(fileName);
		    }
		    vo.setModelImgStr(imgNames.toString());
		    service.modelInsert(vo);
		    return new ResponseEntity<>("success", HttpStatus.OK);
	}

	// 모델 삭제 처리
	@RequestMapping(value="/deleteModel.do")
	public void modelDelete(ModelVO vo, 
			HttpServletResponse response) throws IOException {
		service.modelDelete(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 모델 수정 처리
	@RequestMapping(value="/updateModel.do", method = RequestMethod.POST)
	public String updateModel(ModelVO vo, 
	       @RequestParam("modelImgList") List<MultipartFile> modelImgList, 
	       HttpServletResponse response) throws Exception { 
	    StringBuilder imgNames = new StringBuilder();
	    
	    for (MultipartFile uploadFile : modelImgList) {
	        long time = System.currentTimeMillis();
	        SimpleDateFormat daytime = new SimpleDateFormat("HHmmss");
	        String timeStr = daytime.format(time);
	        
	        String fileName = uploadFile.getOriginalFilename();
	        File f = new File(path + fileName);

	        if (!uploadFile.isEmpty()) {
	            if (f.exists()) {
	                String fName = fileName.substring(0, fileName.lastIndexOf("."));
	                String extention = fileName.substring(fileName.lastIndexOf("."));
	                
	                fileName = fName + "_" + timeStr + extention;
	            }
	            uploadFile.transferTo(new File(path + fileName));
	        } else {
	            fileName = "space.png";
	        }
	        if (imgNames.length() > 0) {
	            imgNames.append(",");
	        }
	        imgNames.append(fileName);
	    }
	    
	    vo.setModelImgStr(imgNames.toString());
	    service.modelUpdate(vo);
	    return "redirect:manageModelList.do";
	}
	
	// 모델 상세 정보 조회 처리
	@RequestMapping(value="/getModel.do")
	public String getModel(Model model, ModelVO vo) { 
	    ModelVO m = service.modelOne(vo);
	    String modelImgStr = m.getModelImgStr();
	    if (modelImgStr != null) {
	        String[] imageArray = modelImgStr.split(",");
	        List<String> modelImageNames = Arrays.asList(imageArray);
	        m.setImageNames(modelImageNames); 
	    }
	    model.addAttribute("m", m);
	    return "/vehicle/admin/getModel.jsp";
	}
	
	// 모델 정보 수정 폼으로 이동
	@RequestMapping(value="/editModel.do")
	public String editModel(Model model, ModelVO vo) { 
	    ModelVO m = service.modelOne(vo);
	    String modelImgStr = m.getModelImgStr();
	    if (modelImgStr != null) {
	        String[] imageArray = modelImgStr.split(",");
	        List<String> modelImageNames = Arrays.asList(imageArray);
	        m.setImageNames(modelImageNames); 
	    }
	    model.addAttribute("m", m);
	    return "/vehicle/admin/editModel.jsp";
	}
	
	// 모델 목록 조회 처리
	@RequestMapping(value="/modelList.do")
	public String modelList(Model model, ModelVO vo) {
	    if (vo.getSearchTitle() == null) {
	        vo.setSearchTitle("modelName");
	    }
	    if (vo.getSearchValue() == null) {
	        vo.setSearchValue("");
	    }
	    if (vo.getStartIdx() == 0) {
	        vo.setStartIdx(1);
	    } else {
	        vo.setStartIdx(vo.getStartIdx());
	    }
	    vo.setEndIdx(vo.getStartIdx() + 4);
	    
	    int totalCount = service.totalCount(vo);
	    int pageSize = 5;
	    int pageListSize = 10;
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
	    int nowPage = vo.getStartIdx() / pageSize + 1;
	    int endPage = (totalPage - 1) * pageSize + 1;
	    int listStartPage = (nowPage - 1) / pageListSize * pageListSize + 1;
	    int listEndPage = listStartPage + pageListSize - 1;
	    
	    model.addAttribute("start_idx", vo.getStartIdx());
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("nowPage", nowPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("listStartPage", listStartPage);
	    model.addAttribute("listEndPage", listEndPage);
	    model.addAttribute("searchTitle", vo.getSearchTitle());
	    model.addAttribute("searchValue", vo.getSearchValue());
	    
	    List<ModelVO> modelList = service.modelList(vo);
	    for (ModelVO selectedModel : modelList) {
	        String modelImgStr = selectedModel.getModelImgStr();
	        if (modelImgStr != null) {
	            String[] imageArray = modelImgStr.split(",");
	            List<String> modelImageNames = Arrays.asList(imageArray);
	            selectedModel.setImageNames(modelImageNames); 
	        }
	    }
	    model.addAttribute("li", modelList);
	    return "/vehicle/admin/modelList.jsp";
	}

	// 관리자용 모델 목록 조회 처리
	@RequestMapping(value="/manageModelList.do")
	public String manageModelList(Model model, ModelVO vo) {
	    if (vo.getSearchTitle() == null) {
	        vo.setSearchTitle("modelName");
	    }
	    if (vo.getSearchValue() == null) {
	        vo.setSearchValue("");
	    }
	    if (vo.getStartIdx() == 0) {
	        vo.setStartIdx(1);
	    } else {
	        vo.setStartIdx(vo.getStartIdx());
	    }
	    vo.setEndIdx(vo.getStartIdx() + 4);
	    
	    int totalCount = service.totalCount(vo);
	    int pageSize = 5;
	    int pageListSize = 10;
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
	    int nowPage = vo.getStartIdx() / pageSize + 1;
	    int endPage = (totalPage - 1) * pageSize + 1;
	    int listStartPage = (nowPage - 1) / pageListSize * pageListSize + 1;
	    int listEndPage = listStartPage + pageListSize - 1;
	    
	    model.addAttribute("start_idx", vo.getStartIdx());
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("nowPage", nowPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("listStartPage", listStartPage);
	    model.addAttribute("listEndPage", listEndPage);
	    model.addAttribute("searchTitle", vo.getSearchTitle());
	    model.addAttribute("searchValue", vo.getSearchValue());
	    
	    List<ModelVO> modelList = service.modelList(vo);
	    for (ModelVO selectedModel : modelList) {
	        String modelImgStr = selectedModel.getModelImgStr();
	        if (modelImgStr != null) {
	            String[] imageArray = modelImgStr.split(",");
	            List<String> modelImageNames = Arrays.asList(imageArray);
	            selectedModel.setImageNames(modelImageNames); 
	        }
	    }
	    
	    model.addAttribute("li", modelList);
	    return "/vehicle/admin/manageModelList.jsp";
	}
}
