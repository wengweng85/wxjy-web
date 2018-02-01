package com.insigma.http;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.github.pagehelper.PageInfo;
import com.insigma.dto.SysCode;
import com.insigma.json.JsonDateValueProcessor;
import com.insigma.resolver.AppException;
import com.insigma.shiro.realm.SUserUtil;


/**
 * httprequest工具类
 *
 * @param <T>
 * @author wengsh
 */
public class HttpRequestUtils<T> {


    private Log log = LogFactory.getLog(HttpRequestUtils.class);    //日志记录

    public JsonConfig jsonConfig;
    private String appkey;
    private String base_api_url;

    public HttpRequestUtils(String appkey, String base_api_url) {
        jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
        this.appkey = appkey;
        this.base_api_url = base_api_url;
    }

    public HttpRequestUtils(String appkey) {
        jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
        this.appkey = appkey;
        this.base_api_url = "";
    }

    /**
     * 对象转换成jsonobject
     *
     * @param t
     * @return
     */
    private JSONObject toJsonObject(T t) {
        JSONObject jsonParam = JSONObject.fromObject(t, jsonConfig);
        return jsonParam;
    }

    /**
     * jsonobject转换成对象
     *
     * @param t
     * @return
     */
    private T tobean(JSONObject jsonobject, T t) {
        return (T) JSONObject.toBean(jsonobject, t.getClass());
    }

    /**
     * jsonobject转换成对象数组
     *
     * @param t
     * @return
     */
    public List<T> toList(JSONArray jsonarray, T t) {
        return (List<T>) JSONArray.toList(jsonarray, t.getClass());
    }

    /**
     * jsonobject转换成对象数组
     *
     * @return
     */
    public List<T> toList(JSONArray jsonarray, Class c) {
        return (List<T>) JSONArray.toList(jsonarray, c);
    }


    /**
     * 发送get请求 返回json数组
     *
     * @param url 路径
     * @return
     */
    private JSONArray httpGetReturnArray(String url) throws AppException {
        return httpGet(url).getJSONArray("obj");
    }

    /**
     * 发送get请求 返回json数组
     *
     * @param url 路径
     * @param t   请求数据对象
     * @return
     */
    private JSONArray httpPostReturnArray(String url, T t) throws AppException {
        return httpPost(url, t).getJSONArray("obj");
    }

    public PageInfo<T> httpPostReturnPage(String url, T t) throws AppException {
        JSONObject jsonObject = httpPost(url, t);
        PageInfo<T> pageInfo = (PageInfo<T>) JSONObject.toBean(jsonObject.getJSONObject("obj"), PageInfo.class);
        pageInfo.setList(toList(jsonObject.getJSONObject("obj").getJSONArray("list"), t.getClass()));
        return pageInfo;
    }

    public PageInfo<T> httpPostReturnPage(String url, T t, Class c) throws AppException {
        JSONObject jsonObject = httpPost(url, t);
        PageInfo<T> pageInfo = (PageInfo<T>) JSONObject.toBean(jsonObject.getJSONObject("obj"), PageInfo.class);
        pageInfo.setList(toList(jsonObject.getJSONObject("obj").getJSONArray("list"), c));
        return pageInfo;
    }


    /**
     * 发送get请求 返回json对象
     *
     * @param url 路径
     * @param t   请求数据对象
     * @return
     */
    public JSONObject httpPostReturnObject(String url, T t) throws AppException {
        return httpPost(url, t).getJSONObject("obj");
    }

    public List<T> httpGetReturnList(String url, T t) throws AppException {
        return toList(httpGetReturnArray(url), t);
    }


    /**
     * 返回对象list
     *
     * @param url
     * @param t
     * @return
     * @throws AppException
     */
    public List<T> httpPostReturnList(String url, T t) throws AppException {
        return toList(httpPostReturnArray(url, t), t);
    }

    /**
     * 发送get请求 返回json对象
     *
     * @param url 路径
     * @return
     */
    public T httpPostObject(String url, T t, Class c) throws AppException {
        return (T) JSONObject.toBean(httpPost(url, t).getJSONObject("obj"), c);
    }


    /**
     * 发送get请求 返回json对象
     *
     * @param url 路径
     * @return
     */
    public JSONObject httpGetReturnObject(String url) throws AppException {
        return httpGet(url).getJSONObject("obj");
    }


    /**
     * 发送get请求 返回json对象
     *
     * @param url 路径
     * @return
     */
    public T httpGetObject(String url, Class c) throws AppException {
        return (T) JSONObject.toBean(httpGet(url).getJSONObject("obj"), c);
    }


