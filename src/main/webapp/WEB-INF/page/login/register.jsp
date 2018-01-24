<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>陕西省人力资源市场管理系统用户注册页面</title>
    <!-- css引入 -->
    <link href="<c:url value='/resource/hplus/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resource/hplus/css/font-awesome.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resource/hplus/css/animate.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resource/hplus/css/style.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/resource/hplus/css/plugins/iCheck/custom.css'/>" rel="stylesheet">
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
</head>
<body class="gray-bg">
<div class="middle-box text-center loginscreen  animated fadeInDown">
    <div>
        <h3>用户注册</h3>
        <form class="m-t" role="form" method="post" action="">
            <input type="hidden" id="publicKeyExponent" name="publicKeyExponent" value="${publicKeyExponent}"/>
	        <input type="hidden" id="publicKeyModulus" name="publicKeyModulus" value="${publicKeyModulus}"/>
            <div class="form-group">
               <input type="text" id="aec101" name="aec101" class="form-control" placeholder="请输入用户名" required=""  onchange="isCheckUsername()">
            </div>
            <div class="form-group">
                <input type="password" id="aec102" name="aec102"  oncopy="" class="form-control" placeholder="请输入密码" onchange="isCheckPwd()" required="">
            </div>
            <div class="form-group">
                <input type="password" id="aec102_1" name="aec102_1"  oncopy="" class="form-control"  placeholder="请再次输入密码" 
                onchange="isCheckConfirmPwd()"  required="">
            </div>
            <div class="form-group">
                <input type="text" id="aab998" name="aab998" class="form-control" placeholder="请输入统一社会信用代码" required="true" 
                onchange="isCheckAab998()" >
            </div>
            <div class="form-group">
                <input type="text" id="aec106" name="aec106" class="form-control" placeholder="请输入电子邮箱" required="true" 
                onchange="isEmail()">
            </div>
            <button  type="button"  class="btn btn-w-m btn-info full-width m-b" onclick="registerInfo()">注 册</button>
            <p class="text-muted text-center">
                <small>已经有账户了？</small>
                <a href="<c:url value='gotologin'/>">点此登录</a>
            </p>
        </form>
    </div>
</div>
    <script src="<c:url value='/resource/hplus/js/jQuery/all/jquery.js'/>"></script>
    <script src="<c:url value='/resource/hplus/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/resource/hplus/js/plugins/iCheck/icheck.min.js'/>"></script>
    <script src="<c:url value='/resource/hplus/js/plugins/layer/layer.min.js"'/>"></script>
    <script src="<c:url value='/resource/hplus/js/rc.all-2.0.js'/>"></script>
    <script src="<c:url value='/resource/hplus/js/RSA.js'/>"></script>
