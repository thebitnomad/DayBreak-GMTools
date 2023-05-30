

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
					<H1>如何搜尋提供者 - <img src="..\..\images\business.gif" heigh="16" width="16" alt="提供者"></H1>
					<p>
						透過使用 [搜尋] 中的 [提供者] 索引標籤，您可以依據名稱、類別、識別項，或依據相關的 tModel 來搜尋提供者。
						<p class="to">搜尋提供者</p>
					</p>
					<OL>
						<li>
							在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。</li>
						<li>
							按一下 [提供者] 索引標籤。
						<li>
							完成一或多個搜尋選項，如下所示：
							<ul>
								<li>
									<b>提供者名稱：</b>在 [提供者名稱] 中，輸入您要尋找的提供者名稱。如果您僅知道部份名稱，則可以使用 % 作為萬用字元。<br>例如，若要搜尋以 an 開頭的提供者名稱，則請輸入 <b>an</b>。若要搜尋含有字母 an 的提供者名稱，則請輸入 <b>%an%</b>。
								</li>
								<li>
									<b>類別：</b>新增定義您要尋找之提供者類型的類別。搜尋僅傳回您指定之類別所分類的那些提供者。
									<ol>
									<LI>按一下 [新增類別]</li>
									<LI>選取定義您正搜尋之提供者類型的類別，再按一下 [新增類別]
									</ol>
								</li>
								<li>
									<b>識別項：</b>新增與您正搜尋之提供者相關的識別項。搜尋僅傳回那些發行所有指定之識別項的提供者。

									<ol>
									<LI>按一下 [新增識別項]。
									<LI>選取代表搜尋依據之識別配置的 tModel。 
									<LI>在 [機碼名稱] 中，鍵入搜尋依據之識別項的名稱。 
									<LI>在 [機碼值] 中，鍵入搜尋依據之識別項的值。 
									<LI>按一下 [更新]。 
									</ol>
								</li>
								<li>
									<b>tModel：</b>新增您正搜尋的提供者所使用的 tModel。搜尋僅傳回那些發行所有指定之 tModel 的提供者。
									<OL>
										<LI>按一下 [新增 tModel]。</LI>
										<LI>鍵入您要新增之 tModel 的全部或部份名稱，再按一下 [搜尋]。</LI>
										<LI>選取您要新增的 tModel。</li>
									</OL>

								</li>
							</ul>
						</li>
						<li>
							一旦您已定義了搜尋條件並準備執行搜尋時，請按一下 [搜尋]。<br>
						</li>
						<li>若要檢視實體的詳細資料，請在清單中按一下其名稱。然後，您可以檢視並瀏覽該實體及任何相關實體的屬性。
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

