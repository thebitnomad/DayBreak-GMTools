<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_machinectrl, App_Web_machinectrl.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>
<%@ Register TagPrefix="sat" TagName="MachineList" Src="~/common/machinelist.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgSelNoMachine			= '<%= Resources.StringDef.MsgSelNoMachine %>';
		var msgCommonOpConfirm		= '<%= Resources.StringDef.MsgCommonOpConfirm %>';
		var msgAlreadyAddToTranList	= '<%= Resources.StringDef.MsgAlreadyAddToTranList %>';
		var msgNoUpdatePakName		= '<%= Resources.StringDef.MsgNoUpdatePakName %>';
		var msgUpload				= '<%= Resources.StringDef.Upload %>';
		var msgSvrPakUpload			= '<%= Resources.StringDef.SvrPakUpload %>';
		var msgExecSuccess			= '<%= Resources.StringDef.ExecSuccess %>';
		var msgOpSuc				= '<%= Resources.StringDef.OpSuc %>';
		
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_winFileManOp	= 0;				//WindowFileMan操作：0表示上传文件
		
			var initData = function( ) {
				machinelistRefresh( );
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
				var machineIds = machinelistGetSelectedSvr( );
				if( machineIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/MUploadPakFile",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: machineIds,
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
			
			var clearFileTasks = function( ) {
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						var machineIds = machinelistGetSelectedSvr( );
						if( machineIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoMachine );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/MClearFileTask",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: machineIds
							},
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
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
			
			var updateDetector = function( ) {
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						var machineIds = machinelistGetSelectedSvr( );
						if( machineIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoMachine );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/MUpdateDetector",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: machineIds
							},
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
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
			
			var btnExecShellScriptClick = function( ) {
				#{PanelShellScript}.reset( );
				#{WindowShellScript}.show( );
			};
			
			var execShellScript = function( ) {
				var machineIds = machinelistGetSelectedSvr( );
				if( machineIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoMachine );
					return;
				}

				var shellScript = #{FieldShellScript}.getValue( );
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/MExecShellScript",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: machineIds,
						script		: shellScript
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgExecSuccess );
							#{WindowShellScript}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnSetSvrTimeClick = function( ) {
				#{PanelSetTime}.reset( );
				#{WindowSetTime}.show( );
			};
			
			var setSvrTime = function( ) {
				var machineIds = machinelistGetSelectedSvr( );
				if( machineIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoMachine );
					return;
				}

				var time = #{DateCurrTime}.getValue( );
				if( time ) {
					time = getDateTimeString( time );
				}
				
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/SetSvrTime",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: machineIds,
						time		: time
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowSetTime}.hide( );
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
							<ext:SplitButton ID="BtnUploadFile" runat="server" Icon="FolderGo" Scale="Medium" Text="<%$ Resources:StringDef, SvrPakUpload %>">
								<Listeners>
									<Click Fn="btnUploadFileClick" />
								</Listeners>
								<Menu>
									<ext:Menu ID="Menu1" runat="server">
										<Items>                    
											<ext:MenuItem ID="MenuItem3" runat="server" Text="<%$ Resources:StringDef, ClearFileTask %>" Icon="AwardStarBronze3" >
												<Listeners>
													<Click Fn="clearFileTasks" />
												</Listeners>
											</ext:MenuItem>
										</Items>
									</ext:Menu>
								</Menu>
							</ext:SplitButton>
							<ext:Button ID="BtnSetSvrTime" runat="server" Icon="Clock" Scale="Medium" Text="<%$ Resources:StringDef, SetTime %>" Hidden="true">
								<Listeners>
									<Click Fn="btnSetSvrTimeClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnUpdateDetector" runat="server" Icon="AwardStarGold3" Scale="Medium" Text="<%$ Resources:StringDef, UpdateDetector %>">
								<Listeners>
									<Click Fn="updateDetector" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnExecShell" runat="server" Icon="Script" Scale="Medium" Text="<%$ Resources:StringDef, ExecShellScript %>" Hidden="true">
								<Listeners>
									<Click Fn="btnExecShellScriptClick" />
								</Listeners>
							</ext:Button>
						</Items>
					</ext:Toolbar>
				</North>
				<Center>
					<ext:Container ID="Container1" runat="server" StyleSpec="background-color:#FFF;" >
						<Content>
							<sat:MachineList ID="MachineList" runat="Server" Border="false" ></sat:MachineList>
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
	
	<ext:Window ID="WindowShellScript" runat="server" Resizable="false" Maximizable="false"
		Width="600" Height="200" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:BorderLayout ID="BorderLayout5" runat="server">
				<Center>
					<ext:FormPanel ID="PanelShellScript" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
						<Items>
							<ext:TextArea ID="FieldShellScript" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, ShellScript %>" Height="100">
							</ext:TextArea>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="Button3" runat="Server" Text="<%$ Resources:StringDef, Execute %>">
				<Listeners>
					<Click Fn="execShellScript" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button4" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowShellScript}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowSetTime" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, SetTime %>">
		<Items>
			<ext:FormPanel ID="PanelSetTime" runat="Server" LabelAlign="Right" LabelWidth="80"
				ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:DateField runat="Server" ID="DateCurrTime" Format="Y-n-j H:i:s"
						FieldLabel="<%$ Resources:StringDef, Time %>" Note="<%$ Resources:StringDef, MsgSetTimeNote %>" AnchorHorizontal="95%" NoteAlign="Down">
					</ext:DateField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button5" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setSvrTime" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button6" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowSetTime}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
