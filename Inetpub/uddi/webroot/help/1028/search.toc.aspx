

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
									
					<uddi:ContentController Runat='server' Mode='Private'>
					<H1>搜尋 UDDI 服務</H1>
					</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>
					<H1>搜尋 UDDI</H1>
					</uddi:ContentController>
					
					
					<div class="clsTocHead">&nbsp;開始使用
					</div>
					<div class="children">
					
					<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.gettingstarted.aspx">搜尋簡介</a></div>
					</div>
					<div class="clsTocHead">&nbsp;如何搜尋...
					</div>
					<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.searchbycategory.aspx">使用按類別瀏覽</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.searchforservices.aspx">服務</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.searchforproviders.aspx">提供者</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.searchfortmodels.aspx">tModel</a></div>
					</div>
					<p class="portal">請參閱
					<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="search.glossary.aspx">詞彙</a></div>
					<!-- <div class="clsTocItem"><img src="images\bullet.gif" alt="bullet" height="7" width="7">&nbsp;<a href="search.troubleshooting.aspx">Troubleshooting</a></div> --> <uddi:ContentController Runat='server' Mode='Private'>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 網站</a>上 UDDI 服務網頁上的其他資源<div>
					</uddi:ContentController>
				</td>
				<td>
				<img border="0" src="images\search.guide.gif" >
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

