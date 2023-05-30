

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
					<H1>匯入資料</H1>
					使用 [匯入] 索引標籤，將分類配置或其他「可延伸標記語言 (XML)」資料匯入「UDDI 服務」。您匯入的任何資訊必須首先根據適當的 XML 架構定義 (XSD) 進行驗證。匯入資料及取得驗證之適當 XSD 的相關資訊，請參閱 <a href="http://go.microsoft.com/fwlink/?linkid=5202&clcid=0x409" target="_blank">UDDI資源</a>。
					
					<ul>
						<li><b>資料檔案：</b>列出包含您要匯入之資訊的 XML 檔案位置。
						<ul class="action">
							<li>按一下 [瀏覽]，以指定包含您要匯入之資料的檔案。
							<li>按一下 [匯入]，以匯入包含在您指定之檔案中的資料。
						</ul>
					</ul>
					
					<b>附註：</b>若要匯入大型資料檔案，請參閱「UDDI 服務 Microsoft Management Console (MMC) 嵌入式管理單元說明」，以取得使用命令列匯入工具的相關資訊。
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

