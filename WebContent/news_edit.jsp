<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>修改信息</title>
	<!-- Bootstrap -->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
	<!-- fileinput -->
	<link href="css/fileinput.css" media="all"rel="stylesheet" type="text/css" />
	
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/fileinput.js"type="text/javascript"></script>
	<script src="js/locales/zh.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		$("#imgId").click(function() {
			if (confirm("确认修改图片吗？")) {
				$("#pId").hide();
				//动态构建标签的实例
				var $tag = $("<label class='control-label' for='uploadfile'>图片:</label><input type='file' id='uploadfile' name='file' multiple />");
				$("#fileId").append($tag);
				$("#fileId").show();
				//修改表单encytype
				$("#formId").attr("enctype","multipart/form-data");
				$("#formId").attr("action","${pageContext.servletContext.contextPath}/NewsUpdateServlet");
				//初始化fileinput
				$("#uploadfile").fileinput({
				    language: 'zh',
				    showCaption: true,
				    showUpload: false,
				    showRemove: true,
				    showClose: false,
				    layoutTemplates:{
				        actionDelete: ''
				    },
				    browseClass: 'btn btn-primary'
				});
			}
		});
	})
</script>
	<style type="text/css">
		.news-foot {
			padding-top: 50px;
			padding-bottom: 50px;
		}
	</style>
</head>

<body>
	<!-- 顶部导航栏 -->
	<%@include file="top.jsp"%>

	<div class="container-fluid" style="margin-top: 50px;">
		<!-- 左侧导航栏 -->
		<c:choose>
			<c:when test="${user.isAdmin == 1}">
				<%@include file="left_admin.jsp"%>
			</c:when>
			<c:otherwise>
				<%@include file="left_user.jsp"%>
			</c:otherwise>
		</c:choose>

		<!-- 右侧列表 -->
		<div class="col-xs-10">
			<div class="container-fluid">
				<ol class="breadcrumb">
					<li><a herf="#">首页</a></li>
					<li class="active">当前页面</li>
				</ol>
				<form class="col-xs-8 col-xs-offset-2"
					action="
				${pageContext.servletContext.contextPath}/NewsServlet"
					method="post" id="formId">
					<input name="method" type="hidden" value="editNews" /> 
					<input name="nid" type="hidden" value="${news.nid}" />
					<legend>修改信息</legend>
					<div class="form-group">
						<label>主题:</label> 
						<select class="form-control" name="tid">
							<c:forEach items="${topics}" var="topic">
								<option value="${topic.tid}"
									<c:if test="${news.topic.tid eq topic.tid}">selected="selected"</c:if>>${topic.tname}</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group">
						<label>标题:</label> <input type="text" class="form-control"
							name="ntitle" value="${news.ntitle}" />
					</div>
					<div class="form-group">
						<label>摘要:</label> <input type="text" class="form-control"
							name="nsummary" value="${news.nsummary}" />
					</div>
					<div class="form-group">
						<label>内容:</label>
						<textarea rows="10" class="form-control" name="ncontent">${news.ncontent}</textarea>
					</div>
					<div class="form-group" style="display: none;" id="fileId">
						<!-- 
						<label>上传图片:</label>
						<input name="file" type="file" class="file" data-show-preview="false"> -->
					</div>
					<div class="form-group" id="pId">
						<label>图片:</label><br>
						<img
							src="${pageContext.servletContext.contextPath}${news.file}"
							alt="图片不存在" class="img-thumbnail" id="imgId" />
					</div>
					<div class="form-group">
					<c:choose>
						<c:when test="${user.isAdmin == 1}">
							<div style="text-align:center; padding-top:20px;">
								<button type="submit" class="btn btn-success" onclick="">修改通过</button>
								<button type="button" class="btn btn-warning" onclick="{javascrtpt:window.location.href =
									'${pageContext.servletContext.contextPath}/NewsServlet?method=noPassCheck&nid=${news.nid}'}">不予通过</button>
								<button type="button" class="btn btn-danger" onclick="{if(confirm('确认删除?')){javascrtpt:window.location.href = 
												'${pageContext.servletContext.contextPath}/NewsServlet?method=removeNews&nid=${news.nid}'}}">违规删除</button>
								<button type="button" class="btn btn-default" onclick="{javascrtpt:window.location.href =
									'javascript:history.go(-1);'}">取消操作</button>
							</div>
						</c:when>
						<c:otherwise>
							<div style="text-align:center; padding-top:20px;">
								<button type="submit" class="btn btn-success" onclick="">提交修改</button>
								<button type="button" class="btn btn-danger" onclick="{if(confirm('确认删除?')){javascrtpt:window.location.href = 
												'${pageContext.servletContext.contextPath}/NewsServlet?method=removeNews&nid=${news.nid}'}}">删除信息</button>
								<button type="button" class="btn btn-default" onclick="{javascrtpt:window.location.href =
									'javascript:history.go(-1);'}">取消修改</button>						
							</div>
						</c:otherwise>
					</c:choose>
					</div>
				</form>
			</div>
			<!-- 页脚 -->	
			<div class="news-foot">
				<footer>
					<p class="pull-right">
						<a href="#top">回到顶部</a>
					</p>
					<p>&copy; 2020 南开通校园综合信息平台</p>
				</footer>
			</div>
		</div>
	</div>
</body>
		
</html>