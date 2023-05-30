<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_machinemgr, App_Web_machinemgr.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgAddCabinet				= '<%= Resources.StringDef.AddCabinet %>';
		var msgDelCabinetPrompt			= '<%= Resources.StringDef.MsgDelCabinetPrompt %>';
		var msgModifyCabinet			= '<%= Resources.StringDef.ModifyCabinet %>';
		var msgAddMachine				= '<%= Resources.StringDef.AddMachine %>';
		var msgDelMachinePrompt			= '<%= Resources.StringDef.MsgDelMachinePrompt %>';
		var msgModifyMachine			= '<%= Resources.StringDef.ModifyMachine %>';
		var msgCannotBeNullFormat		= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgName						= '<%= Resources.StringDef.Name %>';
		var msgIpAddress				= '<%= Resources.StringDef.IpAddress %>';
		var msgInvalidIPAddress			= '<%= Resources.StringDef.InvalidIPAddress %>';
		var msgInvalidPort				= '<%= Resources.StringDef.InvalidPort %>';

		var msgAddGameProc				= '<%= Resources.StringDef.AddGameProc %>';
		var msgModifyGameProc			= '<%= Resources.StringDef.ModifyGameProc %>';
		var msgDeleteGameProcPrompt		= '<%= Resources.StringDef.DeleteGameProcPrompt %>';
		
		var msgOSTypeLinux				= '<%= Resources.StringDef.OSTypeLinux %>';
		var msgOSTypeWindows			= '<%= Resources.StringDef.OSTypeWindows %>';

		var msgNSDisconnect				= '<%= Resources.StringDef.NSDisconnect %>';
		var msgNSUnknown				= '<%= Resources.StringDef.NSUnknown %>';
		var msgNSConnect				= '<%= Resources.StringDef.NSConnect %>';

		var msgProcessConfig			= '<%= Resources.StringDef.ProcessConfig %>';
		var msgFileList					= '<%= Resources.StringDef.FileList %>';
		var msgShellCommand				= '<%= Resources.StringDef.ShellCommand %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var groupOp				= 0;				//操作：0表示新加，1表示修改。
			var machineOp			= 0;
			var gameProcOp			= 0;
			var tipType				= 1;
			var currMachineId;
			var selMachine;
			var hasMgrPri			= false;
			var updateModIndex		= 0;				//分组更新Mod编号(分为3次更新 每次取一个3个余数)

