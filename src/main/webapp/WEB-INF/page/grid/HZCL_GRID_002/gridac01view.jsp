<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>残疾人信息查看</title>
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content ">
         <table class="table table-bordered table-striped xedittable ">
            <tr>
                 <td><strong>姓名</strong></td><td>${disableBasicCard.name}</td>
                 <td rowspan="6" width="150">
                    <img width="150" height="200" src="<c:url value='/resource/pic/'/>${disableBasicCard.photoname}" />
                 </td>
            </tr>
            <tr>
                 <td><strong>残疾证号</strong></td><td>${disableBasicCard.disable_card_num}</td>
            </tr>
            <tr>
                 <td><strong>性别</strong></td><td>${disableBasicCard.gender}</td>
            </tr>
            <tr>
                 <td><strong>身份证</strong></td><td>${disableBasicCard.identity_card}</td>
            </tr>
            <tr>
                 <td><strong>残疾类型</strong></td><td>${disableBasicCard.disable_type}</td>
           </tr>
            <tr>
                 <td><strong>残疾等级</strong></td><td >${disableBasicCard.disable_level}</td>
            </tr>
            <tr>
                 <td><strong>电话</strong></td><td colspan="3">${disableBasicCard.phone}</td>
                 </tr>
            <tr>
                 <td><strong>手机</strong></td><td colspan="3">${disableBasicCard.mobile_phone} </td>
            </tr>
            <tr>
                 <td><strong>现住址</strong></td><td colspan="3">${disableBasicCard.address}</td>
            </tr>
            <tr>
                 <td><strong>户籍地址</strong></td><td colspan="3">${disableBasicCard.permanent_address}</td>
            </tr>
            <tr>
                 <td><strong>所属网格</strong></td><td colspan="3">${disableBasicCard.abz182_name}</td>
            </tr>
            <tr>
                 <td><strong>籍贯</strong></td><td colspan="3">${disableBasicCard.native_place} </td>
            </tr>
            
          
        </table>
        <!--  
        <div class="form-group" style="text-align: right;">
            <a class="btn btn-danger " onclick="select_closeframe()"><i class="fa fa-remove"></i>&nbsp;关闭</a>
        </div>
        -->
    </div>
    <rc:jsfooter/>
    <script type="text/javascript">
     //关闭
    function select_closeframe(){
       var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
       parent.layer.close(index); //再执行关闭   
    }
    </script>
</body>
</html>