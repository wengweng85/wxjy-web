<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>网格管理</title>
<!-- css头文件  -->
<rc:csshead />
<style type="text/css">
    #allmap{width:100%;height:615px;}
</style>
</head>
<body class="gray-bg" >
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-sm-3">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>网格树(<span style="color:blue">网格数</span>)</h5>
					<div class="ibox-tools">
			        </div>
				</div>
				<div class="ibox-content">
					<div id="tree-div" class="ztree" style="overflow: auto; height: 760px; "></div>
				</div>
			</div>
		</div>
		<div class="col-sm-5">
		    <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>浙江省网格及残疾人整理情况</h5>
					<div class="ibox-tools">
			        </div>
				</div>
				<div class="ibox-content">
				<table class="table table-bordered table-striped" style="text-align: center;">
                <tr>
                    <td>
                       <button type="button" class="btn btn-danger ">残疾人 1227089</button>
                   </td>
                   <td>
                       <button type="button" class="btn btn-primary ">网格 37675</button>
                   </td>
                   <td >
                       <button type="button" class="btn btn-info ">网格员 33040</button>
                   </td>
                 </tr>
                </table>
		        </div>
		    </div>
		    <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>网格地图</h5>
					<div class="ibox-tools">
					<!--  
						 <a class="btn btn-primary btn-xs" onclick="polygon.enableEditing();" ><i class="fa fa-plus"></i>&nbsp;开启线、面编辑功能</a>
						 <a class="btn btn-danger btn-xs" onclick="polygon.disableEditing();" ><i class="fa  fa-trash-o"></i>&nbsp;关闭线、面编辑功能</a>
						 <a class="btn btn-primary btn-xs" onclick="print()" ><i class="fa  fa-trash-o"></i>&nbsp;保存</a>
					-->	 
			        </div>
				</div>
				<div class="ibox-content">
					<div id="allmap"></div>
					<rc:hidden property="ab_bf023_2"/>
				</div>
			</div>
		</div>
		<div class="col-sm-4">
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h5>网格信息</h5>
				<div class="ibox-tools">
		        </div>
			</div>
			<div class="tab-content" style="padding: 10px;">
			<table class="table table-bordered table-striped">
	            <tr>
	               <td><strong>网格名称</strong></td><td colspan="3"><span id="ab_bf023_1"></span></td>
	            </tr>
	            <tr>      
	               <td><strong>联系地址</strong></td><td colspan="3"><span id="aae006"></span</td>
	            </tr>
	            <tr>   
	               <td><strong>网格负责人</strong></td><td><span id="ab_bf025"></span</td>
	               <td><strong>联系电话</strong></td><td><span id="aae005"></span</td>
	            </tr>
	            <tr>
	               <td><strong>网格内残疾人数</strong></td><td colspan="3"><span style="color:blue;" id="usercou"></span</td>
	            </tr>
	            <tr>
	               <td><strong>网格员数</strong></td><td><span style="color:blue;" id="abf014"></span</td>
	               <td><strong>专职委员数</strong></td><td><span style="color:blue;" id="ab_bf027"></span</td>
	            </tr>
            </table>
			</div>
		 </div>		
		 <div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>网格下网格员、专职委员、残疾人信息</h5>
					<div class="ibox-tools">
			        </div>
				</div>
				<div class="ibox-content">
				<!-- 隐藏域 -->
				<rc:hidden property="abz182"/>
				<!-- tabs头 -->
				<ul class="nav nav-tabs">
					 <li class="active"><a href="#tab1" data-toggle="tab">网格长(<span style="color:blue;" >1</span>)</a> </li>
					 <li><a href="#tab2" data-toggle="tab">网格员(<span style="color:blue;" id="abf014_cou">0</span>)</a></li>
					 <li><a href="#tab3" data-toggle="tab">专职委员(<span style="color:blue;" id="ab_bf027_cou">0</span>)</a></li>
					 <li><a href="#tab4" data-toggle="tab">残疾人(<span style="color:blue;" id="usercou_div">0</span>)</a></li>
				</ul>
				<!-- tabs内容 --> 
				<div class="tab-content" style="padding: 10px;">
					 <div class="tab-pane active" id="tab1">
						 <table class="table table-bordered table-striped">
				            <tr>
				               <td><strong>姓名</strong></td><td ><span id="cnname"></span</td>
				               <td><strong>用户名</strong></td><td ><span id="username"></span></td>
				            </tr>
				            <tr>   
				               <td><strong>电话</strong></td><td><span id="phone"></span</td>
				               <td><strong>邮箱</strong></td><td><span id="email"></span</td>
				            </tr>
				            <tr>
				               <td><strong>联系地址</strong></td><td colspan="3"><span id="address"></span</td>
				            </tr>
				            <tr>
				            <td colspan="4">
				                 <!-- 
				                 <button id="btn_add_toolbar_user1" type="button" class="btn btn-primary" onclick="user1table_import('2','网格长维护')">
								     <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>编辑
								 </button>
								 -->
				             </td>
				            </tr>
			             </table>
					 </div>
					 <div class="tab-pane" id="tab2">
					  <!-- toolbar_user2 -->
		              <div id="toolbar_user2" class="btn-group">
						 <button id="btn_add_toolbar_user2" type="button" class="btn btn-primary" onclick="user1table_import('3','网格员维护')">
						 <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>网格员编辑
						 </button>
					  </div>
					  <table id="user2table" 
							data-click-to-select="true"
	                        data-single-select="true"
	                        data-pagination="true"
	                        data-page-size="5"
	                        data-card-view="false"
	                        data-toolbar="toolbar_user2"
							>
							<thead>
							     <tr>
							        <th data-formatter="sys_user_role_indexFormatter">序号</th>
				                    <th data-field="username">用户名</th>
				                    <th data-field="cnname">姓名</th>
				                    <th data-field="phone">电话</th>
							    </tr>
					        </thead>
						</table>
					 </div>
					 <div class="tab-pane" id="tab3">
					 <!-- toolbar_user3 -->
			         <div id="toolbar_user3" class="btn-group">
						 <button id="btn_add_toolbar_user3" type="button" class="btn btn-primary" onclick="user1table_import('4','专职委员维护')">
						    <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>专职委员编辑
						 </button>
					 </div>
					 <table id="user3table" 
							data-click-to-select="true"
	                        data-single-select="true"
	                        data-pagination="true"
	                        data-page-size="5"
	                        data-card-view="false"
	                        data-toolbar="toolbar_user3"
							>
							<thead>
							     <tr>
							        <th data-formatter="sys_user_role_indexFormatter">序号</th>
				                    <th data-field="username">用户名</th>
				                    <th data-field="cnname">姓名</th>
				                    <th data-field="phone">电话</th>
							    </tr>
					        </thead>
						</table>
					 </div>
					 <div class="tab-pane" id="tab4">
				     <!-- toolbar_ac01 -->
		             <div id="toolbar_ac01" class="btn-group">
		                  <button id="btn_add_toolbar_ac01" type="button" class="btn btn-primary" onclick="ac01table_import('残疾人维护')">
						    <span class="glyphicon glyphicon-plus" aria-hidden="false"></span>残疾人编辑
						 </button>
					 </div>
					 <table id="ac01table" 
							data-click-to-select="true"
	                        data-single-select="true"
	                        data-pagination="true"
	                        data-page-size="5"
	                        data-card-view="false"
							>
							<thead>
							    <tr>
							        <th data-formatter="sys_user_role_indexFormatter">序号</th>
				                    <th data-field="name">姓名</th>
				                    <th data-field="disable_card_num" data-formatter="text_next_row_indexFormatter">残疾证号码</th>
				                    <th data-field="disable_type">残疾类型</th>
				                    <!-- 
				                    <th data-field="gender">性别</th>
				                    <th data-field="disable_level">残疾等级</th>
				                    <th data-field="phone">联系电话</th>
				                     -->
							    </tr>
					        </thead>
						</table>
					 </div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>
