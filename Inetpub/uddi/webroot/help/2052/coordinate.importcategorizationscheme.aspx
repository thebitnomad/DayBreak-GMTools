

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
				<p><b>注意：</b>必须是“UDDI&nbsp;服务”管理员才能将数据导入到“UDDI&nbsp;服务”中。<p>
				
				您可以使用“数据导入”将分类方案或其他相应的数据导入到“UDDI&nbsp;服务”中。必须首先根据合适的 XML 架构定义 (XSD) 来验证导入的任何信息。有关导入数据和获得验证的合适的 XSD 的详细信息，请参阅 <a href="http://go.microsoft.com/fwlink/?linkid=5202&clcid=0x409" target="_blank">UDDI 资源</a>。
				<p class="to">导入 XML 数据</p>
				<ol>
					<li>在“UDDI&nbsp;服务”菜单上，请单击“协调”。
					<li>单击“数据导入”。
					<li>单击“浏览”，然后查找包含要导入的数据的 XML 文件。
					<li>单击“打开”，然后单击“导入”。
				</ol>
				<B>注意：</B>如果要导入大量数据文件，请参阅“UDDI&nbsp;服务 MMC 管理单元帮助”以获得有关使用命令行导入工具的信息。 
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

