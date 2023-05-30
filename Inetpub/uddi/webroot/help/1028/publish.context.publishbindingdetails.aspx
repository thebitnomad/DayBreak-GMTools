

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
					<h1><img src="..\..\images\binding.gif" height="16" width="16" alt="連結">連結 - 詳細資料</h1>
					使用 [詳細資料] 索引標籤，來檢視或修改此連結的存取點及描述。
					<UL>
						<li>
							<b>存取指標：</b>列出您可以存取此連結及其支援之通訊協定的 Uniform Resource Locator (URL)。
							<ul>
								<li class="action">
									按一下 [編輯]，以修改此連結的存取點或 URL 類型。
								</li>
							</ul>
						</li>
						<li>
							<b>描述：</b>列出此連結的描述及撰寫每個描述的語言。
						<ul>
							<li class="action">
								按一下 [新增描述]，以新增描述。
							</li>
							<li class="action">
								按一下 [編輯] 以編輯描述。
							</li>
							<li class="action">
								按一下 [刪除] 以刪除描述。
							</li>
						</ul>
						</li>
					</UL>
					<H3>更多資訊</H3>					
					<!-- #include file = "glossary.binding.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 