

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
					<H1>統計 - 發行者統計</H1>
					使用 [發行者統計] 索引標籤來檢視發行者的總人數，含使用中之發行集的發行者數，及每一種不同類型實體之最前面的發行者。顯示的統計依據以螢幕底端、[上次重新計算] 旁邊顯示之日期累積的資料，且不會自動重新整理。
					
					<UL>
					<LI><B>統計資料</B>&nbsp;&nbsp;列示發行者的總數及在此「UDDI 服務」的安裝中含作用中之發行集的發行者數量。含作用中之發行集的發行者是至少已發行了一位提供者或 (未隱藏) tModel 的任何發行者。
					<LI><B>實體類型</B>&nbsp;&nbsp;每一種不同實體類型中最前面的發行者，每種類型最多為 10 個，以遞減排序列示。</LI>
					</UL>
					<ul class="action">
						<li>按一下 [重新計算] 以重新整理所有統計。
					</ul>
					
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

