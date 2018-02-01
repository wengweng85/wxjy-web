package com.insigma.common.listener;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.sf.ehcache.Element;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.insigma.common.util.DateUtil;
import com.insigma.common.util.EhCacheUtil;
import com.insigma.http.HttpRequestUtils;
import com.insigma.mvc.component.appcontext.MyApplicationContextUtil;
import com.insigma.mvc.model.CodeType;
import com.insigma.mvc.model.CodeValue;
import com.insigma.redis.RedisManager;
import com.insigma.resolver.AppException;

/**
 * ��Ŀ��ʼ��
 *
 * @author wengsh
 */
public class ApplicationListener implements ServletContextListener {

    private Log log = LogFactory.getLog(ApplicationListener.class);

    private static String API_BASE_URL;

    private static String appkey;

    private static String redisswitch;

    static {
        Properties pro = new Properties();
        try {
            InputStream fis = ApplicationListener.class.getClassLoader().getResourceAsStream("/config/app/app.properties");
            pro.load(fis);
            API_BASE_URL = pro.getProperty("api_base_url");
            appkey = pro.getProperty("appkey");
            redisswitch = pro.getProperty("redisswitch");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public void contextDestroyed(ServletContextEvent arg0) {

    }

    /**
     * ����ehcache
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Date start=new Date();
    	//ʹ��redis
        if (redisswitch.equals("on")) {
            log.info("ʹ��redis���ز���");
            //ͨ��MyApplicationContextUtil��ȡbean
            final RedisManager redismanager = MyApplicationContextUtil.getContext().getBean(RedisManager.class);
            redismanager.init();
            //�Ƿ�ͬ����־ �����һ��ͬ��ʱ����1Сʱ֮�ڣ���ͬ�����ش���
            boolean syn_flag = true;
            Date code_value_last_update_time = (Date) redismanager.get("code_value_last_update_time");
            if (code_value_last_update_time != null) {
                if (!DateUtil.compare(new Date(), code_value_last_update_time, 3600 * 1000)) {
                    syn_flag = false;
                }
            }

            String url = API_BASE_URL + "/codetype/getInitcodetypeList";
            List<CodeType> list_code_type = null;
            try {
                list_code_type = new HttpRequestUtils<CodeType>(appkey).httpGetReturnList(url, CodeType.class);
                if (syn_flag) {
                	 ExecutorService fixedThreadPool = Executors.newFixedThreadPool(10);  
                     for(int i = 0; i < list_code_type.size(); i++){  
                     	 CodeType codeType = list_code_type.get(i);
                     	 final String code_type = codeType.getCode_type();  
                     	 fixedThreadPool.execute(new Runnable() {  
                     		    public void run() {  
                     		      log.info("��������="+code_type+",��ǰ�߳�="+Thread.currentThread().getName());  
                     		        //Thread.sleep(2000);  
                     		        try{
                     		        	 String url = API_BASE_URL + "/codetype/getInitCodeValueList/" + code_type;
                         		         List<CodeValue> list_code_value = new HttpRequestUtils<CodeValue>(appkey).httpGetReturnList(url, CodeValue.class);
                         		         if (list_code_value.size() > 0) {
                         		             //������μӼ��ص�redis������
                         		        	redismanager.set(code_type, list_code_value);
                         		         }
                     		        }catch(AppException e){
                     		        	//e.printStackTrace();
                     		        }
                     		    }  
                     		   });  
                     }
                    //��һ�θ���ʱ��
                    redismanager.set("code_value_last_update_time", new Date());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            //��redis��ͬ����ehcached
            if (list_code_type != null) {
                for (CodeType codetype : list_code_type) {
                    EhCacheUtil.getManager().getCache("webcache").put(new Element(codetype.getCode_type(), (List<CodeValue>) redismanager.get(codetype.getCode_type())));
                }
            }
           } else {
            log.info("��ʹ��redis���ز���");
            //�Ƿ�ͬ����־ �����һ��ͬ��ʱ����1Сʱ֮�ڣ���ͬ�����ش���
            boolean syn_flag = true;
            Element element = EhCacheUtil.getManager().getCache("webcache").get("code_value_last_update_time");
            if (element != null) {
                Date code_value_last_update_time = (Date) element.getValue();
                if (code_value_last_update_time != null) {
                    if (!DateUtil.compare(new Date(), code_value_last_update_time, 3600 * 1000)) {
                        syn_flag = false;
                    }
                }
            }
            if (syn_flag) {
                String url = API_BASE_URL + "/codetype/getInitcodetypeList";
                try {
                    List<CodeType> list_code_type = new HttpRequestUtils<CodeType>(appkey).httpGetReturnList(url, CodeType.class);
                    ExecutorService fixedThreadPool = Executors.newFixedThreadPool(10);  
                    for(int i = 0; i < list_code_type.size(); i++){  
                    	 CodeType codeType = list_code_type.get(i);
                    	 final String code_type = codeType.getCode_type();  
                    	 fixedThreadPool.execute(new Runnable() {  
                    		    public void run() {  
                    		    	 log.info("��������="+code_type+",��ǰ�߳�="+Thread.currentThread().getName());  
                    		        //Thread.sleep(2000);  
                    		        try{
                    		        	 String url = API_BASE_URL + "/codetype/getInitCodeValueList/" + code_type;
                        		         List<CodeValue> list_code_value = new HttpRequestUtils<CodeValue>(appkey).httpGetReturnList(url, CodeValue.class);
                        		         if (list_code_value.size() > 0) {
                        		             //������μӼ��ص�ehcache������
                        		             EhCacheUtil.getManager().getCache("webcache").put(new Element(code_type, list_code_value));
                        		         }
                    		        }catch(AppException e){
                    		        	//e.printStackTrace();
                    		        }
                    		    }  
                    	});  
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                //��һ�θ���ʱ��
                EhCacheUtil.getManager().getCache("webcache").put(new Element("code_value_last_update_time", new Date()));
            }
        }
    
	    Date end=new Date();
	    // log.info("��ʱ="+(end.getTime()-start.getTime())/1000+"��");
    }
}