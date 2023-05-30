<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_snap, App_Web_snap.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content4" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
		
			var refreshSnap = function( ) {
				Ext.net.DirectMethods.RefreshSnapshot( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
							#{PanelSnap}.body.dom.innerHTML = result.Result;
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var initData = function( ) {
				refreshSnap( );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:Panel ID="PanelSnap" runat="Server" PreventBodyReset="true" Border="false" AutoScroll="true" Padding="5">
						<TopBar>
							<ext:Toolbar runat="Server">
								<Items>
									<ext:Button runat="Server" ID="BtnRefresh" Icon="ArrowRefresh" Text="<%$ Resources:StringDef, Refresh %>">
										<Listeners>
											<Click Handler="
												refreshSnap( );
											" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<%--<ext:ToolTip ID="ToolTipMsg" runat="server" Target="#{GridPanelEventLog}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" Width="300">
		<Listeners>
			<Show Fn="showMsgTip" />
		</Listeners>
	</ext:ToolTip>--%>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

