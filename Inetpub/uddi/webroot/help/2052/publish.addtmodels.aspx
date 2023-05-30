

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
					<H1>如何添加 tModel</H1>
					<p>tModel 可以表示类别方案、名称空间、协议、签名组件、Web 规范、在 WSDL（Web 服务描述语言）还是 XML（可扩展标记语言）中、标识方案。您还可以使用 tModel 来描述要发布的实体（提供者、tModel、服务、绑定或实例信息）或对其进行分类。</p>
					<p>要添加 tModel，必须首先创建一个 tModel 项目，然后可以用任何适用的语言为其指派一个唯一名称和描述。然后可以添加一个或多个标识符，并指定用于描述 tModel 的功能的类别，例如：地理位置、所提供服务的类型、业务类别或其他适用的类别。当完成 tModel 的定义时，指定一个概述文档 URL，它是包含有关该 tModel 的描述性信息的文件所在的位置。
					</p>
					<b>转到：</b><a href="#tmodel">添加 tModel</a>、<a href="#categories">添加类别</a>、<a href="#overview">指定概述文档 URL</a>。 <!-- #include file = "warning.changestouddi.htm" -->
					<h2><a name="tmodel"></a>添加 tModel</h2>
					<OL>
						<li>
							在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。
						<li>
							单击“tModel”选项卡。</li>
							单击“添加 tModel”。<br>出现一个新 tModel 项目 <img src="../../images/tmodel.gif" width="16" height="16" alt="" border="0"> <font color="#444444">（新 tModel）</font>。
						<LI>
							在详细信息区域中，请单击“编辑”。
						<LI>
							在“tModel 名称”中，键入该 tModel 的唯一名称。
						</LI>
						<li>
							单击“更新”。</li>
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中，键入该 tModel 的简要说明。
						</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复步骤&nbsp;6 到步骤&nbsp;9。</LI>
					</OL>
					<a name="#categories"></a>
					<h2>添加类别</h2>
					类别用来描述该 tModel 及其所标识的功能，如类别方案或接口类型。
					<OL>
						<li>
							单击“类别”选项卡。
						<li>
							单击“添加类别”。</li>
						<li>
							选择合适的类别方案和子类别。<br>
							</li>
						<li>
							单击“添加类别”。</li>
						<li>
							要添加其他分类，请重复步骤&nbsp;2 到步骤&nbsp;5。</li>
					</OL>
					<a name="overview"></a>
					<h2>指定概述文档 URL</h2>
					概述文档 URL 提供包含与该 tModel 相关的其他信息或资源的文件所在的位置。例如，它可能包含 WDSL（Web 服务描述语言）文件或其他接口描述。
					<ol>
						<LI>
							单击“概述文档 URL”选项卡。
						<li>
							单击“编辑”。
						<LI>
							指定可以在其中找到该 tModel 的概述文档的 URL。<br>例如：<a class="code">http://www.wideworldimporters.com/SampleWebService.asmx</a>。</LI>
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
					<p></p>
					现在已经<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”</uddi:ContentController>中发布了 tModel。<a href="#tmodel">重复这些步骤</a>以发布其他 tModel。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

