

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
					<H1>如何修改数据</H1>
					<p>
						您可以修改您发布的任何提供程序、联系人、服务、绑定、实例信息或 tModel；但不能修改其他发布者拥有的数据。</p>
						
						<uddi:ContentController Runat='server' Mode='Private'>
							<p>要修改其他发布者的信息，请与“UDDI&nbsp;服务”协调员联系。</p>
						</uddi:ContentController>
						
					<!-- #include file = "warning.changestouddi.htm" -->
					<h2><a name="#modify"></a>修改实体</h2>
					<OL>
						<li>
							在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>查找并选择要修改的实体。</li>
						<li>
						在详细信息区域中，单击相应的选项卡，然后单击要修改的特性旁边相应的操作（“添加”、“编辑”或“删除”）。 </LI>
						
					</OL>
					<p>要修改其他提供程序、联系人、服务、绑定、实例信息或 tModel，请<a href="#modify">重复该步骤</a>。
						
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

