

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
					<H1>如何发布服务 - <img src="../../images/service.gif" width="16" height="16" alt="服务" border="0"></H1>
					<p>
						服务表示要在 <uddi:ContentController Runat='server' Mode='Private'>UDDI 服务</uddi:ContentController>中发布的 XML（可扩展标记语言）Web 服务。一个服务可以有多个实现，每个实现都由一个绑定来表示。</p>
					<!-- #include file = "warning.changestouddi.htm" --> <b>转到：</b><a href="#service">添加服务</a>、<a href="#categories">添加类别</a>。
					<h2><a name="service"></a>添加服务</h2>
					该项目表示要在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>中发布的服务。
					<OL>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>查找要向其中添加服务的提供者，请单击服务名称旁边的“查看”。
						<li>单击“服务”选项卡。
						<li>单击“添加服务”。<BR>出现 <img src="../../images/service.gif" width="16" height="16" alt="服务" border="0">（新建服务）。
						<LI>
							在详细信息区域中，单击“编辑”。
						<LI>
							在“语言”列表中，选择该名称的语言。</LI>
						<LI>
							在“名称”中，键入该服务的名称。</LI>
						<li>
							单击“更新”。</li>
						<li>
							要用其他语言添加其他名称，请单击“添加名称”，然后重复第&nbsp;7 步到第&nbsp;9 步。</li>
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中键入简要描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复第&nbsp;11 步到第&nbsp;14 步。</LI>
					</OL>
					<a name="#categories"></a>
					<h2>添加类别</h2>
					类别描述该服务，如它所提供的功能、地理位置、标准业务分类或任何其他适用的类别。为了在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>中获取最佳搜索功能，请使用希望其他人在像您那样搜索时使用的类别来描述您的服务。
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
					<p>
						您已经添加和描述了服务并且可以向服务中<a href="publish.addbindings.aspx">添加绑定</a>了。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

