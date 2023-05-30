

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
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者">提供者 - 详细信息</h1>
					使用“详细信息”选项卡管理该提供程序的名称和描述。
					<UL>
						<li>
							<b>所有者：</b>显示拥有该提供程序的用户名称。
						</li>
						<li>
							<b>提供程序密钥：</b>显示指定给该提供程序的唯一密钥。在程序查询中使用。
						</li>
						<li>
							<b>名称：</b>列出了该提供程序的名称。如果提供的名称多于一个，则默认名称显示在列表顶端。
							</li>
						<li>
							<b>描述：</b>列出了对该提供程序的描述和编写每个描述所用的语言。
						</li>
					</UL>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.provider.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 