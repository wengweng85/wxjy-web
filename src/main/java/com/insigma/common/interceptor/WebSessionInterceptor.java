package com.insigma.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.insigma.common.util.MD5Util;
import com.insigma.mvc.model.SUser;
import com.insigma.shiro.realm.SUserUtil;

/**
 * 通用登录相关session Interceptor过滤器
 * @author wengsh
 * @date 2015-8-17
 *
 */
public class WebSessionInterceptor extends HandlerInterceptorAdapter {

	Log log=LogFactory.getLog(WebSessionInterceptor.class);

    private static int OVERTIME = 500;
    
	
	private NamedThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("StopWatch-StartTime");
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	 long beginTime = System.currentTimeMillis();//1、开始时间
         startTimeThreadLocal.set(beginTime);//线程绑定变量（该数据只有当前请求的线程可见）
    	if (handler instanceof HandlerMethod) {
			request.setAttribute("contextpath", request.getContextPath());
			Subject subject = SecurityUtils.getSubject();  
			if(subject.isAuthenticated()){
				//将当前登录信息设置到threadlocal中
				SUserUtil.setCurrentUser ((SUser)subject.getSession().getAttribute(SUserUtil.SHIRO_CURRENT_USER_INFO));  
			}
            return true;
        } else {
            return super.preHandle(request, response, handler);
        }
    }
    
	/**
	 * 获取ip+usergent+sessionid的hashcode
	 * @param request
	 * @return
	 */
	public String getReqeustHashcode(HttpServletRequest request ){
		String ip=request.getRemoteHost();
		String useragent=request.getHeader("User-Agent");
		String sessionid=request.getSession().getId();
		return MD5Util.MD5Encode(ip+useragent+sessionid);
	}
	
	  /**
     * afterCompletion
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
      
    }
}