//------------------------------- render func -----------------------------------------------------

			var renderOSType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value )
				{
					case 0:
						return msgOSTypeWindows;
					case 1:
						return msgOSTypeLinux;
				}
			};
			
			var renderCabinetId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var index = #{StoreCabinet}.find( 'Id', value );
				if( index != -1 ) {
					var record = #{StoreCabinet}.getAt( index );
					return record.get( 'Name' );
				} else {
					return '';
				}
			};
			
			var renderMachineId = function( value, metadata, record, rowIndex, colIndex, store ) {
				var index = #{StoreMachine}.find( 'Id', value );
				if( index != -1 ) {
					var record = #{StoreMachine}.getAt( index );
					return record.get( 'Name' );
				} else {
					return '';
				}
			};
			
			var renderMachineConState = function( value, metadata, record, rowIndex, colIndex, store ) {
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
			
			var renderCpuLoad = function( value, metadata, record, rowIndex, colIndex, store ) {
				var avg = record.get( 'CpuLoadAvg' );
				var max = record.get( 'CpuLoadMax' );
				
				if( max > 80 ) {
					metadata.css = 'loadhigh';
				} else if( max > 40 ) {
					metadata.css = 'loadmid';
				} else if( max >= 0 ) {
					metadata.css = 'loadlow';
				} else {
					metadata.css = 'loadna';
				}
				
				if( avg == -1 )
					return msgNotAvailable;
				else
					return String.format( "Avg:{0}% Max:{1}%", avg, max );
			};
			
			var renderNetworkLoad = function( value, metadata, record, rowIndex, colIndex, store ) {
				var rx = record.get( 'NetworkLoadRX' );
				var tx = record.get( 'NetworkLoadTX' );
				
				var max = rx > tx ? rx : tx;
				
				if( max > 1024 * 500 ) {
					metadata.css = 'loadmid';
				} else if( max >= 0 ) {
					metadata.css = 'loadlow';
				} else {
					metadata.css = 'loadna';
				}
				
				if( rx == -1 )
					return msgNotAvailable;
				else
					return String.format( "RX:{0} TX:{1}", getSizeText( rx ), getSizeText( tx ) );
			};
			
			var renderMachineTask = function( value, metadata, record, rowIndex, colIndex, store ) {
				var machineId	= record.get( 'Id' );
				var progressId	= 'rowProgress' + machineId;
				var renderHtml	= "<span id='" + progressId + "' style='float:left;'></span>";
			
				renderHtml += "&nbsp;"
				renderHtml += "<span style='line-height:18px;'>" + record.get( 'TransSpeed' ) + "</span>";
				
				return renderHtml;
			};
			
			var lazyRenderProgress = function( store, records, options ) {
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					var filePercent	= records[nLoopCount].data.FilePercent;
					if( filePercent >= 0 ) {
						var machineId	= records[nLoopCount].get( 'Id' );
						var progressId	= 'rowProgress' + machineId;
						var proBarId	= 'proBar' + machineId;
						
						createProgressBar( proBarId, progressId, filePercent );
					}
				}
			};
			
			var prepareMachineToolbar = function( grid, toolbar, rowIndex, record ) {
				var btnDetail	= toolbar.items.get( 0 );
				var btnProcCfg	= toolbar.items.get( 1 );
				var btnFileList	= toolbar.items.get( 2 );

				//btnDetail.setDisabled( record.data.NetStatus != 1 );
				btnFileList.setDisabled( record.data.NetStatus != 1 );
				
				if( !hasMgrPri ) {
					btnProcCfg.setVisible( false );
				}
			};

//------------------------------------- query -------------------------------------------------
			
			var getMachineQueryParams = function( store, options ) {
				var keyword = #{TextFieldQueryKeyword}.getValue( );
				
				options.params.keyword = keyword;
			};

			var getGameProcQueryParams = function( store, options ) {
				if( selMachine ) {
					options.params.MachineId = selMachine.data.Id;
				}
			};

			var getCabinetQueryParams = function( store, options ) {

			};
			
			var queryCabinet = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingCabinet}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreCabinet}.lastOptions ) {
					paramStart = #{StoreCabinet}.lastOptions.params.start;
				}
				#{StoreCabinet}.load( {
					params: { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
//------------------------------------ cabinet -----------------------------------------------
			
			var addCabinet = function( ) {
				#{TextFieldCabinetId}.setVisible( false );
			
				#{FormPanelCabinet}.reset( );
				#{ButtonCabinetOp}.setText( msgOK );
				#{WindowCabinet}.setTitle( msgAddCabinet );
				#{WindowCabinet}.show( );
				
				groupOp = 0;
			};

			var deleteCabinet = function( ) {
				var grid = #{GridPanelCabinet};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelCabinetPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteCabinet( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryCabinet( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyCabinet = function( ) {
				#{TextFieldCabinetId}.setVisible( true );
			
				var record = #{GridPanelCabinet}.getSelectionModel( ).getSelected( );
				showGroupDetail( record );				
				
				groupOp = 1;
			};
			
			var showGroupDetail = function( record ) {
				#{TextFieldCabinetId}.setValue( record.data.Id );
				#{TextFieldCabinetName}.setValue( record.data.Name );
				#{TextFieldCabinetComment}.setValue( record.data.Comment );

				#{ButtonCabinetOp}.setText( msgSave );
				
				#{WindowCabinet}.setTitle( msgModifyCabinet );
				#{WindowCabinet}.show( );
			};
			
			var setCabinet = function( ) {
				var groupName = #{TextFieldCabinetName}.getValue( );
				if( groupName.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				Ext.net.DirectMethods.SetCabinet( groupOp, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowCabinet}.hide( );
							queryCabinet( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryCabinet( );
						}
					}
				});
			};

			var showCabinetWindow = function( ) {
				#{WindowCabinetMgr}.show( );
			};
			
