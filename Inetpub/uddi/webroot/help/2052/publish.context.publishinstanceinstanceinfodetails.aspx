

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
					<h1><img src="..\..\images\instance.gif" height="16" width="16" alt="实例信息">实例信息 - 实例详细信息</h1>
					使用“实例详细信息”选项卡查看或修改要为该实例信息发布的参数。
					<UL>
						<li>
							<b>实例参数：</b>列出了由该实例信息支持的参数。
						<ul>
							<li class="action">
								单击“编辑”可以编辑该实例信息的实例参数。
							</li>
						</ul>	
						</li>
						<li>
							<b>描述：</b>列出了对该实例参数的描述和编写每个描述所用的语言。
						</li>
						<ul>
							<li class="action">
								单击“添加描述”可以添加描述。
							</li>
							<li class="action">
								单击“编辑”修改描述。
							</li>
							<li class="action">
								单击“删除”可以删除描述。
							</li>
						</ul>
					</UL>
					<H3>更多信息</H3>
					
						<!-- #include file = "glossary.instanceparameter.htm" -->
					
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 