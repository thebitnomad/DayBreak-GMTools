<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="data_datactrl, App_Web_datactrl.aspx.551d078a" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>
<%@ Register TagPrefix="sat" TagName="SvrList" Src="~/common/svrlist.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle				= '<%= Resources.StringDef.SystemName %>';
		var msgLoading				= '<%= Resources.StringDef.Loading %>';
		var msgSaving				= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting			= '<%= Resources.StringDef.Submitting %>';
		var msgSave					= '<%= Resources.StringDef.Save %>';
		var msgOK					= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable			= '<%= Resources.StringDef.NotAvailable %>';
		var msgOpSuc				= '<%= Resources.StringDef.OpSuc %>';
		var msgSelNoGameGroup		= '<%= Resources.StringDef.MsgSelNoGameGroup %>';
		var msgSelNoGameProc		= '<%= Resources.StringDef.MsgSelNoGameProc %>';
		
		var msgNoUpdatePakName		= '<%= Resources.StringDef.MsgNoUpdatePakName %>';
		var msgUpload				= '<%= Resources.StringDef.Upload %>';
		var msgUpdate				= '<%= Resources.StringDef.Update %>';
		var msgSvrPakUpload			= '<%= Resources.StringDef.SvrPakUpload %>';
		var msgClearRankDataConfirm	= '<%= Resources.StringDef.MsgClearRankDataConfirm %>';
	
		var msgUpdateRewardCfgInfoFormat	= '<%= Resources.StringDef.MsgUpdateRewardCfgInfoFormat %>';
		var msgUpdateChargeRewardConfirm	= '<%= Resources.StringDef.MsgUpdateChargeRewardConfirm %>';
	
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_winFileManOp	= 0;				//WindowFileMan操作：0表示上传文件 1表示更新服务器 2表示更新Sql脚本
		
			var initData = function( ) {
				svrlistRefresh( );
			};
			
			var btnUploadFileClick = function( ) {
				fileManRefreshDir( );
				
				#{BtnWinFileMan}.setText( msgUpload );
				#{WindowFileMan}.setTitle( msgSvrPakUpload );
				#{WindowFileMan}.show( );
				
				m_winFileManOp = 0;
			};
			
			var btnWinFileManClick = function( ) {
				if( m_winFileManOp == 0 ) {
					/* 上传 */
					uploadPakFile( );
				}
			};
			
			var uploadPakFile = function( ) {
				var pakRelPath = fileManGetSelFile( );
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/UploadPakFile",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						pakRelPath  : pakRelPath
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgAlreadyAddToTranList );
							#{WindowFileMan}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnSetOpenDateClick = function( ) {
				#{DateFieldOpenDate}.setValue( new Date( ) );
				#{WindowSetOpenDate}.show( );
			};
			
			var btnImportSpecialIP = function( ) {
				//todo
			};
			
			var setOpenDate = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				var time = #{DateFieldOpenDate}.getValue( );
				if( time ) {
					time = getDateString( time );
				}
				
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/SetOpenDate",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						date		: time
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowSetOpenDate}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnClearRankDataClick = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				/* 1:普通排行 2:副本排行 */
				var rankType = 3;
				
				showConfirmMsg( msgTitle, msgClearRankDataConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "dataservice.asmx/ClearRankData",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds,
								rankType	: rankType
							},
							eventMask: {
								showMask	: true,
								minDelay	: 200,
								msg			: msgSubmitting
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
					}
				} );
			};
			
			var btnExecSerCmdClick = function( ){
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
			
				var win = #{WindowSerCmd};
				win.load( {
					url			: 'servercommand.aspx',
					params		: { ggIds: svrIds },
					discardUrl	: false,
					nocache		: true,
					timeout		: 30
				});
			
				#{WindowSerCmd}.show( );
			};
			
			var btnSerCommandConfigClick = function( ) {
				#{WindowSerCmdConfig}.show( );
			};
			
			var btnModifyRewardCfgClick = function( ){
				var win = #{WindowRewardCfg};
				win.load( {
					url			: 'chargereward.aspx',
					discardUrl	: false,
					nocache		: true,
					timeout		: 30
				});
			
				#{WindowRewardCfg}.show( );
			};
			
			var btnUpdateRewardCfgClick = function( ) {
				Ext.net.DirectMethods.GetRewardSummaryInfo( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function ( result ) {
						if( result.Success ) {
							var msg = String.format( msgUpdateRewardCfgInfoFormat, result.Result.Total, result.Result.First, result.Result.Normal );
							#{DisFieldUpdateRewardCfg}.setValue( msg );
							#{WindowUpdateRewardCfg}.show( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var updateRewardCfg = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				showConfirmMsg( msgTitle, msgUpdateChargeRewardConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "dataservice.asmx/UpdateChargeRewardCfg",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
							},
							eventMask: {
								showMask	: true,
								minDelay	: 200,
								msg			: msgSubmitting
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
					}
				} );
			};
			
			var btnModifyGameGroupName = function( ) {
				#{WindowModifyGameGroup}.show( );
			};
			
			var setGameGroup = function( ) {
			
				var newGameGroupName = #{TextFieldModifyGameGroupName}.getValue( );
				
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				Ext.net.DirectMethods.SetGameGroup( svrIds, newGameGroupName, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function ( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowModifyGameGroup}.hide( );	
							svrlistRefresh( );
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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server" >
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:Toolbar ID="Toolbar1" runat="Server" Height="35">
						<Items>
							<ext:Button ID="BtnUploadFile" runat="server" Icon="FolderGo" Scale="Medium" Text="<%$ Resources:StringDef, RoleData %>" Hidden="true">
								<Listeners>
									<Click Fn="btnUploadFileClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnClearRankData" runat="server" Icon="ControlRemoveBlue" Scale="Medium" Text="<%$ Resources:StringDef, ClearRankData %>">
								<Listeners>
									<Click Fn="btnClearRankDataClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="ButtonExecSerCmd" runat="Server" Text="<%$ Resources:StringDef, ExecServerCommand %>" Icon="PageKey" Scale="Medium">
								<Listeners>
									<Click Fn="btnExecSerCmdClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnModifyRewardCfg" runat="Server" Text="<%$ Resources:StringDef, ModifyRewardCfg %>" Icon="ApplicationFormEdit" Scale="Medium" Hidden="true">
								<Listeners>
									<Click Fn="btnModifyRewardCfgClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnUpdateRewardCfg" runat="Server" Text="<%$ Resources:StringDef, UpdateRewardCfg %>" Icon="ApplicationLink" Scale="Medium" Hidden="true">
								<Listeners>
									<Click Fn="btnUpdateRewardCfgClick" />
								</Listeners>
							</ext:Button>
							<ext:Button Id="ButtonSerCmdConfig" runat="Server"  Text="<%$ Resources:StringDef,ServerCommandConfig %>" Icon="PageGear" Scale="Medium">
								<Listeners>
									<Click Fn="btnSerCommandConfigClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnModifyGameGroupName" runat="Server" Text="<%$ Resources:StringDef,ModifyGameGroupName %>" Icon="NoteEdit" Scale="Medium">
								<Listeners>
									<Click Fn="btnModifyGameGroupName" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="SplitButton1" runat="server" Icon="Cog" Scale="Medium" Text="<%$ Resources:StringDef, SvrConfig %>" Hidden="true">
								<Menu>
									<ext:Menu ID="Menu1" runat="server">
										<Items>
											<ext:MenuItem ID="BtnSetOpenDate" runat="server" Icon="LockOpen"  Text="<%$ Resources:StringDef, SetOpenDate %>">
												<Listeners>
													<Click Fn="btnSetOpenDateClick" />
												</Listeners>
											</ext:MenuItem>
											<ext:MenuItem ID="MenuItem4" runat="server" Icon="BookKey" Text="<%$ Resources:StringDef, ImportSpecialIP %>" Hidden="true">
												<Listeners>
													<Click Fn="btnImportSpecialIP" />
												</Listeners>
											</ext:MenuItem>
										</Items>
									</ext:Menu>
								</Menu>
							</ext:Button>
							<ext:Button ID="Btn" runat="Server" Text="<%$ Resources:StringDef, RoleImportToInnerSvr %>" Icon="NoteEdit" Scale="Medium">
								<Listeners>
									<Click Handler="
										#{WindowRoleDataImport}.show( );
									" />
								</Listeners>
							</ext:Button>
							<ext:ToolbarFill />
							<ext:Button ID="BtnHistory" runat="server" Text="<%$ Resources:StringDef, History %>" Icon="Table">
								<Listeners>
									<Click Handler="
										#{WindowCtrlOpLog}.show( );
									" />
								</Listeners>
							</ext:Button>
						</Items>
					</ext:Toolbar>
				</North>
				<Center>
					<ext:Container ID="Container1" runat="server" StyleSpec="background-color:#FFF;" >
						<Content>
							<sat:SvrList ID="SvrList" runat="Server" Border="false" ></sat:SvrList>
						</Content>
					</ext:Container>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowFileMan" runat="Server" Width="900" Height="450" CloseAction="Hide"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, SvrPakUpload %>">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Container ID="Container2" runat="server" Height="250">
						<Content>
							<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false">
							</sat:FileMan2>
						</Content>
					</ext:Container>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnWinFileMan" runat="server">
				<Listeners>
					<Click Fn="btnWinFileManClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button1" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowFileMan}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowSetOpenDate" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, SetOpenDate %>">
		<Items>
			<ext:FormPanel ID="FormPanel1" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:DateField runat="Server" ID="DateFieldOpenDate" FieldLabel="<%$ Resources:StringDef, OpenDate %>" AnchorHorizontal="95%" >
					</ext:DateField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button7" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setOpenDate" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button8" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowSetOpenDate}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowSerCmd" runat="Server" Width="900" Height="500" Hidden="true" Modal="true"
		CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Title="<%$ Resources:StringDef, ExecServerCommand %>">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowSerCmdConfig" runat="Server" Width="1100" Height="700" Hidden="true" Modal="true"
		CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Title="<%$ Resources:StringDef, SerCmdConfigTemplate %>">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="sercmdconfig.aspx">
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowRewardCfg" runat="Server" Width="900" Height="500" Hidden="true" Modal="true"
		CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Title="<%$ Resources:StringDef, ModifyRewardCfg %>">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowUpdateRewardCfg" runat="Server" Resizable="false" Maximizable="false" Width="500"
		AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Hidden="true"
		Modal="true" Title="<%$ Resources:StringDef, UpdateRewardCfg %>">
		<Items>
			<ext:Panel ID="FormPanel2" runat="Server" LabelAlign="Right" LabelWidth="80"
				ButtonAlign="Right" Border="false" Padding="8" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:DisplayField runat="Server" ID="DisFieldUpdateRewardCfg" AnchorHorizontal="95%" >
					</ext:DisplayField>
					<ext:LinkButton runat="Server" Text="<%$ Resources:StringDef, ViewCfgDetail %>" Width="200" LabelWidth="100"></ext:LinkButton>
				</Items>
			</ext:Panel>
		</Items>
		<Buttons>
			<ext:Button ID="Button2" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="updateRewardCfg" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button3" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowUpdateRewardCfg}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowCtrlOpLog" runat="Server" Width="1024" Height="600" Hidden="true" Modal="true"
		CloseAction="Hide" Collapsible="false" Title="<%$ Resources:StringDef, History %>">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="ctrlop.aspx">
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowModifyGameGroup" runat="Server" Resizable="false" Maximizable="false" Width="500"
		AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Hidden="true"
		Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, ModifyGameGroupName %>">
		<Items>
			<ext:FormPanel ID="FormPanelModifyGameGroupName" runat="Server" LabelAlign="Right" LabelWidth="80"
				ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:TextField ID="TextFieldModifyGameGroupName" runat="Server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, NewSvrName %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button9" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setGameGroup" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button10" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowModifyGameGroup}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowRoleDataImport" runat="server" Resizable="false" Maximizable="false" BodyBorder="false"
		Width="1000" Height="600" Padding="0" CloseAction="Hide" Collapsible="false" Title="<%$ Resources:StringDef, RoleImportToInnerSvr %>"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" Url="rolebakimport.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