//------------------------------------ machine ----------------------------------------------
			
			var queryMachine = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingMachine}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreMachine}.lastOptions ) {
					paramStart = #{StoreMachine}.lastOptions.params.start;
				}
				#{StoreMachine}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var addMachine = function( ) {
				#{TextFieldMachineId}.setVisible( false );
			
				#{FormPanelMachine}.reset( );
				#{ButtonMachineOp}.setText( msgOK );
				#{WindowMachine}.setTitle( msgAddMachine );
				#{WindowMachine}.show( );
				
				machineOp = 0;
			};

			var deleteMachine = function( ) {
				var grid = #{GridPanelMachine};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelMachinePrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteMachine( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ) {
									queryMachine( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyMachine = function( ) {
				#{TextFieldMachineId}.setVisible( true );
			
				var record = #{GridPanelMachine}.getSelectionModel( ).getSelected( );
				showMachineDetail( record );				
				
				machineOp = 1;
			};
			
			var showMachineDetail = function( record ) {
				#{TextFieldMachineId}.setValue( record.data.Id );
				#{TextFieldMachineName}.setValue( record.data.Name );
				#{TextFieldMachineIpAddress}.setValue( record.data.IpAddress );
				#{TextFieldMachineIpAddressInner}.setValue( record.data.IpAddressInner );
				#{TextFieldMachineMacAddress}.setValue( record.data.MacAddress );
				#{TextFieldMachineComment}.setValue( record.data.Comment );
				#{ComboBoxMachineOSType}.setValue( record.data.OSType );
				#{ComboBoxMachineType}.setValue( record.data.Type );
				#{ComboBoxMachine}.setValue( record.data.GroupId );
				#{TextFieldMachineMasterIp}.setValue( record.data.MasterIpAddress );
				#{TextFieldMachineMasterPort}.setValue( record.data.MasterPort );
				
				#{ButtonMachineOp}.setText( msgSave );
				
				#{WindowMachine}.setTitle( msgModifyMachine );
				#{WindowMachine}.show( );
			};
			
			var setMachine = function( ) {
//				var machineName = #{TextFieldMachineName}.getValue( );
//				if( machineName.length == 0 ) {
//					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
//					return;
//				}

				var machineIp = #{TextFieldMachineIpAddress}.getValue( );
				if( machineIp.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgIpAddress ) );
					return;
				}
				
				Ext.net.DirectMethods.SetMachine( machineOp, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowMachine}.hide( );
							queryMachine( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryMachine( );
						}
					}
				});
			};

