

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
					<H1>如何搜索提供程序 - <img src="..\..\images\business.gif" heigh="16" width="16" alt="提供者"></H1>
					<p>
						使用“搜索”中的“提供者”选项卡，可以按名称、类别、标识符或按关联的 tModel 来搜索提供程序。
						<p class="to">搜索提供程序</p>
					</p>
					<OL>
						<li>
							在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController> <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。</li>
						<li>
							单击“提供者”选项卡。
						<li>
							按如下方式填写一个或多个搜索选项：
							<ul>
								<li>
									<b>提供程序名称：</b>在“提供程序名称”中，键入要查找的提供程序的名称。如果您只知道部分名称，则可以使用“%”做为通配符。<br>例如，要搜索名称以“an”开头的提供者，请键入“an”。要搜索名称中包含“an”字母的提供者，请键入“%an%”。
								</li>
								<li>
									<b>类别：</b>添加用于定义要查找的提供者类型的类别。搜索只返回按指定的类别归类的提供者。
									<ol>
									<LI>单击“添加类别”。</li>
									<LI>选择用于定义要搜索的提供者类型的类别，然后单击“添加类别”。
									</ol>
								</li>
								<li>
									<b>标识符：</b>添加与要搜索的提供者关联的标识符。搜索只返回那些发布所有指定的标识符的提供者。

									<ol>
									<LI>单击“添加标识符”。
									<LI>选择代表搜索使用的标识方案的 tModel。 
									<LI>在“项名”中，键入搜索使用的标识符名称。 
									<LI>在“项值”中，键入搜索使用的标识符的值。 
									<LI>单击“更新”。 
									</ol>
								</li>
								<li>
									<b>tModel：</b>添加由要搜索的提供者使用的 tModel。搜索只返回那些发布所有指定的 tModel 的提供者。
									<OL>
										<LI>单击“添加 tModel”。</LI>
										<LI>键入要添加的 tModel 的全称或部分名称，然后单击“搜索”。</LI>
										<LI>选择要添加的 tModel。</li>
									</OL>

								</li>
							</ul>
						</li>
						<li>
							定义搜索条件并准备好执行搜索后，请单击“搜索”。<br>
						</li>
						<li>要查看实体的详细信息，请单击列表中实体的名称。然后，您可以查看和浏览该实体及其所有关联实体的特性。
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

