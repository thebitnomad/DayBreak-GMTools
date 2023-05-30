

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
					<H1>如何發行提供者 - <img src="../../images/business.gif" width="16" height="16" alt="" border="0"></H1>
					<p>
					提供者代表所有提供一或多個服務的群組或實體。有效的提供者範例可能包含提供服務的企業、企業單位、組織、組織部門、個人、電腦或應用程式。</p>
					
					<!-- #include file = "warning.changestouddi.htm" --> <b>跳至：</b> <a href="#provider" class="inline">新增提供者</a>、<a href="#identifiers">新增識別項</a>、<a href="#categories">新增類別</a>、<a href="#discovery">新增發現 URL</a> 及<a href="#relationships">新增關係</a>。
					<h2><a name="#provider"></a>新增提供者</h2>
					<OL>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。
						<li>按一下 [提供者] 索引標籤。
						<li>按一下 [新增提供者]。<br><img src="../../images/business.gif" width="16" height="16" alt="" border="0"> (新的提供者名稱) </font>顯示。
						<LI>
							在詳細資料區域中，按一下 [編輯]。
						<LI>
							在 [語言] 清單中，選取此名稱的語言。
						<LI>
							在 [名稱] 中，輸入此提供者的名稱。</LI>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增使用其他語言的名稱，請按一下 [新增名稱] 並重覆步驟 5 至 7。</li>
						<LI>
							按一下 [新增描述]。
						<LI>
							在 [語言] 清單中，請選取此描述的語言。
						<LI>
							在 [描述] 中，請輸入此提供者的簡要描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
						若要新增以其他語言進行的描述，請重覆步驟 9 至 12。
					</OL>
					<a name="#identifiers"></a>
					<h2>新增識別項</h2>
					使用識別項來定義此提供者為其成員之一的邏輯群組。
					<ol>
						<li>
							按一下 [識別項] 索引標籤</li>.
						<LI>
							按一下 [新增識別項]。
						<LI>
							請選取代表與此提供者關聯之識別碼配置的 tModel (如果可用)。
						<li>
							在 [機碼名稱] 中，輸入此識別項的名稱。</li>
						<li>
							在 [機碼值] 中，輸入此識別項的值。</li>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增其他識別項，請重覆步驟 2 至 6。</li>
					</ol>
					<a name="#categories"></a>
					<h2>新增類別</h2>
					類別目錄提供此提供者的描述性資訊，如其地理位置、所提供的服務或任何其他適當的類別。搜尋與查詢使用類別以尋找特定類型、分類或屬性的提供者。為此提供者指派適當的分類，以便人員搜尋或程式設計查詢時可以在邏輯上或在直覺發現它。 
					<OL>
						<li>
							按一下 [類別] 索引標籤。
						<li>
							按一下 [新增類別]。</li>
						<li>
							選取適當的「分類配置」及子類別。<br>
							</li>
						<li>
							按一下 [新增類別]。</li>
						<li>
							若要新增其他類別，請重覆步驟 2 至 5。</li>
					</OL>
					<a name="#discovery"></a>
					<h2>新增發現 URL</h2>
					「發現 URL」提供有關提供者的其他技術或描述性資訊的連結。<uddi:ContentController Runat='server' Mode='Private'>建立提供者時，「UDDI 服務」會自動建立一個「發現 URL」，指向這個「UDDI 服務」安裝中此提供者的 businessEntity。</uddi:ContentController>
					<ol>
						<li>
							按一下 [發現 URL] 索引標籤。</li>
						<li>
							按一下 [新增 URL]。</li>
						<li>
							在 [發現 URL] 中，輸入包含要發行之資料的 URL。</li>
						<li>
							在 [使用類型] 中，輸入此「發現 URL」的使用類型。</li>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增其他「發現 URL」，請重覆步驟 2 至 5。</li>
					</ol>
					<a name="#relationships"></a>
					<h2>新增關係</h2>
					關係定義您要公佈的提供者之間的關係。在描述組織結構或通告提供者間的合作關係時，它們很有用。
					<ol>
						<li>
							按一下 [關係] 索引標籤。</li>
						<li>
							按一下 [新增關係]。</li>
						<li>
							選取要發行與之關係的提供者。</li>
						<li>
							在 [關係類型] 中，請選取要建立的關係類型。
							
							<ul>
								<li>
								<b>身分識別：</b> 兩個提供者代表相同的公司。
								</li>
								<li>
								<b>父系-子系：</b> 一個提供者是另一個提供者的父系，如分公司。
								</li>
								<li>
								<b>對等：</b> 一個提供者是另一個提供者的對等體。
								</li>
							</ul>
						<li>
							選取關係的方向。
							<ul>
								<li>
									<b>(您的提供者) 到其他提供者：</b> 您的提供者代表父系或對等體的關係。</li>
								<li>
									<b>其他提供者到 (您的提供者)：</b> 其他提供者代表父系或對等體的關係。</li>
							</ul>
						</li>
						<li>
							按一下 [新增]。
						</li>
						<li>
							若要建立其他關係，請重覆步驟 2 至 6。
						</li>
					</ol>
					在其他提供者允許之前，不會發行您定義的任何關係。還沒得到允許的關係會在 [關係] 索引標籤中顯示為「擱置」，而在其他提供者的 [關係] 索引標籤中則顯示為「擱置允許」。<p>
					您現已新增並定義了提供者，且準備就緒以為其新增連絡人與服務。若需相關資訊，請參閱<a href="publish.addcontacts.aspx">如何新增連絡人</a>或<a href="publish.addservices.aspx">如何新增服務</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

