

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
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者"> 提供者 - 關係</h1>
					使用 [關係] 標籤來檢視及管理與其他提供者的關係。
					<UL>
						<li>
							<b>關係：</b> 列出與其他提供者的已發行關係。提供者名稱、方向、狀態及類型會針對每一個項目列出。
								<ul>
								<li class="action">
									按一下 [新增關係] ，將新的關係新增到此提供者。
									
								</li>
								<li class="action">
									按一下 [刪除] 以永久刪除關係。
								</li>
								
							</ul>
										
						</li>
						<li>
							<b>擱置關係</b> 列出擱置批准的關係。
						</li>
							<ul>
								<li class="action">
									按一下 [接受]，以接受由另一個提供者提交的關係。
								</li>
							</ul>
					<LI><b>關係類型</b>
					
					<ul>
										<LI>
								<b>身分識別：</b> 兩個提供者代表相同的公司。
								</li>
								<li>
								<b>父系-子系：</b> 一個提供者是另一個提供者的父系，如分公司。
								</li>
								<li>
								<b>對等：</b> 一個提供者是另一個提供者的對等體。
								</li>
									
									</ul>
					</li>
					</UL>
					
					<br>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.relationship.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 