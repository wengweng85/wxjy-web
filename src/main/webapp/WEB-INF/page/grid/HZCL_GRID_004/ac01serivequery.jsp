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
    <title>服务状态查询</title>
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
            <script id="tpl" type="text/x-handlebars-template" >
                           {{#equals status '已受理' }}
                              <div class="progress progress-striped active " style="margin-bottom:0px;">			                
                                 <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 30%;">
已受理	                             
</div>
                              </div>
			              {{/equals}} 
                          {{#equals status '审核中' }}
                              <div class="progress progress-striped active " style="margin-bottom:0px;">			                
                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 50%;">
审核中	                          
</div>
                              </div>
			              {{/equals}} 
			              {{#equals status '复核中'}}
                           <div class="progress progress-striped active " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">
复核中	                          
</div>
                              </div>
			              {{/equals}}
                          {{#equals status '审批通过'}}
                           <div class="progress progress-striped active " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
审批通过	                          
</div>
                           </div>
			              {{/equals}}
                          
            </script>
            <div class="ibox-content">
	            <form class="form-horizontal" id="query_form" >
			       <div class="form-group">
			           <rc:textedit property="name" label="姓名" />
			           <rc:textedit property="type" label="业务类型" />
			           <rc:textedit property="status" label="当前状态" />
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
                <h5>信息列表</h5>
                <div class="ibox-tools">
                </div>
            </div>
            <!-- 模型 -->
            <div class="ibox-content">
			    <table id="ac01table" data-url="<c:url value='/grid/servicelist'/>" 
			          data-click-to-select="false"
                      data-show-export="true"
                      data-pagination="true"
                      data-uniqueId="1"
                      data-page-size="25" >
			    <thead>
			    <tr>
			        <th data-formatter="sys_user_role_indexFormatter">序号</th>
                    <th data-field="name">姓名</th>
                    <th data-field="area" >所属地区</th>
                    <th data-field="type" >业务类型</th>
                    <th data-field="begintime">开始时间</th>
                    <th data-field="status" data-formatter="statusFormatter">当前状态</th>
                    <th data-field="opuser" >处理人员</th>
                    <th data-field="optime" >处理时间</th>
                    <th data-field="oporg">受理机构</th>
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
    	view_by_id(row.id,row.name,row.abz182)
    });
    
    //操作编辑
    function statusFormatter(value, row, index) {
    	console.log(row);
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
    	if(value!='undefined'){
    		return "<span style='word-wrap:break-word;word-break:break-all;'>"+value+"</span>"
    	}
    }
     //查看
    function dtgx(id){
    	var index=layer.open({
      		  type: 2,
      		  title: '动态更新',
      		  shadeClose: true,
      		  maxmin:true,
      		  area: ['650px', '90%'],
      		  content: "<c:url value='/resource/dtfx.html'/>" //iframe的url
   		});
    	layer.full(index);
    }
    
    </script>
</body>
</html>