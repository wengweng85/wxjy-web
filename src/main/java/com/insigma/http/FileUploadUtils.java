package com.insigma.http;

import com.insigma.mvc.model.SFileRecord;
import net.sf.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Arrays;
import java.util.Iterator;

/**
 * �ļ��ϴ�������
 * Created by liuds on 2017/9/11.
 */
public class FileUploadUtils {

    //http������
    @Resource
    private HttpRequestUtils httpRequestUtils;

    public SFileRecord uploadFile(HttpServletRequest request, String userid, String file_bus_id, String file_bus_type, String url) throws Exception {

        String desc = request.getParameter("desc");

        // **********************������ʼ��*********************
        //����һ��ͨ�õĶಿ�ֽ�����
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //�ж� request �Ƿ����ļ��ϴ�,���ಿ������
        if (multipartResolver.isMultipart(request)) {
            //ת���ɶಿ��request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //ȡ��request�е������ļ���
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                //ȡ���ϴ��ļ�
                MultipartFile multipartFile = multiRequest.getFile(iter.next());

                // �õ�ȥ��·�����ļ���
                String originalFilename = multipartFile.getOriginalFilename();
                int indexofdoute = originalFilename.lastIndexOf(".");

                if (indexofdoute < 0) {
                    throw new Exception("�ļ���ʽ����");
                }

                /**�ļ�������׺*/
                String prefix = originalFilename.substring(0, indexofdoute);
                /**��ȡ�ļ��ĺ�׺**/
                String endfix = originalFilename.substring(indexofdoute).toLowerCase();
                String[] arr = {".jpg", ".jpeg", ".gif", ".png", ".bmp", ".pdf", ".doc", ".docx",
                        ".xls", ".xlsx", ".rar", ".zip", ".mp4"};
                if (!Arrays.asList(arr).contains(endfix)) {
                    throw new Exception("�ļ���ʽ����ȷ,��ȷ��");
                }
                if (prefix.length() < 3) {
                    prefix = prefix + "-001";
                }

                //�ϴ�����¼��־
                File file = File.createTempFile(prefix, endfix);
                multipartFile.transferTo(file);
                JSONObject result = httpRequestUtils.httpUploadFile(url, file, originalFilename, file_bus_type, file_bus_id, userid, desc);
                if (!result.getBoolean("success")) {
                    throw new Exception(result.getString("message"));
                }
                return (SFileRecord) JSONObject.toBean(result.getJSONObject("obj"), SFileRecord.class);
            }
        }
        return null;
    }
}