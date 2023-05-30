

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "search.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "search.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr valign="top">
				<td>
									
					<uddi:ContentController Runat='server' Mode='Private'>
					<H1>搜索“UDDI&nbsp;服务”</H1>
					</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>
					<H1>搜索 UDDI</H1>
					</uddi:ContentController>
					
					
					<div class="clsTocHead">&nbsp;入门
					</div>
					<div class="children">
					
					<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.gettingstarted.aspx">搜索简介</a></div>
					</div>
					<div class="clsTocHead">&nbsp;如何搜索
					</div>
					<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.searchbycategory.aspx">使用“按类别浏览”</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.searchforservices.aspx">服务</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.searchforproviders.aspx">提供者</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.searchfortmodels.aspx">tModel</a></div>
					</div>
					<p class="portal">请参阅
					<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="search.glossary.aspx">词汇表</a></div>
					<!-- <div class="clsTocItem"><img src="images\bullet.gif" alt="bullet" height="7" width="7">&nbsp;<a href="search.troubleshooting.aspx">Troubleshooting</a></div> --> <uddi:ContentController Runat='server' Mode='Private'>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 网站</a>“UDDI&nbsp;服务”网页上的其他资源<div>
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

 

