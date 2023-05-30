<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svrctrl, App_Web_svrctrl.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>
<%@ Register TagPrefix="sat" TagName="SvrList" Src="~/common/svrlist.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgSelNoGameGroup			= '<%= Resources.StringDef.MsgSelNoGameGroup %>';
		var msgSelNoGameProc			= '<%= Resources.StringDef.MsgSelNoGameProc %>';
		var msgStartGameConfirm			= '<%= Resources.StringDef.MsgStartGameConfirm %>';
		var msgStopGameConfirm			= '<%= Resources.StringDef.MsgStopGameConfirm %>';
		var msgCommonOpConfirm			= '<%= Resources.StringDef.MsgCommonOpConfirm %>';
		var msgKillGameConfirm			= '<%= Resources.StringDef.MsgKillGameConfirm %>';

		var msgUpdateGameConfirmFormat	= '<%= Resources.StringDef.MsgUpdateGameConfirmFormat %>';
		var msgAlreadyAddToTranList		= '<%= Resources.StringDef.MsgAlreadyAddToTranList %>';
		
		var msgNoUpdatePakName			= '<%= Resources.StringDef.MsgNoUpdatePakName %>';
		var msgUpload					= '<%= Resources.StringDef.Upload %>';
		var msgUpdate					= '<%= Resources.StringDef.Update %>';
		var msgSvrPakUpload				= '<%= Resources.StringDef.SvrPakUpload %>';
		var msgSvrUpdate				= '<%= Resources.StringDef.SvrUpdate %>';
		var msgExecSuccess				= '<%= Resources.StringDef.ExecSuccess %>';
		var msgOpSuc					= '<%= Resources.StringDef.OpSuc %>';
		var msgUpdateGameStarted		= '<%= Resources.StringDef.MsgUpdateGameStarted %>';
		var msgUpdateIBShop				= '<%= Resources.StringDef.UpdateIBShop %>';
		var msgUpdateIBShopSuc			= '<%= Resources.StringDef.UpdateIBShopSuc %>';
		var msgClearRankDataConfirm		= '<%= Resources.StringDef.MsgClearRankDataConfirm %>';
		var msgClearWarApplyDataConfirm = '<%= Resources.StringDef.MsgClearWarApplyDataConfirm %>';
		var msgClearOpenServerDataConfirm = '<%= Resources.StringDef.MsgClearOpenServerDataConfirm%>';
		var msgSelectSvrCfgDbDBNameNote = '<%= Resources.StringDef.MsgSelectSvrCfgDbDBNameNote %>';
	</script>
	<ext:XScript runat="Server">
		<script type="text/javascript">
			var m_winFileManOp	= 0;				//WindowFileMan操作：0表示上传文件 1表示更新服务器 2表示更新Sql脚本
			var initData = function( ) {
				svrlistRefresh( );
			};
			
			var btnStartGameClick = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				var result = showConfirmMsg( msgTitle, msgStartGameConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/StartGame",
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
									//queryGameProc( true );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var btnStopGameClick = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
			
				showConfirmMsg( msgTitle, msgStopGameConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/StopGame",
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
									//queryGameProc( true );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var btnUpdateGameClick = function( ) {
				fileManRefreshDir( );
				
				#{BtnWinFileMan}.setText( msgUpdate );
				#{WindowFileMan}.setTitle( msgSvrUpdate );
				#{WindowFileMan}.show( );
				
				m_winFileManOp = 1;
			};
			
			var btnUpdateIBShopClick = function( ) {
				fileManRefreshDir( );
				
				#{BtnWinFileMan}.setText( msgUpdate );
				#{WindowFileMan}.setTitle( msgUpdateIBShop );
				#{WindowFileMan}.show( );
				
				m_winFileManOp = 2;
			};
			
			var updategame = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
			
				var pakFilePath = fileManGetSelFile( );
				if( pakFilePath.length == 0 ) {
					showErrMsg( msgTitle, msgNoUpdatePakName );
					return;
				}
			
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/UpdateGame",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						pakFilePath	: pakFilePath
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgUpdateGameStarted );
							#{WindowFileMan}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var updateIBShop = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
			
				var sqlFilePath = fileManGetSelFile( );
				var sqlName = getFileName( sqlFilePath );
				if( sqlName.length == 0 ) {
					showErrMsg( msgTitle, msgNoUpdatePakName );
					return;
				}
			
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/UpdateIBShop",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids      : svrIds,
						sqlName  : sqlName
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgUpdateIBShopSuc );
							#{WindowFileMan}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnKillGameClick = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
			
				showConfirmMsg( msgTitle, msgKillGameConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/KillGame",
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
									//queryGameProc( true );
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
				} else if( m_winFileManOp == 1 ) {
					/* 更新 */
					updategame( );
				} else if( m_winFileManOp == 2 ) {
					/* 更新IBShop */
					updateIBShop( );
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
			
			var clearFileTasks = function( ) {
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						var svrIds = svrlistGetSelectedSvr( );
						if( svrIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoGameGroup );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/ClearFileTask",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
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
						var svrIds = svrlistGetSelectedSvr( );
						if( svrIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoGameGroup );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/UpdateDetector",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
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
			
			var backupDb = function( ) {
				var type	= 0;
				
				if( #{RadioBKTypeMini}.checked )
					type = 0;
				else if( #{RadioBKTypeAll}.checked )
					type = 1;
				else
					type = 2;
				
				var bkDir	= #{TextFieldBKDir}.getValue( );
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						var svrIds = svrlistGetSelectedSvr( );
						if( svrIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoGameGroup );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/BackupDb",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds,
								type		: type,
								bkDir		: bkDir
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
			
			var backupVipRole = function( ) {
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						var svrIds = svrlistGetSelectedSvr( );
						if( svrIds.length == 0 ) {
							showErrMsg( msgTitle, msgSelNoGameGroup );
							return;
						}

						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/BackupVipRole",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
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
			
			var btnExecGMCmdClick = function( ) {
				#{PanelGMCmd}.reset( );
				#{WindowGMCmd}.show( );
			};
			
			var execGMCmd = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				var gmcmd = #{FieldGMCmd}.getValue( );
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/ExecGMCmd",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						gmcmd		: gmcmd
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgExecSuccess );
							#{WindowGMCmd}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnExecSqlScriptClick = function( ) {
				#{PanelSqlScript}.reset( );
				#{WindowSqlScript}.show( );
			};
			
			var execSqlScript = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				var sqlScript = #{FieldSqlScript}.getValue( );
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/ExecSqlScript",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						script		: sqlScript
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgExecSuccess );
							#{WindowSqlScript}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					},
					failure: function( msg, result, param, req ) {
						showErrMsg( msgTitle, msg );
					}
				} );
			};
			
			var btnExecLogSqlScriptClick = function( ) {
				#{PanelLogSqlScript}.reset( );
				#{WindowLogSqlScript}.show( );
			};
			
			var execLogSqlScript = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				var sqlScript = #{FieldLogSqlScript}.getValue( );
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/ExecLogSqlScript",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						script		: sqlScript
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgExecSuccess );
							#{WindowLogSqlScript}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					},
					failure: function( msg, result, param, req ) {
						showErrMsg( msgTitle, msg );
					}
				} );
			};
			
			var btnExecShellScriptClick = function( ) {
				#{PanelShellScript}.reset( );
				#{WindowShellScript}.show( );
			};
			
			var execShellScript = function( ) {
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}

				var shellScript = #{FieldShellScript}.getValue( );
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/ExecShellScript",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
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
				var svrIds = svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
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
						ids			: svrIds,
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
							url				: "opservice.asmx/ClearRankData",
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
			
			var btnClearOpenServerDataClick =function( ) {
				var msgDBNameInfo;
				var svrIds	= svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				showConfirmMsg( msgTitle, msgClearOpenServerDataConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.ExamineSelectServerDBName( svrIds, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									msgDBNameInfo = String.format( '<span style="font-weight:bold; color:red">{0}</span>', msgSelectSvrCfgDbDBNameNote ) + '</br>' + String.format( '<span>{0}</span>', result.Result.DBNames );
									clearOpenServerData( svrIds, msgDBNameInfo );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
						
					}
				} );
			};
			
			var clearOpenServerData = function( svrIds, msgDBNameInfo ) {
				showConfirmMsg( msgTitle, msgDBNameInfo, function( btn ) {
					if( btn =="yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/ClearOpenData",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
							},
							eventMask	:{
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
			
			var btnWarBatchUpdateClick = function( ) {
				#{WindowSetWarBatchUpdate}.show( );
			};
			
			var storeWarSvrLoad = function( store, records, options ) {
				if( records.length > 0 ) {
					#{ComboBoxWarSvr}.setValue( store.getAt( 0 ).get( 'Id' ) );
					#{ComboBoxWarSvr}.fireEvent( "select", #{ComboBoxWarSvr}.getStore( ) );
				}
			};
			
			var warBatchUpdate = function( ) {
				var svrIds	= svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				var warOn		= #{ComboBoxWarOn}.getValue( );
				var warGameId	= #{ComboBoxWarSvr}.getValue( );
				
				Ext.net.DirectMethod.request({
					url				: "opservice.asmx/WarBatchUpdate",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: svrIds,
						warOn		: warOn,
						warId		: warGameId
					},
					eventMask	:{
						showMask	: true,
						minDelay	: 200,
						msg			: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowSetWarBatchUpdate}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var btnClearWarApplyDataClick = function( ) {
				var svrIds	= svrlistGetSelectedSvr( );
				if( svrIds.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				showConfirmMsg( msgTitle, msgClearWarApplyDataConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request({
							url				: "opservice.asmx/ClearWarApplyData",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids			: svrIds
							},
							eventMask	:{
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
						});
					}
				} );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	
	<ext:Store ID="StoreWarSvr" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreWarSvrRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{FormPanelWarBatchUpdate}.body" />
		</DirectEventConfig>
		<Listeners>
			<Load Fn="storeWarSvrLoad"/>
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server" >
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:Toolbar ID="Toolbar1" runat="Server" Height="35">
						<Items>
							<ext:Button ID="BtnStartGame" runat="server" Icon="PlayGreen" Scale="Medium" Text="<%$ Resources:StringDef, StartGame %>">
								<Listeners>
									<Click Fn="btnStartGameClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnStopGame" runat="server" Icon="StopBlue" Scale="Medium" Text="<%$ Resources:StringDef, StopGame %>">
								<Listeners>
									<Click Fn="btnStopGameClick" />
								</Listeners>
							</ext:Button>
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
							<ext:SplitButton ID="BtnUpdateGame" runat="server" Icon="Build" Scale="Medium" Text="<%$ Resources:StringDef, UpdateGame %>">
								<Listeners>
									<Click Fn="btnUpdateGameClick" />
								</Listeners>
								<Menu>
									<ext:Menu ID="Menu4" runat="server">
										<Items>
											<ext:MenuItem ID="MenuItem5" runat="server" Text="<%$ Resources:StringDef, UpdateIBShop %>" Icon="RubyGo" >
												<Listeners>
													<Click Fn="btnUpdateIBShopClick" />
												</Listeners>
											</ext:MenuItem>
										</Items>
									</ext:Menu>
								</Menu>
							</ext:SplitButton>
							<ext:SplitButton ID="BtnExecGMCmd" runat="server" Icon="Script" Scale="Medium" Text="<%$ Resources:StringDef, ExecScript %>">
								<Listeners>
									<Click Fn="btnExecGMCmdClick" />
								</Listeners>
								<Menu>
									<ext:Menu ID="Menu3" runat="server">
										<Items>                    
											<ext:MenuItem runat="server" Text="<%$ Resources:StringDef, ExecSqlScript %>" Icon="ScriptCode" >
												<Listeners>
													<Click Fn="btnExecSqlScriptClick" />
												</Listeners>
											</ext:MenuItem>
											<ext:MenuItem ID="MenuItem6" runat="server" Text="<%$ Resources:StringDef, ExecLogSqlScript %>" Icon="ScriptCode" >
												<Listeners>
													<Click Fn="btnExecLogSqlScriptClick" />
												</Listeners>
											</ext:MenuItem>
											<ext:MenuItem runat="server" Text="<%$ Resources:StringDef, ExecShellScript %>" Icon="ScriptGo" >
												<Listeners>
													<Click Fn="btnExecShellScriptClick" />
												</Listeners>
											</ext:MenuItem>
										</Items>
									</ext:Menu>
								</Menu>
							</ext:SplitButton>
							<ext:Button ID="BtnSetSvrTime" runat="server" Icon="Clock" Scale="Medium" Text="<%$ Resources:StringDef, SetTime %>">
								<Listeners>
									<Click Fn="btnSetSvrTimeClick" />
								</Listeners>
							</ext:Button>
							
							<ext:Button ID="SplitButton1" runat="server" Icon="Cog" Scale="Medium" Text="<%$ Resources:StringDef, SvrConfig %>">
								<Menu>
									<ext:Menu runat="server">
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
							<ext:Button ID="BtnUpdateDetector" runat="server" Icon="AwardStarGold3" Scale="Medium" Text="<%$ Resources:StringDef, UpdateDetector %>">
								<Listeners>
									<Click Fn="updateDetector" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnKillGame" runat="server" Icon="ErrorGo" Scale="Medium" Text="<%$ Resources:StringDef, KillGame %>">
								<Listeners>
									<Click Fn="btnKillGameClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnBK" runat="server" Icon="DatabaseSave" Scale="Medium" Text="<%$ Resources:StringDef, Backup %>">
								<Menu>
									<ext:Menu ID="Menu2" runat="server">
										<Items>
											<ext:MenuItem ID="MenuItem1" runat="server" Text="<%$ Resources:StringDef, BackupDb %>" Icon="DatabaseWrench" >
												<Listeners>
													<Click Handler="
														#{WindowBackupDb}.show( );
													" />
												</Listeners>
											</ext:MenuItem>
											<ext:MenuItem ID="MenuItem2" runat="server" Text="<%$ Resources:StringDef, BackupVipRole %>" Icon="DatabaseYellow" >
												<Listeners>
													<Click Handler="
														backupVipRole( );
													" />
												</Listeners>
											</ext:MenuItem>
										</Items>
									</ext:Menu>
								</Menu>
							</ext:Button>
							<ext:Button ID="BtnClearRankData" runat="server" Icon="ControlRemoveBlue" Scale="Medium" Text="<%$ Resources:StringDef, ClearRankData %>">
								<Listeners>
									<Click Fn="btnClearRankDataClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnClearOpenServerData" runat="Server" Icon="BasketDelete" Scale="Medium" Text="<%$ Resources:StringDef, ClearOpenServerData %>">
								<Listeners>
									<Click Fn="btnClearOpenServerDataClick" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnWarBatchUpdate" runat="server" Icon="Controller" Scale="Medium" Text="<%$ Resources:StringDef, WarBatchUpdate %>" >
								<Listeners>
									<Click Fn="btnWarBatchUpdateClick"/>
								</Listeners>
							</ext:Button>
							<ext:Button ID="BtnClearWarApplyData" runat="server" Icon="DatabaseDelete" Scale="Medium" Text="<%$ Resources:StringDef, ClearWarApplyData %>" Hidden="true">
								<Listeners>
									<Click Fn="btnClearWarApplyDataClick"/>
								</Listeners>
							</ext:Button>
							<%--<ext:ButtonGroup ID="ButtonGroup1" runat="server" Title="<%$ Resources:StringDef, SvrMaintain %>" >
								<Items>
									<ext:TableLayout ID="TableLayout1" runat="server">                                
										<Cells>
											<ext:Cell>
												<ext:Button ID="BtnStartGame" runat="server" Icon="PlayGreen" Scale="Medium" Text="<%$ Resources:StringDef, StartGame %>">
													<Listeners>
														<Click Fn="btnStartGameClick" />
													</Listeners>
												</ext:Button>
											</ext:Cell>
											<ext:Cell>
												<ext:Button ID="BtnStopGame" runat="server" Icon="StopBlue" Scale="Medium" Text="<%$ Resources:StringDef, StopGame %>">
													<Listeners>
														<Click Fn="btnStopGameClick" />
													</Listeners>
												</ext:Button>
											</ext:Cell>
											<ext:Cell>
												<ext:Button ID="BtnUploadFile" runat="server" Icon="FolderGo" Scale="Medium" Text="<%$ Resources:StringDef, SvrPakUpload %>">
													<Listeners>
														<Click Fn="btnUploadFileClick" />
													</Listeners>
												</ext:Button>
											</ext:Cell>
											<ext:Cell>
												<ext:Button ID="BtnUpdateGame" runat="server" Icon="Build" Scale="Medium" Text="<%$ Resources:StringDef, UpdateGame %>">
													<Listeners>
														<Click Fn="btnUpdateGameClick" />
													</Listeners>
												</ext:Button>
											</ext:Cell>
										</Cells>
									</ext:TableLayout>
								</Items>
							</ext:ButtonGroup>--%>
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
	
	<ext:Window ID="WindowGMCmd" runat="server" Resizable="false" Maximizable="false"
		Width="600" Height="200" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:BorderLayout ID="BorderLayout3" runat="server">
				<Center>
					<ext:FormPanel ID="PanelGMCmd" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
						<Items>
							<ext:TextArea ID="FieldGMCmd" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, GMCommand %>" Height="100">
							</ext:TextArea>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnGMCmd" runat="Server" Text="<%$ Resources:StringDef, Execute %>">
				<Listeners>
					<Click Fn="execGMCmd" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnGMCmdCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowGMCmd}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowSqlScript" runat="server" Resizable="false" Maximizable="false"
		Width="600" Height="200" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:BorderLayout ID="BorderLayout4" runat="server">
				<Center>
					<ext:FormPanel ID="PanelSqlScript" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
						<Items>
							<ext:TextArea ID="FieldSqlScript" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, SqlScript %>" Height="100">
							</ext:TextArea>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Execute %>">
				<Listeners>
					<Click Fn="execSqlScript" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowSqlScript}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowLogSqlScript" runat="server" Resizable="false" Maximizable="false"
		Width="600" Height="200" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
		<Items>
			<ext:BorderLayout runat="server">
				<Center>
					<ext:FormPanel ID="PanelLogSqlScript" runat="Server" LabelAlign="Right" LabelWidth="80"
						ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
						<Items>
							<ext:TextArea ID="FieldLogSqlScript" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, SqlScript %>" Height="100">
							</ext:TextArea>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Execute %>">
				<Listeners>
					<Click Fn="execLogSqlScript" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowLogSqlScript}.hide( );
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
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Execute %>">
				<Listeners>
					<Click Fn="execShellScript" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
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
			<ext:Button ID="Button2" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setSvrTime" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button3" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowSetTime}.hide( );
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
			<ext:Button ID="Button4" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setOpenDate" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button5" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
					#{WindowSetOpenDate}.hide( );
				" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowBackupDb" runat="server" Resizable="false" Maximizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, SetOpenDate %>">
		<Items>
			<ext:FormPanel ID="FormPanel2" runat="Server" LabelAlign="Right" LabelWidth="80" ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:RadioGroup ID="RadioGroupSvr" runat="server" Width="220" FieldLabel="<%$ Resources:StringDef, Type %>">
						<Items>
							<ext:Radio ID="RadioBKTypeMini" runat="server" BoxLabel="<%$ Resources:StringDef, BackupDbCore %>" Checked="true" />
							<ext:Radio ID="RadioBKTypeAll" runat="server" BoxLabel="<%$ Resources:StringDef, BackupDbAll %>" />
							<ext:Radio ID="RadioBKTypeStat" runat="server" BoxLabel="<%$ Resources:StringDef, BackupDbStat %>" />
						</Items>
					</ext:RadioGroup>
					<ext:TextField runat="Server" ID="TextFieldBKDir" Text="/home/lmzg/server/daybreakdatabak" FieldLabel="<%$ Resources:StringDef, BKDir %>" AnchorHorizontal="95%"></ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button6" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="backupDb" />
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
	
	<ext:Window ID="WindowSetWarBatchUpdate" runat="Server" Resizable="false" Minimizable="false"
		Width="500" AutoHeight="true" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
		Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px" Title="<%$ Resources:StringDef, WarBatchUpdate %>">
		<Items>
			<ext:FormPanel ID="FormPanelWarBatchUpdate" runat="Server" LabelAlign="Right" LabelWidth="100"
				ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
				<Items>
					<ext:ComboBox runat="Server" ID="ComboBoxWarOn" FieldLabel="<%$ Resources:StringDef, SvrCfgWarOn %>" Editable="false" AnchorHorizontal="95%" SelectedIndex="0" NoteAlign="Down">
						<Items>
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, WarSvrOff %>" Value="0" />
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, WarSvrOn %>" Value="1"/>
						</Items>
					</ext:ComboBox>
					<ext:ComboBox runat="Server" ID="ComboBoxWarSvr" StoreID="StoreWarSvr" AnchorHorizontal="95%" Editable="false" FieldLabel="<%$ Resources:StringDef,SvrCfgWarSvr %>"
						ValueField="Id" DisplayField="Name" Mode="Remote" SelectedIndex="0">
					</ext:ComboBox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="Button8" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="warBatchUpdate"/>
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button9" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowSetWarBatchUpdate}.hide(  );"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
