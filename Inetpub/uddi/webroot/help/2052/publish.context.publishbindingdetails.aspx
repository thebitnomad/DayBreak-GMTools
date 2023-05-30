

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
					<h1><img src="..\..\images\binding.gif" height="16" width="16" alt="绑定">绑定 - 详细信息</h1>
					使用“详细信息”选项卡查看或修改该绑定的访问点和描述。
					<UL>
						<li>
							<b>访问点：</b>列出可以从其中访问该绑定的统一资源定位器 (URL) 及其支持的协议。
							<ul>
								<li class="action">
									单击“编辑”修改该绑定的访问点或 URL 类型。
								</li>
							</ul>
						</li>
						<li>
							<b>描述：</b>列出该绑定的描述和编写每个描述使用的语言。
						<ul>
							<li class="action">
								单击“添加描述”可以添加描述。
							</li>
							<li class="action">
								单击“编辑”可以编辑描述。
							</li>
							<li class="action">
								单击“删除”可以删除描述。
							</li>
						</ul>
						</li>
					</UL>
					<H3>更多信息</H3>					
					<!-- #include file = "glossary.binding.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 