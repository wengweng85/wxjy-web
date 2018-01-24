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
    <title>网格员维护</title>
    <!-- css引入 -->
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    <!-- 隐藏区域 -->
    <rc:hidden property="abz182" value="${abz182}"/>
    <!-- 未选中的 -->
    <div class="col-sm-6">
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
	            <form class="form-horizontal" id="query_form1" >
			       <div class="form-group">
			           <rc:textedit cols="2,2" property="name" label="姓名" />
			           <rc:textedit cols="2,2" property="disable_num" label="残疾证号" />
			           <div class="col-sm-4" align="right">
		                  <a class="btn btn-info" onclick="query1()"><i class="fa fa-search"></i>&nbsp;查询</a>
		                  <a class="btn btn-danger" onclick="rc.clean($('query_form1'))"><i class="fa fa-refresh"></i>&nbsp;重置</a>
		               </div>
			       </div>
		        </form>
            </div>
        </div>
        <!-- 查询条件结束 -->
        <!-- 查询结果开始 -->    
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>待选择网格人员 双击查看人员明细</h5>
                <div class="ibox-tools">
                </div>
            </div>    
            </div>
            <div class="ibox-content">
			    <table id="nochoosetable" data-url="<c:url value='/grid/getAc01ListNotInGridid'/>?abz182=${abz182}" 
			          data-click-to-select="false"
                      data-toolbar="#toolbar"
                      data-show-export="true"
                      data-uniqueId="1"
                      data-page-size="50" >
			    <thead>
			        <tr>
				        <th data-formatter="sys_user_role_indexFormatter">序号</th>
	                    <th data-field="name">姓名</th>
	                    <th data-field="disable_card_num" data-formatter="text_next_row_indexFormatter">残疾证号码</th>
	                    <th data-field="disable_type">残疾类型</th>
	                    <!--  
	                    <th data-field="disable_level">残疾等级</th>
	                    -->
	                    <th data-field="address" data-formatter="text_next_row_indexFormatter">地址</th>
	                    <th data-formatter="add_rowFormatter">新增</th>
				    </tr>
				   
			    </thead>
			    </table>
            </div>
        </div>
        
        <!-- 选中的 -->
        <div class="col-sm-6">
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
	            <form class="form-horizontal" id="query_form1" >
			       <div class="form-group">
			           <rc:textedit cols="2,2" property="name2" label="姓名" />
			           <rc:textedit cols="2,2" property="disable_num2" label="残疾证号" />
			           <div class="col-sm-4" align="right">
		                  <a class="btn btn-info" onclick="query2()"><i class="fa fa-search"></i>&nbsp;查询</a>
		                  <a class="btn btn-danger" onclick="rc.clean($('query_form2'))"><i class="fa fa-refresh"></i>&nbsp;重置</a>
		               </div>
			       </div>
		        </form>
	        </div>
        </div>
        <!-- 查询条件结束 -->
        
        <!-- 查询结果开始 -->    
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 style="color:blue;"><i class="fa fa-check"></i>已选择网格人员 双击查看人员明细</h5>
                <div class="ibox-tools">
                    <a class="btn btn-primary btn-xs"  onclick="save()"><i class="fa fa-save"></i>&nbsp;保存</a>
                </div>
            </div>   
            
            <div class="ibox-content">
			    <table id="choosetable" data-url="<c:url value='/grid/getAc01ListByGridid'/>?abz182=${abz182}"
			          data-click-to-select="false"
                      data-toolbar="#toolbar"
                      data-show-export="true"
                      data-uniqueId="1"
                      data-pagination="true"
                      data-page-size="50" >
			    <thead>
				   <tr>
	                    <th data-formatter="remove_rowFormatter">删除</th>
				        <th data-formatter="sys_user_role_indexFormatter">序号</th>
	                    <th data-field="name">姓名</th>
	                    <th data-field="disable_card_num" data-formatter="text_next_row_indexFormatter">残疾证号码</th>
	                    <th data-field="disable_type">残疾类型</th>
	                    <!-- 
	                     <th data-field="disable_level">残疾等级</th>
	                    -->
	                    <th data-field="address" data-formatter="text_next_row_indexFormatter">地址</th>
				    </tr>
			    </thead>
			    </table>
            </div>
        </div>
        </div>
       <!-- 查询结果结束 -->
    </div>
    <!-- javascript引入 -->
    <rc:jsfooter/>
    <script type="text/javascript">
    var query_1_form_options={
    	formid:'query_form'
    }
    var query_2_form_options={
       	formid:'query_form2'
    }
    //初始化
    $(function(){
    	//$('.collapse-link').click();
    	$('#nochoosetable').inittable(query_1_form_options);
    	$('#choosetable').inittable(query_2_form_options);
    });
    
    //用户表格监听,双击 
    $('#nochoosetable').on('dbl-click-row.bs.table', function (e, row, $element) {
    	view_by_id(row.id,row.name)
    }); 
  
    //用户表格监听,双击 
    $('#choosetable').on('dbl-click-row.bs.table', function (e, row, $element) {
    	view_by_id(row.id,row.name)
    }); 
    
  //查看
    function view_by_id(id,name){
    	layer.open({
       		  type: 2,
       		  title: name+'信息查看',
       		  shadeClose: true,
       		  maxmin:true,
       		  area: ['60%', '90%'],
       		  content: "<c:url value='/grid/toview'/>/"+id //iframe的url
    		});
    }
  
    function sys_user_role_indexFormatter(value, row, index) {
        return index+1;
    }
    
    //查询1
    function query1(){
    	$('#nochoosetable').refreshtable();
    }
    
    //查询2
    function query2(){
    	$('#choosetable').refreshtable();
    }
    
    function text_next_row_indexFormatter(value, row, index){
    	if(value){
    		return "<span style='word-wrap:break-word;word-break:break-all;'>"+value+"</span>"
    	}
    }
    
    //行操作 增加左边到右边
    function add_rowFormatter(value, row, index){
       return [
            "<a class=\"like\" href='javascript:lefttoright(" + index + ", " + JSON.stringify(row) + ")' title=\"新增\">",
            '<i class="glyphicon glyphicon-plus"></i>',
            '</a>  ',
       ].join('');
    }
    
    //行操作 删除右边到右边
    function remove_rowFormatter(value, row, index){
       return [
            "<a class=\"like\" href='javascript:righttoleft(" + index + ", " + JSON.stringify(row) + ")' title=\"删除\">",
            '<i class="glyphicon glyphicon-minus"></i>',
            '</a>'
       ].join('');
    }
    
    //左边到右边
    function lefttoright(insertIndex, rowObj){
        var insertRow = rowObj;
        $.each(insertRow, function(name, value){
            insertRow[name] = value;
        });
        var params = {index:0, row:insertRow};
        $('#choosetable').bootstrapTable('insertRow', params);
    	
        var a=[];
    	a.push(rowObj['id']);
        $('#nochoosetable').bootstrapTable('remove', {
            field: 'id',
            values: a
        });
    }
    
    //右边到左边
    function righttoleft(insertIndex, rowObj){
    	var insertRow = rowObj;
        $.each(insertRow, function(name, value){
            insertRow[name] = value;
        });
        var params = {index:0, row:insertRow};
        $('#nochoosetable').bootstrapTable('insertRow', params);
    	
        var a=[];
    	a.push(rowObj['id']);
        $('#choosetable').bootstrapTable('remove', {
            field: 'id',
            values: a
        });  
    }
    
    
    function save(){
    	var abz182=$('#abz182').val();
   		var alldata=$('#choosetable').getData();
   		console.log(alldata)
   	    //选中的值
   	    var selectnodes='';
   	    for(i=0;i<alldata.length;i++){
 	     	var item=alldata[i];
 	        selectnodes+=item['id']+',';
 	    }
 		rc.ajax("<c:url value='/grid/updateac01info'/>", {selectnodes:selectnodes,abz182:abz182},function (response) {
 		    layer.alert(response.message);
 		}); 
    }
    </script>
</body>
</html>