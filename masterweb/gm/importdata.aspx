<%@ page language="C#" autoeventwireup="true" masterpagefile="~/common/main.master" inherits="op_importdata, App_Web_importdata.aspx.b931aa99" theme="default" %>

<asp:Content ContentPlaceHolderID="HeaderHolder" Runat="server">
	
	<script type="text/javascript">
		var msgAddConfig				= '<%= Resources.StringDef.AddConfig %>';
		var msgModifyConfig				= '<%= Resources.StringDef.ModifyConfig %>';
		var msgCannotBeNullFormat		= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgName						= '<%= Resources.StringDef.Name %>';
		var msgTitle					= '<%= Resources.StringDef.Config %>';
		var msgSubmitting				= '<%= Resources.StringDef.Submitting %>';
		var msgOpSuc					= '<%= Resources.StringDef.OpSuc %>';
		var msgTitle					= '<%= Resources.StringDef.Config %>';
		var msgMySqlServerConfig		 = '<%= Resources.StringDef.MySqlServerConfig %>';
	</script>

	<ext:XScript ID="XScript" runat="Server">
		<script type="text/javascript">
			
			var selConfigOp	= 0;   //选择导入mysql服务器的配置文件(保存着mysql的用户密码等)  0 添加 1 修改
			
			var initData = function( ) {
				queryConfig( );
			};

			var queryConfig = function( reset, callback ) {
				var paramStart = 0;
			
				#{StoreConfig}.load( { params:{ start: paramStart } } );
			};
			
			var gridCfgSelectionChange =function ( e1 ) {
				#{BtnDeleteConfig}.setDisabled( e1.getCount( ) < 1  );
				#{BtnModifyConfig}.setDisabled( e1.getCount( ) < 1 );
			};
			
			var gridCfgDBClick = function ( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showCfgDetail( record );
				
				selConfigOp = 1;
			};
			
			var showCfgDetail = function( record ) {
				#{TextFieldName}.setValue( record.data.Name );
				#{TextFieldOldName}.setValue( record.data.Name );
				#{TextFieldUserName}.setValue( record.data.UserName );
				#{TextFieldPassword}.setValue( record.data.Password );
				#{TextFieldPort}.setValue( record.data.Port );
				#{TextFieldIpAddress}.setValue( record.data.IpAddress );
				#{TextFieldDBName}.setValue( record.data.DBName );
				#{TextFieldCharSet}.setValue( record.data.CharSet );
				#{WindowConfig}.setTitle( msgModifyConfig );
				#{WindowConfig}.show( );
			};
			
			var addConfig = function( ) {
				#{FormPanelConfig}.reset( );
				#{WindowConfig}.setTitle( msgAddConfig );
				#{WindowConfig}.show( );
				
				selConfigOp = 0;
			};
		
			var modifyConfig = function( ) {
				var record = #{GridPanelQuickImportRoleData}.getSelectionModel( ).getSelected( );
				showCfgDetail( record );
				
				selConfigOp = 1;
			};
			
			var deleteConfig = function () {
			
				var record = #{GridPanelQuickImportRoleData}.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgMySqlServerConfig, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteConfig( record.data.Name, {
							eventMask : {
								showMask : true,
								minDelay : 200,
								msg		 : msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
									queryConfig( );
								}
								else if( result.ErrorMessage ){
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var setConfig = function( ) {
				var oldName = #{TextFieldOldName}.getValue( );
				var name = #{TextFieldName}.getValue( );
				if( name.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				Ext.net.DirectMethods.SetConfig( selConfigOp, oldName, {
					eventMask: {
						showMask :	true,
						minDelay :	200,
						msg		 :	msgSubmitting
					},
					success: function( result ) {
						if( result.Success ){
							showSuccessMsg( msgTitle, msgOpSuc );
							queryConfig( );
							#{WindowConfig}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var importRoleData = function( ) {
				var record = #{GridPanelQuickImportRoleData}.getSelectionModel( ).getSelected( );
				Ext.net.DirectMethods.ImportRoleData( record.data.Name, {
					eventMask: {
						showMask :	true,
						minDelay :	200,
						msg		 :	msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
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
<asp:content contentplaceholderid="ContentHolder" runat="Server">
	<ext:Store ID="StoreConfig" runat="Server" RemotePaging="false" RemoteSort="false"
		AutoLoad="false" OnRefreshData="RefreshConfig">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
				CustomTarget="#{GridPanelQuickImportRoleData}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="Password" Mapping="Password" Type="String" />
					<ext:RecordField Name="Port" Mapping="Port" Type="String" />
					<ext:RecordField Name="IpAddress" Mapping="IpAddress" Type="String" />
					<ext:RecordField Name="DBName" Mapping="DBName" Type="String" />
					<ext:RecordField Name="CharSet" Mapping="CharSet" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout" runat="Server" StyleSpec="background-color:#FFF;">
				<Center>
					<ext:GridPanel ID="GridPanelQuickImportRoleData" runat="Server" StoreID="StoreConfig"
						AutoExpandColumn="Name" ButtonAlign="Center">
						<TopBar>
							<ext:Toolbar ID="ToolBar" runat="Server">
								<Items>
									<ext:Button ID="BtnAddConfig" runat="Server" Text="<%$ Resources:StringDef, Add %>"
										Icon="Add">
										<Listeners>
											<Click Fn="addConfig" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDeleteConfig" runat="Server" Text="<%$ Resources:StringDef, Delete %>"
										Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteConfig" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyConfig" runat="Server" Text="<%$ Resources:StringDef, Modify %>"
										Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyConfig" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:Column DataIndex="Name" Header="<%$ Resources:StringDef, Name %>">
								</ext:Column>
								<ext:Column DataIndex="IpAddress" Header="<%$ Resources:StringDef, IpAddress %>" Width="150">
								</ext:Column>
								<ext:Column DataIndex="DBName" Header="<%$ Resources:StringDef, DBName %>" Width="120" Hidden="true">
								</ext:Column>
								<ext:Column DataIndex="CharSet" Header="<%$ Resources:StringDef, SvrCfgLangCharSet %>" Width="80" Hidden="true">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridCfgSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridCfgDBClick" />
						</Listeners>
						<Buttons>
							<ext:Button ID="BtnImpoprtRoleData" runat="Server" Text="<%$ Resources:StringDef, Import %>" Width="80">
								<Listeners>
									<Click Fn="importRoleData" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<ext:Window ID="WindowConfig" runat="Server" Resizable="false" Width="500" AutoHeight="true"
		Hidden="true" CloseAction="Hide" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelConfig" runat="Server" ButtonAlign="Center" Padding="10"
				LabelWidth="120" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldOldName" runat="Server" AnchorHorizontal="95%" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldUserName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, UserName %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldPassword" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Password %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldPort" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Port %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldIpAddress" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, IpAddress %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldDBName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, DBName %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldCharSet" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, SvrCfgLangCharSet %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonSetConfig" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setConfig" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button13" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowConfig}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ContentPlaceHolderID="TailHolder" Runat="server">
</asp:Content>
