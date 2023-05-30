

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
			<tr>
				<td>
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者"> 提供者 - 關係</h1>
					使用 [關係] 索引標籤來檢視此提供者與其他<uddi:ContentController Runat='server' Mode='Private'>「UDDI 服務」</uddi:ContentController>提供者之間的已發行關係。
					<UL>
						<li>
							<b>關係：</b> 列出與其他提供者的已發行關係。為每一項目列出提供者名稱、關係的方向及關係類型。
							</li>
					</UL>
					<br>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.relationship.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