<rc:jsfooter />
<script type="text/javascript">
$(function() {
	 $.fn.zTree.init($("#tree-div"), sys_user_role_setting);
	 //树默认展开第一级节点
   	 var treeObj = $.fn.zTree.getZTreeObj("tree-div");
     treeObj.expandAll(true);
     $('#user1table').inittable();
     $('#user2table').inittable();
     $('#user3table').inittable();
	 $('#ac01table').inittable();
	 $('#ab01table').inittable();
});

//用户表格监听,双击 
$('#ac01table').on('dbl-click-row.bs.table', function (e, row, $element) {
	view_by_id(row.id,row.name,row.abz182)
}); 

//查看
function view_by_id(id,name,abz182){
	layer.open({
   		  type: 2,
   		  title: abz182+'内'+name+'信息查看',
   		  shadeClose: true,
   		  maxmin:true,
   		  area: ['60%', '90%'],
   		  content: "<c:url value='/grid/toview'/>/"+id //iframe的url
		});
}

//user1table_import
function user1table_import(usertype,titlename){
	var abz182=$('#abz182').val();
	if(abz182){
		var index=layer.open({
	   		  type: 2,
	   		  title: titlename,
	   		  shadeClose: true,
	   		  maxmin:true,
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/grid/userimprt'/>/"+abz182+"/"+usertype //iframe的url
			});
		layer.full(index); 
	}else{
		layer.msg('请先选择一个网格');
	}
}

