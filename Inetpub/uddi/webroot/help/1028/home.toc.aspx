
<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %> <uddi:SecurityControl Runat='server'/>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Big5">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-TW">
		<!-- #include file = "home.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "home.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
				<uddi:ContentController Runat='server' Mode='Private'>
				<H1>UDDI 服務說明</H1>
				</uddi:ContentController>
				
				<uddi:ContentController Runat='server' Mode='Public'>
				<H1>UDDI 說明</H1>
				</uddi:ContentController>
					
				</td>
			</tr>
		</table>
		<table class="navtabe" cellpadding="1" cellspacing="1">
		
		<uddi:ContentController Runat='server' Mode='Private'>
			<tr>
				<td rowspan="2" align="left" valign="top">
					<a href="intro.toc.aspx"><img border="0" src="images\stepbystep.guide.gif" alt="簡介"></a>
				</td>
				
				<td class="portal" align="left" colspan="2"><a href="intro.toc.aspx">UDDI 服務簡介</a>
				</td>
			</tr>
		
		
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					「UDDI 服務」中的重要定義及概念。</td>
			</tr>
			<tr>
				<td><br>
				</td>
			</tr>
		</uddi:ContentController>
		
			<tr>
				<td rowspan="2" align="right" valign="top"><a href="search.toc.aspx"><img border="0" src="images\search.guide.gif" ></a></td>
				<td class="portal" align="left" colspan="2"><a href="search.toc.aspx">
				
					<uddi:ContentController Runat='server' Mode='Private'>搜尋 UDDI 服務</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>搜尋 UDDI</uddi:ContentController>
				
				</a></td>
			</tr>
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					瞭解如何尋找並檢視<uddi:ContentController Runat='server' Mode='Private'>位於「UDDI 服務」資料</uddi:ContentController>中的資料。</td>
			</tr>
			
			
			<tr>
				<td><br>
				</td>
			</tr>
			<tr>
				<td rowspan="2" align="right" valign="top"><a href="publish.toc.aspx"><img border="0" src="images\publish.guide.gif" ></a></td>
				<td class="portal" align="left" colspan="2"><a href="publish.toc.aspx">
				
				<uddi:ContentController Runat='server' Mode='Private'>在 UDDI 服務中發行</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>在 UDDI 中發行</uddi:ContentController>
				
				</a></td>
			</tr>
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					瞭解如何發行並修改「<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>」資料。</td>
			</tr>
			
			<uddi:ContentController Runat='server' Mode='Private' RequiredAccessLevel='Coordinator'>
			<tr>
				<td><br>
				</td>
			</tr>
				<tr>
					<td rowspan="2" align="right" valign="top"><a href="coordinate.toc.aspx"><img border="0" src="images\coord.guide.gif" ></a></td>
					<td class="portal" align="left" colspan="2"><a href="coordinate.toc.aspx">協調員手冊</a></td>
				</tr>
				<tr>
					<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
					<td class="menu" valign="top">
						瞭解如何檢視統計、管理分類配置及維護其他發行者的資料。</td>
				</tr>
			</uddi:ContentController>
			
		</table>
		<br>
		<table>
			<tr>
				<td colspan="2">
					<!--These links are to additional information-->
					<p class="pportal">請參閱</p>
				</td>
			</tr>
			
			<tr>
				<td align="right" valign="middle"><img class="pportal" src="images\bullet.gif" width="8" height="8" alt="" border="0"></td>
				<td align="left">
					<a href="home.glossary.aspx" class="jumpstart">詞彙</a>
				</td>
			</tr>
			<uddi:ContentController Runat='server' Mode='Private'>
			<tr>
				<td align="right" valign="middle"><img class="pportal" src="images\bullet.gif" width="8" height="8" alt="" border="0"></td>
				<td align="left">
					<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 網站</a>上「UDDI 服務」網頁上的其他資源
				</td>
			</tr>
			</uddi:ContentController>
			
			<!-- <tr>
				<td align="right" valign="middle"><img class="pportal" src="images\bullet.gif" width="8" height="8" alt="" border="0"></td>
				<td align="left">
					<a href="home.troubleshooting.aspx" class="jumpstart">Troubleshooting</a> 
				</td>
			</tr> -->
			
		</table>
		<!-- #include file = "home.footer.htm" -->
	</body>
</html>

 

