

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
					<h1><img src="..\..\images\service.gif" height="16" width="16" alt="服务">服务 - 详细信息</h1>
					使用“详细信息”选项卡查看和管理该服务的名称和描述。
					<UL>
						<li>
							<b>服务密钥：</b>显示在编程查询过程中使用的与该站点相关的唯一密钥。
						</li>
						
						<li>
							<b>名称：</b>显示该服务的名称以及编写每个名称时使用的语言。
							<ul>
								<li class="action">
									单击“编辑”修改该服务的名称。
								</li>
								<li class="action">
									单击“添加名称”以其他语言为该服务添加名称。
								</li>
								<li class="action">
									单击“删除”可以删除该服务的名称。不能删除服务的最后一个名称。
								</li>

							</ul>
						</li>
						<li>
							<b>描述：</b>列出该服务和编写每个描述所用的语言的说明。
						</li>
						<ul>
							<li class="action">
								单击“添加描述”向该服务中添加描述。
							</li>
							<li class="action">
								单击“编辑”修改该服务的描述。
							</li>
							<li class="action">
								单击“删除”可以删除该服务的描述。
							</li>
						</ul>
					</UL>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.service.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 