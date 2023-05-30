

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
					<h1><img src="../../images/tmodel.gif" alt="tModel" height="16" width="16"> tModel - 詳細資料</h1>
					使用 [詳細資料] 索引標籤來檢視並管理此 tModel 的名稱及描述。
					<UL>
						<li>
							<b>擁有者：</b> 顯示擁有此實體之使用者的名稱。
						</li>
						<li>
							<b>tModel 金鑰：</b>顯示在程序設計查詢期間所使用的，與此 tModel 相關聯的唯一識別碼。
						</li>
					
						<li>
							<b>名稱：</b> 顯示此 tModel 的名稱。
							<ul>
								<li class="action">
									按一下 [編輯] 以修改此 tModel 的名稱。
								</li>
							</ul>
						</li>
						<li>
							<b>描述：</b>列出此 tModel 的描述及撰寫每個描述的語言。
						</li>
						<ul>
							<li class="action">
								按一下 [新增描述] 以將描述新增至此連結。
							</li>
							<li class="action">
								按一下 [編輯] 以修改此連結的描述。
							</li>
							<li class="action">
								按一下 [刪除] 以刪除此連結的描述。
							</li>
						</ul>
					</UL>
					<h3>更多資訊</h3>
					<!-- #include file = "glossary.tmodel.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 