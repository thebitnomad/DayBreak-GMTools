
<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %> <uddi:SecurityControl Runat='server'/>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "home.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "home.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
				<uddi:ContentController Runat='server' Mode='Private'>
				<H1>“UDDI&nbsp;服务”帮助</H1>
				</uddi:ContentController>
				
				<uddi:ContentController Runat='server' Mode='Public'>
				<H1>UDDI 帮助</H1>
				</uddi:ContentController>
					
				</td>
			</tr>
		</table>
		<table class="navtabe" cellpadding="1" cellspacing="1">
		
		<uddi:ContentController Runat='server' Mode='Private'>
			<tr>
				<td rowspan="2" align="left" valign="top">
					<a href="intro.toc.aspx"><img border="0" src="images\stepbystep.guide.gif" alt="简介"></a>
				</td>
				
				<td class="portal" align="left" colspan="2"><a href="intro.toc.aspx">“UDDI&nbsp;服务”简介</a>
				</td>
			</tr>
		
		
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					“UDDI&nbsp;服务”中重要的定义和概念。</td>
			</tr>
			<tr>
				<td><br>
				</td>
			</tr>
		</uddi:ContentController>
		
			<tr>
				<td rowspan="2" align="right" valign="top"><a href="search.toc.aspx"><img border="0" src="images\search.guide.gif" ></a></td>
				<td class="portal" align="left" colspan="2"><a href="search.toc.aspx">
				
					<uddi:ContentController Runat='server' Mode='Private'>搜索“UDDI&nbsp;服务”</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>搜索 UDDI</uddi:ContentController>
				
				</a></td>
			</tr>
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					了解如何<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”数据</uddi:ContentController>中查找和查看数据。</td>
			</tr>
			
			
			<tr>
				<td><br>
				</td>
			</tr>
			<tr>
				<td rowspan="2" align="right" valign="top"><a href="publish.toc.aspx"><img border="0" src="images\publish.guide.gif" ></a></td>
				<td class="portal" align="left" colspan="2"><a href="publish.toc.aspx">
				
				<uddi:ContentController Runat='server' Mode='Private'>在“UDDI&nbsp;服务”中发布</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>在 UDDI 中发布</uddi:ContentController>
				
				</a></td>
			</tr>
			<tr>
				<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
				<td class="menu" valign="top">
					了解如何发布和修改 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>数据。</td>
			</tr>
			
			<uddi:ContentController Runat='server' Mode='Private' RequiredAccessLevel='Coordinator'>
			<tr>
				<td><br>
				</td>
			</tr>
				<tr>
					<td rowspan="2" align="right" valign="top"><a href="coordinate.toc.aspx"><img border="0" src="images\coord.guide.gif" ></a></td>
					<td class="portal" align="left" colspan="2"><a href="coordinate.toc.aspx">协调员指南</a></td>
				</tr>
				<tr>
					<td class="menu" valign="top"><b>&#187;</b><br> &nbsp;</td>
					<td class="menu" valign="top">
						了解如何查看统计信息、管理类别方案和维护其他发布者的数据。</td>
				</tr>
			</uddi:ContentController>
			
		</table>
		<br>
		<table>
			<tr>
				<td colspan="2">
					<!--These links are to additional information-->
					<p class="pportal">请参阅</p>
				</td>
			</tr>
			
			<tr>
				<td align="right" valign="middle"><img class="pportal" src="images\bullet.gif" width="8" height="8" alt="" border="0"></td>
				<td align="left">
					<a href="home.glossary.aspx" class="jumpstart">词汇表</a>
				</td>
			</tr>
			<uddi:ContentController Runat='server' Mode='Private'>
			<tr>
				<td align="right" valign="middle"><img class="pportal" src="images\bullet.gif" width="8" height="8" alt="" border="0"></td>
				<td align="left">
					<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 网站</a>上“UDDI&nbsp;服务”网页上的其他资源
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

 