</body>
<script type="text/javascript">
    //验证用户名非空
    function isCheckUsername(){
    	var aec101=$('#aec101').val();
    	var aec101_str= aec101.replace(/\s+/g,"");
    	if(!aec101_str){
    		layer.msg('用户名不能为空');
    		$('#aec101').focus();
    		return ;
    	}else {
    		//查询用户表，验证用户名是否已存在
    		var url = "<c:url value='/resources/SXJY_RLZYSC_009_001/getUserInfoByAec101'/>/"+aec101;
     		var param = $('input_content').serializeObject();
     		$.ajax({
                type : "post",
                url : url,
                dataType : "json",
                data: param,  //传入组装的参数
                success:function(response,textStatus){
                	if(response.success){
                		//如果用户名合法，继续输入密码
                		$('#aec102').focus();
                	}else{
                		layer.msg(response.message);
                	    $('#aec101').val('');
                	    $('#aec101').focus();
                	}
                },
                error : function(response) {
                	layer.alert(response.message);
                }
            });
    	}
    }
    //验证第一次输入密码
    function isCheckPwd(){
    	var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{6,16}$/;
      	var aec102=$('#aec102').val();
    	if(!aec102){
    		layer.msg('密码不能为空');
    		$('#aec102').focus();
    		return ;
    	} 
    	var password = reg.test(aec102);
    	if(password == false){
    		layer.msg("密码必须由6-16数字和字母组成");
    		$('#aec102').val("");
    		$('#aec102').focus();
    		return ;
    	}else{
    		$('#aec102_1').focus();
    	}
        
    }
    //验证确认密码
    function isCheckConfirmPwd(){
    	var aec102=$('#aec102').val();
      	var aec102_1=$('#aec102_1').val();
    	if(!aec102_1){
    		layer.msg('请再次输入密码');
    		$('#aec102_1').focus();
    		return ;
    	}
    	if(aec102&&aec102_1){
    		if(aec102_1!=aec102){
        		layer.msg('两次输入密码不一致,请重新输入');
        		$('#aec102_1').val("");
        		$('#aec102_1').focus();
        		return ;
        	}
    	}
    }
  //验证统一社会信用代码
    function isCheckAab998(){
    	var aab998=$('#aab998').val();
    	if(!aab998){
    		layer.msg('统一社会信用代码不能为空');
    		$('#aab998').focus();
    		return ;
    	} else {
    		var rule =/^(?![0-9]+$)(?![A-Z]+$)[0-9A-Z]{18}$/;
    		if(!rule.test(aab998))
	        {
    			layer.msg('统一社会信用代码必须为18位数字字母组合,字母须为大写');
    			$('#aab998').focus();
	             return ;
	        }
    		//查询统一社会信用代码是否已存在
    		var url = "<c:url value='/resources/SXJY_RLZYSC_009_001/getUserInfoByAab998'/>/"+aab998;
     		var param = $('input_content').serializeObject();
     		$.ajax({
                type : "post",
                url : url,
                dataType : "json",
                data: param,  //传入组装的参数
                success:function(response,textStatus){
                	if(response.success){
                	}else{
                		layer.msg(response.message);
                	    $('#aab998').val('');
                	    $('#aab998').focus();
                	}
                },
                error : function(response) {
                	layer.alert(response.message);
                }
            });
    	}
    }
    function isEmail(){
    	var rule= /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;
    	var aec106=$('#aec106').val();
    	if(!aec106){
    		layer.msg('电子邮箱地址不能为空');
    		$('#aec106').focus();
    		return ;
    	} else {
    		if(!rule.test(aec106))
	        {
    			layer.msg('请输入正确格式的电子邮箱\n 如:name@163.com');
    			$('#aec106').focus();
	             return ;
	        }
    	}
    }
    //保存页面配置信息
	function registerInfo(){
		var aec101=$('#aec101').val();
    	var aec101_str= aec101.replace(/\s+/g,"");
    	if(!aec101_str){
    		layer.msg('用户名不能为空');
    		$('#aec101').focus();
    		return ;
    	}
      	var aec102=$('#aec102').val();
      	var aec102_1=$('#aec102_1').val();
    	if(!aec102){
    		layer.msg('密码不能为空');
    		$('#aec102').focus();
    		return ;
    	} 
    	var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{6,16}$/;
    	var password = reg.test(aec102);
    	var newPassword = reg.test(aec102_1);
    	if(password == false || newPassword == false ){
    		layer.msg("密码必须由6-16数字和字母组成");
    		return ;
    	}
    	if(!aec102_1){
    		layer.msg('请再次输入密码');
    		$('#aec102_1').focus();
    		return ;
    	}
        if(aec102&&aec102_1){
    		if(aec102_1!=aec102){
        		layer.msg('两次输入密码不一致,请重新输入');
        		$('#aec102_1').focus();
        		return ;
        	}
    	}
        var aab998=$('#aab998').val();
    	if(!aab998){
    		layer.msg('统一社会信用代码不能为空');
    		$('#aab998').focus();
    		return ;
    	} else{
    		var rule =/^(?![0-9]+$)(?![A-Z]+$)[0-9A-Z]{18}$/;
    		if(!rule.test(aab998))
	        {
    			layer.msg('统一社会信用代码必须为18位数字字母组合,字母须为大写');
    			$('#aab998').focus();
	             return ;
	        }
    	}
    	
    	var aec106=$('#aec106').val();
    	if(!aec106){
    		layer.msg('电子邮箱地址不能为空');
    		$('#aec106').focus();
    		return ;
    	} else {
    		var rule= /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;
    		if(!rule.test(aec106))
	        {
    			layer.msg('请输入正确格式的电子邮箱\n 如:name@163.com');
    			$('#aec106').focus();
	             return ;
	        }
    	}
	    var param = $('form').serializeObject();
	    $.ajax({
            type : "post",
            url : "<c:url value='/resources/SXJY_RLZYSC_009_001/registerData'/>",
            dataType : "json",
            data: param,  //传入组装的参数
            success:function(response,textStatus){
            	layer.msg(response.message);
            	if(response.success){
            		setTimeout("window.location.href='/sxrlzy/'",5000);
            	}else{
            	    $('#aec101').val('');
            	    $('#aec102').val('');
            	    $('#aec102_1').val('');
            	    $('#aab998').val('');
            	}
            },
            error : function(response) {
            	layer.alert(response.message);
                $('#aec101').val('');
        	    $('#aec102').val('');
        	    $('#aec102_1').val('');
        	    $('#aab998').val('');
            }
        });
	}
    </script>
</html>