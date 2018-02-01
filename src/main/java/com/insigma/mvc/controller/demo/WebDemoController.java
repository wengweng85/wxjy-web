package com.insigma.mvc.controller.demo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.insigma.http.FileUploadUtils;
import com.insigma.mvc.model.*;
import com.insigma.resolver.AppException;
import com.insigma.shiro.realm.SUserUtil;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.dto.AjaxReturnMsg;
import com.insigma.http.HttpRequestUtils;
import com.insigma.mvc.MvcHelper;

import java.io.IOException;
import java.io.PrintWriter;


/**
 * demo���Գ���
 * @author wengsh
 *
 */
@Controller
@RequestMapping("/demo")
public class WebDemoController extends MvcHelper {
	

    //http������
    @Resource
    private HttpRequestUtils httpRequestUtils;
	//�ļ��ϴ�������
	@Resource
	private FileUploadUtils fileUploadUtils;



	/**
	 * ��ת����ѯҳ��
	 * @param request
	 * @return
	 */
	@RequestMapping("/toquery")
	public ModelAndView index(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("demo/demoQuery");
        return modelAndView;
	}
	
	/**
	 * ��ת���༭ҳ��
	 * @param request
	 * @return
	 */
	@RequestMapping("/toedit/{id}")
	public ModelAndView toedit(HttpServletRequest request,Model model,@PathVariable String id) throws Exception {
		ModelAndView modelAndView=new ModelAndView("demo/demoEdit");
		String url =  "/api/demo/ac01/"+id;
		DemoAc01 ac01=(DemoAc01) httpRequestUtils.httpGetObject(url, DemoAc01.class);
		modelAndView.addObject("ac01",ac01);  
        return modelAndView;
	}
	
	
	/**
	 * ��ת���鿴ҳ��
	 * @param request
	 * @return
	 */
	@RequestMapping("/toview/{id}")
	public ModelAndView toview(HttpServletRequest request,Model model,@PathVariable String id) throws Exception {
		ModelAndView modelAndView=new ModelAndView("demo/demoView");
		String url =  "/api/demo/ac01/name/"+id;
		DemoAc01 ac01=(DemoAc01) httpRequestUtils.httpGetObject(url, DemoAc01.class);
		modelAndView.addObject("ac01",ac01);  
        return modelAndView;
	}
	
	/**
	 * ��ת���༭(����)ҳ��
	 * @param request
	 * @return
	 */
	@RequestMapping("/toadd")
	public ModelAndView toadd(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("demo/demoAdd");
        return modelAndView;
	}



	
	/**
	 * ��Աѡ���
	 * @param request
	 * @return
	 */
	@RequestMapping("/toselect")
	public ModelAndView selectindex(HttpServletRequest request,Model model) throws Exception {
		String callback_fun_name=request.getParameter("callback_fun_name");
		ModelAndView modelAndView=new ModelAndView("demo/demoSelect");
        modelAndView.addObject("callback_fun_name", callback_fun_name);
        return modelAndView;
	}
	
	

	
	/**
	 * ��ȡ��Ա��Ϣ�б�
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAc01List")
	@ResponseBody
	public String getAc01List(HttpServletRequest request,Model model, DemoAc01 ac01 ) throws Exception {
		String url =  "/api/demo/ac01s";
		return  httpRequestUtils.httpPost(url, ac01).get("obj").toString();
	}
	
	
	/**
	 * ͨ��idɾ����Աdemo��Ϣ
	 * @param request
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/deletebyid/{id}")
	@ResponseBody
	public AjaxReturnMsg deleteDemoDataById(HttpServletRequest request,Model model,@PathVariable String id) throws Exception{
		String url =  "/api/demo/ac01/"+id;
		JSONObject obj = httpRequestUtils.httpDelete(url);
		return (AjaxReturnMsg) JSONObject.toBean(obj, AjaxReturnMsg.class);
	}
	
	
	/**
	 * ����ɾ��
	 * @param request
	 * @param model
	 * @param ac01
	 * @return
	 */
	@RequestMapping("/batdelete")
	@ResponseBody
	public AjaxReturnMsg batDeleteDemodata(HttpServletRequest request,Model model,DemoAc01 ac01) throws Exception{
		String url =  "/api/demo/ac01/delete/bat";
		JSONObject obj =  httpRequestUtils.httpPost(url, ac01);
		return (AjaxReturnMsg) JSONObject.toBean(obj, AjaxReturnMsg.class);
	}
	
	
	/**
	 * ���»򱣴�
	 * @param ac01
	 * @return
	 */
	@RequestMapping("/savedata")
	@ResponseBody
	public AjaxReturnMsg savedata(@Validated({DemoAc01Group.Add.class}) DemoAc01 ac01, BindingResult result) throws Exception {
		//��������
		if (result.hasErrors()){
			return validate(result);
		}
		String url =  "/api/demo/ac01/put";
		JSONObject obj = httpRequestUtils.httpPost(url, ac01);
		return (AjaxReturnMsg) JSONObject.toBean(obj, AjaxReturnMsg.class);
	}

	/**
	 * �ϴ��ļ�
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadFile")
	public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException, AppException {
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();

		SUser suser = SUserUtil.getCurrentUser();

		try {
			SFileRecord sFileRecord = fileUploadUtils.uploadFile(request, suser.getUserid(),
					request.getParameter("file_bus_id"), Param.DEMO_IMG, "/api/demo/uploadFile");
			json.put("success", "true");
			json.put("bus_uuid", sFileRecord.getBus_uuid());
		} catch (Exception e) {
			json.put("success", "false");
			json.put("msg", e.getMessage());
		}

		out.write(json.toString());
		out.close();
	}

}
