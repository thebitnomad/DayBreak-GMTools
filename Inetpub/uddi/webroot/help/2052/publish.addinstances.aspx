

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "publish.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "publish.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<H1>如何添加实例信息 - <img src="../../images/instance.gif" width="16" height="16" alt="实例信息" border="0"></H1>
					实例信息是对包含有关绑定的相关技术信息的 tModel 的引用。例如，您可以创建一个对 tModel 的引用，该引用代表用于描述绑定所支持的约定或功能的接口规范文档或 Web 服务描述语言 (WSDL) 文件。</p>

					<!-- #include file = "warning.changestouddi.htm" --> <b>转到：</b><a href="#instance">添加实例信息</a>、<a href="#parameter">添加实例参数</a>、<a href="#overview">添加概述文档 URL</a>。
					<h2><a name="#instance"></a>添加实例信息</h2>
					<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>查找拥有某个服务而该服务又包含要向其中添加实例信息的绑定的提供者，请单击实例信息名称旁边的“查看”。
						<li>单击“服务”选项卡。
						<li>要查找包含了要将实例信息添加到其中的绑定的服务，请单击实例信息名称旁边的“查看”。
						<li>单击“绑定”选项卡。
						<li>查找要向其中添加实例信息的绑定，请单击实例信息名称旁边的“查看”。
						<li>单击“实例信息”选项卡。
						<li>单击“添加实例信息”。</li>
						<li>
							键入要引用的 tModel 的全称或部分名称，然后单击“搜索”。<br>出现与您的标准相匹配的 tModel 列表。</li>
						<li>
							选择要为其创建实例的 tModel。
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中，输入该实例信息的描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复步骤&nbsp;12 到步骤&nbsp;15。</LI>
					</ol>
					<a name="parameter"></a>
					<h2>添加实例参数</h2>
					实例参数是该 tModel 的该实例所支持的唯一参数。
					<ol>
						<LI>
							单击“实例详细信息”选项卡。
						<li>
							单击“编辑”。
						<LI>
						在“实例参数”中，键入该实例所支持的参数或用于描述该实例信息所支持的参数的文档的 URL。 
						<li>
							单击“更新”。</li>
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中，键入该实例参数的描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复步骤&nbsp;5 到步骤&nbsp;8。</LI>
					</ol>
					<a name="overview"></a>
					<h2>添加概述文档 URL</h2>
					概述文档 URL 标识包含有关该实例的技术详细信息的文件的位置，例如，WSDL（Web 服务描述语言）或 XML（可扩展标记语言）Web 服务定义文件。
					<ol>
						<LI>
							单击“概述文档 URL”选项卡。
						<li>
							单击“编辑”。
						<LI>
							指定可以在其中找到该实例的概述文档的 URL。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中，键入该概述文档的描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复步骤&nbsp;5 到步骤&nbsp;8。</LI>
					</ol>
					<p>要发布其他实例信息，请<a href="#instance">重复这些步骤</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

