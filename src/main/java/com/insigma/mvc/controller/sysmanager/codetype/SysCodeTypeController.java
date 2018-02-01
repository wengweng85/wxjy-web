package com.insigma.mvc.controller.sysmanager.codetype;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.insigma.http.HttpRequestUtils;
import com.insigma.mvc.MvcHelper;
import com.insigma.mvc.model.CodeType;
import com.insigma.mvc.model.CodeValue;
import com.insigma.resolver.AppException;

/**
 * Created by wengsh on 2015-01-14.
 */
@Controller
@RequestMapping("/sys/codetype")
public class SysCodeTypeController extends MvcHelper<CodeValue> {

    //http工具类
    @Resource
    private HttpRequestUtils httpRequestUtils;
    
	 /**
	  * 通过代码类型、过滤条件获取代码 
	  * @param request
	  * @param response
	  * @param codevalue
	  * @return
	  * @throws AppException
	  */
	 @RequestMapping(value = "/getCodeValueList")
	 @ResponseBody
	 public List<CodeValue> getCodeValueList(HttpServletRequest request, HttpServletResponse response,CodeType codetype) throws AppException {
			String url =  "/codetype/getInitCodeValueListByFilter";
			List<CodeValue>  list =(List<CodeValue> )httpRequestUtils.httpPostReturnList(url,CodeValue.class);
			return list;
	 }
}