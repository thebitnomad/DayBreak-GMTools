<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_cltsvrlist, App_Web_cltsvrlist.aspx.b81705c1" theme="default" %>

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
			};
			
			var initData = function( ) {
				if( #{TreePanelSvrRegion}.root.childNodes.length > 0 )
					#{TreePanelSvrRegion}.selectPath( #{TreePanelSvrRegion}.root.childNodes[0].getPath( ) );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport2" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="server">
				<Center>
					<ext:Panel ID="Panel1" runat="Server" Border="false" PaddingSummary="5px 5px 5px 5px" BodyStyle="background-color:white;">
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="Server">
								<Items>
									<ext:Button ID="Button1" runat="server" Text="111添加服务区"></ext:Button>
									<ext:Button ID="Button2" runat="server" Text="111添加服务器"></ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<Items>
							<ext:BorderLayout ID="BorderLayout2" runat="server">
								<West>
									<ext:TreePanel ID="TreePanelSvrRegion" runat="server" Width="240" RootVisible="false" TrackMouseOver="true" 
										Border="true" AutoScroll="true" Margins="10" Title="<div style='text-align:center;'>111服务区</div>" >
										<Root>
										</Root>
										<Listeners>
											<Click Handler="switchCmd( node );" />
										</Listeners>
									</ext:TreePanel>
								</West>
								<Center>
									<ext:Panel ID="PanelGMCommand" runat="server" Height="300" Layout="card" Border="true" 
										ActiveIndex="0" Title="<div style='text-align:center;'>111服务器</div>" StyleSpec="margin:10px 10px 10px 0px;" >
										<Items>
										</Items>
									</ext:Panel>
								</Center>
							</ext:BorderLayout>
						</Items>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
