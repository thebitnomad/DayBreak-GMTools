<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_console, App_Web_console.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgSendSuc		= '<%= Resources.StringDef.SendSuc %>';

		var msgExecShellCmdConfirm	= '<%= Resources.StringDef.MsgExecShellCmdConfirm %>'; 
		
	</script>
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
		
			var textFieldShellKeydown = function( el, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					execShellCmd( );
					
					e.stopEvent( );
				}
			};
			
			var btnExecCmdClick = function( ) {
				var result = showConfirmMsg( msgTitle, msgExecShellCmdConfirm, function( btn ) {
					if( btn == "yes" ) {
						execShellCmd( );
					}
				});
			};
		
			var execShellCmd = function( ) {
				Ext.net.DirectMethods.ExecShellCmd( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{PanelShellRst}.body.dom.innerHTML += result.Result;
							#{FieldShellCmd}.reset( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
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
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:Panel ID="PanelShellRst" runat="Server" Padding="5" Margins="10" AutoScroll="true" Html=">> " >
					</ext:Panel>
				</Center>
				<South>
					<ext:Panel ID="Panel1" runat="Server" ButtonAlign="Center" Margins="10" Height="120" Border="false" >
						<Items>
							<ext:TextArea runat="Server" ID="FieldShellCmd" StyleSpec="width:100%;margin-right:10px;" Height="120" EnableKeyEvents="true">
								<Listeners>
									<KeyDown Fn="textFieldShellKeydown" />
								</Listeners>
							</ext:TextArea>
						</Items>
						<Buttons>
							<ext:Button runat="Server" ID="BtnExecCmd" Text="<%$ Resources:StringDef, Execute %>">
								<Listeners>
									<Click Fn="btnExecCmdClick" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</South>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