    /**
     * 返回对象list
     *
     * @param url
     * @param c
     * @return
     * @throws AppException
     */
    public List<T> httpGetReturnList(String url, Class c) throws AppException {
        return toList(httpGetReturnArray(url), c);
    }



    /**
     * post请求
     *
     * @param url         地址
     * @param t           对象
     * @return
     * @throws AppException
     */
    public JSONObject httpPost(String url, T t) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executePost(base_api_url + url, t, appkey);
            return parseHttpResult(httpresult, url);
        } catch (Exception e) {
            throw new AppException(e);
        }
    }
    


    /**
     * 发送delete 请求
     *
     * @param url
     * @return
     * @throws AppException
     */
    public JSONObject httpDelete(String url) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executeDelete(base_api_url + url, appkey);
            return parseHttpResult(httpresult, url);
        } catch (IOException e) {
            throw new AppException(e);
        }
    }

    
 

    /**
     * 发送get请求
     *
     * @param url
     * @return
     * @throws AppException
     */
    public JSONObject httpGet(String url) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executeGet(base_api_url + url, appkey);
            return parseHttpResult(httpresult, url);
        } catch (IOException e) {
            throw new AppException(e);
        }
    }

    /**
     * 发送文件
     *
     * @param url
     * @return
     * @throws AppException
     */
    public JSONObject httpUploadFile(String url, File file, String file_name,String file_bus_type, String file_bus_id, String userid) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executeUploadFile(base_api_url + url, appkey, file, file_name,file_bus_type, file_bus_id, userid);
            return parseHttpResult(httpresult, url);
        } catch (IOException e) {
            throw new AppException(e);
        }
    }

    /**
     * 发送文件（附加文件描述）
     * @param url
     * @param file
     * @param file_name
     * @param file_bus_type
     * @param file_bus_id
     * @param userid
     * @param desc
     * @return
     * @throws AppException
     */
    public JSONObject httpUploadFile(String url, File file, String file_name,String file_bus_type, String file_bus_id, String userid, String desc) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executeUploadFile(base_api_url + url, appkey, file, file_name,file_bus_type, file_bus_id, userid, desc);
            return parseHttpResult(httpresult, url);
        } catch (IOException e) {
            throw new AppException(e);
        }
    }
    
    /**
     * 发送文件(excel)
     * @param url
     * @param file
     * @param excel_batch_excel_type
     * @param mincolumns
     * @return
     * @throws AppException
     */
    public JSONObject executeUploadExcelFile(String url, File file, String excel_batch_excel_type, String mincolumns) throws AppException {
        try {
            HttpResult httpresult = HttpHelper.executeUploadExcelFile(base_api_url + url, appkey, file, excel_batch_excel_type,  mincolumns);
            return parseHttpResult(httpresult, url);
        } catch (IOException e) {
            throw new AppException(e);
        }
    }
    

    /**
     * 解析返回的httpresult
     *
     * @param httpresult
     * @param url
     * @throws AppException
     */
    private JSONObject parseHttpResult(HttpResult httpresult, String url) throws AppException {
        if (httpresult.getStatusCode() == HttpStatus.SC_OK) {
            JSONObject jsonResult = JSONObject.fromObject(httpresult.getContent());
            /**是否成功*/
            String syscode = jsonResult.getString("syscode");
            if (!syscode.equals(SysCode.SYS_CODE_200.getCode())) {
            	if(syscode.equals(SysCode.SYS_TOKEN_EMPTY.getCode())||syscode.equals(SysCode.SYS_TOKEN_ERROR.getCode())){
            		//注销当前登录信息
            		Subject user = SecurityUtils.getSubject();
            	    user.logout();
            	    SUserUtil.removeCurrentUser();
            	    throw new AppException("接口(" + url + ") 调用失败:状态码" + syscode+"token为空或超时,请登录");
            	}else{
            		throw new AppException("接口(" + url + ") 调用失败:状态码" + syscode);
            	}
            }
            return jsonResult;
        } else {
        	 System.out.println(httpresult.getStatusCode());
			 System.out.println(httpresult.getContent());
             throw new AppException("接口(" + url + ") 调用失败,http状态码:" + httpresult.getStatusCode());
        }
    }


    /**
     * 文件下载
     *
     * @param url
     * @return
     * @throws AppException
     */
    public File httpDownLoadFile(String url, String localdir) throws AppException {
        File file;
        try {
            file = HttpHelper.executeDownloadFile(base_api_url + url, appkey, localdir);
        } catch (IOException e) {
            throw new AppException(e);
        }
        return file;
    }
}
