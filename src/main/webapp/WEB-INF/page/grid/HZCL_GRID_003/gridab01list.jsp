<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <title>单位信息管理</title>
    <!-- css引入 -->
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
         <!-- 查询条件开始 -->
         <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>查询条件</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
	            <form class="form-horizontal" id="query_form" >
			       <div class="form-group">
			           <rc:textedit property="aab004" label="单位名称" />
			           <div class="col-sm-3" align="right">
		                  <a class="btn btn-info" onclick="param_query()"><i class="fa fa-search"></i>&nbsp;查询</a>
		                  <a class="btn btn-info" onclick="rc.clean($('query_form'))"><i class="fa fa-refresh"></i>&nbsp;重置</a>
		                  <a class="btn btn-info" onclick="demo_add()"><i class="fa fa-plus"></i>&nbsp;新增</a>
		               </div>
			       </div>
		       </form>
	       </div>
        </div>
        <!-- 查询条件结束 -->
        <!-- 查询结果开始 -->    
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>查询结果列表</h5>
                <div class="ibox-tools">
                </div>
            </div>
            <!-- 模型 -->
            <!-- 模型 -->
            <script id="tpl" type="text/x-handlebars-template" >
                <a class="link" onclick="demo_view_by_id('{{aab001}}')"><i class="fa fa-file-o"></i>&nbsp;查看</a> 
                <a class="link" onclick="demo_edit_by_id('{{aab001}}')"><i class="fa fa-edit"></i>&nbsp;编辑</a> 
                <a class="link" onclick="demo_delete_by_id('{{aab001}}')" ><i class="fa fa-remove"></i>&nbsp;删除</a> 
            </script>
            
            <!-- toolbar -->
            <div id="toolbar" class="btn-group">
				 <button id="btn_delete" type="button" class="btn btn-danger" onclick="demo_bat_delete('aac001')">
				 <span class="glyphicon glyphicon-remove" aria-hidden="false"></span>批量删除
				 </button>
			</div>
            <div class="ibox-content">
				   <table id="ac01table" data-url="<c:url value='/grid/getAb01List'/>" 
				          data-click-to-select="false"
	                      data-toolbar="#toolbar"
	                      data-show-export="true"
	                      data-pagination="true"
	                      data-uniqueId="1"
	                      data-page-size="15" >
				   <thead>
				   <tr>
				        <th data-formatter="sys_user_role_indexFormatter">序号</th>
	                    <th data-field="aab004">单位名称</th>
	                    <th data-field="aae006">单位地址</th>
	                    <th data-formatter="dataFormatter">操作</th>
				    </tr>
			    </thead>
			    </table>
            </div>
        </div>
       <!-- 查询结果结束 -->
    </div>
    <!-- javascript引入 -->
    <rc:jsfooter/>
    <script type="text/javascript">
    var $table=$('#ac01table');
    
    var demo_options={
    	formid:'query_form'
    }
    //初始化
    $(function(){
    	$('#ac01table').inittable(demo_options);
    });
  
    
    //用户表格监听,双击 
    $('#ac01table').on('dbl-click-row.bs.table', function (e, row, $element) {
    	demo_view_by_id(row.aac001)
    });  
    
    //操作编辑
    function demo_jobnameFormatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    function demo_indexFormatter(value, row, index) {
        return index+1;
    }
   
    //操作编辑
    function dataFormatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    //查询
    function param_query(){
    	$('#ac01table').refreshtable();
    	//$('.collapse-link').click();
    }
    
    function sys_user_role_indexFormatter(value, row, index) {
        return index+1;
    }

    function text_next_row_indexFormatter(value, row, index){
    	return "<span style='word-wrap:break-word;word-break:break-all;'>"+value+"</span>"
    }
    
    //删除数据
    function demo_delete_by_id(aac001){
   	  if(aac001){
   		layer.confirm('确定删除此残疾用户数据吗？', function(index){
   			var url= "<c:url value='/demo/deletebyid/'/>"+aac001;
   			/* rc.ajax(url, null,function (response) {
   				layer.closeAll('dialog');
   				if(response.success){
   					//console.log('layer'+layer.msg+" "+response.message);
   					layer.msg(response.message);
                    $('#ac01table').refreshtable();
   				}else{
   					console.log('layer'+layer);
   					//layer.msg(response.message);
   				}
   			}); */
   		});
   	  }else{
   		layer.alert('请先选择你要删除的数据');
   	  }
    }
   
    
    
    //批量删除
    function demo_bat_delete(idname){
   		var selections=$('#ac01table').getAllTableSelections();
   	    //选中的值
   	    var selectnodes='';
   	    if(selections.length>0){
   	    	layer.confirm('确定批量删除这些数据吗？', function(index){
   	    	   for(i=0;i<selections.length;i++){
   	   	     	   var item=selections[i];
   	   	     	   selectnodes+=item[idname]+',';
   	   	       }
   	   		  /*  rc.ajax("<c:url value='/demo/batdelete'/>", {selectnodes:selectnodes},function (response) {
   	   		    	layer.alert(response.message);
   	   		    	//$('#ac01table').refreshtable();
   	   		   });  */
   	    	});
    	  }else{
    		layer.alert('请先选择你要删除的数据');
    	  }
    }
    </script>
</body>
</html>