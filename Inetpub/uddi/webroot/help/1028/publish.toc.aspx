

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
		<table class="content" width="100%" cellpadding="8" cellspace="0">
			<tr valign="top">
				<td>
					
					<uddi:ContentController Runat='server' Mode='Private'>
					<H1>在 UDDI 服務中發行</H1>
					</uddi:ContentController>
					
					<uddi:ContentController Runat='server' Mode='Public'>
					<H1>在 UDDI 中發行</H1>
					</uddi:ContentController>
					
					
					<p>
					
					<uddi:ContentController Runat='server' Mode='Private'>
					<div class="clsTocHead">&nbsp;開始使用</a>
					</div>
					<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.publishinuddiservices.aspx">發行簡介</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.gettingstarted.aspx">發行網頁服務的逐步指導</a></div>
					</div>
					</uddi:ContentController>
					
					<div class="clsTocHead">&nbsp;作法
					</div>
					<div class="children">
						<div class="clsTocHead">&nbsp;新增
						</div>
						<div class="children">
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addproviders.aspx">提供者</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addcontacts.aspx">連絡人</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addservices.aspx">服務</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addbindings.aspx">連結</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addinstances.aspx">例項資訊</a></div>
							<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.addtmodels.aspx">tModel</a></div>
						</div>
						</div>
						<div class="children">
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.modify.aspx">修改資料</a></div>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.delete.aspx">刪除資料</a></div>
						
					</div>
					<p class="portal">請參閱
					<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="publish.glossary.aspx">詞彙</a></div>
					<!-- <div class="clsTocItem"><img src="images\bullet.gif" alt="bullet" height="7" width="7">&nbsp;<a href="publish.troubleshooting.aspx">Troubleshooting</a></div> --> <uddi:ContentController Runat='server' Mode='Private'>
						<div class="clsTocItem"><img src="images\bullet.gif" alt="項目符號" height="7" width="7">&nbsp;<a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 網站</a>上 UDDI 服務網頁上的其他資源<div>
					</uddi:ContentController>
				</td>
				<td>
				<img border="0" src="images\publish.guide.gif" alt="發行指導">
				</td>

			</tr>
			
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

