

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Big5">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-TW">
		<!-- #include file = "coordinate.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "coordinate.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<H1>變更擁有者 - <img src="..\..\images\changeowner.gif" alt="變更擁有者"></H1>
					<P>作為「UDDI 服務」協調員，您可將任何提供者或 tModel 的擁有權從一個發行者轉送給另一個發行者。轉送的實體會出現在新擁有者的 [發行] 區域內，而不再出現於先前擁有者的 [發行] 區域內。 </P>
					<ul>
						<li><b>提供者：</b>或 <b>tModel：</b>列出您要變更擁有權之提供者或 tModel 的名稱。
						<li><b>目前擁有者：</b>列出此 tModel 或提供者之目前擁有者的使用者名稱。
						<li><b>搜尋包含下列項目的發行者名稱：</b>為您提供一個空格，以輸入您要向其轉送實體擁有權之發行者的整個名稱或名稱的一部份。
						<ul class="action">
						<li>按一下 [搜尋]，搜尋提供者名稱。
						<li>按一下 [取消]，取消此處理程序。
						</ul>
					</ul>
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

