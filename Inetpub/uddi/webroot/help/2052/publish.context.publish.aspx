

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
					<H1><img src="..\..\images\my_uddi.gif" height="16" width="16" alt="我的 UDDI"> 我的 UDDI</H1>
					“我的 UDDI”选项卡是 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>中的起始点。<uddi:ContentController Runat='server' Mode='Public'> UDDI。</uddi:ContentController>选择“提供者”或“tModel”选项卡管理和查看提供者或 tModel。 <uddi:ContentController Runat='server' Mode='Private'>
					<P>
					如果您还不熟悉如何在“UDDI&nbsp;发布”中发布，请参阅“UDDI 服务”中的<a href="publish.publishinuddiservices.aspx">发布简介</a>。</uddi:ContentController>
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

