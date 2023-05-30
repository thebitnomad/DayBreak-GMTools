

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
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<h1><img src="..\..\images\business.gif" height="16" width="16" alt="提供者">提供者 - 关系</h1>
					使用“关系”选项卡查看和管理与其他提供程序的关系。
					<UL>
						<li>
							<b>关系：</b>列出与其他提供程序的发布关系。列出每个项目的提供程序名称、方向、状态和类型。
								<ul>
								<li class="action">
									单击“添加关系”将新关系添加到该提供程序中。
									
								</li>
								<li class="action">
									单击“删除”永久删除关系。
								</li>
								
							</ul>
										
						</li>
						<li>
							<b>搁置关系：</b>列出等待批准的关系。
						</li>
							<ul>
								<li class="action">
									单击“接受”可以接受由其他提供程序提交的关系。
								</li>
							</ul>
					<LI>关系的类型
					
					<ul>
										<LI>
								<b>标识：</b>两个提供程序都代表同一组织。
								</li>
								<li>
								<b>父子：</b>一个提供者是另一提供程序的父级，例如子公司。
								</li>
								<li>
								<b>对等：</b>一个提供者是另一提供程序的对等。
								</li>
									
									</ul>
					</li>
					</UL>
					
					<br>
					<h3>更多信息</h3>
					<!-- #include file = "glossary.relationship.htm" -->
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 