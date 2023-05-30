<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_procscript, App_Web_procscript.aspx.b81705c1" validaterequest="false" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgSendSuc		= '<%= Resources.StringDef.SendSuc %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var queryInterval;
			
			var btnExecScriptClick = function( ) {
				var script = #{TextFieldScript};
				
				Ext.net.DirectMethods.ExecScript( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgSendSuc );
							
							queryInterval = setInterval( queryExecResult, 1 );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var queryExecResult = function( ) {
				Ext.net.DirectMethods.QueryExecScript( {
					success: function( result ) {
						if( result.Success ) {
							clearInterval( queryInterval );
							#{PanelResult}.el.dom.innerText = result.Result;
						}
					}
				});
			};
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" Border="false">
				<Center>
					<ext:Panel runat="Server" >
						<Items>
							<ext:TextField runat="server" ID="TextFieldScript" Width="500" FieldLabel="Script"  >
							</ext:TextField>
							<ext:Button runat="Server" ID="BtnExecScript" Text="Exec">
								<Listeners>
									<Click Fn="btnExecScriptClick" />
								</Listeners>
							</ext:Button>
						</Items>
					</ext:Panel>
				</Center>
				<South>
					<ext:Panel ID="PanelResult" runat="Server" EnableViewState="false" Height="300">
					</ext:Panel>
				</South>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
