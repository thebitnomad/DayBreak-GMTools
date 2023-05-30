

<%@ Page %> <%@ Register TagPrefix='uddi' Namespace='UDDI.Web' Assembly='uddi.web' %>
<html>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GB2312">
		<META HTTP-EQUIV="MSThemeCompatible" CONTENT="Yes">
		<META NAME="MS.LOCALE" CONTENT="ZH-CN">
		<!-- #include file = "intro.header.htm" -->
	</head>
	<body marginwidth="0" marginheight="0" LEFTMARGIN="0" TOPMARGIN="0" rightmargin="0" ONLOAD="BringToFront()">
		<!-- #include file = "intro.heading.htm" -->
		<table class="content" width="100%" cellpadding="8">
			<tr>
				<td>
					<a name="#intro"></a><H1>“UDDI&nbsp;服务”简介</H1>
					<p>
						为了最大程度地了解“UDDI&nbsp;服务”中基本概念的简介，强烈建议您首先熟悉 Web 服务、Web 服务接口和您要描述的服务。详细信息，请参阅 <a href="http://go.microsoft.com/fwlink/?linkid=5202&amp;clcid=0x409" target="_blank">Microsoft 网站</a>上“UDDI&nbsp;服务”页中的其他资源。
					</p>
					<p>
					<b>转到：</b> <a href="#UDDI">什么是 UDDI？</a>、<a href="#UDDISERVICES">了解“UDDI&nbsp;服务”实体和组织</a>、<a href="#ROLES">“UDDI&nbsp;服务”角色</a>。
						</p>
					</a> <a name="UDDI"></a>
					<h2>什么是 UDDI？</h2>
					<p>
						通用描述发现和集成 (UDDI) 是用于发布和查找有关 Web 服务的信息的工业规范。UDDI 定义了用于描述和分类您的组织、它的服务和有关公开的 Web 服务接口的技术详细信息的信息框架。框架还用于持续发现服务或特定类型、类别或功能的接口。UDDI 还定义了一组应用程序和服务用来与 UDDI  数据直接交互的“应用程序接口 (API)”。例如，可以开发各种服务，如自动发布和更新 UDDI 数据、动态响应服务可用性或自动搜索与其交互的其他服务接口的详细信息。</p>
					<p>
						公司的 UDDI.org 联合会建立了“UDDI 业务注册表 (UBR)”，由此公司和组织可以共享和发现 Web 服务。公共注册表由其管理体“UBR 操作员委员会”维护和复制，而不应该与由企业或组织部署和维护的“UDDI&nbsp;服务”相混淆。
					</p>
					<a name="#UDDISERVICES"></a>
					<h2>了解“UDDI&nbsp;服务”实体和组织</h2>
					<p>
						“UDDI&nbsp;服务”在企业内或商业伙伴之间提供 UDDI 使用能力。它包括一个具有搜索、发布和协调功能的 Web 接口，这些功能与 Microsoft Internet Explorer&nbsp;4.0（或更高版本）和 Netscape Navigator 4.5（或更高版本）兼容。“UDDI&nbsp;服务”支持 UDDI&nbsp;1.0 和&nbsp;2.0 版本的 API，可以使企业开发人员通过其开发工具和业务应用程序直接进行发布、搜索、共享和与 Web 服务交互。
					</p>
					<p>
						组织及其提供的产品和服务由“UDDI&nbsp;服务”中的下列实体来表示：
					</p>
					<center>
					<table cellpadding="15" border="1"  bgcolor="#EEEEEE">
						<tr valign="middle">
							<td valign="middle">
								<a href="#provider"><img src="..\..\images\business.gif" height="16" width="16" alt="提供者" border="0">&nbsp;提供者<br></a> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="树"><br> <img src="..\..\images\line-nes.gif" height="16" width="16" alt="树"> <a href="#contact"><img src="..\..\images\contact.gif" height="16" width="16" alt="联系人" border="0">联系人<br></a> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="树"><br> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="树"> <a href="#service"><img src="..\..\images\service.gif" height="16" width="16" alt="服务" border="0">服务<br></a> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="树"><br> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="树"> <a href="#binding"><img src="..\..\images\binding.gif" height="16" width="16" alt="绑定" border="0">绑定<br></a> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ns.gif" height="16" width="16" alt="树"><br> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\blank.gif" height="16" width="16" alt="空白"> <img src="..\..\images\line-ne.gif" height="16" width="16" alt="树"> <a href="#instance"><img src="..\..\images\instance.gif" height="16" width="16" alt="实例信息" border="0">实例信息<br></a>
							<p>
							<a href="#tmodel"><img src="..\..\images\tmodel.gif" height="16" width="16" alt="tModel" border="0"> tModel<br></a>
							</td>
						</tr>
					</table>
					<i><b>图 A</b></i>
					</center>
					<p> 
					下面的定义描述每个实体及其相对于其他实体的角色。
					</p>
					<table width="100%" cellpadding="5" border="0" bgcolor="#FFFFFF">
						<tr>
							<td valign="top"><a name="provider"></a> <img src="..\..\images\business.gif" height="16" width="16" alt="提供者" border="0">
							</td>
							<td>
<!-- #include file = "glossary.provider.htm" -->
							</td>							
						</tr>
						<tr>
							<td valign="top"><a name="contact"></a> <img src="..\..\images\contact.gif" height="16" width="16" alt="联系人" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.contact.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="service"></a> <img src="..\..\images\service.gif" height="16" width="16" alt="服务" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.service.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="binding"></a> <img src="..\..\images\binding.gif" height="16" width="16" alt="绑定" border="0">
							</td>
							<td>						
							<!-- #include file = "glossary.binding.htm" -->
							</td>							
						</tr>
						<tr>
							<td valign="top"><a name="instance"></a> <img src="..\..\images\instance.gif" height="16" width="16" alt="实例信息" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.instanceinfo.htm" -->
							</td>
						</tr>
						<tr>
							<td valign="top"><a name="tmodel"></a> <img src="..\..\images\tmodel.gif" height="16" width="16" alt="tModel" border="0">
							</td>
							<td>
							<!-- #include file = "glossary.tmodel.htm" -->
							</td>														
					</table>																	
					</ul>
					每个实体都由下面的一个或多个特性定义。
					<ul>
						<li>
							<!-- #include file = "glossary.categorization.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.overviewdocument.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.discoveryurl.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.identifier.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.relationship.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.instanceparameter.htm" -->
						</li>
						
					</ul>
					<a name="#ROLES"></a>
					<h2>“UDDI&nbsp;服务”角色</h2>
					<p>
						“UDDI&nbsp;服务”包括定义每个用户所允许的交互级别的四个角色。
					</p>
					<ul>
						<li>
							<!-- #include file = "glossary.user.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.publisher.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.coordinator.htm" -->
						</li>
						<li>
							<!-- #include file = "glossary.administrator.htm" -->
						</li>
					</ul>
					<p>
						用户名和角色显示在“UDDI 服务”Web 接口的右上角中。
					</p>
					<a name="#WHATNEXT"></a>
					<h2>接下来</h2>
					<p>现在，您已经学习了“UDDI&nbsp;服务”中的实体、角色和关系，可以在组织中开始查询、发布或协调 Web 服务信息了。有关查找或发布数据的概述，请参阅<a href="search.gettingstarted.aspx">“搜索”简介</a>或<a href="publish.publishinuddiservices.aspx">“发布”简介</a>。</p>
				</td>
			</tr>
		</table>
		<!-- #include file = "intro.footer.htm" -->
	</body>
</html>

 

