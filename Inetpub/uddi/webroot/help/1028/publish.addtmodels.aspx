

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
					<H1>如何新增 tModel</H1>
					<p>tModel 可以代表使用 WSDL (網頁服務描述語言) 或 XML (可延伸標記語言) 的分類配置、名稱區、通訊協定、簽章元件或網頁規格，或者識別碼配置。您可以使用 tModels 來描述或分類您要發行的項目&mdash;提供者、tModel、服務、連結或「例項資訊」。</p>
					<p>若要新增 tModel，您必須先建立 tModel 項目，然後以所有適當的語言指派唯一的名稱與描述。然後，新增一或多個識別項並指定描述 tModel 功能的類別，例如：地理位置、提供的服務類型、企業類別或其他適當的類別。定義完 tModel 後，請指定作為文件 (包含此 tModel 相關的描述性資訊) 位置的概觀文件 URL。
					</p>
					<b>跳至：</b> <a href="#tmodel">新增 tModel</a>、<a href="#categories">新增類別</a>及<a href="#overview">指定概觀文件 URL</a>。 <!-- #include file = "warning.changestouddi.htm" -->
					<h2><a name="tmodel"></a>新增 tModel</h2>
					<OL>
						<li>
							在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。
						<li>
							按一下 [tModel] 索引標籤。</li>
							按一下 [新增 tModel]。<br>新的 tModel 項目及 <img src="../../images/tmodel.gif" width="16" height="16" alt="" border="0"> <font color="#444444">(新的 tModel)</font> 便會出現。
						<LI>
							在詳細資料區域中，按一下 [編輯]。
						<LI>
							在 [tModel 名稱] 中，輸入此 tModel 的唯一名稱。
						</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，選取此描述的語言。
						<LI>
							在 [描述] 中，輸入此 tModel 的簡要描述。
						</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增以其他語言進行的描述，請重覆步驟 6 至 9。</LI>
					</OL>
					<a name="#categories"></a>
					<h2>新增類別</h2>
					類別描述此 tModel 及其識別的功能，如分類配置或介面類型。
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
					<a name="overview"></a>
					<h2>指定概觀文件 URL</h2>
					概觀文件 URL 提供包含此 tModel 相關之其他資訊或資源的檔案位置。例如，它可能包含 WDSL (網頁服務描述語言) 檔案或其他介面描述。
					<ol>
						<LI>
							按一下 [概觀文件 URL] 索引標籤。
						<li>
							按一下 [編輯]。
						<LI>
							指定可在其中找到此 tModel 之概觀文件的 URL。<br>例如：<a class="code">http://www.wideworldimporters.com/SampleWebService.asmx</a></LI>
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
					<p></p>
					您現已<uddi:ContentController Runat='server' Mode='Private'>在「UDDI 服務」中</uddi:ContentController>發行了 tModel。<a href="#tmodel">重覆這些程序</a>以發行其他 tModel。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

