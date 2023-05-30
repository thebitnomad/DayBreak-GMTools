

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "search.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "search.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<h1>搜索 <img src="..\..\images\service.gif" heigh="16" width="16" alt="服务"> 服务</h1>
					使用“搜索”选项卡按名称、类别、服务所引用的 tModel 来搜索服务。可以使用任一或所有字段来优化搜索。当准备执行搜索时，请单击“搜索”。 
					<ul>
						<li>
							<b>服务名称：</b>键入要查找的服务的名称。如果您只知道部分名称，则可以使用“%”做为通配符。
							<p>
							例如，要搜索名称以“an”开头的服务，请键入“an”。要搜索名称中包含“an”字母的服务，请键入“%an%”。
						</li>
						<li>
							<b>类别：</b>添加一个或多个用于定义和描述要查找的服务类型的类别。搜索只返回那些按照所有已经指定的类别定义的服务。
							<UL>
								<LI>单击“添加类别”将类别添加到搜索条件。</LI>
								<LI>单击“删除”从搜索条件中删除类别。</LI>
							</ul>
						</li>
						<li>
							<b>tModel：</b>添加一个或多个由要查找的服务引用的 tModel。搜索只返回那些发布所有已指定的 tModel 的服务。
							<UL>
								<LI>单击“添加 tModel”将 tModel 添加到搜索条件。</LI>
								<LI>单击“删除”从搜索条件中删除 tModel。</LI>
							</ul>
						</li>
					</ul>

					<h3>更多信息</h3>
					<ul>
						<li><!-- #include file = "glossary.categorization.htm" -->
						<li><!-- #include file = "glossary.tmodel.htm" -->
					</ul>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 