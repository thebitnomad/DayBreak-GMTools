

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
					<H1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者"> 提供者</H1>
					使用 [提供者] 標籤來管理您現有的提供者或新增新的提供者。
					<UL>
						<li>
							<b>提供者</b> 列出您已<uddi:ContentController Runat='server' Mode='Private'>在「UDDI 服務」中</uddi:ContentController>發行的提供者名稱。
							<ul>
								
								<li class="action">
									按一下 [新增提供者] 以新增新的提供者。
								</li>
								<li class="action">
									按一下 [檢視] 以檢視提供者的屬性。
								</li>
								<li class="action">
									按一下 [刪除] 以永久刪除提供者。
								</li>
							</ul>
						</li>
					</UL>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.provider.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

