

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
					<H1>統計 - 分類統計</H1>
					使用 [分類統計] 索引標籤來檢視可用的分類配置及它們包含的類別數。顯示的統計依據以螢幕底端、[上次重新計算] 旁邊顯示之日期累積的資料，且不會自動重新整理。 
					<UL>
					<LI><B>前 10 個分類配置</B> 列出 10 個參照最頻繁的類別或子類別，以及每個的參照數。 </LI>
					<ul class="action">
						<li>按一下 [重新計算] 以重新整理所有統計。
					</ul>
					</UL>
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 