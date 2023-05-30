

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Big5">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-TW">
		<!-- #include file = "publish.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "publish.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<H1><img src="../../images/tmodel.gif" alt="tModel" height="16" width="16"> tModels</H1>
					使用 [tModels] 索引標籤來管理您現有的 tModel 或新增一個。
					<UL>
						<li>
							<b>tModel：</b>列出您已在「<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>」中發行的 tModel 名稱。
							<ul>
								<li class="action">
									按一下 [新增 tModel] 來增加新的 tModel。
								</li>
								<li class="action">
									按一下 [檢視] 來檢視 tModel 的屬性。
								</li>
								<li class="action">
									按一下 [刪除] 以永遠刪除 tModel。
								</li>
								
							</ul>
						</li>
					</UL>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.tmodel.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

