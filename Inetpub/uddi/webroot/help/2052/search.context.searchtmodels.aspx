

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
					<h1>搜索 <img src="..\..\images\tmodel.gif" heigh="16" width="16" alt="tModel"> tModel</h1>
					使用“tModel”选项卡按名称、类别或标识方案来搜索 tModel。可以使用任一或所有字段来优化搜索。当准备执行搜索时，请单击“搜索”。
					<UL>
						<li>
							<b>tModel 名称：</b>键入要查找的 tModel 的名称。如果您只知道部分名称，则可以使用“%”做为通配符。
							<p>
							例如，要搜索名称以“an”开头的 tModel，请键入“an”。要搜索名称中包含“an”字母的 tModel，请键入“%an%”。
						</li>
						<li>
							<b>类别：</b>添加一个或多个用于定义和描述要查找的 tModel 类型的类别。搜索只返回那些按照所有已经指定的类别定义的 tModel。
							<UL>
								<LI>单击“添加类别”将类别添加到搜索条件。</LI>
								<LI>单击“删除”从搜索条件中删除类别。</LI>
							</ul>
						</li>
						<li>
							<b>标识符：</b>添加一个或多个与要查找的 tModel 关联的标识方案。搜索只返回那些已经发布所有指定的标识符的 tModel。
							<UL>
								<LI>单击“添加标识符”将标识符添加到搜索条件。</LI>
								<LI>单击“删除”从搜索条件中删除标识符。</LI>
							</ul>
						</li>
					</UL>
					<h3>更多信息</h3>
					<ul>
						<li><a href="search.searchfortmodels.aspx">如何搜索 tModel</a>
						<li><!-- #include file = "glossary.categorization.htm" -->
						<li><!-- #include file = "glossary.identifier.htm" -->
					</ul>
					
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 