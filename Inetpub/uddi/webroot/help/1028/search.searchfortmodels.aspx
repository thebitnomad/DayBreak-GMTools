

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
					<H1>如何搜尋 tModel - <img src="..\..\images\tmodel.gif" heigh="16" width="16" alt="tModel"> </H1>
					<p>
						透過使用 [搜尋] 中的 [tModels] 索引標籤，依據名稱、類別及其唯一識別項，您可以在「<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>」中搜尋 tModel。</p>
						<p class="to">搜尋 tModel</p>
					<OL>
						<li>
							在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。</li>
						<li>
							按一下 [tModels] 索引標籤。</li>
						<li>
							使用提供用來精簡搜尋的欄位。搜尋結果僅包括那些與指定之所有條件相符的 tModel。
							<ul>
								<li>
									<b>tModel 名稱：</b>在 [tModel 名稱] 中，輸入您要搜尋的 tModel 名稱。如果您僅知道部份名稱，則可以使用 % 作為萬用字元。<br>例如，若要搜尋以 an 開頭的 tModel 名稱，則請輸入 <b>an</b>。若要搜尋含有字母 an 的 tModel 名稱，則請輸入 <b>%an%</b>。
								</li>
								<li>
								<b>類別：</b>新增定義您要搜尋之 tModel 類型的類別。搜尋僅傳回您指定之類別所分類的那些提供者。
									<ol>
									<LI>按一下 [新增類別]</li>
									<LI>選取定義您正搜尋之 tModel 類型的類別，再按一下 [新增類別]
									</ol>
								
								</li>
								<li>
								<b>識別項：</b>新增與您正搜尋之 tModel 相關的識別項。搜尋僅傳回那些與所有指定之識別項相關的 tModel。
									<ol>
									<LI>按一下 [新增識別項]。
									<LI>選取代表搜尋依據之識別配置的 tModel。 
									<LI>在 [機碼名稱] 中，鍵入搜尋依據之識別項的名稱。 
									<LI>在 [機碼值] 中，鍵入搜尋依據之識別項的值。 
									<LI>按一下 [更新]。 
									</ol>

								</li>
							</ul>
						</li>
						<li>
							一旦您已定義了搜尋條件並準備執行搜尋時，請按一下 [搜尋]。<br>
						</li>
						<li>若要檢視實體的詳細資料，請在清單中按一下其名稱。檢視及瀏覽該實體以及任何相關實體的屬性。
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

