<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.epsoft.com/rctag" prefix="rc"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<rc:csshead />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- 贫困人员信息开始 -->
		<div class="ibox ">
			<div class="ibox-title">
				<h5>贫困人员信息</h5>
				<div class="ibox-tools">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a>
				</div>
			</div>
			<div class="ibox-content">
				<table class="table table-bordered table-striped  ">
					<tr>
						<td><strong>姓名</strong></td>
						<td>${ac60.aac003}</td>
						<td><strong>身份证</strong></td>
						<td>${ac60.aac002}</td>
						<td><strong>户口所在地</strong></td>
						<td>${ac60.aac010}</td>
					</tr>
					<tr>
						<td><strong>性别</strong></td>
						<td>${ac60.aac004}</td>
						<td><strong>民族</strong></td>
						<td>${ac60.aac005}</td>
						<td><strong>年龄</strong></td>
						<td>${ac60.aac007}</td>
					</tr>
					<tr>
						<td><strong>健康状况</strong></td>
						<td>${ac60.aac033}</td>
						<td><strong>政治面貌</strong></td>
						<td>${ac60.aac024}</td>
						<td><strong>劳动技能</strong></td>
						<td>${ac60.aae015}</td>
					</tr>
					<tr>
						<td><strong>户主姓名</strong></td>
						<td>${ac60.aac029}</td>
						<td><strong>主要致贫原因</strong></td>
						<td>${ac60.aac031}</td>
						<td><strong>联系电话</strong></td>
						<td>${ac60.aae006}</td>
					</tr>
					<tr>
						<td><strong>否是在校生</strong></td>
						<td>${ac60.aac030}</td>
					</tr>
					<!-- 贫困人员信息结束 -->

					<!-- 就业情况开始 -->

					<tr>
						<td><strong>是否签订劳动合同</strong></td>
						<td>${ac60.adc006}</td>
						<td><strong>就业地域</strong></td>
						<td>${ac60.adc002}</td>
						<td><strong>是否参加社会保险</strong></td>
						<td>${ac60.adc007}
					</tr>
					<tr>
						<td><strong>就业地点</strong></td>
						<td>${ac60.adc002}</td>
						<td><strong>就业工种</strong></td>
						<td>${ac60.adc004}</td>
						<td><strong>就业时间 </strong></td>
						<td>${ac60.adc005}</td>
					</tr>
					<tr>
						<td><strong>月均工资（元）</strong></td>
						<td>${ac60.adc008}</td>
						<td><strong>就业形式</strong></td>
						<td>${ac60.adc001}</td>
					</tr>

					<!-- 就业情况结束 -->
					<!-- 公益性岗位或公益专岗安置情况开始 -->
					<tr>
						<td><strong>岗位类型</strong></td>
						<td>${ac60.adc009}</td>
						<td><strong>公益性岗位安置地址和单位</strong></td>
						<td>${ac60.adc010}</td>
						<td><strong>安置时间</strong></td>
						<td>${ac60.adc012}</td>
					</tr>
					<tr>
						<td><strong>岗位名称</strong></td>
						<td>${ac60.adc013}</td>
					</tr>

					<!-- 公益性岗位或公益专岗安置情况结束 -->
					<!-- 培训情况开始 -->
					<tr>
						<td><strong>是否参加就业培训</strong></td>
						<td>${ac60.adc014}</td>
						<td><strong>培训类型</strong></td>
						<td>${ac60.adc015}</td>
						<td><strong>培训类别</strong></td>
						<td>${ac60.adc018}</td>
					</tr>
					<tr>
						<td><strong>取得证书</strong></td>
						<td>${ac60.adc019}</td>
						<td><strong>培训补贴(元)</strong></td>
						<td>${ac60.adc020}</td>
						<td><strong>是否就业</strong></td>
						<td>${ac60.adc021}</td>
					</tr>
					<tr>
						<td><strong>培训开始时间</strong></td>
						<td>${ac60.adc016}</td>
						<td><strong>培训截止时间</strong></td>
						<td>${ac60.adc017}</td>
					</tr>

					<!-- 培训情况结束 -->
					<!-- 创业情况开始 -->

					<tr>
						<td><strong>创业时间</strong></td>
						<td>${ac60.adc023}</td>
						<td><strong>是否参加创业培训</strong></td>
						<td>${ac60.adc023}</td>
						<td><strong>创业类型</strong></td>
						<td>${ac60.adc024}</td>
					</tr>
					<tr>
						<td><strong>创业隶属</strong></td>
						<td>${ac60.adc025}</td>
						<td><strong>企业或实体名称</strong></td>
						<td>${ac60.adc026}</td>
						<td><strong>是否享受小额担保贷款</strong></td>
						<td>${ac60.adc027}</td>
					</tr>
					<tr>
						<td><strong>是否享受小额担保贷款</strong></td>
						<td>${ac60.adc028}</td>
						<td><strong>贷款金额（万元）</strong></td>
						<td>${ac60.adc029}</td>
						<td><strong>吸纳劳动力人数</strong></td>
						<td>${ac60.adc030}</td>
					</tr>
					<tr>
						<td><strong>是否在工商部门注册登记</strong></td>
						<td>${ac60.adc031}</td>
					</tr>

					<!-- 创业情况结束 -->
					<!-- 未就业情况开始 -->
					<tr>
						<td><strong>是否有就业愿望</strong></td>
						<td>${ac60.adc032}</td>
						<td><strong>就业意向地</strong></td>
						<td>${ac60.adc033}</td>
						<td><strong>期望月薪(元)</strong></td>
						<td>${ac60.adc034}</td>
					</tr>
					<tr>
						<td><strong>就业服务需求</strong></td>
						<td>${ac60.adc035}</td>
					</tr>

					<!-- 未就业情况结束 -->
					<!-- 提供就业服务情况开始 -->
					<tr>
						<td><strong>提供就业政策咨询次数(次)</strong></td>
						<td>${ac60.adc036}</td>
						<td><strong>提供就业信息次数(次)</strong></td>
						<td>${ac60.adc037}</td>
						<td><strong>提供职业指导与介绍次数(次)</strong></td>
						<td>${ac60.adc038}</td>
					</tr>
					<tr>
						<td><strong>提供培训次数(次)</strong></td>
						<td>${ac60.adc039}</td>
						<td><strong>提供创业服务次数(次)</strong></td>
						<td>${ac60.adc040}</td>
						<td><strong>是否享受职业介绍补贴</strong></td>
						<td>${ac60.adc041}</td>
					</tr>
					<!-- 提供就业服务情况结束 -->
					<!-- 政策落实情况开始 -->
					<tr>

						<td><strong>是否享受社会保险补贴</strong></td>
						<td>${ac60.adc042}</td>
						<td><strong>是否享受岗位补贴</strong></td>
						<td>${ac60.adc043}</td>
						<td><strong>是否享受其他政策扶持</strong></td>
						<td>${ac60.adc044}</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 政策落实情况结束 -->
	</div>
	</div>
	<rc:jsfooter />
</body>
</html>