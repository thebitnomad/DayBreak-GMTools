<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="common_platsel, App_Web_platsel.aspx.38131f0b" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgLoading = '<%= Resources.StringDef.Loading %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var selPlatform = function( platformId ) {
				Ext.getBody().mask( msgLoading );
				Ext.net.DirectMethods.SelectPlatform( platformId, {
					success: function( result ) {
						if( result.Success ) {
							window.location.href = result.Result;
						}
					}
				} );
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Window ID="WindowPlatformItem" runat="server" Closable="false" Resizable="false" Height="525" Draggable="true" AutoScroll="true"
		Title="<%$ Resources:StringDef, MsgPleaseSelectPlatform %>" Width="1000" Modal="true" BodyStyle="background-color:#FFF;">
		<Items>
			<ext:Panel runat="server" AutoScroll="true" Border="false" Height="490">
				<Items>
					<ext:ColumnLayout ID="ColumnLayout1" runat="Server" Split="true" FitHeight="true">
						<Columns>
							<ext:LayoutColumn ColumnWidth="0.25">
								<ext:Panel ID="Panel1" runat="Server" Border="false" AutoScroll="true">
									<Defaults>
										<ext:Parameter Name="margins" Value=" 0 0 0 0 " Mode="Value" />
									</Defaults>
									<Items>
										<ext:VBoxLayout ID="VBoxLayout1" runat="Server" Padding="10" Align="Left" Pack="Start" Selectable="true">
											<BoxItems>
											</BoxItems>
										</ext:VBoxLayout>
									</Items>
								</ext:Panel>
							</ext:LayoutColumn>
							<ext:LayoutColumn ColumnWidth="0.25">
								<ext:Panel ID="Panel2" runat="Server" Border="false"  AutoScroll="true" >
									<Defaults>
										<ext:Parameter Name="margins" Value="0 5 0 0" Mode="Value" />
									</Defaults>
									<Items>
										<ext:VBoxLayout ID="VBoxLayout2" runat="Server" Padding="10" Align="Left" Pack="Start" Selectable="true">
											<BoxItems>
											</BoxItems>
										</ext:VBoxLayout>
									</Items>
								</ext:Panel>
							</ext:LayoutColumn>
							<ext:LayoutColumn ColumnWidth="0.25">
								<ext:Panel ID="Panel3" runat="Server" Border="false"  AutoScroll="true" >
									<Defaults>
										<ext:Parameter Name="margins" Value="0 5 0 0" Mode="Value" />
									</Defaults>
									<Items>
										<ext:VBoxLayout ID="VBoxLayout3" runat="Server" Padding="10" Align="Left" Pack="Start" Selectable="true">
											<BoxItems>
											</BoxItems>
										</ext:VBoxLayout>
									</Items>
								</ext:Panel>
							</ext:LayoutColumn>
							<ext:LayoutColumn ColumnWidth="0.25">
								<ext:Panel ID="Panel4" runat="Server" Border="false"  AutoScroll="true">
									<Defaults>
										<ext:Parameter Name="margins" Value="0 5 0 0" Mode="Value" />
									</Defaults>
									<Items>
										<ext:VBoxLayout ID="VBoxLayout4" runat="Server" Padding="10" Align="Left" Pack="Start" Selectable="true">
										</ext:VBoxLayout>
									</Items>
								</ext:Panel>
							</ext:LayoutColumn>
						</Columns>
					</ext:ColumnLayout>
				</Items>
			</ext:Panel>
		</Items>
	</ext:Window>
</asp:Content>
