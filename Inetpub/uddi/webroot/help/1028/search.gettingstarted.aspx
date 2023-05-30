

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
					<H1>搜尋簡介</H1>
					<p>
						搜尋會提供四個索引標籤&mdash;<a href="#browse">按類別瀏覽</a>、<a href="#service">服務</a>、<a href="#provider">提供者</a>，以及 <a href="#tmodel">tModels</a>&mdash;您可以使用它們來尋找網頁服務資訊。您可以根據類別、名稱、識別配置或 tModel 參照來搜尋服務、提供者或 tModel。如果您不瞭解要搜尋之實體的完整名稱，可以使用 <b>%</b> 作為萬用字元。</p>
						<p>
						當您執行搜尋時，與您搜尋條件相符的實體清單會顯示在螢幕上。若要檢視實體的詳細資料，請在清單中按一下其名稱。檢視及瀏覽該實體以及任何相關實體的屬性。例如，如果您要搜尋服務，則也可以檢視該服務的服務提供者或連結及例項資訊。若要執行新的搜尋，請在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]，然後重新啟動。
						
						</p>
						<a name="browse"></a>
						<h2>按類別瀏覽索引標籤</h2>
						使用此索引標籤來尋找已按特定類別進行分類的服務、提供者或 tModel。搜尋僅傳回那些已使用您指定的類別進行定義的服務、提供者或 tModel。<p>
						例如，若要尋找特定類別的服務：
						<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。
						<li>按一下 [依類別瀏覽] 索引標籤。
						<li>選取您搜尋所要依據的分類配置及類別，再按一下 [尋找服務]。
						</ol> 
						<a name="service"></a>
						<h2>服務索引標籤</h2>
						使用此索引標籤，依據名稱、分類它們所使用的類別，或其所參照的 tModel 來尋找服務。您可用任何或所有欄位來精簡搜尋。<p>
						例如，若要尋找支援特定介面或通訊協定的服務：
						<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。
						<li>按一下 [服務] 索引標籤。
						<li>按一下 [新增 tModel]。
						<li>輸入代表您搜尋所要依據的介面或通訊協定之 tModel 的全部或部份名稱，再按一下 [搜尋]。
						<LI>從清單中選取您搜尋所要依據的 tModel。
						<li>按一下 [搜尋]。
						</ol>
						<a name="provider"></a>
						<h2>提供者索引標籤</h2>
						使用此索引標籤，依據名稱、分類它們所使用的類別、識別配置或它們所參照的 tModel 來尋找提供者。您可用任何或所有欄位來精簡搜尋。<p>
						例如，若要尋找名稱含有字母 WS，且屬於特定執行方式或群組的全部提供者：
						<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。
						<li>按一下 [提供者] 索引標籤。
						<li>在 [提供者名稱] 欄位中輸入 <b>%WS%</b>。
						<li>按一下 [新增識別項]。
						<li>指定描述您要尋找之執行方式或群組的識別配置值，再按一下 [更新]。
						<li>按一下 [搜尋]。
						</ol>
						<a name="tmodel"></a>
						<h2>tModels 索引標籤</h2>
						使用此索引標籤，依據名稱、分類它們所使用的類別，或識別配置來搜尋 tModel。您可用任何或所有欄位來精簡搜尋。<p>
						例如，若要尋找任何已分類為「網頁服務描述語言 (WSDL)」描述的 tModel：
						<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。
						<li>按一下 [tModels] 索引標籤。
						<li>按一下 [新增類別]。
						<li>選取 <b>uddi.org:types</b> 分類配置。
						<li>依序選取 [這些類型是針對 tModel]、[網頁服務規格] 及 [WSDL 中描述之網頁服務的規格]。
						<li>按一下 [新增類別]。
						<li>按一下 [搜尋]。
						</ol>
						因為您瞭解如何搜尋<uddi:ContentController Runat='server' Mode='Private'>「UDDI 服務」</uddi:ContentController>中的資訊，所以如果您願意的話，請檢視<a href="search.searchbycategory.aspx">如何使用按類別瀏覽來搜尋</a>、<a href="search.searchforservices.aspx">如何搜尋服務</a>、<a href="search.searchforproviders.aspx">如何搜尋提供者</a>，或<a href="search.searchfortmodels.aspx">如何搜尋 tModel</a>。

					</p>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

