<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>残疾人信息修改</title>
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content ">
        <form action="${contextpath}/grid/updateAc01Data" >
        <div id="input_content">
	        <!-- 人员选择基本信息开始 -->
	        <div class="ibox ">
	            <div class="ibox-title">
	                <h5>基本信息</h5>
	            </div>
	            <div class="ibox-content">
		            <div class="form-horizontal"  >
				        <div class="form-group">
				           <rc:hidden property="id" value="${disableBasicCard.id}" />
			               <rc:textedit  property="name" value="${disableBasicCard.name}" readonly="true" required="true" label="姓名"  />
			               <rc:textedit  property="identity_card" value="${disableBasicCard.identity_card}" readonly="true"  label="身份证"  />
			               <rc:select property="gender" value="${disableBasicCard.gender}" readonly="true"   label="性别"   codetype="AAC004"  />
			               <rc:textedit property="disable_card_num" value="${disableBasicCard.disable_card_num}" readonly="true"  label="残疾证号"    />
			           </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:select property="disable_type" value="${disableBasicCard.disable_type}" required="true"  label="残疾类型"   codetype="DISABLE_TYPE"  validate="{required:true,messages:{required:'残疾类型不能为空'}}"/>
				           <rc:select property="disable_level" value="${disableBasicCard.disable_level}" required="true"  label="残疾等级"  codetype="DISABLE_LEVEL"  validate="{required:true,messages:{required:'残疾等级不能为空'}}"/>
				           <rc:textedit property="phone" value="${disableBasicCard.phone}"  required="true"  label="联系方式(电话)"    validate="{required:true,messages:{required:'联系方式(电话)不能为空'}}"/>
				           <rc:textedit property="mobile_phone" value="${disableBasicCard.mobile_phone}"   label="联系方式(手机)"    />
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:textedit property="address" cols="1,5" value="${disableBasicCard.address}"  label="现住址"  />
				           <rc:textedit property="permanent_address" cols="1,5" value="${disableBasicCard.permanent_address}"  label="户籍地址"  />
				       </div>
				       <div class="hr-line-dashed"></div>
				       <div class="form-group">
				           <rc:textEditSuggest clearbtn="false" required="true" validate="{required:true,messages:{required:'所属网格不能为空'}}" property="abz182" keytype="SGRID" cols="1,5" value="${disableBasicCard.abz182}"  name_value="${disableBasicCard.abz182_name}"   label="所属网格"   />
				       </div>
			       </div>
		       </div>
	        </div>
	        <!-- 人员基本信息结束 -->
	        <div class="form-group" style="text-align: right;">
	              <a class="btn btn-primary " onclick="update_data()"><i class="fa fa-save"></i>&nbsp;保存</a>
	              <a class="btn btn-danger " onclick="select_closeframe()"><i class="fa fa-remove"></i>&nbsp;关闭</a>
	         </div>
         </div>
        </form>
    </div>
    <rc:jsfooter/>
    <script type="text/javascript">
    $(function() {
    	//验证 ajax
    	rc.validAndAjaxSubmit($("form"),demo_callback);
    })
    
    //保存页面配置信息
	function update_data(){
	   $('form').submit();
	}
    
     //关闭
    function select_closeframe(){
    	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    	parent.layer.close(index); //再执行关闭   
    }
  
    function demo_callback(response){
	   	if(response.success){
          	alert(response.message);
          	parent.param_query();
          	select_closeframe();
	   	}
	   	else{
	   		alert(response.message);
	   	}
    }
    </script>
</body>
</html>