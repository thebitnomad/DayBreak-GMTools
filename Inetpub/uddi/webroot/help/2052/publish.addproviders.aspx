

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
					<H1>如何发布提供者 - <img src="../../images/business.gif" width="16" height="16" alt="" border="0"></H1>
					<p>
					提供者表示任何提供一个或多个服务的组或实体。提供程序的有效示例可能包括提供服务的公司、公司单位、组织、组织部门、人、计算机或应用程序。</p>
					
					<!-- #include file = "warning.changestouddi.htm" --> <b>转到：</b><a href="#provider" class="inline">添加提供者</a>、<a href="#identifiers">添加标识符</a>、<a href="#categories">添加类别</a>、<a href="#discovery">添加搜索 URL</a>、<a href="#relationships">添加关系</a>。
					<h2><a name="#provider"></a>添加提供者</h2>
					<OL>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。
						<li>单击“提供者”选项卡。
						<li>单击“添加提供者”。<br>出现 <img src="../../images/business.gif" width="16" height="16" alt="" border="0">（新提供程序名称）</font>。
						<LI>
							在详细信息区域中，单击“编辑”。
						<LI>
							在“语言”列表中，选择该名称的语言。
						<LI>
							在“名称”中，键入该提供程序的名称。</LI>
						<li>
							单击“更新”。</li>
						<li>
							要用其他语言添加名称，请单击“添加名称”并重复第&nbsp;5 步到第&nbsp;7 步。</li>
						<LI>
							单击“添加描述”。
						<LI>
							在“语言”列表中，选择该描述的语言。
						<LI>
							在“描述”中，键入该提供程序的简要描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
						要添加其他语言的描述，请重复第&nbsp;9 步到第&nbsp;12 步。
					</OL>
					<a name="#identifiers"></a>
					<h2>添加标识符</h2>
					标识符用于定义该提供程序所属的逻辑分组。
					<ol>
						<li>
							单击“标识符”选项卡。</li>.
						<LI>
							单击“添加标识符”。
						<LI>
							选择代表要与该提供程序相关的标识方案的 tModel（如果可用的话）。
						<li>
							在“项名称”中，键入该标记符的名称。</li>
						<li>
							在“项值”中，键入该标识符的值。</li>
						<li>
							单击“更新”。</li>
						<li>
							要添加其他标识符，请重复第&nbsp;2 步到第&nbsp;6 步。</li>
					</ol>
					<a name="#categories"></a>
					<h2>添加类别</h2>
					类别提供有关该提供程序的描述信息，例如其地理位置、所提供的服务或任何其他合适的分类。搜索和查询使用类别来查找特定类型、类别或特性的提供者。指派给该提供程序合适的分类，以便通过人工搜索或程序查询可以进行逻辑或直觉搜索。 
					<OL>
						<li>
							单击“类别”选项卡。
						<li>
							单击“添加类别”。</li>
						<li>
							选择合适的类别方案和子类别。<br>
							</li>
						<li>
							单击“添加类别”。</li>
						<li>
							要添加其他分类，请重复步骤&nbsp;2 到步骤&nbsp;5。</li>
					</OL>
					<a name="#discovery"></a>
					<h2>添加搜索 URL</h2>
					搜索 URL 提供一个指向有关提供程序的其他技术性或描述性信息的链接。<uddi:ContentController Runat='server' Mode='Private'>创建提供者时，“UDDI&nbsp;服务”自动创建指向“UDDI&nbsp;服务”安装内的该提供程序的 businessEntity 的搜索 URL。</uddi:ContentController>
					<ol>
						<li>
							单击“搜索 URL”选项卡。</li>
						<li>
							单击“添加 URL”。</li>
						<li>
							在“搜索 URL”中，输入包含要发布数据的 URL。</li>
						<li>
							在“使用类型”中，键入该“搜索 URL”的使用类型。</li>
						<li>
							单击“更新”。</li>
						<li>
							要添加其他“搜索 URL”，请重复第&nbsp;2 步到第&nbsp;5 步。</li>
					</ol>
					<a name="#relationships"></a>
					<h2>添加关系</h2>
					关系用于定义要公开的提供者之间的关系。当描述组织结构或公布提供者之间的合作关系时，关系非常有用。
					<ol>
						<li>
							单击“关系”选项卡。</li>
						<li>
							单击“添加关系”。</li>
						<li>
							选择要用其发布关系的提供者。</li>
						<li>
							在“关系类型”中，选择要建立的关系的类型。
							
							<ul>
								<li>
								<b>标识：</b>两个提供程序都代表同一组织。
								</li>
								<li>
								<b>父子：</b>一个提供者是另一提供程序的父级，例如子公司。
								</li>
								<li>
								<b>对等：</b>一个提供者是另一提供程序的对等。
								</li>
							</ul>
						<li>
							选择关系的方向。
							<ul>
								<li>
									<b>（您的提供者）到其他提供程序：</b>一种关系，您的提供者在其中代表父实体或对等实体。</li>
								<li>
									<b>其他提供程序到（您的提供者）：</b>一种关系，其他提供程序在其中代表父实体或对等实体。</li>
							</ul>
						</li>
						<li>
							单击“添加”。
						</li>
						<li>
							要添加其他关系，请重复第&nbsp;2 步到第&nbsp;6 步。
						</li>
					</ol>
					所定义的任何关系在被其他提供程序批准之前都不会发布。尚未被批准的关系在“关系”选项卡中总是显示为“搁置”，在其他提供程序的“关系”选项卡中总是显示为“等待批准”。<p>
					您已经添加和定义了提供程序，可以向其中添加联系人和服务了。详细信息，请参阅<a href="publish.addcontacts.aspx">如何添加联系人</a>或<a href="publish.addservices.aspx">如何添加服务</a>。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

