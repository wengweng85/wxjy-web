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
    <title>demo测试查询页面</title>
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
                        <rc:textEditSuggest label="个人编号" property="aac001" keytype="AC01"/>
			            <rc:textedit property="aac003"  type="number" max="10" min="5"  maxlength="2" label="姓名" />
			            <rc:select property="aac004" label="性别"  codetype="AAC004" multiple="true" filter="aaa102 in ('1','2') "/>
			            <rc:select property="aac011" label="学历"  codetype="AAC011" multiple="true" />
			       </div>
			       <div class="hr-line-dashed"></div>
			       <div class="form-group">
			            <rc:date property="aac006_begin" label="出生日期(开始)" />
			            <rc:date property="aac006_end" label="出生日期(结束)" />
			            <rc:textedit property="aae009" label="经办机构" />
			            <div class="col-sm-3" align="right">
			                 <a class="btn btn-info" onclick="demo_query()"><i class="fa fa-search"></i>&nbsp;查询</a>
			                 <a class="btn btn-info" onclick="rc.clean($('query_form'))"><i class="fa fa-refresh"></i>&nbsp;重置</a>
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
            <script id="tpl" type="text/x-handlebars-template" >
                <a class="link" onclick="demo_view_by_id('{{aac001}}')"><i class="fa fa-file-o"></i>&nbsp;查看</a> 
                <a class="link" onclick="demo_edit_by_id('{{aac001}}')"><i class="fa fa-edit"></i>&nbsp;编辑</a> 
                <a class="link" onclick="demo_delete_by_id('{{aac001}}')" ><i class="fa fa-remove"></i>&nbsp;删除</a> 
                <a class="link" onclick="rc.open_file_list_upload_page('{{aac001}}','/demo/uploadFile')" ><i class="fa fa-upload"></i>&nbsp;打开文件上传页面</a>
                <a class="link" onclick="rc.open_file_upload_page('{{aac001}}','/demo/uploadFile','file_upload_callback')" ><i class="fa fa-upload"></i>&nbsp;直接上传</a>
            </script>
            
            <script id="tplfile" type="text/x-handlebars-template" >
               {{#if bus_uuid}}
                 <a class="link" onclick="rc.download_file_by_id('{{bus_uuid}}')"><i class="fa fa-download"></i>&nbsp;下载</a> 
                 <a class="link" onclick="delete_file_by_id('{{aac001}}','{{bus_uuid}}')" ><i class="fa fa-remove"></i>&nbsp;删除</a>  
               {{/if}}
            </script>
            <!-- toolbar -->
            <div id="toolbar" class="btn-group">
				 <button id="btn_delete" type="button" class="btn btn-info" onclick="demo_add()">
				    <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>新增
				 </button>
				 <button id="btn_delete" type="button" class="btn btn-danger" onclick="demo_bat_delete('aac001')">
				    <span class="glyphicon glyphicon-remove" aria-hidden="false"></span>批量删除
				 </button>
			</div>
			
            <div class="ibox-content">
            </div>
            
            <!-- tab -->
            <div class="ibox-content">
	            <ul id="myTab" class="nav nav-tabs">
			    <li class="active">
			        <a href="#home" data-toggle="tab">
			                                  菜鸟教程
			        </a>
			    </li>
			    <li><a href="#ios" data-toggle="tab">iOS</a></li>
			    <li class="dropdown">
			        <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Java
			            <b class="caret"></b>
			        </a>
			        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
			            <li><a href="#jmeter" tabindex="-1" data-toggle="tab">jmeter</a></li>
			            <li><a href="#ejb" tabindex="-1" data-toggle="tab">ejb</a></li>
			        </ul>
			    </li>
			</ul>
			<div id="myTabContent" class="tab-content">
			    <div class="tab-pane fade in active" id="home">
			        <table id="ac01table" data-url="<c:url value='/demo/getAc01List'/>" 
			          data-click-to-select="false"
                      data-toolbar="#toolbar"
                      data-show-export="true"
                      data-pagination="true"
                      data-uniqueId="1"
                      data-page-size="10"
                      data-filter-control="false"
                >
			    <thead>
				    <tr>
				        <th data-checkbox="true" ></th>
				        <th data-formatter="demo_indexFormatter">序号</th>
				        <th data-formatter="demo_rowFormatter" data-field="aac001">行操作</th>
	                    <th data-field="aac002" >身份证号码</th>
	                    <th data-field="aac003" >姓名</th>
	                    <th data-field="aac004" >性别</th>
	                    <th data-field="aac006" >出生日期</th>
	                    <th data-field="aac033" >健康状况</th>
	                    <th data-field="aac017" >婚姻状况</th>
	                    <th data-field="aac024" >政治面貌</th>
	                    <th data-field="aac011" >学历</th>
	                    <th data-field="aae010" >经办人</th>
	                    <th data-field="aac007_name" >弹出框数据测试</th>
	                    <th data-field="bus_uuid" data-formatter="demo_bus_uuidFormatter">文件</th>
	                    <th data-formatter="demo_jobnameFormatter">操作</th>
				    </tr>
			    </thead>
			    </table>
			    </div>
			    <div class="tab-pane fade" id="ios">
			        <p>iOS 是一个由苹果公司开发和发布的手机操作系统。最初是于 2007 年首次发布 iPhone、iPod Touch 和 Apple
			            TV。iOS 派生自 OS X，它们共享 Darwin 基础。OS X 操作系统是用在苹果电脑上，iOS 是苹果的移动版本。</p>
			    </div>
			    <div class="tab-pane fade" id="jmeter">
			        <p>jMeter 是一款开源的测试软件。它是 100% 纯 Java 应用程序，用于负载和性能测试。</p>
			    </div>
			    <div class="tab-pane fade" id="ejb">
			        <p>Enterprise Java Beans（EJB）是一个创建高度可扩展性和强大企业级应用程序的开发架构，部署在兼容应用程序服务器（比如 JBOSS、Web Logic 等）的 J2EE 上。
			        </p>
			    </div>
			</div>
            </div>
        </div>
       <!-- 查询结果结束 -->
    </div>
    <!-- javascript引入 -->
    <rc:jsfooter/>
    <script type="text/javascript">
    $(function(){
    	//$('.collapse-link').click();
    	$('#ac01table').inittable(demo_options);
    	
    	//tab切换事件
    	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            // 获取已激活的标签页的名称
            var activeTab = $(e.target).text();
            // 获取前一个激活的标签页的名称
            var previousTab = $(e.relatedTarget).text();
            console.log("当前选中"+activeTab.trim());
            console.log("上一个选中"+previousTab.trim());
        });
    });
    
    var $table=$('#ac01table');
    
    var demo_options={
    	formid:'query_form',
    	editable_url:contextPath+'/demo/updateDataByXedit'
    }
    
    //用户表格监听,双击 
    $('#ac01table').on('dbl-click-row.bs.table', function (e, row, $element) {
    	demo_view_by_id(row.aac001)
    });  
    
    //tabview
    function tab_view(){
    	var selections=$('#ac01table').getAllTableSelections();
    	console.log(selections);
   	    //选中的值
   	    if(selections.length>0){
   	    	if(selections.length>1){
   	    		layer.alert('只能选择一条数据');
   	    		return false;
   	    	}else{
   	    		$('#btn_tab_view').attr('href',contextPath+"/demo/toview/"+selections[0].aac001);
   	    		$('#btn_tab_view').text(selections[0].aac003+'个人基本信息');
   	    		return true;
   	    	}
	   	}else{
	   	   layer.alert('请选择要查看的数据');
	   	   return false;
	   	}
    }
    //操作编辑
    function demo_jobnameFormatter(value, row, index) {
        var tpl = $("#tpl").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    function demo_bus_uuidFormatter(value, row, index) {
    	var tpl = $("#tplfile").html();  
	  	//预编译模板  
	  	var template = Handlebars.compile(tpl);  
	  	return template(row);
    }
    
    function demo_indexFormatter(value, row, index) {
        return index+1;
    }
   
    //行操作 
    function demo_rowFormatter(value, row, index){
       return [
               "<a class=\"like\" href='javascript:addRow(" + index + ", " + JSON.stringify(row) + ")' title=\"新增行\">",
               '<i class="glyphicon glyphicon-plus"></i>',
               '</a>  ',
               '<a class="remove" href="javascript:removeRow(\''+row.aac001+'\')" title="删除行">',
               '<i class="glyphicon glyphicon-remove"></i>',
               '</a>'
           ].join('');
    }
    
    //增加一行
    function addRow(insertIndex, rowObj){
        var insertRow = rowObj;
        $.each(insertRow, function(name, value){
            insertRow[name] = '';
        });

        var params = {index:insertIndex + 1, row:insertRow};
        $('#ac01table').bootstrapTable('insertRow', params);
    }
    
    
    //删除一行
    function removeRow(value){
    	alert(value);
    	var a=[];
    	a.push(value);
        $table.bootstrapTable('remove', {
            field: 'aac001',
            values: a
        });
    }
    
    //查询
    function demo_query(){
    	$('#ac01table').refreshtable();
    	//$('.collapse-link').click();
    }
    
    //show
    function show(message){
    	layer.msg(message);
    }
    
    //删除数据
    function demo_delete_by_id(aac001){
   	  if(aac001){
   		layer.confirm('确定删除要此用户数据吗？', function(index){
   			var url= "<c:url value='/demo/deletebyid/'/>"+aac001;
   			rc.ajax(url, null,function (response) {
   				layer.closeAll('dialog');
   				if(response.success){
   					//console.log('layer'+layer.msg+" "+response.message);
   					show(response.message);
                    $('#ac01table').refreshtable();
   				}else{
   					console.log('layer'+layer);
   					//layer.msg(response.message);
   				}
   			});
   		});
   	  }else{
   		layer.alert('请先选择你要删除的数据');
   	  }
    }
    
    //编辑
    function demo_add(){
    	 index=layer.open({
	   		  type: 2,
	   		  title: '新增页面',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['80%', '90%'],
	   		  content: "<c:url value='/demo/toadd'/>" //iframe的url
 		});
    	 layer.full(index);
    }
    
    //编辑
    function demo_edit_by_id(aac001){
    	layer.open({
	   		  type: 2,
	   		  title: '编辑页面',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['80%', '90%'],
	   		  content: "<c:url value='/demo/toedit'/>/"+aac001 //iframe的url
 		});
    }
    
    //查看
    function demo_view_by_id(aac001){
    	layer.open({
	   		  type: 2,
	   		  title: '查看页面',
	   		  shadeClose: false,
	   		  maxmin:true,
	   		  shade: 0.8,
	   		  area: ['40%', '90%'],
	   		  content: "<c:url value='/demo/toview'/>/"+aac001 //iframe的url
 		});
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
  	   		   rc.ajax("<c:url value='/demo/batdelete'/>", {selectnodes:selectnodes},function (response) {
  	   		    	layer.alert(response.message);
  	   		    	//$('#ac01table').refreshtable();
  	   		   }); 
  	    	});
   	    }else{
   		    layer.alert('请先选择你要删除的数据');
   	    }
    }
    
  
    
    //文件上传回调函数-更新ac01表bus_uuid
    function file_upload_callback(aac001,bus_uuid){
  	  if(aac001&&bus_uuid){
 		  var url= "<c:url value='/demo/updatefile/'/>"+aac001+"/"+bus_uuid;
 		  rc.ajax(url, null,function (response) {
 			if(response.success){
 				$('#ac01table').refreshtable();
 			}else{
 				alert(response.message);
 			}
 		  });
   	  }else{
   		layer.alert('请先选择你要删除的数据');
   	  }
    }

    
    //删除数据,更新表中的上传文件id为空,删除主键为bus_uuid的记录
    function delete_file_by_id(aac001,bus_uuid){
   	  if(aac001&&bus_uuid){
   		layer.confirm('确定删除此文件吗？', function(index){
   			var url= "<c:url value='/demo/deletefile/'/>"+aac001+"/"+bus_uuid;
   			rc.ajax(url, null,function (response) {
   				if(response.success){
   					$('#ac01table').refreshtable()
   				}else{
   					alert(response.message);
   				}
   			});
   		});
   	  }else{
   		layer.alert('请先选择你要删除的数据');
   	  }
    }
    </script>
</body>
</html>