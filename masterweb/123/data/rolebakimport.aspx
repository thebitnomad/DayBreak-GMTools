<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="data_rolebakimport, App_Web_rolebakimport.aspx.551d078a" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">

			var importRoleData = function( ) {
				var fileName = fileManGetSelFileName( );
				var filePath = fileManGetSelFile( );
				if( !filePath )
					return;
				
				#{WindowImportData}.load( {
					url			:'../gm/importdata.aspx?type=1&fname=' + encodeURI( filePath ),
					discardUrl	: false,
					nocache		: true,
					timeout		: 30
				} );
				
				#{WindowImportData}.show( );
			};
			
			var initData = function( ) {
				fileManRefreshDir( );
			};
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Panel runat="Server" ButtonAlign="Center">
						<Items>
							<ext:Container ID="Container1" runat="server" Height="530">
								<Content>
									<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false">
									</sat:FileMan2>
								</Content>
							</ext:Container>
						</Items>
						<Buttons>
							<ext:Button runat="Server" ID="Button1" Text="<%$ Resources:StringDef, Next %>">
								<Listeners>
									<Click Fn="importRoleData" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowImportData" runat="server" Resizable="true" Maximizable="false" BodyBorder="false"
		Width="600" Height="320" Padding="0" CloseAction="Hide" Collapsible="false" Title="<%$ Resources:StringDef, RoleImport %>"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
</asp:Content>


