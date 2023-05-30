

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Big5">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-TW">
		<!-- #include file = "search.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "search.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者"> 提供者 - 詳細資料</h1>
					使用 [詳細資料] 索引標籤來管理此提供者的名稱及描述。
					<UL>
						<li>
							<b>擁有者：</b> 顯示擁有此提供者之使用者的名稱。
						</li>
						<li>
							<b>提供者金鑰：</b>顯示指派給此提供者的唯一識別碼。在程式設計查詢期間會使用它。
						</li>
						<li>
							<b>名稱：</b> 列出此提供者的名稱。如果提供多個名稱，則清單頂端會出現預設名稱。
							</li>
						<li>
							<b>描述：</b> 列出此提供者的描述及撰寫每個描述的語言。
						</li>
					</UL>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.provider.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 