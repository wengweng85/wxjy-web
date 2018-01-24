<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>搜索框</title>
    <rc:csshead/>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="search-form">
                             <div class="input-group">
                                 <input type="text" placeholder="请输入搜索关键字" name="keyword"  id="keyword" class="form-control input-lg">
                                 <div class="input-group-btn">
                                     <button class="btn btn-lg btn-primary" id="search" >
                                                                                                                                     搜索
                                     </button>
                                 </div>
                             </div>
                        </div>
                        <!-- 模型 -->
                        <script id="model" type="text/x-handlebars-template" >
                        <h2>
                                                                                为您找到相关结果约<span id="numfound"></span>个
                        </h2>
                        <small>搜索用时  (<span id="qttime"></span>秒)</small>
                           {{#each this}}
	                        <div class="hr-line-dashed"></div>
	                        <div class="search-result">
	                            <h3><a target="_blank" href="{{{this.f_info_id_ik}}}"> {{{this.f_title_ik}}}</a></h3>
	                            <a target="_blank" href="{{{this.f_info_id_ik}}}" class="search-link">{{{this.f_info_id_ik}}}</a>
                                <div  width='100%' height='150' valign="top">                                  
                                    {{#if f_image_ik}}
                                    <div style='width:200px;height:150px;' >
	                                <img src='{{{this.f_image_ik}}}' width='200' height='150'></img>
                                    </div>
                                    {{/if}}
                                    <div valign="top">
                                    {{{this.f_value_ik}}}
                                    </div>
                               </div>
	                            </div>
	                        {{/each}}
                        </script>
                        <!-- 显示 -->
                        <div id="view"></div>
                        <input type="hidden" id="curpage" value="0">
                        <input type="hidden" id="rows" value="100">
                        
                        <div  class="padlr" align="right">
						　　<div id="pagination" class="pagination"></div>
						</div>
                </div>
            </div>
        </div>
    </div>
   <rc:jsfooter/> 
   
   <script type="text/javascript">
   $(document).keypress(function(e) {  
      //回车键事件  
      if(e.which == 13) {  
   	    $("#search").click();  
      }  
   }); 
   $("#search").click(function() {
            var keyword = $("#keyword").val();
            var start = $("#curpage").val()||0*20;
            var rows = $("#rows").val()||20;
            var url= "<c:url value='/common/solrquery'/>?q="+rc.encodeURITwice(keyword)+"&start="+start+"&rows="+rows;
   			rc.ajax(url, null,function (response) {
   				console.log(response);
   				if(response.success&&response.obj.datalist.length>0){
   					var model=$('#model').html();
   					var modeldata=Handlebars.compile($('#model').html());
   					var views = modeldata(response.obj.datalist);
   					$('#view').html(views);
   					$('#numfound').html(response.obj.numfound);
   	                $('#qttime').html(response.obj.qttime / 1000);
   	                
   	                /* var options = {
   	                  currentPage : '2',    //变量名必须为currentPage
   	                  totalPages : response.obj.numfound/20    //变量名必须为totalPages
   	                }
   	                $('#pagination').bootstrapPaginator(options); */
   				}else{
   					$("#view").html("<font color=\"red\">没有您要查询的结果。</font>");
   				}
   			});
        });
    </script>
</body>
</html>