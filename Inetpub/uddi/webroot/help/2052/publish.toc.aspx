

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "publish.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "publish.heading.htm" -->
		<table class="content" width="100%" cellpadding="8" cellspace="0">
			<tr valign="top">
				<td>
					
					<uddi:ContentController Runat='server' Mode='Private'>
					<H1>在“UDDI&nbsp;服务”中发布</H1>
					</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>
					<H1>在 UDDI 中发布</H1>
					</uddi:ContentController>
					
					
					<p>
					
					<uddi:ContentController Runat='server' Mode='Private'>
					<div class="clsTocHead">&nbsp;入门</a>
					</div>
					<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.publishinuddiservices.aspx">发布简介</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.gettingstarted.aspx">“发布 Web 服务”的循序渐进指南</a></div>
					</div>
					</uddi:ContentController>
					
					<div class="clsTocHead">&nbsp;如何
					</div>
					<div class="children">
						<div class="clsTocHead">&nbsp;添加
						</div>
						<div class="children">
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addproviders.aspx">提供者</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addcontacts.aspx">联系人</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addservices.aspx">服务</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addbindings.aspx">绑定</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addinstances.aspx">实例信息</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.addtmodels.aspx">tModel</a></div>
						</div>
						</div>
						<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.modify.aspx">修改数据</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.delete.aspx">删除数据</a></div>
						
					</div>
					<p class="portal">请参阅
					<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="publish.glossary.aspx">词汇表</a></div>
					<!-- <div class="clsTocItem"><img src="images\bullet.gif" alt="bullet" height="7" width="7">&nbsp;<a href="publish.troubleshooting.aspx">Troubleshooting</a></div> --> <uddi:ContentController Runat='server' Mode='Private'>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="项目符号" height="7" width="7">&nbsp;<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 网站</a>“UDDI&nbsp;服务”网页上的其他资源<div>
					</uddi:ContentController>
				</td>
				<td>
				<img border="0" src="images\publish.guide.gif" alt="发布指南">
				</td>

			</tr>
			
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

