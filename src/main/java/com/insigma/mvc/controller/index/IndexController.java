package com.insigma.mvc.controller.index;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.mvc.MvcHelper;
import com.insigma.shiro.realm.SUserUtil;



/**
 * ��������ҳcontoller
 * @author wengsh
 *
 */
@Controller
public class IndexController extends MvcHelper {
	
	
	/**
	 * ��������ҳ��
	 * @param request
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView gotoAdminIndex(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("index/admin_index");
		modelAndView.addObject("SYS_TITLE", "��������ƽ̨");
		modelAndView.addObject("suser", SUserUtil.getCurrentUser());
    	modelAndView.addObject("permlist",SUserUtil.getCurrentUser().getSpermlist());
        return modelAndView;
	}
	
	
	/**
	 * ϵͳ��ҳ
	 * @param request
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView gotoIndex(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("index/index");
        return modelAndView;
	}
	
	/**
	 * http 404 ����
	 * @param request
	 * @return
	 */
	@RequestMapping("/404")
	public ModelAndView error404(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/404");
        return modelAndView;
	}
	
	/**
	 * http 500 ����
	 * @param request
	 * @return
	 */
	@RequestMapping("/500")
	public ModelAndView error500(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/500");
        return modelAndView;
	}
	
	/**
	 *  δ��Ȩ
	 * @param request
	 * @return
	 */
	@RequestMapping("/unrecognized")
	public ModelAndView unrecognized(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/unrecognized");
        return modelAndView;
	}
	
	/**
	 *  δ��Ȩ
	 * @param request
	 * @return
	 */
	@RequestMapping("/resubmit")
	public ModelAndView resubmit(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/resubmit");
        return modelAndView;
	}
	
	
}