//---------------------------------- game proc --------------------------------------------
			
			var queryGameProc = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingGameProc}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreGameProc}.lastOptions ) {
					paramStart = #{StoreGameProc}.lastOptions.params.start;
				}
				#{StoreGameProc}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var addGameProc = function( ) {
				#{TextFieldGameProcId}.setVisible( false );
			
				#{FormPanelGameProc}.reset( );
				#{ButtonGameProcOp}.setText( msgOK );
				#{WindowGameProc}.setTitle( msgAddGameProc );
				#{WindowGameProc}.show( );
				
				gameProcOp = 0;
			};

			var deleteGameProc = function( ) {
				var grid = #{GridPanelGameProc};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDeleteGameProcPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteGameProc( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ) {
									queryGameProc( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyGameProc = function( ) {
				#{TextFieldGameProcId}.setVisible( true );
			
				var record = #{GridPanelGameProc}.getSelectionModel( ).getSelected( );
				showGameProcDetail( record );
				
				gameProcOp = 1;
			};
			
			var configGameProc = function( procId ) {
				var win = #{WindowSvrCfg};
				win.load( {
					url: 'svrcfg.aspx',
					params: { procId: procId },
					discardUrl: false,
					nocache: true,
					timeout: 30
				} );
			
				#{WindowSvrCfg}.show( );
			};
			
			var setGameProc = function( ) {
//				var procName = #{TextFieldGameProcName}.getValue( );
//				if( procName.length == 0 ) {
//					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
//					return;
//				}
				
				var machineId = selMachine.get( 'Id' );
				Ext.net.DirectMethods.SetGameProc( gameProcOp, machineId, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowGameProc}.hide( );
							queryGameProc( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryGameProc( );
						}
					}
				});
			};
			
			var showGameProcDetail = function( record ) {
				#{TextFieldGameProcId}.setValue( record.data.Id );
				#{TextFieldGameProcName}.setValue( record.data.Name );
				#{TextFieldGameProcComment}.setValue( record.data.Comment );
				#{TextFieldGameAppPath}.setValue( record.data.GameAppPath );
				#{ComboGameProcMachineId}.setValue( record.data.MachineId );

				#{ButtonGameProcOp}.setText( msgSave );
				
				#{WindowGameProc}.setTitle( msgModifyGameProc );
				#{WindowGameProc}.show( );
			};

			var showGameProcWindow = function( ) {
				if( selMachine ) {
					#{WindowGameProcMgr}.setTitle( String.format( '{0}[{1}] - ', selMachine.data.Name, selMachine.data.IpAddress ) + msgProcessConfig );
					
					#{WindowGameProcMgr}.show( );
					queryGameProc( true );	
				}
			};
			
			var showSvrFileWindow = function( ) {
				if( selMachine ) {
				
					var win = #{WindowSvrFile};
					
					win.setTitle( String.format( '[{0}] - ', selMachine.data.IpAddress ) + msgFileList );
					win.load( {
						url: 'svrfile.aspx',
						params: { mId: selMachine.data.Id },
						discardUrl: false,
						nocache: true,
						timeout: 30
					} );
				
					win.show( );
				}
			};
			
			var showConsoleWindow = function( ) {
				if( selMachine ) {
				
					var win = #{WindowConsole};
					
					win.setTitle( String.format( '[{0}] - ', selMachine.data.IpAddress ) + msgShellCommand );
					win.load( {
						url: 'console.aspx',
						params: { mId: selMachine.data.Id },
						discardUrl: false,
						nocache: true,
						timeout: 30
					} );
				
					win.show( );
				}
			};
			
