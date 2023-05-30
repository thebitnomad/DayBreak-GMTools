

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
					<h1>搜尋<img src="..\..\images\business.gif" heigh="16" width="16" alt="提供者"> 提供者</h1>
					使用 [提供者] 索引標籤，依據名稱、類別、識別配置，或它們所參照的 tModel 來尋找提供者。您可用任何或所有欄位來精簡搜尋。當您已準備就緒執行搜尋時，請按一下 [搜尋]。
					<UL>
						<li>
							<b>提供者名稱：</b>輸入您要尋找的提供者名稱。如果您僅知道部份名稱，則可以使用 <b>%</b> 作為萬用字元。
							<p>
							例如，若要搜尋名稱以 an 開頭的提供者，則請輸入 <b>an</b>。若要搜尋含有字母 an 的提供者名稱，則請輸入 <b>%an%</b>。
						</li>
						<li>
							<b>類別：</b>新增一或多個定義並描述您要尋找之提供者類型的類別。搜尋僅傳回那些在所有您已指定的類別下定義的提供者。
							<UL>
								<LI>按一下 [新增類別]，將類別新增至搜尋條件。</LI>
								<LI>按一下 [刪除] 以從搜尋條件中移除類別。</LI>
							</ul>
						</li>
						<li>
							<b>識別項：</b>新增一或多個與您要尋找的提供者相關的識別配置。搜尋僅傳回那些已發行所有您指定之識別項的提供者。
							<UL>
								<LI>按一下 [新增識別項]，將識別項新增至搜尋條件。</LI>
								<LI>按一下 [刪除]，從搜尋條件中移除識別項。</LI>
							</ul>
						</li>
						<li>
							<b>tModel：</b>新增一或多個您要尋找的提供者所參照的 tModel。搜尋僅傳回那些發行所有您已指定之 tModel 的提供者。
							<UL>
								<LI>按一下 [新增 tModel]，將 tModel 新增至搜尋條件。</LI>
								<LI>按一下 [刪除]，從搜尋條件中移除 tModel。</LI>
							</ul>
						</li>
					</UL>
					<h3>更多資訊</h3>
					<ul>
						<li><!-- #include file = "glossary.categorization.htm" -->
						<li><!-- #include file = "glossary.identifier.htm" -->
						<li><!-- #include file = "glossary.tmodel.htm" -->
					</ul>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 