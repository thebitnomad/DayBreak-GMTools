

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
					<H1>统计信息 — 发布者统计信息</H1>
					使用“发布者统计信息”选项卡查看发布者的总数、具有活动发布的发布者的数量以及每个不同实体类型的发布最多的发布者。显示的统计信息是基于屏幕下方、<I>最近重新计算</I>旁边显示的日期中累积的数据，且无法自动刷新。
					
					<UL>
					<LI><B>统计信息</B>&nbsp;&nbsp;列出“UDDI&nbsp;发布”的安装中发布者的总数以及具有活动发布的发布者的数量。具有活动发布的发布者是已经至少发布了一个提供者或（非隐藏的）或 tModel 的任何发布者。
					<LI><B>实体类型</B>&nbsp;&nbsp;按降序列出每个不同实体类型的发布最多的发布者，每个类型最多列出 10 个。</LI>
					</UL>
					<ul class="action">
						<li>请单击“重新计算”来刷新所有的统计信息。
					</ul>
					
				</td>
			</tr>
		</table>
		<!-- #include file = "coordinate.footer.htm" -->
	</body>
</html>

 

