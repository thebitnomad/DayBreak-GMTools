

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
					<H1>如何添加绑定 - <img src="../../images/binding.gif" width="16" height="16" alt="绑定" border="0"></H1>
					绑定表示可以在其中访问所实现的服务的点。如果服务有多个访问点，请为每个访问点添加一个绑定。一个绑定总是包括一个访问点和一个描述如何使用服务的说明。它还可以包括一个或多个实例信息，这些信息是对包含有关该绑定的相关技术信息的 tModel 的引用。<!-- #include file = "warning.changestouddi.htm" -->
						<h2><a name="#binding"></a>添加绑定</h2>
						<ol>
							<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
							<li>单击“提供者”选项卡。
							<li>要查找包含了要将绑定添加到其中的服务的提供者，请在绑定名称旁边单击“查看”。
							<li>单击“服务”选项卡。
							<li>查找要向其中添加绑定的服务，在其名称旁边单击“查看”。
							<li>单击“绑定”选项卡。
							<li>单击“添加绑定”。<BR>出现 <img src="../../images/binding.gif" width="16" height="16" alt="绑定" border="0"> http://。 
							<LI>
								在“详细信息”选项卡中，单击“编辑”。
							<LI>
								在“访问点”中，键入访问点的 URL。</LI>
							<li>
								在“URL 类型”列表中，单击该访问点支持的协议。</li>
							<li>
								单击“更新”。</li>
							<LI>
								单击“添加描述”。
							<LI>
								在“语言”列表中，选择该描述的语言。
							<LI>
								在“描述”中键入简要描述。</LI>
							<li>
								单击“更新”。</li>
							<LI>
								要用其他语言添加其他描述，请重复步骤&nbsp;12 到步骤&nbsp;15。</LI>
						</ol>
					<p></p>
					现在已经向服务中添加了绑定。<a href="#binding">重复这些步骤</a>可以发布其他绑定或向绑定中<a href="publish.addinstances.aspx">添加实例信息</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

