<%@ control language="C#" autoeventwireup="true" inherits="gm_tabrole, App_Web_tabrole.ascx.b931aa99" %>

<script type="text/javascript">
	var msgDisableChat	= '<%= Resources.StringDef.DisableChat %>';
	var msgEnableChat	= '<%= Resources.StringDef.EnableChat %>';
	var msgFreeze		= '<%= Resources.StringDef.Freeze %>';
	var msgUnfreeze		= '<%= Resources.StringDef.Unfreeze %>';
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var tabRoleLoadRoleInfo = function( ggId, tabKey, roleName ) {
			var tab = #{TabPanelRoleInfo}.getItem( tabKey );

			if( !tab ) {
				tab = #{TabPanelRoleInfo}.add( {
					id: tabKey,
					title: roleName,
					closable: true,
					autoLoad: {
						showMask: true,
						url: 'roledetail.aspx?ggId=' + ggId + '&rname=' + encodeURI( roleName ),
						mode: "iframe",
						maskMsg: msgLoading
					},
					listeners: {
						update: {
							fn: function( tab, cfg ) {
								cfg.iframe.setHeight( cfg.iframe.getSize( ).height );
							},
							scope: this,
							single: true
						}
					}
				});
			}

			#{TabPanelRoleInfo}.setActiveTab( tab );
			#{WindowRoleInfo}.show( );
		};
	</script>
</ext:XScript>

<ext:Window ID="WindowRoleInfo" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, RoleInfo %>"
	Width="1100" Height="660" CloseAction="Hide" Collapsible="false" PaddingSummary="5px 0px 0px 0px"
	Hidden="true" Modal="true">
	<Items>
		<ext:BorderLayout ID="BorderLayout2" runat="server">
			<Center>
				<ext:TabPanel runat="Server" ID="TabPanelRoleInfo" Plain="true" Border="false">
				</ext:TabPanel>
			</Center>
		</ext:BorderLayout>
	</Items>
</ext:Window>
