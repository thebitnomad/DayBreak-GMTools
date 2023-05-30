

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
					<H1>如何添加联系人 - <img src="../../images/contact.gif" width="16" height="16" alt="联系人" border="0"></H1>
					<p>联系人是组织内对提供者或提供程序所提供的服务提供支持或帮助的任何联系点。
					</p>
					<!-- #include file = "warning.changestouddi.htm" --> <b>转到：</b><a href="#contact">添加联系人</a>、<a href="#emails">添加电子邮件地址</a>、<a href="#phones">添加电话号码</a>、<a href="#addresses">添加地址</a>。
					<h2><a name="contact"></a>添加联系人</h2>
					<OL>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>找到要向其中添加联系人的提供者，然后单击联系人名称旁边的“查看”。
						<li>单击“联系人”选项卡。
						<li>单击“添加联系人”。<BR>出现 <img src="../../images/contact.gif" width="16" height="16" alt="" border="0">（新建联系人）。</li>
						<LI>
							在详细信息区域中，请单击“编辑”。</LI>
						<LI>
							在“联系人姓名”字段中，键入一个名称。</LI>
						<li>
							在“使用类型”中，输入该联系人的用途，如“技术查询”或“客户服务查询”。</li>
						<li>
							单击“更新”。</li>
						<LI>
							单击“添加描述”。</LI>
						<LI>
							在“语言”中，选择该描述的语言。</LI>
						<LI>
							在“描述”中键入简要描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
							要用其他语言添加其他描述，请重复步骤&nbsp;8 到步骤&nbsp;11。</LI>
					</OL>
					<a name="#emails"></a>
					<h2>添加电子邮件地址</h2>
					<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>找到包含了要将电子邮件地址添加到其中的联系人的提供者，然后单击电子邮件地址名称旁边的“查看”。
						<li>单击“联系人”选项卡。
						<li>找到要将电子邮件地址添加到其中的联系人，然后单击电子邮件地址名称旁边的“查看”。
						<li>
							单击“电子邮件”选项卡。</li>
						<LI>
							单击“添加电子邮件”。</LI>
						<LI>
							在“电子邮件”字段中，键入电子邮件地址。</LI>
						<li>
							在“使用类型”中，输入该电子邮件联系人的用途，如“客户服务查询”。</li>
						<li>
							单击“更新”。</li>
						<li>
							要添加其他电子邮件地址，请重复第&nbsp;2 步到第&nbsp;5 步。</li>
						<LI>
							单击“添加描述”。</LI>
						<LI>
							在“语言”中，选择该描述的语言。</LI>
						<LI>
							在“描述”中键入简要描述。</LI>
						<li>
							单击“更新”。</li>
						<LI>
						要用其他语言添加其他描述，请重复步骤&nbsp;7 到步骤&nbsp;10。
					</ol>
					<a name="#phones"></a>
					<h2>添加电话号码</h2>
					为该联系人提供一个或多个电话号码。
					<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>找到包含了要将电话号码添加到其中的联系人的提供者，然后单击电话号码名称旁边的“查看”。
						<li>单击“联系人”选项卡。
						<li>找到要向其中添加电话号码的联系人，然后单击电话号码名称旁边的“查看”。
						<li>
							单击“电话”选项卡。</li>
						<LI>
							单击“添加电话”。</LI>
						<LI>
							在“电话”中，键入电话号码。</LI>
						<li>
							在“使用类型”中，键入该电话号码的用途，如“FAX”、“TTY”或“Voice”。</li>
						<li>
							单击“更新”。</li>
						<li>
							要添加其他电话号码，请重复第&nbsp;2 步到第&nbsp;5 步。</li>
						<LI>
							单击“添加描述”。</LI>
						<LI>
							在“语言”列表中，选择该描述的语言。</LI>
						<LI>
							在“描述”中键入简要描述。</LI>
						<li>
							单击“更新”。</li>
						<li>
							要用其他语言添加其他描述，请重复步骤&nbsp;7 到步骤&nbsp;10。</li>
					</ol>
					<a name="#addresses"></a>
					<h2>添加地址</h2>
					为该联系人提供一个或多个地址，如物理位置、邮寄地址或邮箱。
					<ol>
						<li>在 <uddi:ContentController Runat='server' Mode='Private'>UDDI&nbsp;服务 </uddi:ContentController><uddi:ContentController Runat='server' Mode='Public'>UDDI</uddi:ContentController> 菜单上，请单击“发布”。</li>
						<li>单击“提供者”选项卡。
						<li>找到包含了要将地址添加到其中的联系人的提供者，然后单击地址名称旁边的“查看”。
						<li>单击“联系人”选项卡。
						<li>找到要将地址添加到其中的联系人，然后单击地址名称旁边的“查看”。
						<li>
							单击“地址”选项卡。</li>
						<LI>
							单击“添加地址”。</LI>
						<LI>
							在“地址”中，键入一个地址。
						</LI>
						<li>
							在“使用类型”中，键入该地址的用途，如“海运”或“书面技术通讯录”。</li>
						<li>
							单击“更新”。</li>
						<LI>
							要添加其他地址，请重复第&nbsp;2 步到第&nbsp;5 步。</LI>
					</ol>
					<p></p>
					现在已经为提供者添加和定义了联系人。<a href="#contact">重复这些步骤</a>可以添加和定义其他联系人。
				</td>
			</tr>
		</table>
		<!-- #include file = "publish.footer.htm" -->
	</body>
</html>

 

