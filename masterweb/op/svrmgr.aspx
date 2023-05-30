<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svrmgr, App_Web_svrmgr.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>
<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
	</style>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgAddRegion				= '<%= Resources.StringDef.AddRegion %>';
		var msgDelRegionPrompt			= '<%= Resources.StringDef.MsgDelRegionPrompt %>';
		var msgModifyRegion				= '<%= Resources.StringDef.ModifyRegion %>';
		var msgAddGameGroup				= '<%= Resources.StringDef.AddGameGroup %>';
		var msgDelGameGroupPrompt		= '<%= Resources.StringDef.MsgDelGameGroupPrompt %>';
		var msgModifyGameGroup			= '<%= Resources.StringDef.ModifyGameGroup %>';
		var msgCannotBeNullFormat		= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgName						= '<%= Resources.StringDef.Name %>';
		var msgInvalidIPAddress			= '<%= Resources.StringDef.InvalidIPAddress %>';
		var msgInvalidPort				= '<%= Resources.StringDef.InvalidPort %>';

		var msgSelNoGameGroup			= '<%= Resources.StringDef.MsgSelNoGameGroup %>';
		var msgSelNoGameProc			= '<%= Resources.StringDef.MsgSelNoGameProc %>';
		var msgNoUpdatePakName			= '<%= Resources.StringDef.MsgNoUpdatePakName %>';
		var msgUpload					= '<%= Resources.StringDef.Upload %>';
		var msgUpdate					= '<%= Resources.StringDef.Update %>';
		var msgSvrPakUpload				= '<%= Resources.StringDef.SvrPakUpload %>';
		var msgSvrUpdate				= '<%= Resources.StringDef.SvrUpdate %>';
		var msgAlertInfo				= '<%= Resources.StringDef.AlertInfo %>';
		
		var msgProcessConfig			= '<%= Resources.StringDef.ProcessConfig %>';
		var msgStartGameConfirmFormat	= '<%= Resources.StringDef.MsgStartGameConfirmFormat %>';
		var msgStopGameConfirmFormat	= '<%= Resources.StringDef.MsgStopGameConfirmFormat %>';
		var msgUpdateGameConfirmFormat	= '<%= Resources.StringDef.MsgUpdateGameConfirmFormat %>';
		var msgAlreadyAddToTranList		= '<%= Resources.StringDef.MsgAlreadyAddToTranList %>';
		var msgNoRelatedGameProc		= '<%= Resources.StringDef.MsgNoRelatedGameProc %>';
		var msgUpdateGameStarted		= '<%= Resources.StringDef.MsgUpdateGameStarted %>';
		
		var msgGSUnknown				= '<%= Resources.StringDef.GSUnknown %>';
		var msgGSStop					= '<%= Resources.StringDef.GSStop %>';
		var msgGSStarting				= '<%= Resources.StringDef.GSStarting %>';
		var msgGSRunning				= '<%= Resources.StringDef.GSRunning %>';
		var msgGSStopping				= '<%= Resources.StringDef.GSStopping %>';
		var msgGSSvrPingTimeout			= '<%= Resources.StringDef.GSSvrPingTimeout %>';
		var msgGSDeadLoop				= '<%= Resources.StringDef.GSDeadLoop %>';
		var msgGSCrash					= '<%= Resources.StringDef.GSCrash %>';
		var msgGSDeadLoopKill			= '<%= Resources.StringDef.GSDeadLoopKill %>';

		var msgUnknown					= '<%= Resources.StringDef.Unknown %>';
		var msgConnected				= '<%= Resources.StringDef.Connected %>';
		var msgDisconnected				= '<%= Resources.StringDef.Disconnected %>';
		
		var msgNSDisconnect				= '<%= Resources.StringDef.NSDisconnect %>';
		var msgNSUnknown				= '<%= Resources.StringDef.NSUnknown %>';
		var msgNSConnect				= '<%= Resources.StringDef.NSConnect %>';
		
		var msgPaySUnknown				= '<%= Resources.StringDef.PaySUnknown %>';
		var msgPaySNormal				= '<%= Resources.StringDef.PaySNormal %>';
		var msgPaySErr					= '<%= Resources.StringDef.PaySErr %>';

		var msgDBSNormal				= '<%= Resources.StringDef.DBSNormal %>';
		var msgDBSUnknown				= '<%= Resources.StringDef.DBSUnknown %>';
		var msgDBSErr					= '<%= Resources.StringDef.DBSErr %>';

		var msgNSErrNormal				= '<%= Resources.StringDef.NSErrNormal %>';
		var msgNSErrUnknown				= '<%= Resources.StringDef.NSErrUnknown %>';
		var msgNSErrErr					= '<%= Resources.StringDef.NSErrErr %>';

		var msgSvrFlagRecommend			= '<%= Resources.StringDef.SvrFlagRecommend %>';
		var msgSvrFlagNew				= '<%= Resources.StringDef.SvrFlagNew %>';
		var msgSvrDisplayFlagFullShort	= '<%= Resources.StringDef.SvrDisplayFlagFullShort %>';
		var msgSvrDisplayFlagWebShort	= '<%= Resources.StringDef.SvrDisplayFlagWebShort %>';

		var msgStartGameGroupConfirmFormat			= '<%= Resources.StringDef.MsgStartGameGroupConfirmFormat %>';
		var msgStopGameGroupConfirmFormat			= '<%= Resources.StringDef.MsgStopGameGroupConfirmFormat %>';
		var msgRmvProcFromGameGroupConfirmFormat	= '<%= Resources.StringDef.MsgRmvProcFromGameGroupConfirmFormat %>';

		var msgCreateSvrListConfirm					= '<%= Resources.StringDef.MsgCreateSvrListConfirm %>';
		var msgSvrListCreated						= '<%= Resources.StringDef.MsgSvrListCreated %>';
		var msgInfo									= '<%= Resources.StringDef.Info %>';
		var msgOperationPlatform					= '<%= Resources.StringDef.OperationPlatform %>';
		var msgPlayerCountFormat					= '<%= Resources.StringDef.MsgPlayerCountFormat %>';
		var msgWarSvrOn								= '<%= Resources.StringDef.WarSvrOn %>';
		var msgWarSvrOff							= '<%= Resources.StringDef.WarSvrOff %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var statusTpl		= "<span class='{0}'></span>";
			var markerTemplate	= "<div class='mark {0}' style='margin-left:1px !important;'>&nbsp;</div>";
			var regionOp		= 0;				//操作：0表示新加，1表示修改。
			var gamegroupOp		= 0;
			var gameProcOp		= 0;
			var winFileManOp	= 0;				//WindowFileMan操作：0表示上传文件 1表示更新服务器
			var currGameGroupId	= 0;
			var tipType			= 0;
			var selGameGroup	= null;
			var hasggMgrPri		= false;
			var hasggMgrPriGame = false;
//			var hasggMgrPriNet	= false;
			var platformId		= 0;
			
			var renderOSType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value )
				{
					case 0:
						return msgOSTypeWindows;
					case 1:
						return msgOSTypeLinux;
				}
			};
			
			var renderRegionId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var index = #{StoreRegion}.find( 'Id', value );
				if( index != -1 ) {
					var regionRec		= #{StoreRegion}.getAt( index );
					var platformIndex	= #{StorePlatform}.find( 'Id', record.data.PlatformId );
					var platformInfo	= '';
					if( platformIndex != -1 ) {
						var platformRecord = #{StorePlatform}.getAt( platformIndex );
						platformInfo = platformRecord.data.Name;
					}
					
					if( platformInfo ) {
						return '[' + platformInfo + ']' + regionRec.get( 'Name' ) + ' - ' + String.format( msgPlayerCountFormat, regionRec.data.PlayerCount );
					} else {
						return regionRec.get( 'Name' ) + ' - ' + String.format( msgPlayerCountFormat, regionRec.data.PlayerCount );
					}
				} else {
					return '';
				}
			};
			
			var renderPlatformId = function( value, metadata, record, rowIndex, colIndex, store ) {
			};
			
