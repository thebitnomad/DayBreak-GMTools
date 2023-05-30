

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
			<tr valign="top">
				<td>
					<H1>如何搜索服务 - <img src="..\..\images\service.gif" heigh="16" width="16" alt="服务"></H1>
					<p>
						使用“搜索”中的“服务”选项卡，可以按名称、类别或关联的 tModel 来搜索 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>。</p>
						<p class="to">搜索服务</p>
					<OL>
						<li>
							在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController> <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。</li>
						<li>
							单击“服务”选项卡。</li>
						<li>
							使用所提供的字段来优化搜索。搜索结果只包括那些与所有指定的标准相匹配的服务。
							<ul>
								<li>
									<b>服务名：</b>在“服务名”中，键入要搜索的服务的名称。如果您只知道部分名称，则可以使用“%”做为通配符。<br>例如，要搜索名称以“an”开头的服务，请键入“an”。要搜索名称中包含“an”字母的服务，请键入“%an%”。
								</li>
								<li>
									<b>类别：</b>添加用于定义要搜索的服务类型的类别。搜索只返回那些按照所有已经指定的类别定义的服务。 
									<ol>
									<LI>单击“添加类别”。</li>
									<LI>选择用于定义要搜索的服务类型的类别，然后单击“添加类别”。
									</ol>
								</li>
								<li>
									<b>tModel：</b>添加由要搜索的服务使用的 tModel。搜索只返回那些发布所有指定的 tModel 的服务。
									<OL>
										<LI>单击“添加 tModel”。</LI>
										<LI>键入要添加的 tModel 的全称或部分名称，然后单击“搜索”。</LI>
										<LI>选择要添加的 tModel。</li>
									</OL>
								</li>
							</ul>
						</li>
						<li>
							在定义搜索条件并准备好执行搜索后，请单击“搜索”。<br>
						</li>
							<li>要查看实体的详细信息，请单击列表中实体的名称。查看和浏览该实体的特性和所有有关的实体。</li>
					</OL>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

