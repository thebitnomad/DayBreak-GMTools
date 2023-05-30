<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_accinfo, App_Web_accinfo.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="GMBaseOp" Src="~/gm/baseop.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgOnline		= '<%= Resources.StringDef.Online %>';
		var msgOffline		= '<%= Resources.StringDef.Offline %>';

		var msgOpSuc		= '<%= Resources.StringDef.OpSuc %>';

		var msgAccountCanNotBeNull	= '<%= Resources.StringDef.MsgAccountCanNotBeNull %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
		
			var btnQueryClick = function( ) {
				var account = #{TextFieldQueryAcc}.getValue( );
				if( account.length == 0 ) {
					showErrMsg( msgTitle, msgAccountCanNotBeNull );
					return;
				}
				
				Ext.net.DirectMethods.QueryAccountInfo( account, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{FormPanelAccountInfo}.setVisible( true );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
//			var loadRoleInfo = function( roleGUID, roleName ) {
//				var tab = #{TabPanelRoleInfo}.getItem( roleGUID );

//				if( !tab ) {
//					tab = #{TabPanelRoleInfo}.add( {
//						id: roleGUID,
//						title: roleName,
//						closable: true,
//						autoLoad: {
//							showMask: true,
//							url: 'roledetail.aspx?ggId=' + m_ggId + '&rguid=' + roleGUID,
//							mode: "iframe",
//							maskMsg: msgLoading
//						},
//						listeners: {
//							update: {
//								fn: function(tab, cfg) {
//									cfg.iframe.setHeight(cfg.iframe.getSize().height);
//								},
//								scope: this,
//								single: true
//							}
//						}
//					});
//				}

//				#{TabPanelRoleInfo}.setActiveTab( tab );
//				#{WindowRoleInfo}.show( );
//			};
//			
//			var gridQueryResultRowDBClick = function( grid, rowIndex, e ) {
//				var record		= grid.store.getAt( rowIndex );
//				var roleGUID	= record.data.RoleGUID;
//				var roleName	= record.data.RoleName;
//				
//				loadRoleInfo( roleGUID, roleName );
//			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="400" Width="1000"
		Title="<%$ Resources:StringDef, QueryCondition %>" Height="105" Padding="10"
		ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px" StyleSpec="margin:10px;">
		<Items>
			<ext:TextField runat="Server" ID="TextFieldQueryAcc" FieldLabel="<%$ Resources:StringDef, Account %>" Width="200" >
				<Listeners>
					<SpecialKey Fn="textFieldQuerySpecialKey" />
				</Listeners>
			</ext:TextField>
		</Items>
		<Buttons>
			<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Query %>">
				<Listeners>
					<Click Fn="btnQueryClick" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:FormPanel>
							
	<ext:FormPanel ID="FormPanelAccountInfo" runat="Server" LabelAlign="Left" LabelWidth="120" Width="1000"
		Title="<%$ Resources:StringDef, AccountInfo %>" Height="160" Padding="10" ButtonAlign="Center"
		Border="true" Margins="10px 10px 10px 10px" Hidden="true" StyleSpec="margin:10px;">
		<TopBar>
			<ext:Toolbar ID="Toolbar1" runat="Server">
				<Items>
					<ext:Button ID="BtnFreeze" runat="Server" Icon="UserDelete" Text="<%$ Resources:StringDef, Freeze %>">
						<Listeners>
							<Click Handler="
								var accName = #{FieldAccount}.getValue( );
								var accId	= #{FieldAccID}.getValue( );
								gmOpSetAccountNoLogin( -1, accName, '', accId, true, function( result ) {
									btnQueryClick( );
								} );
							" />
						</Listeners>
					</ext:Button>
					<ext:Button ID="BtnUnfreeze" runat="Server" Icon="UserTick" Text="<%$ Resources:StringDef, Unfreeze %>">
						<Listeners>
							<Click Handler="
								var accName = #{FieldAccount}.getValue( );
								var accId	= #{FieldAccID}.getValue( );
								gmOpSetAccountNoLogin( -1, accName, '', accId, false, function( result ) {
									btnQueryClick( );
								} );
							" />
						</Listeners>
					</ext:Button>
				</Items>
			</ext:Toolbar>
		</TopBar>
		<Items>
			<ext:DisplayField ID="FieldAccount" runat="Server" FieldLabel="<%$ Resources:StringDef, Account %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldAccID" runat="Server" FieldLabel="<%$ Resources:StringDef, AccID %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldOnlineState" runat="Server" FieldLabel="<%$ Resources:StringDef, OnlineState %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldFreezeState" runat="Server" FieldLabel="<%$ Resources:StringDef, FreezeState %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldLastLoginTime" runat="Server" FieldLabel="<%$ Resources:StringDef, LastLoginTime %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldLastLoginIP" runat="Server" FieldLabel="<%$ Resources:StringDef, LastLoginIP %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldCreateTime" runat="Server" FieldLabel="<%$ Resources:StringDef, CreateTime %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldCreateIP" runat="Server" FieldLabel="<%$ Resources:StringDef, CreateIP %>" Width="400">
			</ext:DisplayField>
			<ext:DisplayField ID="FieldLeftGameCoin" runat="Server" FieldLabel="<%$ Resources:StringDef, LeftGameCoin %>" Width="400">
			</ext:DisplayField>
		</Items>
	</ext:FormPanel>
	
	<sat:GMBaseOp ID="GMBaseOp1" runat="Server" />
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
