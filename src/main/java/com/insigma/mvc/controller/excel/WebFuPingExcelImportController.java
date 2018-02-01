package com.insigma.mvc.controller.excel;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.dto.AjaxReturnMsg;
import com.insigma.http.HttpRequestUtils;
import com.insigma.mvc.MvcHelper;
import com.insigma.mvc.model.Ac60ExcelTemp;
import com.insigma.mvc.model.SysExcelBatch;
import com.insigma.resolver.AppException;

/**
 * 贫困人员信息管理-导入
 * @author pangyuying
 *
 */
@Controller
@RequestMapping("/excelimport/EXCEL_IMPORT_001_001")
public class WebFuPingExcelImportController extends MvcHelper{

	private static Log log=LogFactory.getLog(WebFuPingExcelImportController.class);
	
    //http工具类
    @Resource
    private HttpRequestUtils httpRequestUtils;

	
	/**
	 * 主页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws com.insigma.resolver.AppException
	 */
	@RequestMapping(value = "/index")
	public ModelAndView toCodeValuesuggest(HttpServletRequest request, HttpServletResponse response) throws AppException {
		ModelAndView modelAndView=new ModelAndView("excel/ExcelImport");
        return modelAndView;
	}
	
	/**
	 * 列表查询
	 * @param request
	 * @return
	 */
	@RequestMapping("/getList")
	@ResponseBody
	public String getList(HttpServletRequest request, SysExcelBatch sExcelBatch ) throws Exception {
		String url =  "/api/excel/batchs";
		return  httpRequestUtils.httpPost(url, sExcelBatch).get("obj").toString();
	}

	
	
	/**
	 * 列表查询 导入数据总体情况 
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPovertyImprtDataTotalList")
	@ResponseBody
	public String queryPovertyDataTotalByexcelBatchNumber(HttpServletRequest request, Ac60ExcelTemp ac60ExcelTemp ) throws Exception {
		String url =  "/api/excel/total";
		return  httpRequestUtils.httpPost(url, ac60ExcelTemp).get("obj").toString();
	}
	
	/**
	 * 列表查询 导入数据明细情况 
	 * @param request
	 * @return
	 */
	@RequestMapping("/getPovertyImprtDataList")
	@ResponseBody
	public String getPovertyImprtDataList(HttpServletRequest request, Ac60ExcelTemp ac60ExcelTemp ) throws Exception {
		String url =  "/api/excel/detail";
		return  httpRequestUtils.httpPost(url, ac60ExcelTemp).get("obj").toString();
	}
	
	/**
	 * 删除临时表数据
	 * @param request
	 * @return
	 */
	@RequestMapping("/deleteTempDataByNumber/{excel_batch_number}")
	@ResponseBody
	public AjaxReturnMsg<String> deleteTempDataByNumber(HttpServletRequest request ,@PathVariable String excel_batch_number) throws Exception {
		String url =  "/api/excel/"+excel_batch_number;
		JSONObject obj = httpRequestUtils.httpDelete(url);
		return (AjaxReturnMsg) JSONObject.toBean(obj, AjaxReturnMsg.class);
	}
  
}
