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
    <title>404</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="<%=staticPath%>/resource/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/animate.min.css" rel="stylesheet">
    <link href="<%=staticPath%>/resource/hplus/css/style.min.css" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1>404</h1>
        <h3 class="font-bold">页面未找到！</h3>
        <div class="error-desc">
                               抱歉，页面好像去火星了~
        </div>
    </div>
    <script src="<%=staticPath%>/resource/hplus/js/jquery.min.js"></script>
    <script src="<%=staticPath%>/resource/hplus/js/bootstrap.min.js"></script>
</body>

</html>

