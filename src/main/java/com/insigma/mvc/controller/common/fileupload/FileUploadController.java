package com.insigma.mvc.controller.common.fileupload;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.insigma.common.listener.AppConfig;
import com.insigma.common.util.DateUtil;
import com.insigma.common.util.RandomNumUtil;
import com.insigma.http.FileUploadUtils;
import com.insigma.http.HttpRequestUtils;
import com.insigma.mvc.MvcHelper;
import com.insigma.mvc.model.SFileRecord;
import com.insigma.mvc.model.SysExcelBatch;
import com.insigma.mvc.model.SysFileRecord;
import com.insigma.resolver.AppException;

/**
 * 文件上传下载
 * Created by liuds on 2017/9/11.
 */
@Controller
@RequestMapping(value = "/common/fileload")
public class FileUploadController extends MvcHelper {

    //http工具类
    @Resource
    private HttpRequestUtils<SFileRecord> httpRequestUtils;
    
    //文件上传工具类
  	@Resource
  	private FileUploadUtils fileUploadUtils;


    /**
     * 跳转至上传页面
     * @param request
     * @return
     */
    @RequestMapping("/tofilelist")
    public ModelAndView tofilelist(HttpServletRequest request, Model model, SysFileRecord sFileRecord ) throws Exception {
        ModelAndView modelAndView=new ModelAndView("common/fileupload/filelist");
        if(sFileRecord.getFile_bus_id()==null){
            throw new Exception("业务编号不能为空");
        }
        String url = request.getParameter("url");
        if(url==null){
            throw new Exception("上传路径不能为空");
        }
        sFileRecord.setFile_name("管理");
        modelAndView.addObject("filerecord", sFileRecord);
        modelAndView.addObject("url", url);
        return modelAndView;
    }

    /**
     * 跳转至图片上传页面
     * @param request
     * @return
     */
    @RequestMapping("/toImgUpload")
    public ModelAndView toupload(HttpServletRequest request,Model modell,SysFileRecord sFileRecord) throws Exception {
        ModelAndView modelAndView=new ModelAndView("common/fileupload/imgUpload");
        modelAndView.addObject("filerecord", sFileRecord);
        String url = request.getParameter("url");
        modelAndView.addObject("url", url);
        return modelAndView;
    }

    /**
     * 跳转至文件上传页面
     * @param request
     * @return
     */
    @RequestMapping("/toFileUpload")
    public ModelAndView toFileUpload(HttpServletRequest request,Model modell,SysFileRecord sFileRecord) throws Exception {
        ModelAndView modelAndView=new ModelAndView("common/fileupload/fileUpload");
        modelAndView.addObject("filerecord", sFileRecord);
        String url = request.getParameter("url");
        modelAndView.addObject("url", url);
        return modelAndView;
    }

    /**
     * 通过人员id获取文件列表
     *
     * @param sFileRecord
     * @return
     */
    @RequestMapping("/getFileList")
    @ResponseBody
    public HashMap getUserListByGroupid(SFileRecord sFileRecord) throws Exception {
        PageInfo<SFileRecord> pageinfo = httpRequestUtils.httpPostReturnPage("/api/file/getFileList", sFileRecord);
        return this.success_hashmap_response(pageinfo);
    }

    /**
     * 通过bus_uuid删除文件信息
     *
     * @param bus_uuid
     * @return
     */
    @RequestMapping("/deleteById/{bus_uuid}")
    @ResponseBody
    public String deleteFileByid(@PathVariable String bus_uuid) throws Exception {
        String url = "/api/file/deleteById/" + bus_uuid;
        return httpRequestUtils.httpGet(url).toString();
    }


    /**
     * 文件读取
     *
     * @param bus_uuid
     * @param response
     * @throws AppException
     */
    @RequestMapping(value = "/download/{bus_uuid}")
    public void download(@PathVariable String bus_uuid, HttpServletResponse response) throws AppException {
        String localdir = AppConfig.getProperties("localdir");
        try {
            String url = "/common/download/" + bus_uuid;
            File file = httpRequestUtils.httpDownLoadFile(url, localdir);
            if (file != null) {
                byte[] temp = download(file);
                if (temp != null) {
                    //此行代码是防止中文乱码的关键！！
                    response.setHeader("Content-disposition", "attachment; filename=" +
                            new String(file.getName().getBytes("utf-8"), "iso-8859-1"));
                    BufferedInputStream bis = new BufferedInputStream(new ByteArrayInputStream(temp));
                    BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
                    //新建一个2048字节的缓冲区
                    byte[] buff = new byte[2048];
                    int bytesRead;
                    while ((bytesRead = bis.read(buff, 0, buff.length)) != -1) {
                        bos.write(buff, 0, bytesRead);
                    }
                    bos.flush();
                    bis.close();
                    bos.close();
                    if (file.exists()) {
                        file.delete();
                    }
                } else {
                    throw new AppException("下载错误,文件不存在");
                }
            }
        } catch (Exception e) {
            throw new AppException("下载错误,文件不存在");
        }
    }

