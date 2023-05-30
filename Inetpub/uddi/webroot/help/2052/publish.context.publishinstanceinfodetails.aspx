

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
					<h1><img src="..\..\images\instance.gif" height="16" width="16" alt="实例信息">实例信息 - 详细信息</h1>
					使用“详细信息”选项卡查看或修改该实例信息的名称和描述。
					<UL>
						<li>
							<b>接口 tModel：</b>该实例信息所引用的 tModel 的名称。
						</li>
						<li>
							<b>tModel 密钥：</b>显示与该实例信息所引用的 tModel 相关的唯一密钥。在程序查询中使用。
						</li>
						<li>
							<b>描述：</b>列出了该实例信息的描述和每个描述所用的语言。
						</li>
						<ul>
							<li class="action">
								单击“添加描述”可以添加描述。
							</li>
							<li class="action">
								单击“编辑”修改描述。
							</li>
							<li class="action">
								单击“删除”可以删除描述。
							</li>
						</ul>
					</UL>
					<H3>更多信息</H3>
					
						<!-- #include file = "glossary.instanceinfo.htm" -->
					
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 