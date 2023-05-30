

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
					<H1>如何搜索 tModel - <img src="..\..\images\tmodel.gif" heigh="16" width="16" alt="tModel"> </H1>
					<p>
						使用“搜索”中的“tModel”选项卡，可以按名称、类别及其唯一标识符来在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>中搜索 tModel。</p>
						<p class="to">搜索 tModel</p>
					<OL>
						<li>
							在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController> <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。</li>
						<li>
							单击“tModel”选项卡。</li>
						<li>
							使用所提供的字段来优化搜索。搜索结果只包括那些与所有指定的标准相匹配的 tModel。
							<ul>
								<li>
									<b>tModel 名称：</b>在“tModel 名称”中，键入要搜索的 tModel 的名称。如果您只知道部分名称，则可以使用“%”做为通配符。<br>例如，要搜索名称以“an”开头的 tModel，请键入“an”。要搜索名称中包含“an”字母的 tModel，请键入“%an%”。
								</li>
								<li>
								<b>类别：</b>添加用于定义要搜索的 tModel 类型的类别。搜索只返回按指定的类别归类的提供者。
									<ol>
									<LI>单击“添加类别”。</li>
									<LI>选择用于定义要搜索的 tModel 类型的类别，然后单击“添加类别”。
									</ol>
								
								</li>
								<li>
								<b>标识符：</b>添加与要搜索的 tModel 关联的标识符。搜索只返回那些与所有指定的标识符关联的 tModel。
									<ol>
									<LI>单击“添加标识符”。
									<LI>选择代表搜索使用的标识方案的 tModel。 
									<LI>在“项名”中，请键入搜索使用的标识符名称。 
									<LI>在“项值”中，键入搜索使用的标识符的值。 
									<LI>单击“更新”。 
									</ol>

								</li>
							</ul>
						</li>
						<li>
							定义搜索条件并准备好执行搜索后，请单击“搜索”。<br>
						</li>
						<li>要查看实体的详细信息，请单击列表中实体的名称。查看和浏览该实体的特性和所有有关的实体。
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

