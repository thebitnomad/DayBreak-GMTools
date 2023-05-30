

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
					<H1><img src="../../images/tmodel.gif" alt="tModel" height="16" width="16"> tModel</H1>
					使用“tModel”选项卡管理现有的 tModel 或添加新的 tModel。
					<UL>
						<li>
							<b>tModel：</b>列出已<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”中</uddi:ContentController>发布的 tModel 的名称。
							<ul>
								<li class="action">
									单击“添加 tModel”添加一个新 tModel。
								</li>
								<li class="action">
									单击“查看”可以查看 tModel 的特性。
								</li>
								<li class="action">
									单击“删除”永久删除 tModel。
								</li>
								
							</ul>
						</li>
					</UL>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.tmodel.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

