<%@ page language="C#" autoeventwireup="true" masterpagefile="~/common/main.master" inherits="data_sercmdconfig, App_Web_sercmdconfig.aspx.551d078a" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle				= '<%= Resources.StringDef.SvrCmdParamConfig %>';
		var msgSvrCmdTitle			= '<%= Resources.StringDef.SvrCommand %>';
		var msgName					= '<%= Resources.StringDef.Name %>';
		var msgSubmitting			= '<%= Resources.StringDef.Submitting %>';
		var msgOpSuc				= '<%= Resources.StringDef.OpSuc %>';
		var msgNoParams				= '<%= Resources.StringDef.NoParams %>';

		var msgSelNoGameGroup			= '<%= Resources.StringDef.MsgSelNoGameGroup %>';
		var msgDelServerCommandParam	= '<%= Resources.StringDef.MsgDelServerCommandParam %>';
		var msgServerCommand			= '<%= Resources.StringDef.MsgServerCommand %>';
		var msgAddServerCommand			= '<%= Resources.StringDef.AddServerCommand %>';
		var msgModifyServerCommand		= '<%= Resources.StringDef.ModifyServerCommand %>';
		var msgAddServerCommandParam	= '<%= Resources.StringDef.AddServerCommandParam %>';
		var msgModifyServerCommandParam = '<%= Resources.StringDef.ModifyServerCommandParam %>';
		var msgUploadFileSuccess		= '<%= Resources.StringDef.MsgUploadFileSuccess %>';	
	</script>
	
	<ext:XScript ID="XScript" runat="Server">
		<script type="text/javascript">
			var svrCmdOp		= 0;  //服务器指令： 0 添加  1修改
			var svrCmdParamOp	= 0;  //服务器指令配置： 0 添加 1修改
			var cmdTplName		= '';
			var tplparam		= '';
			
			var gridSvrCmdSelectionChange = function( el  ) {

				#{ModifySvrCmd}.setDisabled( el.getCount( ) < 1 );
				#{DeleteSvrCmd}.setDisabled( el.getCount( ) < 1 );
				
			    var grid = #{GridPanelSvrCmd};
				if( grid.getSelectionModel( ).getCount( ) < 1 ) {
					#{StoreServerCommandParam}.removeAll( );
				}
			};
			
			var gridSvrCmdParamSelectionChange = function( el  ) {
				#{DeleteSvrCmdParam}.setDisabled( el.getCount( ) < 1 );
				#{ModifySvrCmdParam}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridRowSelect = function( selectionModel, rowIndex, record ) {	

				cmdTplName = record.data.Name;
				tplparam = record.data.Params;
				var pam	= record.data.Params;

				#{StoreServerCommandParam}.loadData( pam ); //pam 是从本地获取的， 故StoreServerCmd的store标签中不能带有<proxy>标签
			};
			
			var gridSvrCmdParamDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showSvrCmdParamDetail( record );
				
				svrCmdParamOp = 1;
			};
			
			var addSvrCmdParam = function(  ) {
				#{FormPanelSvrCmdParam}.reset( );
				#{WindowSvrCmdParam}.setTitle( msgAddServerCommandParam );
				#{WindowSvrCmdParam}.show( );
				
				 svrCmdParamOp = 0;
			};
			
			var modifySvrCmdParam = function( ) {
				var record = #{GrisPanelServerCmdParam}.getSelectionModel( ).getSelected( );
				showSvrCmdParamDetail( record );
				svrCmdParamOp = 1;
			};
			
			var deleteSvrCmdParam = function( ) {

				var grid = #{GrisPanelServerCmdParam};
				var record = grid.getSelectionModel( ).getSelected( );
				var paramName = record.data.Name;

				var result = showConfirmMsg( msgTitle, msgDelServerCommandParam, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteServerCommandParam( cmdTplName, paramName, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
									
									#{StoreServerCommandParam}.loadData( result.Result.DelTplParamData );
									
									var record = #{GridPanelSvrCmd}.getSelectionModel( ).getSelected( );
									if( record ) {
										record.data.Params = result.Result.DelTplParamData;
									}
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var showSvrCmdParamDetail = function( record ){
				#{TextFieldSvrCmdParamName}.setValue( record.data.Name );
				#{TextFieldSvrCmdParamOldName}.setValue( record.data.Name );
				#{TextFieldSvrCmdParamDesc}.setValue( record.data.Desc );
				#{TextFieldSvrCmdParamDefaultValue}.setValue( record.data.DefaultValue );
				
				#{WindowSvrCmdParam}.setTitle( msgModifyServerCommandParam );
				#{WindowSvrCmdParam}.show( );
			};
			
			var gridSvrCmdDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showSvrCmdDetail( record );
				
				svrCmdOp = 1;	
			};
			
			var addSvrCmd = function( ) {
				#{FormPanelServerrCommand}.reset( );
				#{WindowServerCommand}.setTitle( msgAddServerCommand );
				#{WindowServerCommand}.show( );
				
				svrCmdOp = 0;
			};
			
			var modifySvrCmd = function( ){

				var record = #{GridPanelSvrCmd}.getSelectionModel( ).getSelected( );
				showSvrCmdDetail( record );
				
				svrCmdOp = 1;
			};
			
			var deleteSvrCmd = function( ) {
				
				var result = showConfirmMsg( msgTitle, msgServerCommand, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DelServerCommand( cmdTplName, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
									
									var record = #{GridPanelSvrCmd}.getSelectionModel( ).getSelected( );
									if( record ) {
										record.data.Params = result.Result.TplParamData;
										#{StoreServerCommand}.remove( record.data.Params );
									}
									//#{StoreServerCommandParam}.loadData( result.Result.TplParamData );
									#{StoreServerCommand}.load( );
									
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var showSvrCmdDetail = function( record ) {
				#{TextFieldSvrCmdName}.setValue( record.data.Name );
				#{TextFieldSvrCmdOldName}.setValue( record.data.Name );
				#{TextFieldSvrCmdScriptTemplate}.setValue( record.data.ScriptTemplate );
				#{ComboBoxSvrCmdType}.setValue( record.data.Type );
				
				#{WindowServerCommand}.setTitle( msgModifyServerCommand );
				#{WindowServerCommand}.show( );
			};
			
			var setSvrCmd = function( ) {
				var svrCmdOldName = #{TextFieldSvrCmdOldName}.getValue( );
				var svrCmdName = #{TextFieldSvrCmdName}.getValue( );
				if( svrCmdName.length == 0 ){
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				Ext.net.DirectMethods.SetServerCommand( svrCmdOp, svrCmdOldName, {
					eventMask:	{
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowServerCommand}.hide( );
							#{StoreServerCommand}.load( );
							#{StoreServerCommandParam}.removeAll( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var setSvrCmdParam = function( ) {
				var paramOldName = #{TextFieldSvrCmdParamOldName}.getValue( );
				
				Ext.net.DirectMethods.SetServerCmdParam( svrCmdParamOp, cmdTplName, paramOldName, {
					eventMask:	{
						showMask: true,
						minDelay: 200,
						msg		: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowSvrCmdParam}.hide( );
							
							#{StoreServerCommandParam}.loadData( result.Result.ParamData );
							
							var record = #{GridPanelSvrCmd}.getSelectionModel( ).getSelected( );
							if( record ) {
								record.data.Params = result.Result.ParamData;
							}
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var exportServerCommand = function( ) {
				
				Ext.net.DirectMethods.ExportServerCommand( {

					success:function( result ) {
						if( result.Success ) {
							
						} else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnImportServerCmd = function( ) {
				#{WindowImportServerCommmand}.show( );
			};
			
			var importServerCommand = function( ) {
				
				Ext.net.DirectMethods.ImportServerCommand( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgUploadFileSuccess );
							#{WindowImportServerCommmand}.hide( );
							#{StoreServerCommand}.reload( );
						}else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	
	<ext:Store ID="StoreServerCommand" runat="Server" OnRefreshData="StoreSvrCmdRefresh">
		<DirectEventConfig >
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelSvrCmd}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="string" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="ScriptTemplate" Mapping="ScriptTemplate" Type="string" />
					<ext:RecordField Name="Params" Mapping="Params" IsComplex="true"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreServerCommandParam" runat="Server">
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="string"/>
					<ext:RecordField Name="Desc" Mapping="Desc" Type="string"/>
					<ext:RecordField Name="DefaultValue" Mapping="DefaultValue" Type="string"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" >
				<Center>
					<ext:GridPanel ID="GridPanelSvrCmd" runat="Server" StoreID="StoreServerCommand" Title="<%$ Resources:StringDef, ServerCommandName %>" Border="false"
						 AutoExpandColumn="ScriptTemplate" StyleSpec="margin-right:1px; border-right:1px solid #8DB2E3; background-color:white;" >
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="Server">
								<Items>
									<ext:Button ID="AddSvrCmd" runat="Server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addSvrCmd" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="DeleteSvrCmd" runat="Server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteSvrCmd" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="ModifySvrCmd" runat="Server"  Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true" >
										<Listeners>
											<Click Fn="modifySvrCmd" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel ID="ColumnModel1" runat="Server">
							<Columns>
								<ext:Column DataIndex="Name" Header="<%$ Resources:StringDef, Name %>" Width="300"/>
								<ext:Column DataIndex="ScriptTemplate" Header="<%$ Resources:StringDef, ScriptTemplate %>"/>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingSvrCmd" runat="Server" StoreID="StoreServerCommand" PageSize="100">
								<Items>
									<ext:ToolbarSeparator />
									<ext:Button ID="BtnImportServerCmd" runat="Server" Icon="PageWhiteCd" ToolTip="<%$ Resources:StringDef, Import %>">
										<Listeners>
											<Click Fn="btnImportServerCmd" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator />
									<ext:Button ID="BtnExportServerCmd" runat="Server" Icon="PageCode" ToolTip="<%$ Resources:StringDef, Export %>">
										<Listeners>
											<Click Fn="exportServerCommand" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server" SingleSelect="true">
								<Listeners>
									<SelectionChange Fn="gridSvrCmdSelectionChange" />
									<RowSelect Fn="gridRowSelect" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridSvrCmdDBClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
				<East>
					<ext:GridPanel ID="GrisPanelServerCmdParam" runat="Server" StoreID="StoreServerCommandParam" Split="true" StyleSpec="margin-left:1px; border-left:1px solid #8DB2E3; background-color:white;" Width="450"
						AutoExpandColumn="DefaultValue" Border="false" Title="<%$ Resources:StringDef, Param %>" >
						<TopBar>
							<ext:Toolbar ID="Toolbar3" runat="Server">
								<Items>
									<ext:Button ID="AddSvrCmdParam" runat="Server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addSvrCmdParam" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="DeleteSvrCmdParam" runat="Server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteSvrCmdParam" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="ModifySvrCmdParam" runat="Server"  Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifySvrCmdParam" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel ID="ColumnModel2" runat="Server">
							<Columns>
								<ext:Column DataIndex="Name" Header="<%$ Resources:StringDef, Name %>"/>
								<ext:Column DataIndex="Desc" Header="<%$ Resources:StringDef, Desc %>"/>
								<ext:Column DataIndex="DefaultValue" Header="<%$ Resources:StringDef, DefaultValue %>" />
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingSvrCmdParam" runat="Server" StoreID="StoreServerCommandParam" PageSize="100" HideRefresh="true"/>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSeletionModel" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridSvrCmdParamSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridSvrCmdParamDBClick" />
						</Listeners>
					</ext:GridPanel>
				</East>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowSvrCmdParam" runat="Server" Resizable="false" Width="500" AutoHeight="true" Hidden="true" 
		CloseAction="Hide" Modal="true" >
		<Items>
			<ext:FormPanel ID="FormPanelSvrCmdParam" runat="Server" ButtonAlign="Center" Padding="10"
				LabelWidth="120" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldSvrCmdParamName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldSvrCmdParamOldName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, OldName %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldSvrCmdParamDesc" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Desc %>" Note="<%$ Resources:StringDef, MsgSvrCmdTplParamDescNote %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldSvrCmdParamDefaultValue" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, DefaultValue %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonSvrCmdParam" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setSvrCmdParam" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button13" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowSvrCmdParam}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window Id="WindowServerCommand" runat="Server" Resizable="false" Width="500" AutoHeight="true" Hidden="true" 
		CloseAction="Hide" Modal="true" ButtonAlign="Center">
		<Items>
			<ext:FormPanel ID="FormPanelServerrCommand" runat="Server" Padding="10"
				LabelWidth="120" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldSvrCmdName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:ComboBox ID="ComboBoxSvrCmdType" runat="server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, Type %>" SelectedIndex="0" Editable="false">
						<Items>
							<ext:ListItem Text="<%$ Resources:StringDef, Script %>" Value="0" />
							<ext:ListItem Text="<%$ Resources:StringDef, SqlScript %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:TextField ID="TextFieldSvrCmdScriptTemplate" runat="Server" AnchorHorizontal="95%"
						FieldLabel="<%$ Resources:StringDef, ScriptTemplate %>" Note="<%$ Resources:StringDef, MsgScriptTemplateNote %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldSvrCmdOldName" runat="Server" AnchorHorizontal="95%"
						FieldLabel="<%$ Resources:StringDef, Name %>" Hidden="true">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonSvrCmd" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setSvrCmd" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button1" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowServerCommand}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowImportServerCommmand" runat="Server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:FormPanel ID="FormPanelImportServerrCommand" runat="Server" LabelWidth="80" MonitorValid="true">
				<Defaults>
					 <ext:Parameter Name="anchor" Value="95%" Mode="Value" />
				</Defaults>
				<Items>
					<ext:FileUploadField ID="FileUploadFieldServerCommand" runat="Server" EmptyText="<%$ Resources:StringDef, MsgUploadFileNotFound %>"
						FieldLabel="<%$ Resources:StringDef,UploadFile %>" Icon="PackageAdd">
					</ext:FileUploadField>
				</Items>
				<Buttons>
					<ext:Button ID="btnServerCommand" runat="Server" Text="<%$ Resources:StringDef, Import %>">
						<Listeners>
							<Click Fn="importServerCommand" />
						</Listeners>
					</ext:Button>
					<ext:Button ID="Button15" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
						<Listeners>
							<Click Handler="#{WindowImportServerCommmand}.hide( );" />
						</Listeners>
					</ext:Button>
				</Buttons>
			</ext:FormPanel>
		</Items>
	</ext:Window>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