function ac01table_import(titlename){
	var abz182=$('#abz182').val();
	if(abz182){
		var index=layer.open({
	   		  type: 2,
	   		  title: titlename,
	   		  shadeClose: true,
	   		  maxmin:true,
	   		  area: ['50%', '70%'],
	   		  content: "<c:url value='/grid/ac01imprt'/>/"+abz182 //iframe的url
			});
		layer.full(index); 
	}else{
		layer.msg('请先选择一个网格');
	}
}


//树配置
var sys_user_role_setting = {
	  view: {
          dblClickExpand: false,
          showLine: true,
          selectedMulti: false,
          nameIsHTML: true
	  },	
	  check: {
		enable: false
	  },
	  data: {
		simpleData: {
			enable: true
		}
	  },
	  callback: {
		 onClick: onClick
	  },
	  async: {
		 enable: true,
		 url: "<c:url value='/grid/treedata'/>",
		 autoParam:["id"]
	  }
};

function refresh_agency_tree(){
	 //树默认展开第一级节点
  	var treeObj = $.fn.zTree.getZTreeObj("tree-div");
    treeObj.expandAll(true);
    var nodes = treeObj.getSelectedNodes();
    if (nodes.length>0) {
    	treeObj.reAsyncChildNodes(nodes[0], "refresh");
    }
}

//点击事件
function onClick(event, treeId, treeNode, clickFlag) {
	//机构信息查询
	//rc.ajaxQuery("<c:url value='/sys/userrole/getgroupdatabyid/'/>"+treeNode.id);
	//sys_user_role_queryuser(treeNode.id);
	
	search(treeNode.ab_bf023_1);
	if(treeNode.isgrid=='1'){
		$('#abz182').val(treeNode.id);
		//机构信息查询
		rc.ajaxQuery("<c:url value='/grid/getGridInfoById/'/>"+treeNode.id);
		rc.ajaxQuery("<c:url value='/grid/getWgzInfo'/>"+'?abz182='+treeNode.id);
		//suer_query(treeNode.id,'2');
		suer_query_2(treeNode.id,'3');
		suer_query_3(treeNode.id,'4');
		ac01_query(treeNode.id);
		ab01_query(treeNode.id);
	}
}

//查询
function suer_query(abz182,usertype){
	var url="<c:url value='/grid/getUserListByGridid'/>"+'?abz182='+abz182+"&usertype="+usertype;
	$('#user1table').refreshtable(url);
}
//查询
function suer_query_2(abz182,usertype){
	var url="<c:url value='/grid/getUserListByGridid'/>"+'?abz182='+abz182+"&usertype="+usertype;
	$('#user2table').refreshtable(url);
}
//查询
function suer_query_3(abz182,usertype){
	var url="<c:url value='/grid/getUserListByGridid'/>"+'?abz182='+abz182+"&usertype="+usertype;
	$('#user3table').refreshtable(url);
}

//查询
function ac01_query(abz182){
	var url="<c:url value='/grid/getAc01ListByGridid'/>"+'?abz182='+abz182;
	$('#ac01table').refreshtable(url);
}

//查询
function ab01_query(abz182){
	var url="<c:url value='/grid/getAb01ListByGridid'/>"+'?abz182='+abz182;
	$('#ab01table').refreshtable(url);
}

function sys_user_role_indexFormatter(value, row, index) {
    return index+1;
}

function text_next_row_indexFormatter(value, row, index){
	if(value!='undefined'){
		return "<span style='word-wrap:break-word;word-break:break-all;'>"+value+"</span>"
	}
}


//百度地图API功能
var map = new BMap.Map("allmap");    // 创建Map实例
map.centerAndZoom(new BMap.Point(120.174693,30.290761), 14);  // 初始化地图,设置中心点坐标和地图级别
//添加地图类型控件
map.addControl(new BMap.MapTypeControl({
	mapTypes:[
     BMAP_NORMAL_MAP,
     BMAP_HYBRID_MAP
 ]}));	  
map.setCurrentCity("杭州");          // 设置地图显示的城市 此项是必须设置的
map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

function search(locale){
	var local = new BMap.LocalSearch(map, {
		renderOptions:{map: map}
	});
	local.search(locale);
}

var polygon = new BMap.Polygon([
    new BMap.Point(121.348763,31.501547),
    new BMap.Point(121.348098,31.5007),
    new BMap.Point(121.35012,31.499192),
    new BMap.Point(121.351054,31.500639)
], {strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});  //创建多边形
map.addOverlay(polygon);   //增加多边形

function print(){
  var path = polygon.getPath();
  var i =0;
  var pathstr = "";
  for(;i<path.length;i++){
      pathstr+=path[i].lat+","+path[i].lng+";";   
  }
  document.getElementById('ab_bf023_2').innerHTML=pathstr;
}
</script>
</body>
</html>