<%@ page title="" language="C#" autoeventwireup="true" masterpagefile="~/common/main.master" inherits="op_servercommand, App_Web_servercommand.aspx.551d078a" theme="default" %>


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
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';
		var msgExecSuccess	= '<%= Resources.StringDef.ExecSuccess %>';
	</script>

	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var selggs;

			var switchCmd = function( node ) {
				var index = eval(node.id);
				#{PanelServerCommand}.layout.setActiveItem( #{PanelServerCommand}.items.items[index] );
			};
			
			var initData = function( ) {
				if( #{TreePanelCmdIndex}.root.childNodes.length > 0 ) {
					#{TreePanelCmdIndex}.selectPath( #{TreePanelCmdIndex}.root.childNodes[0].getPath( ) );
				}
			};
			
			var execGMCommand = function( ) {
				var currPanel	= #{PanelServerCommand}.layout.activeItem;
				var currIndex	= #{PanelServerCommand}.items.indexOf( currPanel );
				var cmdTpl		= currPanel.cmdTpl;
				var cmdName		= currPanel.cmdName;
				var cmdType		= eval( currPanel.cmdType );
				
				var paramList	= new Array( );
				
				for( var itemIndex = 0; currPanel.items.length; ++itemIndex ) {
					var itemId		= String.format( "ctl00_ContentHolder_Ser{0}_Param{1}", currIndex, itemIndex );
					var paramItem	= Ext.get( itemId );
					if( !paramItem )
						break;
					
					var paramValue	= paramItem.getValue( );
					
					paramList.push( paramValue );
				}
				
				Ext.net.DirectMethod.request( {
					url				: "dataservice.asmx/ExecCtrlCmd",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: selggs,
						cmdName		: cmdName,
						type		: cmdType,
						cmdTpl		: cmdTpl,
						reason		: '',
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
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport2" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="server">
				<West>
					<ext:TreePanel ID="TreePanelCmdIndex" runat="server" Width="300" RootVisible="false" TrackMouseOver="true" 
						Border="false" AutoScroll="true" Title="<%$ Resources:StringDef, ServerCommand %>"  StyleSpec="margin-right:5px; border-right:1px solid #8DB2E3; background-color:white;" >
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
								<Center>
									<ext:Panel ID="PanelServerCommand" runat="server" Padding="10" Height="300" Layout="card" Border="false" Margins="0px 0px 1px 0px"
										ActiveIndex="0" Title="<%$ Resources:StringDef, Param %>" StyleSpec="margin-left:5px; border-left:1px solid #8DB2E3; background-color:white;" ButtonAlign="Center" >
										<Items>
										</Items>
										<Buttons>
											<ext:Button ID="btnExec" runat="server" Text="<%$ Resources:StringDef, Execute %>" Scale="Medium" Width="150" Icon="BulletGo">
												<Listeners>
													<Click Fn="execGMCommand" />
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>