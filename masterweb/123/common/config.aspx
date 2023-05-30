<%@ page language="C#" autoeventwireup="true" inherits="common_config, App_Web_config.aspx.38131f0b" theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="Server">
	<title><%= Resources.StringDef.SystemName %> - <%= Resources.StringDef.SystemDesc %></title>
	<style type="text/css">
		
		.x-tree-node div.menu-node
		{
			background:#eee url(../images/menu/cmp-bg.gif) repeat-x;
			margin-top:1px;
			border-top:1px solid #ddd;
			border-bottom:1px solid #ccc;
			padding-top:2px;
			padding-bottom:1px;
		}
		
		.menu-node .x-tree-node-icon
		{
			display:none;
		}
		
		.menu-leaf
		{
			border:1px solid #fff;
			margin:2px;
		}
		
		.menu-leaf .x-tree-ec-icon
		{
			display:none;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.menu-leaf a span
		{
			vertical-align: middle;
		}
		
		.ext-ie8 .menu-leaf a span
		{
			padding-top:7px;
			display: inline-block;
		}
		
		.x-tree-selected a span
		{
			background:transparent;
			color:#15428b;
			font-weight:bold;
		}
		
		.x-grid3-td-Msg .x-grid3-cell-inner
		{
			white-space:normal;
			margin:3px 3px 3px 3px !important;
			line-height:15px;
		}
		
		.old-msg
		{
			color:Gray;
		}
		
		.new-msg
		{
			font-weight: bold;
		}
		
		.copyright
		{
			text-align:center;
			padding:3px;
		}
		
	</style>
</head>
<head>
	<script type="text/javascript">
		var msgTitle = '<%= Resources.StringDef.SystemName %>';
		var msgSystemDesc = '<%= Resources.StringDef.SystemDesc %>';
		var msgSubmitting = '<%= Resources.StringDef.Submitting %>';
		var msgModifyPassSuccess = '<%= Resources.StringDef.MsgModifyPassSuccess %>';
		var msgLogingout = '<%= Resources.StringDef.Logingout %>';
		var msgLogoutConfirm = '<%= Resources.StringDef.MsgLogoutConfirm %>';
		var msgPrompt = '<%= Resources.StringDef.Prompt %>';
		var msgView = '<%= Resources.StringDef.View %>';
		var systemMessage = '<%= Resources.StringDef.SystemMessage %>';

		var disableFuncKeys = function() {
			/* 屏蔽退格键 */
			Ext.fly(document).addKeyMap({
				key: Ext.EventObject.BACKSPACE,
				handler: function(source, e) {
					var target = Ext.fly(e.target);
					if ((target.is('input') || target.is('input') || target.is('textarea')) && !target.dom.readOnly)
						return;

					e.stopEvent();
				}
			});
		};
		
	</script>
</head>
<body>
	<form id="form1" runat="server">
	<ext:ResourceManager ID="ResourceManager1" runat="server">
	</ext:ResourceManager>
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout runat="Server">
				<North Margins-Bottom="2">
					<ext:Panel ID="PanelNorth" runat="server" Header="false" Height="34" PreventBodyReset="true" ContentEl="headerDiv">
					</ext:Panel>
				</North>
				<Center>
					<ext:Panel ID="Panel1" runat="server" PaddingSummary="0px 150px 0px 150px">
						<Items>
							<ext:FieldSet ID="FieldSet2" runat="server" Title="111基本配置" Collapsible="true" LabelAlign="Right" Layout="form" LabelWidth="200">
								<Items>
									<ext:TextField ID="TextField4" runat="Server" AnchorHorizontal="70%" FieldLabel="111系统IP" >
									</ext:TextField>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet ID="FieldSetMySQL" runat="server" Title="111数据库" Collapsible="true" LabelAlign="Right" Layout="form" LabelWidth="200">
								<Items>
									<ext:TextField ID="TextField" runat="Server" AnchorHorizontal="70%" FieldLabel="111用户名" >
									</ext:TextField>
									<ext:TextField ID="TextField2" runat="Server" AnchorHorizontal="70%" FieldLabel="111密码" >
									</ext:TextField>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet ID="FieldSet3" runat="server" Title="111eRating" Collapsible="true" LabelAlign="Right" Layout="form" LabelWidth="200">
								<Items>
									<ext:TextField ID="TextField5" runat="Server" AnchorHorizontal="70%" FieldLabel="111IP地址" >
									</ext:TextField>
									<ext:TextField ID="TextField6" runat="Server" AnchorHorizontal="70%" FieldLabel="111端口" >
									</ext:TextField>
								</Items>
							</ext:FieldSet>
						</Items>
					</ext:Panel>
				</Center>
				<South>
					<ext:Panel ID="PanelSouth" runat="server" Header="false" Height="20" PreventBodyReset="true" BodyStyle="background-color:#DFE8F6;" 
						Border="false" HTML="<%$ Resources:StringDef, MsgCopyRight %>" Cls="copyright" >
					</ext:Panel>
				</South>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<div id="headerDiv" style="border: 0 none; background: url(../images/hbg.gif) repeat-x 0 0; height: 34px;">
		<div class="logo"><%= Resources.StringDef.SystemName %></div>
		<div style="float:right; color:#FFF; margin-top:8px;margin-right:5px;">
			<ext:Label ID="LabelUserName" runat="Server" EnableViewState="false" StyleSpec="font-weight:bold;" />
			<ext:Label ID="LabelLoginTime" runat="Server" EnableViewState="false" />
			<ext:Label ID="Label1" runat="Server" Text="|" />
			<ext:LinkButton ID="LinkUserMsg" runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, SystemMessage %>" StyleSpec="padding-top:2px;" HideMode="Visibility">
				
			</ext:LinkButton>
			<ext:Label ID="Label2" runat="Server" Text="|" />
			<ext:LinkButton ID="LinkModifyPass" runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, ModifyPass %>" Visible="false" >
				
			</ext:LinkButton>
			<ext:Label runat="server" ID="LabelModifyPassAdditional" Text="|" Visible="false" />
			<ext:LinkButton ID="LinkButton1" runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, Logout %>" StyleSpec="padding-top:2px;">
				
			</ext:LinkButton>
		</div>
	</div>
	<div id="footerDiv" style="border: 0 none; text-align:center; padding: 2px; background-color:transparent;">
		<asp:Literal ID="Literal1" runat="Server" Text="<%$ Resources:StringDef, MsgCopyRight %>" />
	</div>
	</form>
</body>
</html>
