

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
					<H1>搜索简介</H1>
					<p>
						搜索提供四个选项卡 - <a href="#browse">按类别浏览</a>、<a href="#service">服务</a>、<a href="#provider">提供者</a>和 <a href="#tmodel">tModel</a>，可用来查找 Web 服务信息。您可以按类别、名称、标识方案或 tModel 引用来搜索服务、提供者或 tModel。如果不知道要搜索的实体的全名，您可以将“%”用作通配符。</p>
						<p>
						在执行搜索时，在屏幕上将出现与搜索标准相匹配的实体列表。要查看实体的详细信息，请单击列表中实体的名称。查看和浏览该实体的特性和所有有关的实体。例如，如果搜索到了某个服务，还可以查看该服务的服务提供者或绑定以及实例信息。要执行新搜索，请在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController> <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，单击“搜索”即可重新开始。
						
						</p>
						<a name="browse"></a>
						<h2>“按类别浏览”选项卡</h2>
						使用该选项卡查找已经按特定类别分类的服务、提供者或 tModel。搜索只返回那些已经用指定类别定义的服务、提供者或 tModel。<p>
						例如，要查找特定分类的服务：
						<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。
						<li>单击“按类别浏览”选项卡。
						<li>选择要作为搜索依据的分类方案和类别或分类，然后单击“查找服务”。
						</ol> 
						<a name="service"></a>
						<h2>“服务”选项卡</h2>
						使用该选项卡按名称、作为分类依据的类别或者服务所引用的 tModel 来搜索服务。可以使用任一或所有字段来优化搜索。<p>
						例如，要查找支持某个特定接口或协议的服务：
						<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。
						<li>单击“服务”选项卡。
						<li>单击“添加 tModel”。
						<li>键入代表要搜索的接口或协议的 tModel 全称或部分名称，然后单击“搜索”。
						<LI>从列表中选择要作为搜索依据的 tModel。
						<li>单击“搜索”。
						</ol>
						<a name="provider"></a>
						<h2>“提供者”选项卡</h2>
						使用该选项卡按名称、作为分类依据的类别、标识方案或者提供程序所引用的 tModel 来搜索提供程序。可以使用任一或所有字段来优化搜索。<p>
						例如，要查找名称中包含“WS”字母且属于特定实现或组的所有提供程序：
						<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。
						<li>单击“提供者”选项卡。
						<li>在“提供程序名称”字段中键入“%WS%”。
						<li>单击“添加标识符”。
						<li>指定描述要查找的实现或组的标识方案值，然后单击“更新”。
						<li>单击“搜索”。
						</ol>
						<a name="tmodel"></a>
						<h2>“tModel”选项卡</h2>
						使用该选项卡按名称、作为分类依据的类别或者标识方案来搜索 tModel。可以使用任一或所有字段来优化搜索。<p>
						例如，要查找已被分类为 Web 服务描述语言 (WSDL) 说明的所有 tModel：
						<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。
						<li>单击“tModel”选项卡。
						<li>单击“添加类别”。
						<li>选择“uddi.org:types”类别方案。
						<li>选则“这些类型面向 tModel”，选择“Web 服务规范”，然后选则“WSDL 中描述的 Web 服务规范”。
						<li>单击“添加类别”。
						<li>单击“搜索”。
						</ol>
						现在已经了解了如何<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”中</uddi:ContentController>搜索信息，可以根据自己的需要阅读<a href="search.searchbycategory.aspx">如何使用“按类别浏览”来搜索</a>、<a href="search.searchforservices.aspx">如何搜索服务</a>、<a href="search.searchforproviders.aspx">如何搜索提供程序</a>或<a href="search.searchfortmodels.aspx">如何搜索 tModel</a>。

					</p>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

