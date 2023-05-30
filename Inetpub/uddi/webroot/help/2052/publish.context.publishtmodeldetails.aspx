

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
					<h1><img src="../../images/tmodel.gif" alt="tModel" height="16" width="16"> tModel - 详细信息</h1>
					使用“详细信息”选项卡查看和管理该 tModel 的名称和描述。
					<UL>
						<li>
							<b>所有者：</b>显示拥有该实体的用户名称。
						</li>
						<li>
							<b>tModel 密钥：</b>显示在编程查询过程中使用的与该 tModel 相关的唯一密钥。
						</li>
					
						<li>
							<b>名称：</b>显示该 tModel 的名称。
							<ul>
								<li class="action">
									单击“编辑”修改该 tModel 的名称。
								</li>
							</ul>
						</li>
						<li>
							<b>描述：</b>列出该 tModel 的描述和编写每个描述使用的语言。
						</li>
						<ul>
							<li class="action">
								单击“添加描述”向该绑定中添加描述。
							</li>
							<li class="action">
								单击“编辑”修改该绑定的描述。
							</li>
							<li class="action">
								单击“删除”可以删除该绑定的描述。
							</li>
						</ul>
					</UL>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.tmodel.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 