    /**
     * 文件下载
     *
     * @param bus_uuid
     * @param response
     * @throws AppException
     */
    @RequestMapping(value = "/downloads/{bus_uuid}")
    public void downloads(@PathVariable String bus_uuid, HttpServletResponse response, HttpServletRequest request) throws AppException {
        PrintWriter out;
        JSONObject json = new JSONObject();
        String urldownloads = request.getSession().getServletContext().getRealPath(""); //路径
        byte[] buffer;
        String localdir = AppConfig.getProperties("localdir");
        String filepath;
        String fileDir;
        String file_rel_path = null;
        try {
            out = response.getWriter();
            String url = "/common/download/" + bus_uuid;
            File file = httpRequestUtils.httpDownLoadFile(url, localdir);
            if (file != null) {
                byte[] temp = download(file);
                InputStream is2 = new ByteArrayInputStream(temp);

                //创建文件路径和创建文件

                /** 构建图片保存的目录 **/
                /** 当前月份 **/

                fileDir = "/webroot/" + DateUtil.dateToString(new Date(), "yyyyMM");
                /** 根据真实路径创建目录 **/
                File fileuploadDir = new File(urldownloads + fileDir);
                if (!fileuploadDir.exists()) {
                    fileuploadDir.mkdirs();
                }
                String originalFilename = file.getName();
                file_rel_path = fileDir + "/" + originalFilename;
                /** 本地保存的最终文件完整路径 **/
                filepath = urldownloads + file_rel_path;
                File files = new File(filepath);
                //如果同名的文件存在
                if (files.exists()) {
                    int indexofdoute = originalFilename.lastIndexOf(".");
                    /**文件名及后缀*/
                    String prefix = originalFilename.substring(0, indexofdoute);
                    String endfix = originalFilename.substring(indexofdoute).toLowerCase();
                    /**新文件名按日期+随机生成*/
                    prefix += DateUtil.dateToString(new Date(), "yyyyMMddHHmmss") + '_' + RandomNumUtil.getRandomString(6);
                    file_rel_path = fileDir + "/" + prefix + endfix;
                    filepath = localdir + file_rel_path;
                    files = new File(filepath);
                }
                OutputStream os = new FileOutputStream(files);
                int bytesRead;
                buffer = new byte[8192];
                while ((bytesRead = is2.read(buffer, 0, 8192)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
                os.close();
                is2.close();

            }
            json.put("message", file_rel_path);
        } catch (Exception e) {
            throw new AppException("下载错误,文件不存在");
        }
        out.write(json.toString());
        out.close();

    }

    /**
     * 下载
     */
    public byte[] download(File file) {
        InputStream data = null;
        try {
            data = new FileInputStream(file);
            int size = data.available();
            byte[] buffer = new byte[size];
            IOUtils.read(data, buffer);
            return buffer;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeQuietly(data);
        }
        return null;
    }
    
    /**
 	 * 跳转至文件上传页面
 	 * @param request
 	 * @return
 	 */
 	@RequestMapping("/toExcelFileUpload")
 	public ModelAndView toExcelFileUpload(HttpServletRequest request,Model modell,SysExcelBatch sExcelBatch) throws Exception {
 		ModelAndView modelAndView=new ModelAndView("common/fileupload/excelfileUpload");
 		modelAndView.addObject("sExcelBatch", sExcelBatch);
 		return modelAndView;
 	}
 	
 	/**
	 * 上传excel并解析文件
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/excelupload")
	public void excelupload(HttpServletRequest request, HttpServletResponse response)  throws IOException{
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		String url="/api/file/uploadExcelFile";
		try {
			SysExcelBatch sysExcelBatch = fileUploadUtils.uploadExcelFile(request,  url);
			json.put("success", "true");
			json.put("bus_uuid", sysExcelBatch.getExcel_batch_number());
		} catch (Exception e) {
			json.put("success", "false");
			json.put("msg", e.getMessage());
		}
		out.write(json.toString());
		out.close();
	}
}
