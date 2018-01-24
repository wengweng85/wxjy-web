<%@ page language="java" contentType="text/html; charset=gbk"  pageEncoding="gbk"%>
<%@taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
  String path = request.getContextPath();
  String staticPath = com.insigma.common.listener.AppConfig.getProperties("website_static_resource_url");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>未授权</title>
    <link href="<%=staticPath%>/resource/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/animate.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/style.min.css" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h2>未授权</h2>

        <div class="error-desc">
            你没有相关访问权限...
            <!-- 
            <br/>您可以返回主页看看
            <br/><a href="<%=staticPath%>/" class="btn btn-primary m-t">主页</a>
            -->
        </div>
    </div>
    <script src="<%=staticPath%>/resource/hplus/js/jquery.min.js"></script>
    <script src="<%=staticPath%>/resource/hplus/js/bootstrap.min.js"></script>
</body>
</html>