//---------------------------------- events --------------------------------------------
			
			var gridGroupSelectionChange = function( el ) {
				#{BtnDelCabinet}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyCabinet}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridMachineSelectionChange = function( el ) {
				#{BtnDelMachine}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyMachine}.setDisabled( el.getCount( ) < 1 );
//				#{BtnCfgProc}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridGameProcSelectionChange = function( el ) {
				#{BtnDelGameProc}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyGameProc}.setDisabled( el.getCount( ) < 1 );
//				#{BtnSvrCfg}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridGroupRowDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showGroupDetail( record );
				
				groupOp = 1;
			};
			
			var gridGameProcRowDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showGameProcDetail( record );
				
				gameProcOp = 1;
			};
			
			var gameProcOnCommand = function( command, record, rowIndex, colIndex ) {
				switch( command ) {
					case "Config":
						{
							var procId = record.get( 'Id' );
							configGameProc( procId );
						}
						braek;
				}
			};
			
			var gridMachineRowDBClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var machineId	= record.data.Id;
				
				if( machineId == -1 )
					return;
					
				showMachineInfo( record );
			};
			
			var showMachineInfo = function( record ) {
				var url = 'machinedetail.aspx?mId=' + record.data.Id;
				window.open( url );
			};
			
			var gridMachineOnCommand = function( command, record, rowIndex, colIndex ) {
				selMachine = record;
			
				switch( command ) {
					case "View":
						{
							showMachineInfo( record );
							
//							var win = #{WindowMachineDetail};
//							win.setTitle( record.data.Name + ' - ' + record.data.IpAddress );
//							win.load( {
//								url: 'machinedetail.aspx',
//								params: { mId: record.data.Id },
//								discardUrl: false,
//								nocache: true,
//								timeout: 30
//							});
//							
//							#{WindowMachineDetail}.show( );
						}
						break;
					case "ProcessConfig":
						{
							showGameProcWindow( );
						}
						break;
					case "FileList":
						{
							showSvrFileWindow( );
						}
						break;
					case "ShellCommand":
						{
							showConsoleWindow( );
						}
						break;
				}
			};
			
			var machineStateLoad = function( store, records, options ) {
			};
			
			var textFieldKeywordsSpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					queryMachine( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
//-------------------------------- progress bar ------------------------------------------------------
			
			var getProgressBar = function( proBarId ) {
				return Ext.get( proBarId );
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
			
			var updateMachineState = function( ) {
				var paramStart = 0;
				var paramLimit = #{PagingMachine}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( #{StoreMachine}.lastOptions ) {
					paramStart = #{StoreMachine}.lastOptions.params.start;
				}
				
				++updateModIndex
				if( updateModIndex >= 3 )
					updateModIndex = 0;
				
				#{StoreMachineState}.load( {
					params: { start: paramStart, limit: paramLimit, ModIndex : updateModIndex },
					callback : function( records, options, success ) {
						if( success ) {
							for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
								var index = #{StoreMachine}.findExact( "Id", records[nLoopCount].data.Id );
								if( index != -1 ) {
									var srcRecord = #{StoreMachine}.getAt( index );
									
									srcRecord.set( 'NetStatus', records[nLoopCount].get( 'NetStatus' ) );
									srcRecord.set( 'Task', records[nLoopCount].get( 'Task' ) );
									srcRecord.set( 'FilePercent', records[nLoopCount].get( 'FilePercent' ) );
									srcRecord.set( 'TransSpeed', records[nLoopCount].get( 'TransSpeed' ) );
									srcRecord.set( 'CpuLoadAvg', records[nLoopCount].get( 'CpuLoadAvg' ) );
									srcRecord.set( 'CpuLoadMax', records[nLoopCount].get( 'CpuLoadMax' ) );
									srcRecord.set( 'NetworkLoadRX', records[nLoopCount].get( 'NetworkLoadRX' ) );
									srcRecord.set( 'NetworkLoadTX', records[nLoopCount].get( 'NetworkLoadTX' ) );
									
									/* Commit cause low efficiency */
									//srcRecord.commit( );
									
									var machineId	= records[nLoopCount].get( 'Id' );
									var progressId	= 'rowProgress' + machineId;
									var proBarId	= 'proBar' + machineId;
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
						}
					}
				} );
			};
			
//----------------------------------- tip -------------------------------------------------------

			var showMachineTip = function( ) {
				var rowIndex	= #{GridPanelMachine}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelMachine}.view.findCellIndex( this.triggerElement );
				var record = #{StoreMachine}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				
				switch( cellIndex )
				{
					case 2:
					case 3:
					case 5:
					case 6:
						tipType = 1;
						break;
					case 4:
						tipType = 2;
						break;
					default:
						{
							this.hide( );
							return;
						}
				}
				
				currMachineId = record.get( 'Id' );
			};
			
			var updateMachineTip = function( ) {
				var tip = #{ToolTipMachine};
				if( !tip.isVisible( ) ) {
					return;
				}
				
				Ext.net.DirectMethods.Tip.UpdateMachineTip( currMachineId, tipType, {
					method : 'GET',
					success: function( result ) {
						if( result.Success ) {
							tip.body.dom.innerHTML = result.Result;
						}
					}
				} );
			};
			
