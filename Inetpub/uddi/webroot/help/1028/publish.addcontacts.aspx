

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
					<H1>如何新增連絡人 - <img src="../../images/contact.gif" width="16" height="16" alt="連絡人" border="0"></H1>
					<p>連絡人是在您的組織中能夠提供某個提供者之相關支援或協助，或能夠提供該提供者所提供之服務的任何連絡點。
					</p>
					<!-- #include file = "warning.changestouddi.htm" --> <b>跳至：</b> <a href="#contact">新增連絡人</a>、<a href="#emails">新增電子郵件位址</a>、<a href="#phones">新增電話號碼</a>及<a href="#addresses">新增地址</a>。
					<h2><a name="contact"></a>新增連絡人</h2>
					<OL>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找您要新增連絡人的提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [連絡人] 索引標籤。
						<li>按一下 [新增連絡人]。<BR><img src="../../images/contact.gif" width="16" height="16" alt="" border="0"> (新的連絡人) 顯示。</li>
						<LI>
							在詳細資料區域中，按一下 [編輯]。</LI>
						<LI>
							在<b>連絡名稱</b>欄位，輸入名稱。</LI>
						<li>
							在 [使用類型] 中，輸入此連絡的目的，例如「技術查詢」或「客戶服務查詢」。</li>
						<li>
							按一下 [更新]。</li>
						<LI>
							按一下 [新增描述]。</LI>
						<LI>
							在 [語言] 中，選取此描述的語言。</LI>
						<LI>
							在 [描述] 中，鍵入簡要描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增以其他語言進行的描述，請重覆步驟 8 至 11。</LI>
					</OL>
					<a name="#emails"></a>
					<h2>新增電子郵件位址</h2>
					<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找包含您要新增電子郵件位址之連絡人的提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [連絡人] 索引標籤。
						<li>尋找您要新增電子郵件位址的連絡，並在其名稱旁邊按一下 [檢視]。
						<li>
							按一下 [電子郵件] 索引標籤。</li>
						<LI>
							按一下 [新增電子郵件]。</LI>
						<LI>
							在 [電子郵件] 欄位，輸入電子郵件位址。</LI>
						<li>
							在 [使用類型] 中，輸入此電子郵件連絡的目的，例如「客戶服務查詢」。</li>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增其他電子郵件位址，請重覆步驟 2 至 5。</li>
						<LI>
							按一下 [新增描述]。</LI>
						<LI>
							在 [語言] 中，選取此描述的語言。</LI>
						<LI>
							在 [描述] 中，鍵入簡要描述。</LI>
						<li>
							按一下 [更新]。</li>
						<LI>
						若要新增以其他語言進行的描述，請重覆步驟 7 至 10。
					</ol>
					<a name="#phones"></a>
					<h2>新增電話號碼</h2>
					提供此連絡人的一或多個電話號碼。
					<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找包含您要新增電話號碼之連絡人的提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [連絡人] 索引標籤。
						<li>尋找您要新增電話號碼的連絡人，並在其名稱旁邊按一下 [檢視]。
						<li>
							按一下 [電話] 索引標籤。</li>
						<LI>
							按一下 [新增電話]。</LI>
						<LI>
							在 [電話] 中，輸入電話號碼。</LI>
						<li>
							在 [使用類型] 中，輸入此電話號碼的目的，例如「傳真」、TTY 或「語音」。</li>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增其他電話號碼，請重覆步驟 2 至 5。</li>
						<LI>
							按一下 [新增描述]。</LI>
						<LI>
							在 [語言] 清單中，選取此描述的語言。</LI>
						<LI>
							在 [描述] 中，鍵入簡要描述。</LI>
						<li>
							按一下 [更新]。</li>
						<li>
							若要新增以其他語言進行的描述，請重覆步驟 7 至 10。</li>
					</ol>
					<a name="#addresses"></a>
					<h2>新增地址</h2>
					提供此連絡人的一或多個地址，例如實體位置、郵件位址或郵政信箱。
					<ol>
						<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [發行]。</li>
						<li>按一下 [提供者] 索引標籤。
						<li>尋找包含您要新增地址之連絡人的提供者，並在其名稱旁邊按一下 [檢視]。
						<li>按一下 [連絡人] 索引標籤。
						<li>尋找包含您要新增地址的連絡人，並在其名稱旁邊按一下 [檢視]。
						<li>
							按一下 [地址] 索引標籤。</li>
						<LI>
							按一下 [新增地址]。</LI>
						<LI>
							在 [地址] 中，輸入地址。
						</LI>
						<li>
							在 [使用類型] 中，輸入此地址的目的，例如「交貨」或「撰寫技術文件」。</li>
						<li>
							按一下 [更新]。</li>
						<LI>
							若要新增其他地址，請重覆步驟 2 至 5。</LI>
					</ol>
					<p></p>
					您現已新增並定義了提供者的連絡人。<a href="#contact">重覆這些程序</a>以新增並定義其他連絡人。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

