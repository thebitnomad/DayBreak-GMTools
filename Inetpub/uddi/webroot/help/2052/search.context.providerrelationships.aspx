

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
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者">提供者 - 关系</h1>
					使用“关系”选项卡查看该提供程序与其他 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>提供者之间的发布关系。
					<UL>
						<li>
							<b>关系：</b>列出与其他提供程序的发布关系。列出每个项目的提供程序名称、关系的方向和关系的类型。
							</li>
					</UL>
					<br>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.relationship.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

