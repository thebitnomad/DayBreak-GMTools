<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svrcombine, App_Web_svrcombine.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrList" Src="~/common/svrlist.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.content
		{
			margin: 10px 0px 0px 30px;
			width: 1240px;
			overflow: hidden;
			zoom: 1;
		}
		.l-col
		{
			width: 800px;
			float: left;
		}
		.r-col
		{
			float: right;
			width: 224px;
		}
		.c-title
		{	
			height: 28px;
			line-height: 28px;
			border-bottom: 1px #cdd7d9 solid;
			margin-bottom: 20px;
			position: relative;
		}
		.c-title h3
		{
			font-size: 14px;
			font-weight: 700;
			color: #000;
		}
		.c-title a
		{
			position: absolute;
			right: 2px;
			top: 0;
			outline: none;
		}
		.user-card
		{
			overflow: hidden;
			zoom: 1;
		}
		.user-card-main
		{
			float: left;
			width: 960px;
			border: 1px #ededed solid;
			background: #fbfbfb;
			padding: 8px 9px;
			overflow: hidden;
			font-weight: bold;
			font-size: 14px;
		}
		.user-pic
		{
			width: 78px;
			height: 78px;
			border: 1px #cfcfcf solid;
			float: left;
		}
		.user-pic table
		{
			width: 78px;
			height: 78px;
		}
		.user-pic tr
		{
			width: 78px;
			height: 78px;
		}
		.user-pic td
		{
			vertical-align: middle;
			text-align: center;
		}
		.user-info-main
		{
			margin-left: 97px;
		}
		.user-name
		{
			margin-top: 11px;
			height: 24px;
			line-height: 24px;
			font-weight: 700;
			color: #000;
			font-size: 14px;
		}
		.user-info-co
		{
			height: 30px;
			line-height: 30px;
			color: #686868;
			font-size: 14px;
		}
		/* l-col */
		.user-func
		{
			padding-top: 6px;
			margin-left: 340px;
		}
		.user-func li
		{
			height: 28px;
			line-height: 28px;
			padding-left: 22px;
		}
		.user-func li.bg
		{
			background-position: 7px -232px; *background-position:7px-234px;
		}
		.user-info-list
		{
			overflow: hidden;
			color: #686868;
		}
		.user-info-list li
		{
			margin-top: 20px;
		}
		.user-info-list h3
		{
			color: #15428b;
			font-size: 14px;
			font-weight: 700;
			line-height: 18px;
			margin-bottom: 6px;
			border-bottom: 1px #cdd7d9 solid;
			padding-bottom: 6px;
		}
		.user-info-list p
		{
			line-height: 26px;
			font-size: 14px;
			zoom: 1;
			overflow: hidden;
		}
		.user-info-list .info-label
		{
			float: left;
			width: 95px;
			padding-right: 16px;
			text-align: right;
		}
		.user-info-list .info-content
		{
			display: block;
			margin-left: 89px;
			word-wrap: break-word;
		}
		.user-info-list .special
		{
			padding-left: 82px;
			color: #686868;
		}
		.user-info-list .special strong
		{
			font-weight: 400;
			padding-right: 20px;
		}
		.user-info-list .desc
		{
			color: #686868;
		}
		
		.uneditable
		{
			font-size: 12px;
			font-family:宋体;
		}
		
		.editable
		{
			font-size: 14px;
			font-family:宋体;
			cursor: pointer;
		}
		.x-form-field-editor
		{
			font-size: 14px;
			font-family:宋体;
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
		var msgOpSuc		= '<%= Resources.StringDef.OpSuc %>';

		var msgCommonOpConfirm			= '<%= Resources.StringDef.MsgCommonOpConfirm %>';
		var msgSvrCombineImportSvrNote	= '<%= Resources.StringDef.MsgSvrCombineImportSvrNote %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var m_selImport		= true;
		
			var getCurrentState = function( ) {
				Ext.net.DirectMethods.GetCurrentState( {
					success: function( result ) {
						if( result.Success ) {
						}
						else if( result.ErrorMessage ) {
						}
					}
				});
			};
		
			var setCombineSvr = function( ) {
				var result = showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.SetCombineSvr( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									#{TextFieldImportGameGroup}.setDisabled( true );
									#{BtnSelImport}.setDisabled( true );
									#{TextFieldExportGameGroupList}.setDisabled( true );
									#{BtnSelExport}.setDisabled( true );
									
									showSuccessMsg( msgTitle, msgOpSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var checkDupName = function( ) {
				var result = showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.CheckDupName( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var processRename = function( ) {
				var result = showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.ProcessRename( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var preProcessData = function( ) {
				var result = showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.PreProcessData( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var exportData = function( ) {
				var exportDir = #{TextFieldExportDir}.getValue( );
				
				Ext.net.DirectMethods.ExportData( exportDir, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowExportDb}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
							#{DisplayFieldExportDir}.setValue( exportDir );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var importData = function( ) {
				var sqlFileDir = #{TextFieldSqlFileDir}.getValue( );
				
				Ext.net.DirectMethods.ImportData( sqlFileDir, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowImportDb}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
							
							refreshImportState( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var combineAccount = function( ) {
				var result = showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.CombineAccount( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var backupDatabase = function( ) {
				var bkDir = #{TextFieldBKDir}.getValue( );
				
				Ext.net.DirectMethods.BackupDatabase( bkDir, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var exportNameList = function( type ) {
				window.open( "op.ashx?op=exnamelist&type=" + type );
			};
			
			var refreshImportState = function( ) {
				Ext.net.DirectMethods.RefreshImportState( {
					success: function( result ) {
						if( result.Success ) {
							#{DisplayFieldImportInfo}.setValue( result.Result.Desc );
							
							if( !result.Result.AllFinish ) {
								setTimeout( "refreshImportState( );", 1000 );
							}
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var selImportSvr = function( ) {
				m_selImport = true;
				svrlistRefresh( );
				#{WindowSvrList}.show( );
			};
			
			var selExportSvr = function( ) {
				m_selImport = false;
				svrlistRefresh( );
				#{WindowSvrList}.show( );
			};
			
			var btnWinSvrClick = function( ) {
				if( m_selImport ) {
					/* 处理导入区服 */
					var selSvrCnt = svrlistGetSelectedSvrCnt( );
					if( selSvrCnt != 1 ) {
						showErrMsg( msgTitle, msgSvrCombineImportSvrNote );
						return;
					}
					
					#{TextFieldImportGameGroup}.setValue( svrlistGetSelectedSvrName( ) );
					#{WindowSvrList}.hide( );
				} else {
					/* 处理导出区服 */
					#{TextFieldExportGameGroupList}.setValue( svrlistGetSelectedSvrName( ) );
					#{WindowSvrList}.hide( );
				}
			};
						
			var initData = function( ) {
				getCurrentState( );
				setInterval( getCurrentState, 3000 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreRename" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreRenameRefresh" >
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelRename}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="RoleID" Mapping="RoleID" Type="Int" />
					<ext:RecordField Name="AccID" Mapping="AccID" Type="Int" />
					<ext:RecordField Name="OriRoleName" Mapping="OriRoleName" Type="String" />
					<ext:RecordField Name="DBName" Mapping="DBName" Type="String" />
					<ext:RecordField Name="Charge" Mapping="Charge" Type="Int" />
					<ext:RecordField Name="RoleLevel" Mapping="RoleLevel" Type="Int" />
					<ext:RecordField Name="RoleGUID" Mapping="RoleGUID" Type="String" />
					<ext:RecordField Name="NewRoleName" Mapping="NewRoleName" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="String" />
					<ext:RecordField Name="Message" Mapping="Message" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<div class="content">
		<div class="l-col">
			<div class="user-card">
				<div class="user-card-main">
					<ext:DisplayField ID="DisplayFieldState" runat="server" LabelWidth="60" FieldLabel="<%$ Resources:StringDef, CurrentState %>" >
					</ext:DisplayField>
				</div>
			</div>
			<ul class="user-info-list">
				<li>
					<h3><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep1 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel1" runat="server" Layout="Form" LabelWidth="95" LabelAlign="Right" Border="false" Width="750" ButtonAlign="Center">
						<Items>
							<ext:CompositeField ID="ComFieldImportGameGroup" runat="Server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ImportGameGroup %>" LabelSeparator="<%$ Resources:StringDef, Colon %>" Note="<%$ Resources:StringDef, MsgSvrCombineImportSvrNote %>">
								<Items>
									<ext:TextField ID="TextFieldImportGameGroup" runat="server" Width="400">
									</ext:TextField>
									<ext:Button ID="BtnSelImport" runat="Server"  Text="..." Width="40">
										<Listeners>
											<Click Fn="selImportSvr" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="ComFieldExportGameGroup" runat="Server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ExportGameGroupList %>" LabelSeparator="<%$ Resources:StringDef, Colon %>">
								<Items>
									<ext:TextField ID="TextFieldExportGameGroupList" runat="server" Width="400">
									</ext:TextField>
									<ext:Button ID="BtnSelExport" runat="Server" Text="..." Width="40">
										<Listeners>
											<Click Fn="selExportSvr" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:CompositeField>
							<ext:DisplayField ID="DisplayFieldSelSvr" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineSelSvrNote %>" StyleSpec="font-weight:bold;color:red;"></ext:DisplayField>
						</Items>
						<Buttons>
							<ext:Button runat="server" ID="BtnSetGameGroup" Scale="Medium" Text="<%$ Resources:StringDef, SetCombineSvr %>" Width="100" >
								<Listeners>
									<Click Fn="setCombineSvr" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal5" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep2 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel5" runat="server" Layout="Form" LabelAlign="Left" LabelWidth="1" Border="false" Width="750" ButtonAlign="Center">
						<Content>
							<ext:DisplayField ID="LabelDBName" runat="server" LabelSeparator="<%$ Resources:StringDef, Colon %>" StyleSpec="line-height:20px;">
							</ext:DisplayField>
						</Content>
						<Buttons>
							<ext:Button runat="server" ID="BtnDBBackup" Scale="Medium" Text="<%$ Resources:StringDef, Backup %>" Width="100">
								<Listeners>
									<Click Handler="
										#{WindowBackupDb}.show( );
									" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal2" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep3 %>"></asp:Literal></h3>
					
					<ext:GridPanel ID="GridPanelRename" runat="Server" Width="780" StoreID="StoreRename" Height="300" AutoExpandColumn="Message" > <%--ColumnLines="true"--%>
						<View>
							<ext:GridView ID="GridView2" runat="Server">
							</ext:GridView>
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnCheckDupName" runat="server" Text="<%$ Resources:StringDef, CheckDupName %>" Icon="BrickGo">
										<Listeners>
											<Click Fn="checkDupName" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnProcessRename" runat="server" Text="<%$ Resources:StringDef, ProcessRename %>" Icon="Tick">
										<Listeners>
											<Click Fn="processRename" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, RoleID %>" DataIndex="RoleID" Width="50" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, AccID %>" DataIndex="AccID" Width="60">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, OriRoleName %>" DataIndex="OriRoleName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DBName %>" DataIndex="DBName" Width="100" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, TotalCharge %>" DataIndex="Charge" Width="70" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleLevel %>" DataIndex="RoleLevel" Width="50" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NewRoleName %>" DataIndex="NewRoleName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="80" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Message %>" DataIndex="Message" Align="Left" >
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingRename" runat="server" PageSize="10000" StoreID="StoreRename" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal6" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep4 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel2" runat="server" Layout="Form" LabelAlign="Right" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Items>
							<ext:DisplayField ID="DisplayFieldPreProcessData" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombinePreProcessNote %>"></ext:DisplayField>
						</Items>
						<Buttons>
							<ext:Button runat="server" ID="BtnPreProcessData" Scale="Medium" Text="<%$ Resources:StringDef, PreProcessData %>" Width="100">
								<Listeners>
									<Click Fn="preProcessData" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal7" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep5 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel6" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Items>
							<ext:DisplayField ID="DisplayFieldExportNote" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineExportDataNote %>"></ext:DisplayField>
							<ext:DisplayField ID="DisplayFieldExportNote1" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineExportDataNote1 %>" StyleSpec="font-weight:bold;color:red;"></ext:DisplayField>
							<ext:DisplayField ID="DisplayFieldExportDir" runat="server" StyleSpec="font-weight:bold;"></ext:DisplayField>
						</Items>
						<Buttons>
							<ext:Button runat="server" ID="BtnExport" Scale="Medium" Text="<%$ Resources:StringDef, ExportData %>" Width="100">
								<Listeners>
									<Click Handler="
										#{WindowExportDb}.show( );
									" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal10" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep6 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel7" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Items>
							<ext:DisplayField ID="DisplayFieldImportNote" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineImportDataNote %>"></ext:DisplayField>
							<ext:DisplayField ID="DisplayFieldImportNote1" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineImportDataNote1 %>" StyleSpec="font-weight:bold;color:red;"></ext:DisplayField>
							<ext:DisplayField ID="DisplayFieldLine" runat="Server" Text="<br />"></ext:DisplayField>
							<ext:DisplayField ID="DisplayFieldImportInfo" runat="Server"></ext:DisplayField>
						</Items>
						<Buttons>
							<ext:Button runat="server" Scale="Medium" Text="<%$ Resources:StringDef, ImportData %>" Width="100">
								<Listeners>
									<Click Handler="
										#{WindowImportDb}.show( );
									" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal9" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep7 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel3" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Buttons>
							<ext:Button runat="server" ID="Button1" Scale="Medium" Text="<%$ Resources:StringDef, CombineAccount %>" Width="100">
								<Listeners>
									<Click Fn="combineAccount" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep8 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel4" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Buttons>
							<ext:Button runat="server" ID="Button2" Text="<%$ Resources:StringDef, ExportRoleNameList %>" Hidden="true">
								<Listeners>
									<Click Handler="exportNameList( 0 );" />
								</Listeners>
							</ext:Button>
							<ext:Button runat="server" ID="Button3" Text="<%$ Resources:StringDef, ExportDelRoleNameList %>" Hidden="true">
								<Listeners>
									<Click Handler="exportNameList( 1 );" />
								</Listeners>
							</ext:Button>
							<ext:Button runat="server" ID="Button4" Text="<%$ Resources:StringDef, ExportSocietyNameList %>" Hidden="true">
								<Listeners>
									<Click Handler="exportNameList( 2 );" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal ID="Literal4" runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep9 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel8" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Items>
							<ext:DisplayField ID="DisplayFieldModifySvrCfgDesc" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineModifySvrCfgDesc %>" />
						</Items>
					</ext:Panel>
				</li>
				<li>
					<h3><asp:Literal runat="server" Text="<%$ Resources:StringDef, MsgSvrCombineStep10 %>"></asp:Literal></h3>
					<ext:Panel ID="Panel9" runat="server" Layout="Form" Border="false" Width="750" LabelWidth="1" ButtonAlign="Center">
						<Items>
							<ext:DisplayField ID="DisplayFieldUpdateImportSvrNote" runat="Server" Text="<%$ Resources:StringDef, MsgSvrCombineUpdateImportSvrDesc %>" />
						</Items>
					</ext:Panel>
					<br />
					<br />
				</li>
			</ul>
		</div>
	</div>
	
	<ext:Window ID="WindowSvrList" runat="Server" Width="900" Height="450" CloseAction="Hide"
		Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Container ID="Container1" runat="server" Height="250">
						<Content>
							<sat:SvrList runat="Server" />
						</Content>
					</ext:Container>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnWinSvr" runat="server" Text="<%$ Resources:StringDef, OK %>" >
				<Listeners>
					<Click Fn="btnWinSvrClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button5" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowSvrList}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowBackupDb" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, DatabaseBackup %>">
		<Items>
			<ext:FormPanel ID="FormPanel2" runat="Server" LabelAlign="Right" LabelWidth="80" ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:TextField runat="Server" ID="TextFieldBKDir" Text="/home/lmzg/server/daybreakdatabak" FieldLabel="<%$ Resources:StringDef, BKDir %>" AnchorHorizontal="95%"></ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button6" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="backupDatabase" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button7" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowBackupDb}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowExportDb" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, ExportData %>">
		<Items>
			<ext:FormPanel ID="FormPanel1" runat="Server" LabelAlign="Right" LabelWidth="80" ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:TextField runat="Server" ID="TextFieldExportDir" Text="/home/lmzg/server/daybreakdatabak" FieldLabel="<%$ Resources:StringDef, ExportDir %>" AnchorHorizontal="95%"></ext:TextField>
					<ext:DisplayField runat="Server" ID="DisplayFieldExFileDesc" Text="<%$ Resources:StringDef, MsgExportFileDesc %>"  StyleSpec="font-weight:bold;color:red;" />
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button8" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="exportData" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button9" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowExportDb}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowImportDb" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, ExportData %>">
		<Items>
			<ext:FormPanel runat="Server" LabelAlign="Right" LabelWidth="80" ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:TextField runat="Server" ID="TextFieldSqlFileDir" Text="/home/lmzg/server/daybreakdatabak" FieldLabel="<%$ Resources:StringDef, SqlFileDir %>" AnchorHorizontal="95%"></ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="BtnImportData" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="importData" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowImportDb}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