//			var renderMarker = function( value, metadata, record, rowIndex, colIndex, store ) {
//				switch( value ) {
//					case 0:
//						return String.format( markerTemplate, '&nbsp;&nbsp;&nbsp;' );
//					case 1:
//						return String.format( markerTemplate, 'star' );
//					case 2:
//						return String.format( markerTemplate, 'flag' );
//				}
//				return value;
//			};
			
			var renderGameGroupId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var index = #{StoreGameGroup}.find( 'Id', value );
				if( index != -1 ) {
					var record = #{StoreGameGroup}.getAt( index );
					return record.get( 'Name' );
				} else {
					return '';
				}
			};
			
			var renderGameGroupState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return String.format( statusTpl, "sunknow" );	
					case 1:
						return String.format( statusTpl, "snormal" );	
					case 2:
						return String.format( statusTpl, "salert" );
					case 3:
						return String.format( statusTpl, "sstop" );
					default:
						return msgNotAvailable;
				}
			};
			
			var renderGameGroupName = function( value, metadata, record, rowIndex, colIndex, store ) {
				return value + renderFlag( record.data.Flag, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderFlag = function( value, metadata, record, rowIndex, colIndex, store ) {
				var flag = record.data.Flag;
				var flagText = '';
				
				if( ( value & 2 ) > 0 ) {
					flagText += String.format( "【{0}】", msgSvrFlagNew );
				}
				else if( ( value & 1 ) > 0 ) {
					flagText += String.format( "【{0}】", msgSvrFlagRecommend );
				}
				
				return flagText;
			};
			
			var renderDisplayFlag = function( value, metadata, record, rowIndex, colIndex, store ) {
				var flag = record.data.DisplayFlag;
				var flagText = '';
				
				if( ( value & 1 ) > 0 ) {
					flagText += msgSvrDisplayFlagFullShort + ' ';
				}
				if( ( value & 2 ) > 0 ) {
					flagText += msgSvrDisplayFlagWebShort + ' ';
				}
				
				return flagText;
			};
			
			var renderGameGroupNetStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						metadata.css = 'netdis';
						return msgNSDisconnect;
					case 1:
						metadata.css = 'netcon';
						return msgNSConnect;
					default:
						metadata.css = 'netunknown';
						return msgNSUnknown;
				}
			};
			
			var renderGameGroupGameStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 1:
						metadata.css = 'pstop';
						return msgGSStop;
					case 2:
						metadata.css = 'pstarting';
						return msgGSStarting;
					case 3:
						metadata.css = 'prunning';
						return msgGSRunning;
					case 4:
						metadata.css = 'pstopping';
						return msgGSStopping;
					case 5:
						metadata.css = 'ptimeout';
						return msgGSSvrPingTimeout;
					case 6:
						metadata.css = 'pdeadloop';
						return msgGSDeadLoop;
					case 7:
						metadata.css = 'pcrash';
						return msgGSCrash;
					case 8:
						metadata.css = 'pdeadloopkill';
						return msgGSDeadLoopKill;
					case 0:
					default:
						metadata.css = 'punknown';
						return msgGSUnknown;
				}
			};
			
			var renderGameGroupPaymentStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case -1:
						metadata.css = 'payunknown';
						return msgPaySUnknown;
					case 0:
						metadata.css = 'paynormal';
						return msgPaySNormal;
					default:
						metadata.css = 'payerr';
						return value;
				}
			};
			
			var renderGameGroupDBStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case -1:
						metadata.css = 'dbunknown';
						return msgDBSUnknown;
					case 0:
						metadata.css = 'dbnormal';
						return msgDBSNormal;
					default:
						metadata.css = 'dberr';
						return msgDBSErr;
				}
			};
			
			var renderGameGroupNetErrStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case -1:
						metadata.css = 'nsunknown';
						return msgNSErrUnknown;
					case 0:
						metadata.css = 'nsnormal';
						return msgNSErrNormal;
					default:
						metadata.css = 'nserr';
						return msgNSErrErr;
				}
			};
			
			var renderGameGroupWarStatus = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case -1:
						metadata.css = 'warunknown';
						return msgUnknown;
					case 0:
						metadata.css = 'warcon';
						return msgConnected;
					default:
						metadata.css = 'wardis';
						return msgDisconnected;
				}
			};
			
			var renderGameGroupPlayerCount = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value >= 0 ) {
					if( record.data.QueueCount > 0 ) {
						return value + '-[' + record.data.QueueCount + ']';
					} else {
						return value;
					}
				} else {
					return msgNotAvailable;
				}
			};
			
			var renderGameGroupTask = function( value, metadata, record, rowIndex, colIndex, store ) {
				var gamegroupId	= record.get( 'Id' );
				var progressId	= 'rowProgress' + gamegroupId;
				var renderHtml	= "<span id='" + progressId + "' style='float:left;'></span>";
				
				renderHtml += "&nbsp;"
				renderHtml += "<span style='line-height:18px;'>" + record.get( 'TransSpeed' ) + "</span>";
				
				return renderHtml;
			};
			
			var renderGameProcState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return String.format( statusTpl, "punknown" );	
					case 1:
						return String.format( statusTpl, "pstop" );	
					case 2:
						return String.format( statusTpl, "pstarting" );	
					case 3:
						return String.format( statusTpl, "prunning" );	
					case 4:
						return String.format( statusTpl, "pstopping" );
				}
			};
			
			var renderGameProcPhyId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var state = record.data.State;
				switch( state ) {
					case 0:
						return "N/A";
					default:
						return value;
				}
			};
						
			var renderPlatformId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var platformIndex = #{StorePlatform}.find( 'Id', value );
				if( platformIndex != -1 ) {
					return #{StorePlatform}.getAt( platformIndex ).data.Name;
				} else {
					return value;
				}
			};
			
			var getGameGroupQueryParams = function( store, options ) {
				var keyword = #{TextFieldQueryKeyword}.getValue( );
				
				options.params.keyword = keyword;
			};

			var getGameProcQueryParams = function( store, options ) {
				if( selGameGroup ) {
					options.params.GameGroupId = selGameGroup.get( 'Id' );
				}
			};

			var getRegionQueryParams = function( store, options ) {
				
			};
			
			var queryPlatform = function( reset, callback ) {
				#{StorePlatform}.load( { 
					callback : callback
				} );
			};
			
			var queryRegion = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingRegion}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreRegion}.lastOptions ) {
					paramStart = #{StoreRegion}.lastOptions.params.start;
				}
				#{StoreRegion}.load( { 
					params : { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
			var addRegion = function( ) {
				#{TextFieldRegionId}.setVisible( false );
			
				#{FormPanelRegion}.reset( );
				#{ButtonRegionOp}.setText( msgOK );
				#{WindowRegion}.setTitle( msgAddRegion );
				#{WindowRegion}.show( );
				
				regionOp = 0;
			};

			var deleteRegion = function( ) {
				var grid = #{GridPanelRegion};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelRegionPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteRegion( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryRegion( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyRegion = function( ) {
				#{TextFieldRegionId}.setVisible( true );
			
				var record = #{GridPanelRegion}.getSelectionModel( ).getSelected( );
				showGroupDetail( record );				
				
				regionOp = 1;
			};
			
			var showGroupDetail = function( record ) {
				#{TextFieldRegionId}.setValue( record.data.Id );
				#{TextFieldRegionName}.setValue( record.data.Name );
				#{TextFieldRegionComment}.setValue( record.data.Comment );
				#{ComboBoxPlatform}.setValue( record.data.PlatformId );

				#{ButtonRegionOp}.setText( msgSave );
				
				#{WindowRegion}.setTitle( msgModifyRegion );
				#{WindowRegion}.show( );
			};
			
			var setRegion = function( ) {
				var groupName = #{TextFieldRegionName}.getValue( );
				if( groupName.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				var regionId = #{TextFieldRegionId}.getValue( );
				var platformId = #{ComboBoxPlatform}.getValue( );
				if( !platformId ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgOperationPlatform ) );
					return;
				}
				
				Ext.net.DirectMethods.SetRegion( regionOp, regionId, platformId, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowRegion}.hide( );
							queryRegion( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryRegion( );
						}
					}
				});
			};
			
			var queryGameGroup = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingGameGroup}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreGameGroup}.lastOptions ) {
					paramStart = #{StoreGameGroup}.lastOptions.params.start;
				}
				#{StoreGameGroup}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var addGameGroup = function( ) {
				gamegroupOp = 0;
			
				#{TextFieldGameGroupId}.setVisible( false );
			
				/* GameProc */
				#{ComboAddProcCabinetId}.clearValue( );
				#{ComboAddProcMachineId}.clearValue( );
				#{ComboAddProcId}.clearValue( );
				
				#{StoreCabinet}.removeAll( true );
				#{StoreMachine}.removeAll( true );
				#{StoreQueryGameProc}.removeAll( true );
				
				#{StoreCabinet}.load( );
			
				#{FormPanelGameGroup}.reset( );
				#{ButtonGameGroupOp}.setText( msgOK );
				#{WindowGameGroup}.setTitle( msgAddGameGroup );
				#{WindowGameGroup}.show( );
			};

			var deleteGameGroup = function( ) {
				var grid = #{GridPanelGameGroup};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelGameGroupPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteGameGroup( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ) {
									queryGameGroup( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyGameGroup = function( ) {
				gamegroupOp = 1;
			
				#{TextFieldGameGroupId}.setVisible( true );
			
				var record = selGameGroup;
				showGameGroupDetail( record );
				
				#{StoreCabinet}.removeAll( true );
				#{StoreMachine}.removeAll( true );
				#{StoreQueryGameProc}.removeAll( true );
				
				#{StoreCabinet}.load( { callback: function( records, options, success ) {
					/* 修改选择对应的 */
					var cabinetId = selGameGroup.get( 'CabinetId' );
					if( cabinetId != -1 ) {
						#{ComboAddProcCabinetId}.setValue( cabinetId );
						
						#{StoreMachine}.load( { callback : function( ) {
							var machineId = selGameGroup.get( 'MachineId' );
							if( machineId != -1 ) {
								#{ComboAddProcMachineId}.setValue( machineId );
								
								#{StoreQueryGameProc}.load( { callback : function( ) {
									var procId = selGameGroup.get( 'ProcId' );
									if( procId != -1 ) {
										#{ComboAddProcId}.setValue( procId );
										#{ComboAddProcId}.fireEvent( "select", #{ComboAddProcId}.getStore( ) );
									}
								} } );
							}
						} } );
					}
				} } );
			};
			
			var showGameGroupDetail = function( record ) {
				#{TextFieldGameGroupId}.setValue( record.data.Id );
				#{TextFieldGameGroupName}.setValue( record.data.Name );
				#{TextFieldGameGroupIndex}.setValue( record.data.Index );
				#{TextFieldGameGroupComment}.setValue( record.data.Comment );
				#{MultiSelectRegion}.setValue( record.data.Region );
				
				#{CheckFlagRecommend}.setValue( ( record.data.Flag & 1 ) > 0 );
				#{CheckFlagNew}.setValue( ( record.data.Flag & 2 ) > 0 );
				
				#{CheckDisFlagFull}.setValue( ( record.data.DisplayFlag & 1 ) > 0 );
				#{CheckDisFlagWeb}.setValue( ( record.data.DisplayFlag & 2 ) > 0 );
				
				#{ButtonGameGroupOp}.setText( msgSave );
				
				#{WindowGameGroup}.setTitle( msgModifyGameGroup );
				#{WindowGameGroup}.show( );
			};
			
			var setGameGroup = function( ) {
				var machineName = #{TextFieldGameGroupName}.getValue( );
				if( machineName.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				var gamegroupId = #{TextFieldGameGroupId}.getValue( );
				Ext.net.DirectMethods.SetGameGroup( gamegroupOp, gamegroupId, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowGameGroup}.hide( );
							queryGameGroup( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryGameGroup( );
						}
					}
				});
			};
			
			var gridGroupSelectionChange = function( el ) {
				#{BtnDelRegion}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyRegion}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridGameGroupSelectionChange = function( el ) {
				#{BtnDelGameGroup}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridGameProcSelectionChange = function( el ) {
				#{BtnDelGameProc}.setDisabled( el.getCount( ) < 1 );
				#{BtnSvrCfg}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridGroupRowDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showGroupDetail( record );
				
				regionOp = 1;
			};
			
			var initData = function( ) {
				queryPlatform( true, function( ) {
					queryRegion( true, function( ) {
						queryGameGroup( );
					} );
				} );
				
				setInterval( updateGameGroupState, 3000 );
				setInterval( updateGameGroupTip, 2000 );
				setInterval( updateGameRegion, 5000 );
				setInterval( updateAlertMsg, 5000 );
			};
			
			var showDetectorConfiguration = function( ) {
				#{FormPanelDetectorConfiguration}.reset( );
//				#{BtnDetectorConfig}.setText( msgOK );
				#{WindowDetectorConfiguration}.show( );
			};
			
			var configureDetector = function( ) {
				var monitorIP = #{TextFieldDetectorConfigurationIP}.getValue( );
				var monitorPort = #{TextFieldDetectorConfigurationPort}.getValue( );
				var ipReg = RegExp( '^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$' );
				if( !ipReg.test( monitorIP ) ) {
					showErrMsg( msgTitle, msgInvalidIPAddress );
					return;
				}
				if( monitorPort == null || monitorPort == '' || isNaN( monitorPort ) || monitorPort > 65535 || monitorPort < 1 ) {
					showErrMsg( msgTitle, msgInvalidPort );
					return;
				}
				
				Ext.net.DirectMethods.ConfigureDetector( 
					monitorIP,
					monitorPort, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowDetectorConfiguration}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var showRegionWindow = function( ) {
				#{WindowRegionMgr}.show( );
			};
			
			var createSvrList = function( ) {
				var result = showConfirmMsg( msgTitle, msgCreateSvrListConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.CreateSvrList( {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgSvrListCreated );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var showBatchWindow = function( ) {
				#{WindowBatchOp}.show( );
			};
			
			var textFieldKeywordsSpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					queryGameGroup( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var comboAddProcCabinetSelect = function( combo, record, index ) {
				#{StoreMachine}.removeAll( true );
				#{StoreQueryGameProc}.removeAll( true );
				#{ComboAddProcMachineId}.clearValue( );
				#{ComboAddProcId}.clearValue( );
				#{StoreMachine}.load( );
			};
			
			var comboAddProcMachineSelect = function( combo, record, index ) {
				#{ComboAddProcId}.clearValue( );
				#{StoreQueryGameProc}.load( );
			};
			
			var storeCabinetLoad = function( store, records, options ) {
				if( gamegroupOp == 0 ) {
					/* 添加默认选择一个 */
					if( records.length > 0 ) {
						#{ComboAddProcCabinetId}.setValue( store.getAt( 0 ).get( 'Id' ) );
						#{ComboAddProcCabinetId}.fireEvent( "select", #{ComboAddProcCabinetId}.getStore( ) );
					}
				}
			};
			
			var storeMachineLoad = function( store, records, options ) {
				if( gamegroupOp == 0 ) {
					/* 添加默认选择一个 */
					if( records.length > 0 ) {
						#{ComboAddProcMachineId}.setValue( store.getAt( 0 ).get( 'Id' ) );
						#{ComboAddProcMachineId}.fireEvent( "select", #{ComboAddProcMachineId}.getStore( ) );
					}
				}
			};
			
			var storeQueryGameProcLoad = function( store, records, options ) {
				if( gamegroupOp == 0 ) {
					/* 添加默认选择一个 */
					if( records.length > 0 ) {
						#{ComboAddProcId}.setValue( store.getAt( 0 ).get( 'Id' ) );
						#{ComboAddProcId}.fireEvent( "select", #{ComboAddProcId}.getStore( ) );
					}
				}
			};
			
			var btnStartGameClick = function( ) {
				var records = #{GridPanelGameGroup}.getSelectionModel( ).getSelections( );
				
				if( records.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				var ids = '';
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					ids += records[nLoopCount].data.Id;
					ids += ',';
				}
			
				startgame( String.format( msgStartGameConfirmFormat, records.length ) );
			};
			
			var startgame = function( confirmMsg ) {
				var result = showConfirmMsg( msgTitle, confirmMsg, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/StartGame",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids	: selGameGroup.get( 'Id' )
							},
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
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
				});
			};
			
			var btnStopGameClick = function( ) {
				var records = #{GridPanelGameGroup}.getSelectionModel( ).getSelections( );
				
				if( records.length == 0 ) {
					showErrMsg( msgTitle, msgSelNoGameGroup );
					return;
				}
				
				var ids = '';
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					ids += records[nLoopCount].data.Id;
					ids += ',';
				}
			
				stopgame( String.format( msgStopGameConfirmFormat, records.length ) );
			};
			
			var stopgame = function( confirmMsg ) {
				showConfirmMsg( msgTitle, confirmMsg, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethod.request( {
							url				: "opservice.asmx/StopGame",
							cleanRequest	: true,
							json			: true,
							params			: {
								ids	: selGameGroup.get( 'Id' )
							},
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
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
				});
			}
			
			var btnUpdateGameClick = function( ) {
				#{BtnWinFileMan}.setText( msgUpdate );
				#{WindowFileMan}.setTitle( msgSvrUpdate );
				
				fileManRefreshDir( );
				#{WindowFileMan}.show( );
				
				winFileManOp = 1;
			};
			
			var updategame = function( ) {
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
						ids			: selGameGroup.get( 'Id' ),
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
			
			var btnUploadFileClick = function( ) {
				#{BtnWinFileMan}.setText( msgUpload );
				#{WindowFileMan}.setTitle( msgSvrPakUpload );
				
				fileManRefreshDir( );
				#{WindowFileMan}.show( );
				
				winFileManOp = 0;
			};
			
			var btnWinFileManClick = function( ) {
				if( winFileManOp == 1 ) {
					/* 更新 */
					updategame( );
				} else {
					/* 上传 */
					uploadPakFile( );
				}
			};
			
			var uploadPakFile = function( ) {
				var pakRelPath = fileManGetSelFile( );
				var records = #{GridPanelGameGroup}.getSelectionModel( ).getSelections( );
				
				Ext.net.DirectMethod.request( {
					url				: "opservice.asmx/UploadPakFile",
					cleanRequest	: true,
					json			: true,
					params			: {
						ids			: selGameGroup.get( 'Id' ),
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
							updateGameGroupState( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var gridGroupCommand = function( command, groupId, records ) {
				if( command === 'SelectGroup') {
					#{GridPanelGameGroup}.getSelectionModel( ).selectRecords( records, true );
				}
				else if( command === 'UnselectGroup' ) {
					#{GridPanelGameGroup}.getSelectionModel( ).clearSelections( );
				}
			};
			
			var gridOnCommand = function( command, record, rowIndex, colIndex ) {
				selGameGroup = record;
				
				switch( command ) {
					case "Modify":
						{
							modifyGameGroup( );
						}
						break;
					case "Config":
						{
							configGameProc( )
						}
						break;
					case "StartGame":
						{
							var confirmMsg = String.format( msgStartGameGroupConfirmFormat, record.data.Name );
							startgame( confirmMsg );
						}
						break;
					case "StopGame":
						{
							var confirmMsg = String.format( msgStopGameGroupConfirmFormat, record.data.Name );
							stopgame( confirmMsg );
						}
						break;
					case "UpdateGame":
						{
							btnUpdateGameClick( );
						}
						break;
					case "SvrPakUpload":
						{
							btnUploadFileClick( );
						}
						break;
					case "EventHis":
						{
							#{PanelEventLog}.autoLoad.params.ggId = selGameGroup.data.Id;
							#{PanelSnap}.autoLoad.params.ggId = selGameGroup.data.Id;
							#{PanelDBInfo}.autoLoad.params.ggId = selGameGroup.data.Id;
							#{PanelEffInfo}.autoLoad.params.ggId = selGameGroup.data.Id;
							#{PanelSysLogInfo}.autoLoad.params.ggId = selGameGroup.data.Id;
							
							showExInfo( );
						}
						break;
				}
			};
			
			var gridDblClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var machineId	= record.data.MachineId;
				
				if( machineId == -1 ) {
					showErrMsg( msgTitle, msgNoRelatedGameProc, function( ) {
						selGameGroup = record;
						modifyGameGroup( );
					} );
				} else {
					showMachineDetail( record );
				}
			};
			
			var gridCellClick = function( grid, rowIndex, columnIndex, e ) {
				if( columnIndex == 0 ) {
					var gamegroupId	= grid.getStore( ).getAt( rowIndex ).get( 'Id' );
					var mark		= grid.getStore( ).getAt( rowIndex ).get( 'Mark' );
					++mark;
					if( mark > 2 ) {
						mark = 0;
					}
					Ext.net.DirectMethods.SetGameGroupMark( gamegroupId, mark );
					updateGameGroupState( );
				}
			};
			
//			var gridMouseOver = function( e ) {
//				var cellIdx = #{GridPanelGameGroup}.getView( ).findCellIndex( e.target );
//				if( cellIdx === false )
//					return;
//				
//				if( cellIdx == 0 ) {
//				}
//			};
			
			var prepareGameGroupToolbar = function( grid, toolbar, rowIndex, record ) {
				var btnStartGame	= toolbar.items.get( 0 );
				var btnStopGame		= toolbar.items.get( 2 );
				var btnUpdateGame	= toolbar.items.get( 4 );
				var btnSvrUpload	= toolbar.items.get( 6 );
				var btnModify		= toolbar.items.get( 8 );
				var btnConfig		= toolbar.items.get( 10 );

				btnStartGame.setDisabled( record.data.GameStatus != 1 );
				//btnStopGame.setDisabled( record.data.GameStatus != 3 && record.data.GameStatus != 2 );
				btnStopGame.setDisabled( record.data.GameStatus != 3 );
				//btnSvrUpload.setDisabled( record.data.NetStatus != 1 );
				btnUpdateGame.setDisabled( record.data.NetStatus != 1 );
				btnConfig.setDisabled( record.data.ProcId == -1 );
				
				if( !hasggMgrPriGame ) {
					btnStartGame.setVisible( false );
					btnStopGame.setVisible( false );
				}
				
				if( !hasggMgrPri ) {
					btnModify.setVisible( false );
					btnConfig.setVisible( false );
				}
			};
			
			var gridProcOnCommand = function( command, record, rowIndex, colIndex ) {
				switch( command ) {
					case "Script":
						{
							var win = #{WindowProcScript};
							win.load( {
								url: 'procscript.aspx',
								params: { procId: record.data.Id },
								discardUrl: false,
								nocache: true,
								timeout: 30
							});
							
							#{WindowProcScript}.show( );
						}
						break;
					case "MachineDetail":
						{
							showMachineDetail( record );
						}
						break;
				}
			};
			
			var gameGroupStateLoad = function( store, records, options ) {
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					var index = #{StoreGameGroup}.findExact( "Id", records[nLoopCount].data.Id );
					if( index != -1 ) {
						var srcRecord = #{StoreGameGroup}.getAt( index );
						
						srcRecord.set( 'NetStatus', records[nLoopCount].get( 'NetStatus' ) );
						srcRecord.set( 'NetErrStatus', records[nLoopCount].get( 'NetErrStatus' ) );
						srcRecord.set( 'GameStatus', records[nLoopCount].get( 'GameStatus' ) );
						srcRecord.set( 'PaymentStatus', records[nLoopCount].get( 'PaymentStatus' ) );
						srcRecord.set( 'DBStatus', records[nLoopCount].get( 'DBStatus' ) );
						srcRecord.set( 'Task', records[nLoopCount].get( 'Task' ) );
						srcRecord.set( 'TransSpeed', records[nLoopCount].get( 'TransSpeed' ) );
						srcRecord.set( 'Mark', records[nLoopCount].get( 'Mark' ) );
						srcRecord.set( 'PlayerCount', records[nLoopCount].get( 'PlayerCount' ) );
						srcRecord.set( 'QueueCount', records[nLoopCount].get( 'QueueCount' ) );
						srcRecord.set( 'Version', records[nLoopCount].get( 'Version' ) );
						srcRecord.set( 'OpenDate', records[nLoopCount].get( 'OpenDate' ) );
						srcRecord.set( 'WarStatus', records[nLoopCount].get( 'WarStatus' ) );
						srcRecord.set( 'SvrType', records[nLoopCount].get( 'SvrType' ) );
				
						/* Commit cause low efficiency */
						//srcRecord.commit( );
						
						var gamegroupId	= records[nLoopCount].get( 'Id' );
						var progressId	= 'rowProgress' + gamegroupId;
						var proBarId	= 'proBar' + gamegroupId;
						
						var filePercent	= records[nLoopCount].data.FilePercent;
						if( filePercent >= 0 ) {
							var bar = getProgressBar( proBarId );
							if( !bar ) {
								bar = createProgressBar( proBarId, progressId, filePercent );
							}
							bar.updateProgress( filePercent );
							bar.show( );
						} else {
							var bar = getProgressBar( proBarId );
							if( bar ) {
								bar.hide( );
							}
						}
					}
				}
			};
			
			var updateGameGroupState = function( ) {
			
				if( !isAutoRefreshOn( ) )
					return;
				var paramStart = 0;
				var paramLimit = #{PagingGameGroup}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( #{StoreGameGroup}.lastOptions ) {
					paramStart = #{StoreGameGroup}.lastOptions.params.start;
				}

				#{StoreGameGroupState}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var configGameProc = function( ) {
				var win = #{WindowSvrCfg};
				win.load( {
					url: 'svrcfg.aspx',
					params: { procId: selGameGroup.get( 'ProcId' ), plId: platformId },
					discardUrl: false,
					nocache: true,
					timeout: 30
				} );
			
				#{WindowSvrCfg}.show( );
			};
			
			var showExInfo = function( ) {
				checkReloadExInfo( #{TabPanelExInfo}.activeTab );
				
				#{WindowInfo}.setTitle( msgInfo + " - " + selGameGroup.get( 'Name' ) );
				#{WindowInfo}.show( );
			};
			
			var closeCfgWin = function( ) {
				#{WindowSvrCfg}.hide( );
			};
			
			var showMachineDetail = function( record ) {
				var url = 'machinedetail.aspx?mId=' + record.data.MachineId;
				window.open( url );
				
//				var win = #{WindowMachineDetail};
//				win.setTitle( record.data.MachineInfo );
//				win.load( {
//					url: '',
//					params: { mId:  },
//					discardUrl: false,
//					nocache: true,
//					timeout: 30
//				});
//				
//				#{ToolTipGameGroup}.hide( );
//				#{WindowMachineDetail}.show( );
			};
			
			var lazyRenderProgress = function( store, records, options ) {
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					var filePercent	= records[nLoopCount].data.FilePercent;
					if( filePercent >= 0 ) {
						var gamegroupId	= records[nLoopCount].get( 'Id' );
						var progressId	= 'rowProgress' + gamegroupId;
						var proBarId	= 'proBar' + gamegroupId;
						
						createProgressBar( proBarId, progressId, filePercent );
					}
				}
			};
			
			var createProgressBar = function( proBarId, renderId, filePercent ) {
				var bar = new Ext.ProgressBar( {
					id : proBarId,
					renderTo: renderId,
					width: 100,
					height: 18,
					value: filePercent,
					text: ( filePercent * 100 ).toFixed( 0 ) + '%'
				} );
			
				return bar;
			};
			
			var getProgressBar = function( proBarId ) {
				return Ext.get( proBarId );
			};
			
			var showGameGroupTip = function( ) {
				var rowIndex	= #{GridPanelGameGroup}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelGameGroup}.view.findCellIndex( this.triggerElement );
				var record = #{StoreGameGroup}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				
				switch( cellIndex )
				{
					case 4:
					case 5:
						tipType = 0;
						break;
					case 6:
						tipType = 2;
						break;
					case 7:
						tipType = 3;
						break;
					case 8:
						tipType = 4;
						break;
					case 9:
						tipType = 5;
						break;
					case 10:
						tipType = 6;
						break;
					case 11:
						tipType = 8;
						break;
					case 14:
						tipType = 7;
						break;
					default:
						{
							this.hide( );
							return;
						}
				}
				
				currGameGroupId = record.get( 'Id' );
			};
			
			var updateGameGroupTip = function( ) {
				var tip = #{ToolTipGameGroup};
				if( !tip.isVisible( ) ) {
					return;
				}
				
				Ext.net.DirectMethods.Tip.UpdateGameGroupTip( currGameGroupId, tipType, {
					method : 'GET',
					success: function( result ) {
						if( result.Success ) {
							tip.body.dom.innerHTML = result.Result;
							setTimeout( "adjustTipPos( );", 200 );
						}
					}
				} );
			};
			
			var updateGameRegion = function( ) {
				queryRegion( true, function( store, records ) {
					try
					{
						var regionOffset = eval( #{HiddenRegionIndex}.getValue( ) );
					
						var titleElArray = Ext.query( 'div.x-grid-group-title' );
						for( var index = 0; index < titleElArray.length; ++index ) {
							var regionRec		= #{StoreRegion}.getAt( regionOffset + index );
							var platformIndex	= #{StorePlatform}.find( 'Id', regionRec.data.PlatformId );
							var platformInfo	= '';
							if( platformIndex != -1 ) {
								var platformRecord = #{StorePlatform}.getAt( platformIndex );
								platformInfo = platformRecord.data.Name;
							}
							
							var regionTitle = '';
							if( platformInfo ) {
								regionTitle = '[' + platformInfo + ']' + regionRec.get( 'Name' ) + ' - ' + String.format( msgPlayerCountFormat, regionRec.data.PlayerCount );
							} else {
								regionTitle = regionRec.get( 'Name' ) + ' - ' + String.format( msgPlayerCountFormat, regionRec.data.PlayerCount );
							}
							
							titleElArray[index].innerHTML = regionTitle;
						}
					}
					catch( e )
					{
					}
				} );
			};
			
			var updateAlertMsg = function( ) {
				Ext.net.DirectMethods.UpdateAlertMsg( {
					method : 'GET',
					success: function( result ) {
						if( result.Success && result.Result.Msg ) {
							Ext.net.Notification.show( {
								iconCls		: 'icon-information',
								showFx		: {
									args	: [ 
										'C3DAF9', 
										1,
										{
											duration : 2.0
										}
									],
									fxName : 'frame'
								},
								alignToCfg	: {
									offset  : [ 10, -10 ],
									position: 'bl-bl'
								},
								autoHide	: false,
								bodyStyle	: 'padding:5px',
								shadow		: false,
								height		: 150,
								width		: 400,
								html		: result.Result.Msg,
								title		: msgAlertInfo
							} );
						}
					}
				} );
			};
			
			var tabPanelExInfoTabChange = function( tabPanel, tab ) {
				checkReloadExInfo( tab );
			};
			
			var checkReloadExInfo = function( tab ) {
				if( !selGameGroup )
					return;
				
				if( tab.ggId == undefined || tab.ggId != selGameGroup.data.Id ) {
					tab.reload( );
					tab.ggId = selGameGroup.data.Id;
				}
			};
			
			var isAutoRefreshOn = function( ) {
				return #{CheckAutoRefresh}.checked;
			};
			
			var renderSvrType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 1:
						return String.format( markerTemplate,'flag' );
					default:
						return String.format( markerTemplate,'&nbsp;&nbsp;&nbsp;' );
				}
			};
			
			var renderSvrWarOn = function ( value, metadata, record, rowIndex, colIndex, store ) {
				var type = record.data.SvrType;
				
				if( type == 0 ) {
					switch( value ) {
						case 0:
							return String.format( "[{0}]", msgWarSvrOff ) + record.data.SvrCfgWarSvr;
						case 1:
							return String.format( "[{0}]", msgWarSvrOn )	+ record.data.SvrCfgWarSvr;
					}
				} else {
					return msgNotAvailable;
				}
			};
			
			var refreshLodingSelectChange = function() {
				#{PagingGameGroup}.pageSize = parseInt( this.getValue( ) );
				var paramStart = 0;
				var paramLimit = #{PagingGameGroup}.pageSize;
				#{StoreGameGroup}.load( { params: { start: paramStart, limit: paramLimit } } );
			}
			
			var adjustTipPos = function( ) {
				var tip = #{ToolTipGameGroup};
				var height = tip.body.dom.childNodes[0].clientHeight;
				var posX = tip.targetXY[0];
				var posY = tip.targetXY[1];
				
				if( posX + tip.maxWidth > document.body.clientWidth && posX > tip.maxWidth ) {
					posX = posX - tip.maxWidth;
					tip.setPosition( posX, posY );
				}
				if( posY + height > document.body.clientHeight && posY > height ) {
					posY = posY - height;
					tip.setPosition( posX,posY );
				}
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreRegion" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="RegionRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelRegion}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getRegionQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="PlatformId" Mapping="PlatformId" Type="Int" />
					<ext:RecordField Name="PlayerCount" Mapping="PlayerCount" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StorePlatform" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="PlatformRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="ShortName" Mapping="ShortName" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreGameGroup" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="GameGroupRefresh" GroupField="RegionId" WarningOnDirty="false">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelGameGroup}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getGameGroupQueryParams" />
			<Load Fn="lazyRenderProgress" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="Mark" Mapping="Mark" Type="Int" />
					<ext:RecordField Name="RegionId" Mapping="RegionId" Type="Int" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="Region" Mapping="Region" Type="String" />
					<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
					<ext:RecordField Name="NetErrStatus" Mapping="NetErrStatus" Type="Int" />
					<ext:RecordField Name="GameStatus" Mapping="GameStatus" Type="Int" />
					<ext:RecordField Name="PaymentStatus" Mapping="PaymentStatus" Type="Int" />
					<ext:RecordField Name="DBStatus" Mapping="DBStatus" Type="Int" />
					<ext:RecordField Name="MachineInfo" Mapping="MachineInfo" Type="String" />
					<ext:RecordField Name="CabinetId" Mapping="CabinetId" Type="Int" />
					<ext:RecordField Name="MachineId" Mapping="MachineId" Type="Int" />
					<ext:RecordField Name="ProcId" Mapping="ProcId" Type="Int" />
					<ext:RecordField Name="PlayerCount" Mapping="PlayerCount" Type="Int" />
					<ext:RecordField Name="QueueCount" Mapping="QueueCount" Type="Int" />
					<ext:RecordField Name="Task" Mapping="Task" Type="String" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="String" />
					<ext:RecordField Name="Version" Mapping="Version" Type="String" />
					<ext:RecordField Name="Flag" Mapping="Flag" Type="Int" />
					<ext:RecordField Name="Index" Mapping="Index" Type="Int" />
					<ext:RecordField Name="OpenDate" Mapping="OpenDate" Type="String" />
					<ext:RecordField Name="DisplayFlag" Mapping="DisplayFlag" Type="Int" />
					<ext:RecordField Name="WarStatus" Mapping="WarStatus" Type="Int" />
					<ext:RecordField Name="SvrType" Mapping="SvrType" Type="Int" />
					<ext:RecordField Name="WarServer" Mapping="WarServer" Type="Int" />
					<ext:RecordField Name="SvrCfgWarSvr" Mapping="SvrCfgWarSvr" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Store ID="StoreGameGroupState" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="GameGroupStateRefresh">
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getGameGroupQueryParams" />
			<Load Fn="gameGroupStateLoad" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Mark" Mapping="Mark" Type="Int" />
					<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
					<ext:RecordField Name="NetErrStatus" Mapping="NetErrStatus" Type="Int" />
					<ext:RecordField Name="GameStatus" Mapping="GameStatus" Type="Int" />
					<ext:RecordField Name="PaymentStatus" Mapping="PaymentStatus" Type="Int" />
					<ext:RecordField Name="DBStatus" Mapping="DBStatus" Type="Int" />
					<ext:RecordField Name="PlayerCount" Mapping="PlayerCount" Type="Int" />
					<ext:RecordField Name="QueueCount" Mapping="QueueCount" Type="Int" />
					<ext:RecordField Name="Task" Mapping="Task" Type="String" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="String" />
					<ext:RecordField Name="Version" Mapping="Version" Type="String" />
					<ext:RecordField Name="ProcId" Mapping="ProcId" Type="Int" />
					<ext:RecordField Name="OpenDate" Mapping="OpenDate" Type="String" />
					<ext:RecordField Name="WarStatus" Mapping="WarStatus" Type="Int" />
					<ext:RecordField Name="SvrType" Mapping="SvrType" Type="Int" />
					<ext:RecordField Name="WarServer" Mapping="WarServer" Type="Int" />
					<ext:RecordField Name="SvrCfgWarSvr" Mapping="SvrCfgWarSvr" Type="String" /> 
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreCabinet" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="CabinetRefresh" >
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{FormPanelGameGroup}.body" />
		</DirectEventConfig>
		<Listeners>
			<Load Fn="storeCabinetLoad" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Store ID="StoreMachine" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="MachineRefresh">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{FormPanelGameGroup}.body" />
		</DirectEventConfig>
		<Listeners>
			<Load Fn="storeMachineLoad" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="IpAddress" Mapping="IpAddress" Type="String" />
					<ext:RecordField Name="GroupId" Mapping="GroupId" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Store ID="StoreQueryGameProc" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="QueryGameProcRefresh">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{FormPanelGameGroup}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getGameProcQueryParams" />
			<Load Fn="storeQueryGameProcLoad" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="GameAppPath" Mapping="GameAppPath" Type="String" />
					<ext:RecordField Name="MachineId" Mapping="MachineId" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Hidden ID="HiddenRegionIndex" runat="Server"></ext:Hidden>
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelGameGroup" runat="Server" Border="false" StoreID="StoreGameGroup" AutoExpandColumn="Name" > <%--ColumnLines="true"--%>
						<View>
							<ext:GroupingView ID="GroupingView1" runat="server" MarkDirty="false" ShowGroupName="false" EnableNoGroups="true" HideGroupedColumn="true" >
							</ext:GroupingView>
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnAddGameGroup" runat="server" Text="<%$ Resources:StringDef, AddGameGroup %>" Icon="Add">
										<Listeners>
											<Click Fn="addGameGroup" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelGameGroup" runat="server" Text="<%$ Resources:StringDef, DelGameGroup %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteGameGroup" />
										</Listeners>
									</ext:Button>
									<%--<ext:Button ID="BtnModifyGameGroup" runat="server" Text="<%$ Resources:StringDef, ModifyGameGroup %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyGameGroup" />
										</Listeners>
									</ext:Button>--%>
									<%--<ext:ToolbarSeparator />
									<ext:Button ID="BtnStartGame" runat="server" Text="<%$ Resources:StringDef, StartGame %>" Icon="PlayGreen" Disabled="true">
										<Listeners>
											<Click Fn="btnStartGameClick" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnStopGame" runat="server" Text="<%$ Resources:StringDef, StopGame %>" Icon="StopBlue" Disabled="true">
										<Listeners>
											<Click Fn="btnStopGameClick" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnUpdateGame" runat="server" Text="<%$ Resources:StringDef, UpdateGame %>" Icon="Build" Disabled="true">
										<Listeners>
											<Click Fn="btnUpdateGameClick" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnUploadFile" runat="server" Text="<%$ Resources:StringDef, SvrPakUpload %>" Icon="FolderGo" Disabled="true">
										<Listeners>
											<Click Fn="btnUploadFileClick" />
										</Listeners>
									</ext:Button>--%>
									<ext:ToolbarSeparator ID="ToolbarSepGameGroup" runat="Server" />
									<ext:Button ID="BtnRegionMgr" runat="server" Text="<%$ Resources:StringDef, SvrRegionManage %>" Icon="DriveNetwork">
										<Listeners>
											<Click Fn="showRegionWindow" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator ID="ToolbarSepRegion" runat="Server" />
									<ext:Button ID="BtnBatchOp" runat="server" Icon="ApplicationOsxGo" Text="<%$ Resources:StringDef, BatchOperation %>">
										<Listeners>
											<Click Fn="showBatchWindow" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator />
									<ext:Button ID="BtnCreateSvrList" runat="server" Text="<%$ Resources:StringDef, CreateSvrList %>" Icon="ShapeFlipVertical">
										<Listeners>
											<Click Fn="createSvrList" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarFill />
									<ext:TextField ID="TextFieldQueryKeyword" runat="Server" Width="100" EmptyText="<%$ Resources:StringDef, Keyword %>" >
										<Listeners>
											<SpecialKey Fn="textFieldKeywordsSpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:ToolbarSpacer />
									<ext:Button ID="TbarButtonRefresh" runat="server" Text="<%$ Resources:StringDef, Query %>" Icon="Magnifier" >
										<Listeners>
											<Click Handler="queryGameGroup( true );" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<%--<ext:RowNumbererColumn DataIndex="Mark">
									<Renderer Fn="renderMarker" />
								</ext:RowNumbererColumn>--%>
								<ext:RowNumbererColumn DataIndex="SvrType">
									<Renderer Fn="renderSvrType"/>
								</ext:RowNumbererColumn>
								<ext:Column Header="" DataIndex="RegionId" >
									<%--<Renderer Fn="renderRegionId" />--%>
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="50" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SerNum %>" DataIndex="Index" Width="35" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SvrName %>" DataIndex="Name" Width="200" Sortable="false">
									<Renderer Fn="renderGameGroupName" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="DisplayFlag" Align="Center" Width="50"  Sortable="false" >
									<Renderer Fn="renderDisplayFlag" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Detector %>" DataIndex="NetStatus" Width="55" Align="Center" Sortable="false" >
									<Renderer Fn="renderGameGroupNetStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Game %>" DataIndex="GameStatus" Width="55" ColumnID="GameStatus" Align="Center" Sortable="false">
									<Renderer Fn="renderGameGroupGameStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Payment %>" DataIndex="PaymentStatus" Width="55" Align="Center" Sortable="false">
									<Renderer Fn="renderGameGroupPaymentStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Database %>" DataIndex="DBStatus" Width="55" Align="Center" Sortable="false">
									<Renderer Fn="renderGameGroupDBStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Net %>" DataIndex="NetErrStatus" Width="55" Align="Center" Sortable="false">
									<Renderer Fn="renderGameGroupNetErrStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, War %>" DataIndex="WarStatus" Width="55" Align="Center" Sortable="false">
									<Renderer Fn="renderGameGroupWarStatus" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, WarServer %>" DataIndex="WarServer" Width="100" Align="Center" Sortable="false" >
									<Renderer Fn="renderSvrWarOn" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SvrCfgWarSvr %>" DataIndex="SvrCfgWarSvr" Width="10" Align="Center" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PlayerCount %>" DataIndex="PlayerCount" Width="70" Align="Center" Sortable="false" >
									<Renderer Fn="renderGameGroupPlayerCount" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Version %>" DataIndex="Version" Width="90" Align="Center" Sortable="false">
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, QueueCount %>" DataIndex="Queue" Width="30" Align="Center">
									<Renderer Fn="renderGameGroupPlayerCount" />
								</ext:Column>--%>
								<ext:Column Header="<%$ Resources:StringDef, OpenDate %>" DataIndex="OpenDate" Width="70" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Machine %>" DataIndex="MachineInfo" Width="150" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CurrentTask %>" DataIndex="Task" Width="150" Sortable="false">
									<Renderer Fn="renderGameGroupTask" />
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" >
								</ext:Column>--%>
								<ext:CommandColumn Width="240">
									<%--<GroupCommands>
										<ext:CommandFill />
										<ext:GridCommand Icon="ShapeSquareSelect" CommandName="SelectGroup" Text="<%$ Resources:StringDef, SelectAll %>">
										</ext:GridCommand>
										<ext:GridCommand Icon="ShapeSquare" CommandName="UnselectGroup" Text="<%$ Resources:StringDef, UnselectAll %>">
										</ext:GridCommand>
									</GroupCommands>--%>
									<Commands>
										<ext:GridCommand CommandName="StartGame" Icon="PlayGreen" >
											<ToolTip Text="<%$ Resources:StringDef, StartGame %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="StopGame" Icon="StopBlue" >
											<ToolTip Text="<%$ Resources:StringDef, StopGame %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="UpdateGame" Icon="Build">
											<ToolTip Text="<%$ Resources:StringDef, UpdateGame %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="SvrPakUpload" Icon="FolderGo" >
											<ToolTip Text="<%$ Resources:StringDef, Upload %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="Modify" Icon="NoteEdit" >
											<ToolTip Text="<%$ Resources:StringDef, Modify %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="Config" Icon="Cog" >
											<ToolTip Text="<%$ Resources:StringDef, Config %>" />
										</ext:GridCommand>
										<ext:CommandSeparator />
										<ext:GridCommand CommandName="EventHis" Icon="CarStart" >
											<ToolTip Text="<%$ Resources:StringDef, Info %>" />
										</ext:GridCommand>
									</Commands>
									<PrepareToolbar Fn="prepareGameGroupToolbar" />
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingGameGroup" runat="server" PageSize="20" StoreID="StoreGameGroup">
								<Items>
									<ext:ToolbarSeparator />
									<ext:Label runat="server" Text="<%$ Resources:StringDef, PageSize %>" />
									<ext:ToolbarSpacer runat="server" Width="5" />
									<ext:ComboBox runat="server" Width="50" Editable="false">
										<Items>
											<ext:ListItem Text="20" />
											<ext:ListItem Text="50" />
											<ext:ListItem Text="100" />
											<ext:ListItem Text="<%$ Resources:StringDef, All %>" Value="99999"/>
										</Items>
										<SelectedItem Value="20"/>
										<Listeners>
											<Select Fn="refreshLodingSelectChange"/>
										</Listeners>
									</ext:ComboBox>
									<ext:ToolbarSeparator />
									<ext:Checkbox runat="Server" ID="CheckAutoRefresh" BoxLabel="<%$ Resources:StringDef, AutoRefresh %>" Checked="true" />
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<%--<ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" >
								<Listeners>
									<SelectionChange Fn="gridGameGroupSelectionChange" />
								</Listeners>
							</ext:CheckboxSelectionModel>--%>
							<ext:RowSelectionModel runat="Server">
								<Listeners>
									<SelectionChange Fn="gridGameGroupSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<GroupCommand Fn="gridGroupCommand" />
							<Command Fn="gridOnCommand" />
							<RowDblClick Fn="gridDblClick" />
							<%--<CellClick Fn="gridCellClick" />--%>
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowGameGroup" runat="server" Resizable="false" Width="700"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelGameGroup" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldGameGroupId" runat="server" Width="520" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true" >
					</ext:TextField>
					<ext:TextField ID="TextFieldGameGroupName" runat="server" Width="520" FieldLabel="<%$ Resources:StringDef, SvrName %>">
					</ext:TextField>
					<ext:SpinnerField ID="TextFieldGameGroupIndex" runat="server" Width="520" FieldLabel="<%$ Resources:StringDef, SerNum %>" Note="<%$ Resources:StringDef, MsgSvrNumNote %>">
					</ext:SpinnerField>
					<%--<ext:TextField ID="TextFieldGameGroupIpAddress" runat="server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, IpAddress %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldGameGroupMacAddress" runat="server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, MacAddress %>">
					</ext:TextField>
					<ext:ComboBox ID="ComboBoxGameGroupOSType" runat="server" AnchorHorizontal="95%" FieldLabel="<%$ Resources:StringDef, OSType %>" SelectedIndex="0">
						<Items>
							<ext:ListItem Text="<%$ Resources:StringDef, OSTypeWindows %>" Value="0" />
							<ext:ListItem Text="<%$ Resources:StringDef, OSTypeLinux %>" Value="1" />
						</Items>
					</ext:ComboBox>--%>
					<ext:TextField ID="TextFieldGameGroupComment" runat="server" Width="520" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
					<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, Flag %>" Width="520" >
						<Items>
							<ext:Checkbox runat="Server" ID="CheckFlagRecommend" BoxLabel="<%$ Resources:StringDef, SvrFlagRecommend %>">
							</ext:Checkbox>
							<ext:Checkbox runat="Server" ID="CheckFlagNew" BoxLabel="<%$ Resources:StringDef, SvrFlagNew %>" Checked="true">
							</ext:Checkbox>
						</Items>
					</ext:CompositeField>
					<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, Type %>" Width="520" >
						<Items>
							<ext:Checkbox runat="Server" ID="CheckDisFlagFull" BoxLabel="<%$ Resources:StringDef, SvrDisplayFlagFull %>">
							</ext:Checkbox>
							<ext:Checkbox runat="Server" ID="CheckDisFlagWeb" BoxLabel="<%$ Resources:StringDef, SvrDisplayFlagWeb %>" Checked="true">
							</ext:Checkbox>
						</Items>
					</ext:CompositeField>
					<ext:MultiCombo ID="MultiSelectRegion" StoreID="StoreRegion" FieldLabel="<%$ Resources:StringDef, BelongedRegion %>"
						runat="server" Width="520" ValueField="Id" DisplayField="Name" Mode="Local" >
					</ext:MultiCombo>
					<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, GameProcess %>" Width="520" >
						<Items>
							<ext:ComboBox ID="ComboAddProcCabinetId" StoreID="StoreCabinet"
								runat="server" ValueField="Id" DisplayField="Name" ForceSelection="true" Mode="Local" Width="120">
								<Listeners>
									<Select Fn="comboAddProcCabinetSelect" />
								</Listeners>
							</ext:ComboBox>
							<ext:ComboBox ID="ComboAddProcMachineId" StoreID="StoreMachine" runat="server" ValueField="Id"
								DisplayField="IpAddress" ForceSelection="true" Mode="Local" Width="180">
								<Listeners>
									<Select Fn="comboAddProcMachineSelect" />
								</Listeners>
							</ext:ComboBox>
							<ext:ComboBox ID="ComboAddProcId" StoreID="StoreQueryGameProc" runat="server" ValueField="Id"
								DisplayField="GameAppPath" ForceSelection="true" Mode="Local" Width="210">
							</ext:ComboBox>
						</Items>
					</ext:CompositeField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonGameGroupOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setGameGroup" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button3" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowGameGroup}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowRegion" runat="server" Resizable="false" Width="400"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelRegion" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldRegionId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldRegionName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldRegionComment" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
					<ext:ComboBox ID="ComboBoxPlatform" runat="server" StoreID="StorePlatform" AnchorHorizontal="90%" Editable="false" FieldLabel="<%$ Resources:StringDef, OperationPlatform %>"
						ValueField="Id" DisplayField="Name" ForceSelection="true" Mode="Local" >
					</ext:ComboBox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonRegionOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setRegion" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button2" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowRegion}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowRegionMgr" runat="Server" Title="<%$ Resources:StringDef, SvrRegionManage %>" Width="900" Height="450" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelRegion" runat="Server" Border="false" StoreID="StoreRegion" AutoExpandColumn="Comment">
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="BtnAddRegion" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addRegion" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelRegion" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteRegion" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyRegion" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyRegion" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="50">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, OperationPlatform %>" DataIndex="PlatformId" >
									<Renderer Fn="renderPlatformId" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" >
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingRegion" runat="server" PageSize="20" StoreID="StoreRegion" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridGroupSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridGroupRowDBClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
	
	<ext:Window ID="WindowFileMan" runat="Server" Width="900" Height="450" CloseAction="Hide"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, SvrPakUpload %>">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Container ID="Container1" runat="server" Height="250">
						<Content>
							<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false" >
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
			<ext:Button runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowFileMan}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowProcScript" runat="server" Resizable="true" Width="1080" Height="600" Padding="0" Title="<%$ Resources:StringDef, ProcInfo %>" CloseAction="Hide"
		Collapsible="false" Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<%--
	<ext:Window ID="WindowMachineDetail" runat="server" Resizable="true" Maximizable="true"
		Width="880" Height="740" Padding="0" Collapsible="false"
		Hidden="true" AutoDestroy="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" DiscardUrl="true" >
		</AutoLoad>
	</ext:Window>
	--%>
	
	<ext:Window ID="WindowSvrCfg" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, Config %>"
		Width="620" Height="600" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowBatchOp" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, BatchOperation %>"
		Width="1200" Height="600" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowInfo" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, Info %>"
		Border="false" Width="1250" Height="700" Collapsible="false" Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:TabPanel runat="Server" ID="TabPanelExInfo" AutoTabs="false">
						<Items>
							<ext:Panel ID="PanelEventLog" runat="Server" Title="<%$ Resources:StringDef, Event %>">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="eventlog.aspx" NoCache="true" DiscardUrl="true" >
									<Params>
										<ext:Parameter Name="ggId" Value="0" ></ext:Parameter>
									</Params>
								</AutoLoad>
							</ext:Panel>
							<ext:Panel ID="PanelSnap" runat="Server" Title="<%$ Resources:StringDef, Snapshot %>">
								<AutoLoad ReloadOnEvent="true" Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="snap.aspx" NoCache="true" DiscardUrl="true" >
									<Params>
										<ext:Parameter Name="ggId" Value="0" ></ext:Parameter>
									</Params>
								</AutoLoad>
							</ext:Panel>
							<ext:Panel ID="PanelDBInfo" runat="Server" Title="<%$ Resources:StringDef, Database %>">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="dbinfo.aspx" NoCache="true" DiscardUrl="true" >
									<Params>
										<ext:Parameter Name="ggId" Value="0" ></ext:Parameter>
									</Params>
								</AutoLoad>
							</ext:Panel>
							<ext:Panel ID="PanelEffInfo" runat="Server" Title="<%$ Resources:StringDef, EffStatInfo %>">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="effstat.aspx" NoCache="true" DiscardUrl="true" >
									<Params>
										<ext:Parameter Name="ggId" Value="0" ></ext:Parameter>
									</Params>
								</AutoLoad>
							</ext:Panel>
							<ext:Panel ID="PanelSysLogInfo" runat="Server" Title="<%$ Resources:StringDef, SystemLogInfo %>">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="systemlog.aspx" NoCache="true" DiscardUrl="true">
									<Params>
										<ext:Parameter Name="ggId" Value="0" ></ext:Parameter>
									</Params>
								</AutoLoad>
							</ext:Panel>
						</Items>
						<Listeners>
							<TabChange Fn="tabPanelExInfoTabChange" />
						</Listeners>
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTipGameGroup" runat="server" Target="#{GridPanelGameGroup}.getView( ).mainBody" TrackMouse="true" AutoHide="false" AutoHeight="false" Delegate=".x-grid3-cell" Width="300" ShowDelay="500" >
		<CustomConfig>
			<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
		</CustomConfig>
		<Listeners>
			<Show Fn="showGameGroupTip" />
		</Listeners>
	</ext:ToolTip>
	
	<sat:Tip runat="Server" />
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

