

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "coordinate.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "coordinate.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<H1>导入数据</H1>
					使用“导入”选项卡将类别方案或其他可扩展标记语言 (XML) 数据导入“UDDI&nbsp;服务”中。必须首先根据合适的 XML 架构定义 (XSD) 来验证导入的任何信息。有关导入数据和获得验证的合适的 XSD 的详细信息，请参阅 <a href="http://go.microsoft.com/fwlink/?linkid=5202&clcid=0x409" target="_blank">UDDI 资源</a>。
					
					<ul>
						<li><b>数据文件：</b>列出包含要导入的信息的 XML 文件的位置。
						<ul class="action">
							<li>单击“浏览”指定包含要导入的数据的文件。
							<li>单击“导入”导入包含在已经指定的文件中的数据。
						</ul>
					</ul>
					
					<b>注意：</b>如果要导入大量数据文件，请参阅“UDDI&nbsp;服务 Microsoft 管理控制台 (MMC) 管理单元帮助”以获得有关使用命令行导入工具的信息。
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

