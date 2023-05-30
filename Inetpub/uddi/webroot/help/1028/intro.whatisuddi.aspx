

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Big5">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-TW">
		<!-- #include file = "intro.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "intro.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<a name="#intro"></a><H1>UDDI 服務簡介</H1>
					<p>
						為了充分利用「UDDI 服務」中該基本概念的簡介，建議您首先要熟悉網頁服務、網頁服務介面及您要描述的服務。若需相關資訊，請參閱 <a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 網站</a>上「UDDI 服務」網頁上的「其他資源」。
					</p>
					<p>
					<b>跳至：</b> <a href="#UDDI">何謂 UDDI？</a>、<a href="#UDDISERVICES">瞭解 UDDI 服務實體及組織</a>及 <a href="#ROLES">UDDI 服務角色</a>。
						</p>
					</a> <a name="UDDI"></a>
					<h2>何謂 UDDI？</h2>
					<p>
						通用描述、探索與整合 (UDDI) 是發行及尋找網頁服務相關資訊的工業規格。它會定義一個資訊架構，可讓您描述及分類組織、其服務及您顯示之網頁服務介面的詳細技術資料。架構還可讓您不斷發現服務，或者特定類型、類別或功能的介面。UDDI 還會定義一組「應用程式介面 (API)」，供應用程式及服務直接與 UDDI 資料互動使用。例如，您可以開發自動發行及更新其 UDDI 資料、動態對服務可用性作出反應，或自動發現與它們互動之其他服務介面詳細資料的服務。</p>
					<p>
						公司的 UDDI.org 聯盟建立了「UDDI 企業登錄 (UBR)」，公司及組織可在其中共用及探索網頁服務。此公開登錄由其管理主體 UBR Operator Council 維護及複寫，且不應與「UDDI 服務」混淆，該服務是由您的企業或組織來調配及複寫的。
					</p>
					<a name="#UDDISERVICES"></a>
					<h2>瞭解 UDDI 服務實體及組織</h2>
					<p>
						「UDDI 服務」提供 UDDI 功能，其可用於企業內部或企業夥伴之間。它將與 Microsoft Internet Explorer 4.0 或更新版本及 Netscape Navigator 4.5 或更新版本相容的搜尋、發行及協調功能併入網頁介面。「UDDI 服務」支援 UDDI 版本 1.0 及 2.0 API，可讓企業開發人員直接透過其開發工具及企業應用程式發行、探索及共用網頁服務，並與網頁服務互動。
					</p>
					<p>
						「UDDI 服務」中的下列實體將代表組織及其提供的產品和服務：
					</p>
					<center>
					<table cellpadding="15" border="1"  bgcolor="#EEEEEE">
						<tr valign="middle">
							<td valign="middle">
								<a href="#provider"><img src="..\..\images\business.gif" height="16" width="16" alt="提供者" border="0">&nbsp;提供者<br></a> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="樹狀目錄"><br> <img src="..\..\images\line-nes.gif" height="16" width="16" alt="樹狀目錄"> <a href="#contact"><img src="..\..\images\contact.gif" height="16" width="16" alt="連絡" border="0"> 連絡<br></a> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="樹狀目錄"><br> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="樹狀目錄"> <a href="#service"><img src="..\..\images\service.gif" height="16" width="16" alt="服務" border="0"> 服務<br></a> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="樹狀目錄"><br> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="樹狀目錄"> <a href="#binding"><img src="..\..\images\binding.gif" height="16" width="16" alt="連結" border="0"> 連結<br></a> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="樹狀目錄"><br> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="樹狀目錄"> <a href="#instance"><img src="..\..\images\instance.gif" height="16" width="16" alt="例項資訊" border="0"> 例項資訊<br></a>
							<p>
							<a href="#tmodel"><img src="..\..\images\tmodel.gif" height="16" width="16" alt="tModel" border="0"> tModel<br></a>
							</td>
						</tr>
					</table>
					<i><b>圖形 A</b></i>
					</center>
					<p> 
					下列定義描述與其他實體相關的每一個實體及其角色。
					</p>
					<table width="100%" cellpadding="5" border="0" bgcolor="#FFFFFF">
						<tr>
							<td valign="top"><a name="provider"></a> <img src="..\..\images\business.gif" height="16" width="16" alt="provider 提供者" border="0">
							</td>
							<td>
<!-- #include file = "glossary.provider.htm" -->
							</td>							
						</tr>
						<tr>
							<td valign="top"><a name="contact"></a> <img src="..\..\images\contact.gif" height="16" width="16" alt="contact 連絡" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.contact.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="service"></a> <img src="..\..\images\service.gif" height="16" width="16" alt="service 服務" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.service.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="binding"></a> <img src="..\..\images\binding.gif" height="16" width="16" alt="binding 連結" border="0">
							</td>
							<td>						
							<!-- #include file = "glossary.binding.htm" -->
							</td>							
						</tr>
						<tr>
							<td valign="top"><a name="instance"></a> <img src="..\..\images\instance.gif" height="16" width="16" alt="instance info 例項資訊" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.instanceinfo.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="tmodel"></a> <img src="..\..\images\tmodel.gif" height="16" width="16" alt="tModel" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.tmodel.htm" -->
							</td>														
					</table>																	
					</ul>
					使用下列一或多個屬性定義每一個實體。
					<ul>
						<li>
							<!-- #include file = "glossary.categorization.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.overviewdocument.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.discoveryurl.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.identifier.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.relationship.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.instanceparameter.htm" -->
						</li>
						
					</ul>
					<a name="#ROLES"></a>
					<h2>UDDI 服務角色</h2>
					<p>
						「UDDI 服務」包含定義允許每一位使用者使用之互動層級的四個角色。
					</p>
					<ul>
						<li>
							<!-- #include file = "glossary.user.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.publisher.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.coordinator.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.administrator.htm" -->
						</li>
					</ul>
					<p>
						使用者名稱及角色會在「UDDI 服務」網頁介面的右上角顯示。
					</p>
					<a name="#WHATNEXT"></a>
					<h2>下一步</h2>
					<p>因為您現在已經檢視「UDDI 服務」中的實體、角色及關係，所以要準備就緒以開始查詢、發行或協調網頁服務資訊。如需尋找或發行資料的概觀，請參閱<a href="search.gettingstarted.aspx">搜尋簡介</a>或<a href="publish.publishinuddiservices.aspx">發行簡介</a>。</p>
				</td>
			</tr>
		</table>
		<!-- #include file = "intro.footer.htm" -->
	</body>
</html>

 

