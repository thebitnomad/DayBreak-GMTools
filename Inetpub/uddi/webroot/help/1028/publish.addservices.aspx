

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
					<H1>如何發行服務 - <img src="../../images/service.gif" width="16" height="16" alt="服務" border="0"></H1>
					<p>
						服務代表您要<uddi:ContentController Runat='server' Mode='Private'>在「UDDI 服務」中</uddi:ContentController>發行的 XML (可延伸標記語言) 網頁服務。服務可以有多種執行方式，且每種執行方式都由連結代表。</p>
					<!-- #include file = "warning.changestouddi.htm" --> <b>跳至：</b> <a href="#service">新增服務</a>及<a href="#categories">新增類別</a>。
					<h2><a name="service"></a>新增服務</h2>
					這個項目代表您<uddi:ContentController Runat='server' Mode='Private'>在「UDDI 服務」中</uddi:ContentController>發行的服務。
					<OL>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找您要新增服務的提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [服務] 索引標籤。
						<li>按一下 [新增服務]。<BR><img src="../../images/service.gif" width="16" height="16" alt="服務" border="0"> (新的服務) 即會出現。
						<LI>
							在詳細資料區域中，按一下 [編輯]。
						<LI>
							在 [語言] 清單中，選取此名稱的語言。</LI>
						<LI>
							在 [名稱] 中，輸入此服務的名稱。</LI>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增使用其他語言的名稱，則按一下 [新增名稱] 並重覆步驟 7 至步驟 9。</li>
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，選取此描述的語言。
						<LI>
							在 [描述] 中，鍵入簡要描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增使用其他語言的語言，請重覆步驟 11 至 14。</LI>
					</OL>
					<a name="#categories"></a>
					<h2>新增類別</h2>
					類別描述這個服務，如其提供的功能、地理位置、標準企業類別或其他適當的類別。對於<uddi:ContentController Runat='server' Mode='Private'>「UDDI 服務」中</uddi:ContentController>的最佳發現，則會使用您期望其他人在搜尋服務 (與您的服務類似) 時所用的類別來描述您的服務。
					<OL>
						<li>
							按一下 [類別] 索引標籤。
						<li>
							按一下 [新增類別]。</li>
						<li>
							選取適當的分類配置及子類別。<br>
							</li>
						<li>
							按一下 [新增類別]。</li>
						<li>
							若要新增其他類別，請重覆步驟 2 至 5。</li>
					</OL>
					<p>
						您現已新增並描述了服務，且準備<a href="publish.addbindings.aspx">新增連結</a>至服務。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

