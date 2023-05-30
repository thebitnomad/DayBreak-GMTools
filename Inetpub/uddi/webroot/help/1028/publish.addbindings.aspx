

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
					<H1>如何新增連結 - <img src="../../images/binding.gif" width="16" height="16" alt="連結" border="0"></H1>
					連結代表可以存取服務之執行方式的點。如果您的服務有多個存取點，則為每一個存取點新增連結。連結永遠包含存取點及如何使用服務的描述。它也可能包含一或多個例項資訊，該資訊參照包含有關連結之相關技術資訊的 tModels <!-- #include file = "warning.changestouddi.htm" -->
						<h2><a name="#binding"></a>新增連結</h2>
						<ol>
							<li>在 [<uddi:ContentController Runat='server' Mode='Private'>UDDI 服務</uddi:ContentController>] <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 功能表上，按一下 [發行]。</li>
							<li>按一下 [提供者] 索引標籤。
							<li>尋找包含您要新增連結之服務的提供者，並在其名稱旁邊按一下 [檢視]。
							<li>按一下 [服務] 索引標籤。
							<li>尋找您要新增連結之服務，並在其名稱旁邊按一下 [檢視]。
							<li>按一下 [連結] 索引標籤。
							<li>按一下 [新增連結]。<BR><img src="../../images/binding.gif" width="16" height="16" alt="連結" border="0"> http:// 顯示。 
							<LI>
								在 [詳細資料] 索引標籤上，按一下 [編輯]。
							<LI>
								在 [存取點] 中，輸入存取點 URL。</LI>
							<li>
								在 [URL 類型] 清單中，按一下該存取點支援的通訊協定。</li>
							<li>
								按一下 [更新]。</li>
							<LI>
								按一下 [新增描述]。
							<LI>
								在 [語言] 清單中，選取此描述的語言。
							<LI>
								在 [描述] 中，鍵入簡要描述。</LI>
							<li>
								按一下 [更新]。</li>
							<LI>
								若要新增以其他語言進行的描述，請重覆步驟 12 至 15。</LI>
						</ol>
					<p></p>
					您現已新增服務的連結。<a href="#binding">重覆這些程序</a>以發行其他連結，或<a href="publish.addinstances.aspx">新增例項資訊</a>至您的連結。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

