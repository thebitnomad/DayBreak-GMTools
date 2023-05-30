

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
					<h1>搜尋<img src="..\..\images\tmodel.gif" heigh="16" width="16" alt="tModel"> tModels</h1>
					使用 [tModels] 索引標籤，依據名稱、類別或識別配置來搜尋 tModel。您可用任何或所有欄位來精簡搜尋。當您已準備就緒執行搜尋時，請按一下 [搜尋]。
					<UL>
						<li>
							<b>tModel 名稱：</b>輸入您要尋找的 tModel 名稱。如果您僅知道部份名稱，則可以使用 <b>%</b> 作為萬用字元。
							<p>
							例如，若要搜尋名稱以 an 開頭的 tModel，則請輸入 <b>An</b>。若要搜尋含有字母 an 的 tModel 名稱，則請輸入 <b>%an%</b>。
						</li>
						<li>
							<b>類別：</b>新增一或多個定義並描述您要尋找之 tModel 類型的類別。搜尋僅傳回那些在所有您已指定的類別下定義的 tModel。
							<UL>
								<LI>按一下 [新增類別]，將類別新增至搜尋條件。</LI>
								<LI>按一下 [刪除] 以從搜尋條件中移除類別。</LI>
							</ul>
						</li>
						<li>
							<b>識別項：</b>新增一或多個與您要尋找的 tModel 相關的識別配置。搜尋僅傳回那些已發行所有您指定之識別項的 tModel。
							<UL>
								<LI>按一下 [新增識別項]，將識別項新增至搜尋條件。</LI>
								<LI>按一下 [刪除]，從搜尋條件中移除識別項。</LI>
							</ul>
						</li>
					</UL>
					<h3>更多資訊</h3>
					<ul>
						<li><a href="search.searchfortmodels.aspx">如何搜尋 tModel</a>
						<li><!-- #include file = "glossary.categorization.htm" -->
						<li><!-- #include file = "glossary.identifier.htm" -->
					</ul>
					
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 