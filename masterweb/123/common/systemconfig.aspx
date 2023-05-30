<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="common_systemconfig, App_Web_systemconfig.aspx.38131f0b" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" runat="server">

<script type="text/javascript">
	var msgSubmitting = '<%= Resources.StringDef.Submitting %>';
</script>

<script type="text/javascript">
	var msgTitle		= '<%= Resources.StringDef.SystemName %>';
	var msgLoading		= '<%= Resources.StringDef.Loading %>';
	var msgSaving		= '<%= Resources.StringDef.Saving %>';
	var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
	var msgSave			= '<%= Resources.StringDef.Save %>';
	var msgOK			= '<%= Resources.StringDef.OK %>';
	var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
</script>

<ext:XScript runat="Server">
	<script type="text/javascript">
		
		var initData = function( ) {
			fileManRefreshDir( );
			#{StoreSysVar}.load( );
		};
	
		var sysvarEdit = function( e ) {
			var record	= e.record;
			
			Ext.net.DirectMethods.ModifySystemVar( record.data.Name, record.data.Value, record.data.Desc, {
				eventMask: {
					showMask: true,
					minDelay: 200,
					msg: msgSubmitting
				},
				success: function( result ){
					if( result.Success ) {
						#{StoreSysVar}.commitChanges( );
					}
					else if( result.ErrorMessage ) {
						showErrMsg( msgTitle, result.ErrorMessage );
						#{StoreSysVar}.rejectChanges( );
					}
				}
			});
		};
	
	</script>
</ext:XScript>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
	<ext:Store ID="StoreSysVar" runat="server" OnRefreshData="StoreSysVarRefresh" RemotePaging="true"
		RemoteSort="true" AutoLoad="false">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelSysVar}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Value" Mapping="Value" Type="String" />
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="ViewPort1" runat="Server">
		<Items>
			<ext:Panel runat="Server" Height="250" Title="<%$ Resources:StringDef, SystemLog %>" StyleSpec="padding:10px 10px 0px 10px;" >
				<Content>
					<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false">
					</sat:FileMan2>
				</Content>
			</ext:Panel>
			
			<ext:GridPanel ID="GridPanelSysVar" runat="Server" Margins="10" Height="300" StyleSpec="padding:10px;"
				AutoExpandColumn="Desc" Title="<%$ Resources:StringDef, SystemVar %>" StoreID="StoreSysVar">
				<ColumnModel>
					<Columns>
						<ext:RowNumbererColumn>
							<Renderer Handler="return '';" />
						</ext:RowNumbererColumn>
						<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="200">
						</ext:Column>
						<ext:Column Header="<%$ Resources:StringDef, Value %>" DataIndex="Value" Width="400">
							<Editor>
								<ext:TextField runat="Server"></ext:TextField>
							</Editor>
						</ext:Column>
						<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Desc" Width="300">
							<Editor>
								<ext:TextField runat="Server"></ext:TextField>
							</Editor>
						</ext:Column>
					</Columns>
				</ColumnModel>
				<Listeners>
					<AfterEdit Fn="sysvarEdit" />
				</Listeners>
				<BottomBar>
					<ext:PagingToolbar ID="PagingToolbarStaff" runat="server" PageSize="50" StoreID="StoreSysVar">
					</ext:PagingToolbar>
				</BottomBar>
			</ext:GridPanel>
		</Items>
	</ext:Viewport>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" runat="server">
</asp:Content>