//---------------------------------- other ------------------------------------------------------

			var showDetectorConfiguration = function( ) {
				#{FormPanelDetectorConfiguration}.reset( );
				//#{BtnDetectorConfig}.setText( msgOK );
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
			
			var showBatchWindow = function( ) {
				#{WindowBatchOp}.show( );
			};
			
			var initData = function( ) {
				queryCabinet( true, function( ) {
					queryMachine( );
					updateMachineState( );
				} );
				
				setInterval( updateMachineState, 1500 );
				setInterval( updateMachineTip, 2000 );
			};
			
			var closeCfgWin = function( ) {
				#{WindowSvrCfg}.hide( );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreCabinet" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="CabinetRefresh" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelCabinet}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getCabinetQueryParams" />
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
	<ext:Store ID="StoreMachine" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="MachineRefresh" GroupField="GroupId" WarningOnDirty="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelMachine}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getMachineQueryParams" />
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
					<ext:RecordField Name="IpAddress" Mapping="IpAddress" Type="String" />
					<ext:RecordField Name="IpAddressInner" Mapping="IpAddressInner" Type="String" />
					<ext:RecordField Name="MacAddress" Mapping="MacAddress" Type="String" />
					<ext:RecordField Name="OSType" Mapping="OSType" Type="Int" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="GroupId" Mapping="GroupId" Type="Int" />
					<ext:RecordField Name="ProcCount" Mapping="ProcCount" Type="Int" />
					<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
					<ext:RecordField Name="Task" Mapping="Task" Type="String" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="String" />
					<ext:RecordField Name="CpuLoad" Mapping="CpuLoad" Type="String" />
					<ext:RecordField Name="NetworkLoad" Mapping="NetworkLoad" Type="String" />
					<ext:RecordField Name="CpuLoadAvg" Mapping="CpuLoadAvg" Type="Int" />
					<ext:RecordField Name="CpuLoadMax" Mapping="CpuLoadMax" Type="Int" />
					<ext:RecordField Name="NetworkLoadRX" Mapping="NetworkLoadRX" Type="Int" />
					<ext:RecordField Name="NetworkLoadTX" Mapping="NetworkLoadTX" Type="Int" />
					<ext:RecordField Name="MasterIpAddress" Mapping="MasterIpAddress" Type="String" />
					<ext:RecordField Name="MasterPort" Mapping="MasterPort" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreMachineState" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="MachineStateRefresh">
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getMachineQueryParams" />
			<Load Fn="machineStateLoad" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
					<ext:RecordField Name="Task" Mapping="Task" Type="String" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="String" />
					<ext:RecordField Name="CpuLoadAvg" Mapping="CpuLoadAvg" Type="Int" />
					<ext:RecordField Name="CpuLoadMax" Mapping="CpuLoadMax" Type="Int" />
					<ext:RecordField Name="NetworkLoadRX" Mapping="NetworkLoadRX" Type="Int" />
					<ext:RecordField Name="NetworkLoadTX" Mapping="NetworkLoadTX" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreGameProc" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="GameProcRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelGameProc}.body" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getGameProcQueryParams" />
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
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelMachine" runat="Server" Border="false" StoreID="StoreMachine" AutoExpandColumn="Task" >
						<View>
							<ext:GroupingView ID="GroupingView1" runat="server" MarkDirty="false" ShowGroupName="false"
								EnableNoGroups="true" HideGroupedColumn="true">
							</ext:GroupingView>
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnAddMachine" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addMachine" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelMachine" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteMachine" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyMachine" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyMachine" />
										</Listeners>
									</ext:Button>
									<%--<ext:Button ID="BtnCfgProc" runat="server" Disabled="true" Text="<%$ Resources:StringDef, ProcessInfo %>" Icon="Cog">
										<Listeners>
											<Click Fn="showGameProcWindow" />
										</Listeners>
									</ext:Button>--%>
									<ext:ToolbarSeparator ID="ToolbarSepMachine" runat="Server" />
									<ext:Button ID="BtnCabinetMgr" runat="server" Text="<%$ Resources:StringDef, CabinetManage %>" Icon="DriveNetwork">
										<Listeners>
											<Click Fn="showCabinetWindow" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator />
									<ext:Button ID="BtnBatchOp" runat="server" Icon="ApplicationOsxGo" Text="<%$ Resources:StringDef, BatchOperation %>">
										<Listeners>
											<Click Fn="showBatchWindow" />
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
											<Click Handler="queryMachine( true );" />
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
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="50" Hidden="true">
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" >
								</ext:Column>--%>
								<ext:Column Header="<%$ Resources:StringDef, IpAddress %>" DataIndex="IpAddress" Width="170">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" Width="120" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NetStatus %>" DataIndex="NetStatus" Width="80" Align="Center">
									<Renderer Fn="renderMachineConState" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CpuLoad %>" DataIndex="CpuLoad" Width="130" Align="Center">
									<Renderer Fn="renderCpuLoad" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NetworkLoad %>" DataIndex="NetworkLoad" Width="200" Align="Center">
									<Renderer Fn="renderNetworkLoad" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CurrentTask %>" DataIndex="Task" Width="200">
									<Renderer Fn="renderMachineTask" />
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, ProcessCount %>" DataIndex="ProcCount" Width="20">
								</ext:Column>--%>
								<%--<ext:Column Header="<%$ Resources:StringDef, MacAddress %>" DataIndex="MacAddress" Width="40">
								</ext:Column>--%>
								<%--<ext:Column Header="<%$ Resources:StringDef, OSType %>" DataIndex="OSType" Width="20">
									<Renderer Fn="renderOSType" />
								</ext:Column>--%>
								<ext:Column Header="<%$ Resources:StringDef, BelongedCabinet %>" DataIndex="GroupId" >
									<Renderer Fn="renderCabinetId" />
								</ext:Column>
								<ext:CommandColumn Width="310">
									<Commands>
										<ext:GridCommand CommandName="View" Text="<%$ Resources:StringDef, RealTimeInfo %>" Icon="ServerGo" />
										<ext:GridCommand CommandName="ProcessConfig" Text="<%$ Resources:StringDef, ProcessConfig %>" Icon="Cog" />
										<ext:GridCommand CommandName="FileList" Text="<%$ Resources:StringDef, FileList %>" Icon="Page" />
										<ext:GridCommand CommandName="ShellCommand" Text="<%$ Resources:StringDef, ShellCommand %>" Icon="ComputerConnect" />
									</Commands>
									<PrepareToolbar Fn="prepareMachineToolbar" />
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingMachine" runat="server" PageSize="2000" StoreID="StoreMachine" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridMachineSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridMachineRowDBClick" />
							<Command Fn="gridMachineOnCommand" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowMachine" runat="server" Resizable="false" Width="400"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelMachine" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldMachineId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true" >
					</ext:TextField>
					<ext:TextField ID="TextFieldMachineName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>" Hidden="true">
					</ext:TextField>
					<ext:ComboBox ID="ComboBoxMachineType" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Type %>" SelectedIndex="0" Editable="false">
						<Items>
							<ext:ListItem Text="<%$ Resources:StringDef, MachineTypeGame %>" Value="0" />
							<ext:ListItem Text="<%$ Resources:StringDef, MachineTypeDB %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:TextField ID="TextFieldMachineIpAddress" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, IpAddress %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldMachineIpAddressInner" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, IpAddressInner %>" EmptyText="<%$ Resources:StringDef, MsgIpAddressInnerEmptyText %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldMachineComment" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldMachineMacAddress" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, MacAddress %>" Hidden="true">
					</ext:TextField>
					<ext:ComboBox ID="ComboBoxMachineOSType" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, OSType %>" SelectedIndex="1" Editable="false" Hidden="true">
						<Items>
							<ext:ListItem Text="<%$ Resources:StringDef, OSTypeWindows %>" Value="0" />
							<ext:ListItem Text="<%$ Resources:StringDef, OSTypeLinux %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:ComboBox ID="ComboBoxMachine" StoreID="StoreCabinet" FieldLabel="<%$ Resources:StringDef, BelongedCabinet %>"
						runat="server" AnchorHorizontal="90%" ValueField="Id" DisplayField="Name" Mode="Local" >
					</ext:ComboBox>
					<ext:TextField ID="TextFieldMachineMasterIp" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, MasterIpAddress %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldMachineMasterPort" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, MasterPort %>" Text="9999">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonMachineOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setMachine" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button3" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowMachine}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowCabinet" runat="server" Resizable="false" Width="400"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelCabinet" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldCabinetId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldCabinetName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldCabinetComment" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonCabinetOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setCabinet" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button2" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowCabinet}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowGameProc" runat="server" Resizable="false" Width="400"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelGameProc" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldGameProcId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldGameAppPath" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, GameAppPath %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldGameProcComment" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldGameProcName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>" Hidden="true">
					</ext:TextField>
					<ext:ComboBox ID="ComboGameProcMachineId" StoreID="StoreMachine" FieldLabel="<%$ Resources:StringDef, BelongedMachine %>"
						runat="server" AnchorHorizontal="90%" ValueField="Id" DisplayField="Name" Mode="Local" Hidden="true" >
					</ext:ComboBox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonGameProcOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setGameProc" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button4" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowGameProc}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowCabinetMgr" runat="Server" Title="<%$ Resources:StringDef, CabinetManage %>" Width="900" Height="450" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelCabinet" runat="Server" Border="false" StoreID="StoreCabinet" AutoExpandColumn="Comment">
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="BtnAddCabinet" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addCabinet" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelCabinet" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteCabinet" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyCabinet" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyCabinet" />
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
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" >
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingCabinet" runat="server" PageSize="20" StoreID="StoreCabinet" />
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
	
	<ext:Window ID="WindowGameProcMgr" runat="Server" Width="700" Height="350" CloseAction="Hide"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, GameProcess %>">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelGameProc" runat="server" StoreID="StoreGameProc" Border="false" AutoExpandColumn="Comment" >
						<TopBar>
							<ext:Toolbar ID="ToolbarGameProc" runat="server">
								<Items>
									<ext:Button ID="TbarButtonAddGameProc" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addGameProc" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelGameProc" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteGameProc" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyGameProc" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyGameProc" />
										</Listeners>
									</ext:Button>
									<%--<ext:Button ID="BtnSvrCfg" runat="server" Text="<%$ Resources:StringDef, Config %>" Icon="Cog" Disabled="true">
										<Listeners>
											<Click Fn="configGameProc" />
										</Listeners>
									</ext:Button>--%>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="50" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, GameAppPath %>" DataIndex="GameAppPath" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" >
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="60">
								</ext:Column>--%>
								<%--<ext:Column Header="<%$ Resources:StringDef, BelongedMachine %>" DataIndex="MachineId" Width="200">
									<Renderer Fn="renderMachineId" />
								</ext:Column>--%>
								<ext:CommandColumn Width="80">
									<Commands>
										<ext:GridCommand CommandName="Config" Text="<%$ Resources:StringDef, Config %>" Icon="Cog" />
									</Commands>
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingGameProc" runat="server" PageSize="20" StoreID="StoreGameProc" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel3" runat="server" SingleSelect="true" >
								<Listeners>
									<SelectionChange Fn="gridGameProcSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridGameProcRowDBClick" />
							<Command Fn="gameProcOnCommand" />
						</Listeners>
					</ext:GridPanel>		
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>

<%--
	<ext:Window ID="WindowMachineDetail" runat="server" Resizable="true" Maximizable="true"
		Width="1080" Height="540" Padding="0" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
--%>
	
	<ext:Window ID="WindowSvrCfg" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, Config %>"
		Width="800" Height="500" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowSvrFile" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, FileList %>"
		Width="1080" Height="540" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowConsole" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, ShellCommand %>"
		Width="1080" Height="540" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowBatchOp" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, BatchOperation %>"
		Width="1200" Height="600" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="machinectrl.aspx" >
		</AutoLoad>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTipMachine" runat="server" Target="#{GridPanelMachine}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" Width="300">
		<CustomConfig>
			<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
		</CustomConfig>
		<Listeners>
			<Show Fn="showMachineTip" />
		</Listeners>
	</ext:ToolTip>
	
	<sat:Tip runat="Server" />
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

