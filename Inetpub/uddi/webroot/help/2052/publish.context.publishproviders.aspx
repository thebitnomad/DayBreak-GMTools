

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
					<H1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者">提供者</H1>
					使用“提供者”选项卡管理现有的提供者或添加新的提供者。
					<UL>
						<li>
							<b>提供者：</b>列出已<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”中</uddi:ContentController>发布的提供程序的名称。
							<ul>
								
								<li class="action">
									单击“添加提供者”添加一个新提供者。
								</li>
								<li class="action">
									单击“查看”可以查看提供程序的特性。
								</li>
								<li class="action">
									单击“删除”永久删除提供程序。
								</li>
							</ul>
						</li>
					</UL>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.provider.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

