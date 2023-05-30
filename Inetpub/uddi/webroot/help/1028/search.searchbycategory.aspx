

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
					<H1>如何使用按類別瀏覽來搜尋</H1>
					<p>
					使用 [搜尋] 中的 [依類別瀏覽] 索引標籤，您可以根據類別在「<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>」中搜尋服務、提供者或 tModel。搜尋僅傳回與您指定之類別相關聯的「提供者」、「服務」或 tModel。
					<P class="to">使用按類別瀏覽來尋找實體</p>
					<OL>
						<LI>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]。
						<LI>在 [依類別瀏覽] 索引標籤上，瀏覽可用的分類配置並尋找您搜尋所要依據的類別，再依序按一下 [尋找提供者]、[尋找服務] 或 [尋找 tModel]。
						<li>若要檢視實體的詳細資料，請在清單中按一下其名稱。檢視及瀏覽該實體以及任何相關實體的屬性。例如，如果您要搜尋服務，則也可以檢視該服務的服務提供者或連結及例項資訊。 

</LI>
</p>
<LI>
若要執行新的搜尋，請在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController>] 功能表上，按一下 [搜尋]，然後重新啟動。</LI>						

					</ol>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

