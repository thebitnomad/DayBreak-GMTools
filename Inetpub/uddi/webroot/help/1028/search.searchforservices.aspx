

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
			<tr valign="top">
				<td>
					<H1>如何搜尋服務 - <img src="..\..\images\service.gif" heigh="16" width="16" alt="服務"></H1>
					<p>
						透過使用 [搜尋] 中的 [服務] 索引標籤，依據名稱、類別或相關的 tModel，您可以在「<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>」中搜尋服務。</p>
						<p class="to">搜尋服務</p>
					<OL>
						<li>
							在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。</li>
						<li>
							按一下 [服務] 索引標籤。</li>
						<li>
							使用提供用來精簡搜尋的欄位。搜尋結果僅包括那些與指定之所有條件相符的服務。
							<ul>
								<li>
									<b>服務名稱：</b>在 [服務名稱] 中，輸入您要搜尋的服務名稱。如果您僅知道部份名稱，則可以使用 % 作為萬用字元。<br>例如，若要搜尋以 an 開頭的服務名稱，則請輸入 <b>an</b>。若要搜尋含有字母 an 的服務名稱，則請輸入 <b>%an%</b>。
								</li>
								<li>
									<b>類別：</b>新增定義您要搜尋之服務類型的類別。搜尋僅傳回那些在所有您已指定的類別下定義的服務。 
									<ol>
									<LI>按一下 [新增類別]</li>
									<LI>選取定義您正搜尋之服務類型的類別，再按一下 [新增類別]
									</ol>
								</li>
								<li>
									<b>tModel：</b>新增您正搜尋的服務所使用的 tModel。搜尋僅傳回那些發行所有指定之 tModel 的服務。
									<OL>
										<LI>按一下 [新增 tModel]。</LI>
										<LI>鍵入您要新增之 tModel 的全部或部份名稱，再按一下 [搜尋]。</LI>
										<LI>選取您要新增的 tModel。</li>
									</OL>
								</li>
							</ul>
						</li>
						<li>
							在您已定義了搜尋條件並準備執行搜尋之後，請按一下 [搜尋]。<br>
						</li>
							<li>若要檢視實體的詳細資料，請在清單中按一下其名稱。檢視及瀏覽該實體以及任何相關實體的屬性。</li>
					</OL>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

