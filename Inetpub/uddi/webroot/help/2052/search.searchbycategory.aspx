

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "search.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "search.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr valign="top">
				<td>
					<H1>如何使用“按类别浏览”来搜索 </H1>
					<p>
					在“搜索”中使用“按类别浏览”选项卡，可以按照类别或分类在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务</uddi:ContentController>中搜索服务、提供者或 tModel。搜索只返回与指定的类别关联的提供者、服务或 tModel。
					<P class="to">使用“按类别浏览”查找实体</p>
					<OL>
						<LI>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“搜索”。
						<LI>在“按类别搜索”选项卡上，定位到可用的类别方案，找到要作为搜索依据的类别或分类，然后单击“查找提供程序”、“查找服务”或“查找 tModel”。
						<li>要查看实体的详细信息，请单击列表中实体的名称。查看和浏览该实体的特性和所有有关的实体。例如，如果搜索到了某个服务，还可以查看该服务的服务提供者或绑定以及实例信息。 

</LI>
</p>
<LI>
要执行新搜索，请在 <uddi:ContentController Runat='server' Mode='Private'> UDDI&nbsp;服务</uddi:ContentController> <uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，单击“搜索”即可重新开始。</LI>						

					</ol>
				</td>
			</tr>
		</table>
		<!-- #include file = "search.footer.htm" -->
	</body>
</html>

 

