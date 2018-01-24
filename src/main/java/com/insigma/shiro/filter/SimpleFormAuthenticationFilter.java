package com.insigma.shiro.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.servlet.Cookie;
import org.apache.shiro.web.servlet.ShiroHttpServletRequest;
import org.apache.shiro.web.util.WebUtils;


/**
 * 自定义authc校验器
 * @author wengsh
 *
 */
public class SimpleFormAuthenticationFilter extends FormAuthenticationFilter {
	
	private Cookie sessionIdCookie;  
    
    public Cookie getSessionIdCookie() {  
        return sessionIdCookie;  
    }  
  
  
    public void setSessionIdCookie(Cookie sessionIdCookie) {  
        this.sessionIdCookie = sessionIdCookie;  
    }  
    
    @Override  
    protected void setFailureAttribute(ServletRequest request, AuthenticationException ae) {  
        request.setAttribute(getFailureKeyAttribute(), ae);  
    }  
      
    @Override  
    protected void issueSuccessRedirect(ServletRequest request, ServletResponse response) throws Exception {  
        String sessionid = sessionIdCookie.readValue(WebUtils.toHttp(request), WebUtils.toHttp(response));  
        // clear JSESSIONID in URL if session id is not null   
        if(sessionid != null){  
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_SOURCE,ShiroHttpServletRequest.COOKIE_SESSION_ID_SOURCE);  
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID, sessionid);  
            request.setAttribute(ShiroHttpServletRequest.REFERENCED_SESSION_ID_IS_VALID, Boolean.TRUE);  
        }  
        super.issueSuccessRedirect(request, response);  
    }  

	protected boolean onAccessDenied(ServletRequest servletrequest, ServletResponse servletresponse) throws Exception {  
        HttpServletRequest request = (HttpServletRequest) servletrequest;  
        HttpServletResponse response = (HttpServletResponse) servletresponse;  
        Subject subject = getSubject(request, response);  
        //如果没有登录
        if (subject.getPrincipal() == null) {  
        	//如果是ajax请求
        	if (isAjax(request)){
        		/*PrintWriter writer = response.getWriter();
                AjaxReturnMsg dto = new AjaxReturnMsg();
                Map<String, Object> map=new HashMap<String, Object>();
                map.put("statuscode", "session_expired");//您尚未登录或登录时间过长,请重新登录!
                map.put("redirecturl", "/gotologin");;
                dto.setObj(map);
                writer.write(JSONObject.fromObject(dto).toString());
                writer.flush();*/
        		
        		//未登录将强制跳转到登录页面
                response.setHeader("statuscode", "session_expired");
                response.setHeader("redirecturl", "/gotologin");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            } else {  
                saveRequestAndRedirectToLogin(request, response);  
            } 
        }else{
        	//如果是ajax请求
        	if (isAjax(request)){
        		/*PrintWriter writer = response.getWriter();
                AjaxReturnMsg dto = new AjaxReturnMsg();
                Map<String, Object> map=new HashMap<String, Object>();
                map.put("statuscode", "unauthorized");//您没有足够的权限执行该操作
                map.put("redirecturl", "/index");;
                dto.setObj(map);
                writer.write(JSONObject.fromObject(dto).toString());
                writer.flush();*/
                
                response.setHeader("statuscode", "unauthorized");
                response.setHeader("redirecturl", "/index");
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            } else {  
                saveRequestAndRedirectToLogin(request, response);  
            } 
        }
        return false;
    } 
	
	/**
	 * 是否是ajax请求
	 * @param request
	 * @return
	 */
	public boolean isAjax( HttpServletRequest request){
	      return request.getHeader("accept").indexOf("application/json") > -1 || (request.getHeader("X-Requested-With")!= null && request.getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1); 
	}
}
