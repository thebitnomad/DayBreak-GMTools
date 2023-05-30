

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
				<p><b>附註：</b>您必須是「UDDI 服務系統管理員」才能將資料匯入「UDDI 服務」。<p>
				
				您可以使用 [資料匯入]，將類別配置或其他適當資料匯入「UDDI 服務」。您匯入的任何資訊必須首先根據適當的 XML 架構定義 (XSD) 進行驗證。匯入資料及取得驗證之適當 XSD 的相關資訊，請參閱 <a href="http://go.microsoft.com/fwlink/?linkid=5202&clcid=0x409" target="_blank">UDDI資源</a>。
				<p class="to">匯入 XML 資料</p>
				<ol>
					<li>在 [UDDI 服務] 功能表上，按一下 [協調]。
					<li>按一下 [資料匯入]。
					<li>按一下 [瀏覽]，再尋找包含您要匯入的資料之 XML 檔案。
					<li>按一下 [開啟]，再按 [匯入]
				</ol>
				<B>附註：</B>若要匯入大型資料檔案，請參閱「UDDI 服務 MMC 嵌入式管理單元說明」以取得使用命令列匯入工具的相關資訊。 
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

