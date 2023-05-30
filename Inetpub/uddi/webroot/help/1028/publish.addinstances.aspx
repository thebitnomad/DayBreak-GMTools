

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
					<H1>如何新增例項資訊 - <img src="../../images/instance.gif" width="16" height="16" alt="例項資訊" border="0"></H1>
					例項資訊是 tModel 的參照，其中包含有關連結的相關技術資訊。例如，您可能建立了 tModel 的參照，該參照代表介面規格文件或「網頁服務描述語言 (WSDL)」檔案，其中描述連結所支援的慣例或功能。</p>

					<!-- #include file = "warning.changestouddi.htm" --> <b>跳至：</b> <a href="#instance">新增例項資訊</a>、<a href="#parameter">新增例項參數</a>、<a href="#overview">新增概觀文件 URL</a>。
					<h2><a name="#instance"></a>新增例項資訊</h2>
					<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找擁有包含您要新增例項資訊之連結的服務提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [服務] 索引標籤。
						<li>尋找包含您要新增例項資訊之連結的服務，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [連結] 索引標籤。
						<li>尋找您要新增例項資訊的連結，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [例項資訊] 索引標籤。
						<li>按一下 [新增例項資訊]。</li>
						<li>
							輸入您要參照之 tModel 的全部或部份名稱，再按一下 [搜尋]。<br>顯示與您的條件相符之 tModels 清單。</li>
						<li>
							選取您要建立例項的 tModel。
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，選取此描述的語言。
						<LI>
							在 [描述] 中，輸入此例項資訊的描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增以其他語言進行的描述，請重覆步驟 12 至 15。</LI>
					</ol>
					<a name="parameter"></a>
					<h2>新增例項參數</h2>
					例項參數是此 tModel 的這個例項支援之唯一參數。
					<ol>
						<LI>
							按一下 [例項詳細資料] 索引標籤。
						<li>
							按一下 [編輯]。
						<LI>
						在 [例項參數] 中，輸入此例項支援的參數，或描述此例項資訊所支援參數的文件之 URL。 
						<li>
							按一下 [更新]。</li>
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，選取此描述的語言。
						<LI>
							在 [描述] 中，輸入此例項參數的描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增以其他語言進行的描述，請重覆步驟 5 至 8。</LI>
					</ol>
					<a name="overview"></a>
					<h2>新增概觀文件 URL</h2>
					概觀文件 URL 識別包含此例項之詳細技術資料的檔案位置&mdash;例如，WSDL (網頁服務描述語言) 或 XML (可延伸標記語言) 網頁服務定義檔案。
					<ol>
						<LI>
							按一下 [概觀文件 URL] 索引標籤。
						<li>
							按一下 [編輯]。
						<LI>
							指定能找到此例項之概觀文件的 URL。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，選取此描述的語言。
						<LI>
							在 [描述] 中，鍵入此概觀文件的描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增以其他語言進行的描述，請重覆步驟 5 至 8。</LI>
					</ol>
					<p>若要發行其他例項資訊，請<a href="#instance">重覆這些程序</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

