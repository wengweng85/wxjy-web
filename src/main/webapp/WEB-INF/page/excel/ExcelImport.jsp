<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>excel数据导入测试</title>
<!-- css头文件  -->
<rc:csshead />
<style type="text/css">
	.progress_bar .pro-bar {
		background: hsl(0, 0%, 97%);
		box-shadow: 0 1px 2px hsla(0, 0%, 0%, 0.1) inset;
		height:4px;
		margin-bottom: 12px;
		margin-top: 50px;
		position: relative;
	}
	.progress_bar .progress_bar_title{
		/*color: hsl(218, 4%, 50%);*/
		color: #D5D6E2;
		font-size: 15px;
		font-weight: 300;
		position: relative;
		top: -28px;
		z-index: 1;
	}
	.progress_bar .progress_number{
		float: right;
		margin-top: -24px;
	}
	.progress_bar .progress-bar-inner {
		background-color: hsl(0, 0%, 88%);
		display: block;
		width: 0;
		height: 100%;
		position: absolute;
		top: 0;
		left: 0;
		transition: width 1s linear 0s;
		animation: animate-positive 2s;
	}
	.progress_bar .progress-bar-inner:before {
		content: "";
		background-color: hsl(0, 0%, 100%);
		border-radius: 50%;
		width: 4px;
		height: 4px;
		position: absolute;
		right: 1px;
		top: 0;
		z-index: 1;
	}
	.progress_bar .progress-bar-inner:after {
		content: "";
		width: 14px;
		height: 14px;
		background-color: inherit;
		border-radius: 50%;
		position: absolute;
		right: -4px;
		top: -5px;
	}
	@-webkit-keyframes animate-positive{
		0% { width: 0%; }
	}
	@keyframes animate-positive{
		0% { width: 0%; }
	}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-sm-3">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
						    <h5>列表</h5>
							<div class="ibox-tools">
							     <a class="btn btn-primary btn-xs" onclick="file_query()" ><i class="fa fa-search"></i>查询</a>
						         <a class="btn btn-primary btn-xs" onclick="down_excel_model()" ><i class="fa fa-download"></i>下载模版</a>
				                 <a class="btn btn-success btn-xs" onclick="rc.open_excel_file_upload_page('sxpt_excel_imp','60','file_query')" ><i class="fa  fa-upload"></i>上传</a> 
					        </div>
						</div>
						<!-- 模型 -->
				        <script id="tpl" type="text/x-handlebars-template" >
                           {{#equals excel_batch_status '0' }}
                              5%
                              <div class="progress progress-striped active " style="margin-bottom:0px;">			                
                              <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 10%;">
	                          </div>
                              </div>
			              {{/equals}} 
			              {{#equals excel_batch_status '1'}}
                          {{excel_batch_data_status}}%                              
                           <div class="progress progress-striped active " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: {{excel_batch_data_status}}%;">
	                          </div>
                              </div>
			              {{/equals}}
                          {{#equals excel_batch_status '2'}}
                           {{excel_batch_data_status}}%                              
                           <div class="progress progress-striped active " style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: {{excel_batch_data_status}}%;">
	                          </div>
                              </div>
			              {{/equals}}
                          {{#equals excel_batch_status '3'}}
                           100%
                              <div class="progress" style="margin-bottom:0px;">
                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
	                          </div>
                              </div>
			              {{/equals}}

                          {{#equals excel_batch_status '4'}}
                          <span style='color:red;'>
                                                                                      导入失败:{{excel_batch_rt_msg}}
                          </span>
			              {{/equals}}
                          
                        </script>
                       
                        <script id="tpl_op" type="text/x-handlebars-template" >
                            <!--只有管理员才能看到删除及入库操作-->
                            <shiro:hasRole name="admin">
                            {{#equals excel_batch_status '2,4' }}
                               <a class="link" onclick="exec_proc('{{excel_batch_id}}')"><i class="fa fa-edit"></i>重新入库</a> 
                            {{/equals}}
                            <a class="link" onclick="delete_by_excel_batch_number('{{excel_batch_number}}')" ><i class="fa fa-remove"></i>删除临时数据</a> 
                            </shiro:hasRole>
                            {{#equals  excel_error_file_download '1'}}
                               <a class="link" onclick="download_excel_file_by_number('{{excel_batch_number}}')" ><i class="fa fa-download"></i>错误数据下载</a> 
                            {{/equals}}
                        </script>
                       
                        
                        <div class="ibox-content" >
						      <table class="table" style="height: 10px;">
						      <tr>
							      <td>
							                   步骤  1.转换excel
							      <div class="progress progress-striped active " style="margin-bottom:0px;">			                
	                              <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 5%;">
			                        <span class="sr-only"></span>
		                          </div>
		                          </div>
							      </td>
						      <td>
							       2.导入临时表
		                          <div class="progress progress-striped active " style="margin-bottom:0px;">
	                              <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 30%;">
			                        <span class="sr-only"></span>
		                          </div>
		                          </div>
						      </td>
						      <td>
							      3.解析临时表
		                          <div class="progress progress-striped active " style="margin-bottom:0px;">
	                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
			                        <span class="sr-only"></span>
		                          </div>
	                              </div>
						      </td>
						      <td>
							     4.完成导入
		                          <div class="progress" style="margin-bottom:0px;">
	                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
			                        <span class="sr-only"></span>
		                          </div>
	                              </div>
						      </td>
						      </tr>
						      </table>
						</div>
							<table id="exceltable" 
							data-url="<c:url value='/excelimport/EXCEL_IMPORT_001_001/getList'/>"
                            data-single-select="true"
                            data-page-size="5"
                            data-pagination="true"
                            data-card-view="true"
							>
							<thead>
							    <tr>
							        <th data-formatter="indexFormatter">序号</th>
				                    <th data-field="excel_batch_number">批次号</th>
				                    <th data-field="excel_batch_status" data-formatter="excel_batch_status_formatter">导入状态</th>
				                    <th data-field="excel_batch_total_count" >数据总量</th>
				                    <th data-field="excel_batch_error_count" data-formatter="excel_batch_error_count_formatter">错误数量</th>
				                    <th data-field="excel_batch_file_name" >文件名</th>
				                    <th data-field="excel_batch_begin_time_string">开始时间</th>
				                    <th data-field="excel_batch_cost">耗时(秒）</th>
				                    <th data-formatter="excel_batch_op_formatter">操作</th>
							    </tr>
					        </thead>
							</table>
					</div>
				</div>
			</div>
			</div>
			<div class="col-sm-9">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>批次明细</h5>
						<div class="ibox-tools">
						     <a class="btn btn-primary btn-xs" onclick="data_query()" ><i class="fa fa-search"></i>查询</a>
					         <a class="btn btn-success btn-xs" onclick="ge_excel_file()" ><i class="fa fa-download"></i>错误数据生成</a>
				        </div>
					</div>
					<div class="ibox-content" >
						<form class="form-horizontal" >
							<!-- 隐藏区域 -->
							<div class="form-group">
							    <rc:hidden property="excel_error_file_download"/>
							    <rc:textedit property="excel_batch_number" label="批次号" readonly="true" cols="1,3"/>
							    <rc:select label="是否处理完成" codetype="YESNO" property="excel_isop" value="1" cols="2,2"/>
							    <rc:select label="数据是否正确" codetype="YESNO" property="excel_isvalid" value="1" cols="2,2"/>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
			    <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>扶贫导入整理数据情况</h5>
				</div>
				<div class="ibox-content" >
					<table id="exceldatatable_total">
						<thead>
						    <tr>
			                    <th data-field="excel_errormsg">数据情况</th>
			                    <th data-field="excel_errormsg_groupby_total">数据量</th>
						    </tr>
				        </thead>
					</table>
				</div>
				</div>
			</div>
			<div class="col-sm-12">
			    <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>扶贫导入明细情况列表</h5>
				</div>
				<div class="ibox-content" >
					<table id="exceldatatable"  data-page-size="10" data-pagination="true" >
						<thead>
						    <tr>
						        <th data-field="excel_rownum">数据行数</th>
						        <th data-field="excel_isop" data-formatter="excel_isvalid_formatter">是否完成</th>
						        <th data-field="excel_isvalid" data-formatter="excel_isvalid_formatter">是否正确</th>
						        <th data-field="aac003">姓名</th>
			                    <th data-field="aac002">身份证号码</th>
			                    <th data-field="aac010">户口所在地</th>
			                    <th data-field="aac005">民族</th>
			                    <th data-field="aac007">年龄</th>
			                    <th data-field="aac033">健康状况</th>
			                    <th data-field="aae006">联系电话</th>
			                    <th data-field="aae015">劳动技能</th>
			                    <th data-field="aac031">主要致贫原因</th>
			                    <th data-field="excel_errormsg" data-formatter="excel_errormsg_formatter">说明</th>
						    </tr>
				        </thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<rc:jsfooter />
<script type="text/javascript">
$(function() {
	 $exceltable=$('#exceltable').inittable();
	 $('#exceldatatable_total').inittable();
	 $('#exceldatatable').inittable();
	 //定时执行 每20秒刷新批次列表
	 window.setInterval(file_query,200000) 
})

//下载模版
function down_excel_model(){
	window.open(contextPath+'/resource/excel/sxfp_excel.xlsx');
}
//表监听
$('#exceltable').on('click-row.bs.table', function (e, row, $element) {
   	$('#excel_batch_number').val(row.excel_batch_number);
   	if(row.excel_error_file_download){
   		$('#excel_error_file_download').val(row.excel_error_file_download);
   	}
   	query_excel_data_total_by_batch(row.excel_batch_number);
   	query_excel_data_detail_by_batch(row.excel_batch_number);
});   


//表监听
$('#exceldatatable_total').on('click-row.bs.table', function (e, row, $element) {
   	query_excel_data_detail_by_batch($('#excel_batch_number').val(),null,row.excel_errormsg);
}); 

//表监听
$('#exceldatatable').on('click-row.bs.table', function (e, row, $element) {
    if(row.excel_isop=='1'){
    	//查看
       	layer.open({
       		  type: 2,
       		  title: row.aac003+'个人信息查看',
       		  shadeClose: false,
       		  maxmin:true,
       		  shade: 0.8,
       		  area: ['80%', '90%'],
       		  content: "<c:url value='/excelimport/EXCEL_IMPORT_001_001/view'/>/"+row.aac002 //iframe的url
    	});
    }
}); 

//手动执行过程
function exec_proc(excel_batch_id){
	var url="<c:url value='/excelimport/EXCEL_IMPORT_001_001/executeProc'/>"+'?excel_batch_id='+excel_batch_id;
	   rc.ajax(url, null,function (response) {
	});
}

//format
//状态
function excel_batch_status_formatter(value, row, index) {
	var tpl = $("#tpl").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}
//操作
function excel_batch_op_formatter(value, row, index) {
	var tpl = $("#tpl_op").html();  
  	//预编译模板  
  	var template = Handlebars.compile(tpl);  
  	return template(row);
}

//错误数据数量
function excel_batch_error_count_formatter(value, row, index) {
	if(row.excel_batch_error_count){
		return "<span style='color:red;'>"+row.excel_batch_error_count+"</span>";
	}
}
//错误原因
function excel_errormsg_formatter(value, row, index) {
    if(row.excel_errormsg&&row.excel_errormsg=='成功'){
    	return "<span style='color:blue;'>"+row.excel_errormsg+"</span>";
	}else if(row.excel_errormsg){
		return "<span style='color:red;'>"+row.excel_errormsg+"</span>";
	}else{
		
	}
}

//是否正确
function excel_isvalid_formatter(value, row, index){
	if(value=='1'){
		return "<span style='color:blue;'><i class='fa fa-check'></i></span>";
	}else{
		return "<span style='color:red;'><i class='fa fa-close'></i></span>";
	}
}
function indexFormatter(value, row, index) {
    return index+1;
}
//查询总体
function query_excel_data_total_by_batch(excel_batch_number){
	var url="<c:url value='/excelimport/EXCEL_IMPORT_001_001/getPovertyImprtDataTotalList'/>"+'?excel_batch_number='+excel_batch_number;
	$('#exceldatatable_total').refreshtable(url);
}

//查询明细
function query_excel_data_detail_by_batch(excel_batch_number,excel_isvalid,excel_errormsg,excel_isop){
	var url="<c:url value='/excelimport/EXCEL_IMPORT_001_001/getPovertyImprtDataList'/>"+'?excel_batch_number='+excel_batch_number;
	if(excel_isvalid){
		url+="&excel_isvalid="+excel_isvalid;
	}
	if(excel_errormsg){
		url+="&excel_errormsg="+rc.encodeURITwice(excel_errormsg);
	}
	if(excel_isop){
		url+="&excel_isop="+excel_isop
	}
	$('#exceldatatable').refreshtable(url);
}

//明细查询
function data_query(){
	var excel_batch_number=$('#excel_batch_number').val();
	if(excel_batch_number){
		query_excel_data_detail_by_batch(excel_batch_number,$('#excel_isvalid').val(),null,$('#excel_isop').val());
	}else{
		layer.msg('请先选择一个批次');
	}
}
//刷新用户列表
function file_query(){
	$('#exceltable').refreshtable();
}

function delete_by_excel_batch_number(excel_batch_number){
	if(excel_batch_number){
 		layer.confirm('确定删除吗？', function(index){
 			var url= "<c:url value='/excelimport/EXCEL_IMPORT_001_001/deleteTempDataByNumber/'/>"+excel_batch_number;
 			rc.ajax(url, null,function (response) {
 				if(response.success){
 					$('#exceltable').refreshtable();
 				}else{
 					layer.msg(response.message);
 				}
 			});
 			layer.close(index);
 		});
 	}else{
 	    layer.alert('请先选择你要删除的数据');
 	}
}
//判断是否需要生成错误文件excel
function ge_excel_file(){
	var excel_batch_number=$('#excel_batch_number').val();
	if(excel_batch_number){
		var excel_error_file_download=$('#excel_error_file_download').val();
		if(excel_error_file_download=='1'){
			layer.confirm('已经生成过本批次错误数据excel文件,是否重新生成', function(index){
				execute_ge_file(excel_batch_number);
				layer.close(index);
			})
		}else if(excel_error_file_download=='0'){
			layer.msg('正在生成.....,待生成成功后到批次列表中下载,请勿频繁操作');
		}else{
			execute_ge_file(excel_batch_number);
		}
 	}else{
 		layer.msg('请先选择一个批次');
 	}
}
//生成错误文件excel
function execute_ge_file(excel_batch_number){
	var url= "<c:url value='/excelimport/EXCEL_IMPORT_001_001/genExcel/'/>"+excel_batch_number;
	rc.ajax(url, null,function (response) {
		if(response.success){
			$('#exceltable').refreshtable();
			alert(response.message);
		}else{
			alert(response.message);
		}
	});
}
//文件下载
function download_excel_file_by_number(excel_batch_number){
	window.open(contextPath+'/common/fileload/exceldownload/'+excel_batch_number);
} 
</script>
</body>
</html>