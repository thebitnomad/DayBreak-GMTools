

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
					<H1>如何刪除實體</H1>
					<p>
						您可刪除任何您已發行的提供者、連絡人、服務、連結、例項資訊或 tModel；您無法刪除其他發行者所擁有的實體。</p>
						
						<uddi:ContentController Runat='server' Mode='Private'>
							<p>若要刪除來自其他發行者的資訊，請與「UDDI 服務協調員」連絡。</p>
						</uddi:ContentController>
						
					<!-- #include file = "warning.changestouddi.htm" -->
					<h2><a name="#delete"></a>刪除實體</h2>
					<OL>
						<li>
							在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>尋找您要刪除的實體，在它們的名稱旁邊按一下 [刪除]，再按 [確定]。</LI>
					</OL>
					<p>若要刪除其他的提供者、連絡人、服務、連結、例項資訊或 tModel，請<a href="#delete">重複此程序</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

