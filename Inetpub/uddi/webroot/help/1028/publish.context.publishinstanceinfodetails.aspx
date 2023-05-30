

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
					<h1><img src="..\..\images\instance.gif" height="16" width="16" alt="例項資訊">例項資訊 - 詳細資料</h1>
					使用 [詳細資料] 索引標籤，來檢視或修改此例項資訊的名稱及描述。
					<UL>
						<li>
							<b>介面 tModel：</b>此例項資訊參照之 tModel 的名稱。
						</li>
						<li>
							<b>tModel 金鑰：</b>顯示與此例項資訊參照之 tModel 相關的唯一識別碼。在程式設計查詢期間會使用它。
						</li>
						<li>
							<b>描述：</b> 列出此例項資訊的描述及撰寫每個描述的語言。
						</li>
						<ul>
							<li class="action">
								按一下 [新增描述]，以新增描述。
							</li>
							<li class="action">
								按一下 [編輯] 以修改描述。
							</li>
							<li class="action">
								按一下 [刪除] 以刪除描述。
							</li>
						</ul>
					</UL>
					<H3>更多資訊</H3>
					
						<!-- #include file = "glossary.instanceinfo.htm" -->
					
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 