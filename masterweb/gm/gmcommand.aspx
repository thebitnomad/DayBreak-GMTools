<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_gmcommand, App_Web_gmcommand.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.gmidx-normal, .gmidx-curr
		{
			border:1px solid #fff;
			margin:2px;
		}
		
		.gmidx-normal .x-tree-ec-icon, .gmidx-curr .x-tree-ec-icon
		{
			display:none;
		}
		
		.gmidx-normal a span
		{
			vertical-align: middle;
			height:22px;
			line-height :22px;
		}
		
		.gmidx-curr a span
		{
			vertical-align: middle;
			height:22px;
			line-height :22px;
			font-weight:bold;
		}
		
		.ext-ie8 .gmidx-normal a span, .ext-ie8 .gmidx-curr a span
		{
			padding-top:7px;
			display: inline-block;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.x-tree-selected a span
		{
			background:transparent;
			color:#15428b;
		}
				
		.gmidx-icon
		{
			height:22px !important;
			width:22px !important;
			background-image: url('../images/yellow.png') !important;
			background-repeat: no-repeat;
			vertical-align:middle !important;
		}
	</style>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		var msgExecSuccess	= '<%= Resources.StringDef.ExecSuccess %>';
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_roleName	= '';
			var m_accName	= '';
			var m_ggId		= 0;
		
			var btnExecClick = function( ) {
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
							#{FieldAccount}.setValue( result.Result.Account );
							#{FieldOnlineState}.setValue( result.Result.OnlineState );
							#{FieldFreezeState}.setValue( result.Result.FreezeState );
							#{FieldLastLoginTime}.setValue( result.Result.LastLoginTime );
							#{FieldLastLoginIP}.setValue( result.Result.LastLoginIP );
							#{FieldCreateTime}.setValue( result.Result.CreateTime );
							#{FieldCreateIP}.setValue( result.Result.CreateIP );
							#{FieldLeftGameCoin}.setValue( result.Result.LeftGameCoin );
						
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
			
			var switchCmd = function( node ) {
				var index = eval( node.id );
				#{PanelGMCommand}.layout.setActiveItem( #{PanelGMCommand}.items.items[index] );
				//setRoleName( );
			};
			
			var initData = function( ) {
				if( #{TreePanelCmdIndex}.root.childNodes.length > 0 )
					#{TreePanelCmdIndex}.selectPath( #{TreePanelCmdIndex}.root.childNodes[0].getPath( ) );
					
				//setRoleName( );
			};
			
			var btnExecClick = function( ) {
				#{WindowConfirm}.show( );
			};
			
			var execGMCommand = function( ) {
				//var ggId		= svrComboGetSelectedSvrId( );
				
				var ggId		= m_ggId;
				var currPanel	= #{PanelGMCommand}.layout.activeItem;
				var currIndex	= #{PanelGMCommand}.items.indexOf( currPanel );
				var reason		= #{FieldReason}.getValue( );
				var account		= m_accName;
				var cmd			= currPanel.cmdTpl;
				var typeDesc	= currPanel.typeDesc;
				
				var paramList	= new Array( );
				
				for( var itemIndex = 0; currPanel.items.length; ++itemIndex ) {
					var itemId		= String.format( "ctl00_ContentHolder_GM{0}_Param{1}", currIndex, itemIndex );
					var paramItem	= Ext.get( itemId );
					if( !paramItem )
						break;
					
					var paramValue	= paramItem.getValue( );
										
//					var paramHolder	= "{" + itemIndex + "}";
//					cmd = cmd.replace( paramHolder, paramValue ); 

					paramList.push( paramValue );
				}
				
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/ExecGMCommand",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: ggId,
						account		: account,
						roleName	: m_roleName,
						cmdTpl		: cmd,
						typeDesc	: typeDesc,
						reason		: reason,
						jsonParam	: paramList
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgExecSuccess );
							#{WindowConfirm}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var setRoleName = function( ) {
				if( !m_roleName )
					return;
			
				var currPanel		= #{PanelGMCommand}.layout.activeItem;
				var currIndex		= #{PanelGMCommand}.items.indexOf( currPanel );
				
				var itemRoleName	= Ext.get( String.format( "ctl00_ContentHolder_GM{0}_Param0", currIndex ) );
				if( itemRoleName ) {
					itemRoleName.setValue( m_roleName );
				}
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport2" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="server">
				<West>
					<ext:TreePanel ID="TreePanelCmdIndex" runat="server" Width="240" RootVisible="false" TrackMouseOver="true" 
						Border="true" AutoScroll="true" Title="<%$ Resources:StringDef, GMCommand %>">
						<Root>
						</Root>
						<Listeners>
							<Click Handler="switchCmd( node );" />
						</Listeners>
					</ext:TreePanel>
				</West>
				<Center>
					<ext:Panel ID="Panel1" runat="Server" Border="false">
						<Items>
							<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:white;">
								<North>
									<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="180"
										Title="<%$ Resources:StringDef, GameServer %>" Height="70" Padding="15" Hidden="true"
										ButtonAlign="Center" Border="true" Margins="0px 0px 5px 5px">
										<Items>
											<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
												<Items>
													<ext:Container ID="Container2" runat="Server">
														<Content>
															<sat:SvrCombo runat="Server" ID="svrCombo1" />
														</Content>
													</ext:Container>
												</Items>
											</ext:CompositeField>
										</Items>
									</ext:FormPanel>
								</North>
								<Center>
									<ext:Panel ID="PanelGMCommand" runat="server" Padding="15" Height="300" Layout="card" Border="false"
										ActiveIndex="0" Title="<%$ Resources:StringDef, Param %>" StyleSpec="margin-left:5px; border:1px solid #8DB2E3; background-color:white;" ButtonAlign="Center" >
										<Items>
										</Items>
										<Buttons>
											<ext:Button ID="btnExec" runat="server" Text="<%$ Resources:StringDef, Execute %>" Scale="Medium" Width="150" Icon="BulletGo">
												<Listeners>
													<Click Fn="btnExecClick" />
												</Listeners>
											</ext:Button>
										</Buttons>
									</ext:Panel>				
								</Center>
							</ext:BorderLayout>
						</Items>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowConfirm" runat="server" Resizable="false" Maximizable="false"
		Width="500" Height="110" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:BorderLayout ID="BorderLayout3" runat="server">
				<Center>
					<ext:FormPanel ID="PanelConfirm" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
						<Items>
							<ext:ComboBox ID="FieldReason" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, Reason %>" Editable="true" ForceSelection="false">
								<Items>
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason1 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason2 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason3 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason4 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason5 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason6 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason7 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason8 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason9 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason10 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason11 %>" />
									<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason12 %>" />
								</Items>
							</ext:ComboBox>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnConfirm" runat="Server" Text="<%$ Resources:StringDef, Ok %>">
				<Listeners>
					<Click Fn="execGMCommand" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnConfirmCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowConfirm}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

