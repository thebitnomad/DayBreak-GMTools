<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_cltupdateunit, App_Web_cltupdateunit.aspx.b81705c1" theme="default" %>


<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>
<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgAddCltUpdateSvr			= '<%= Resources.StringDef.AddCltUpdateSvr %>';
		var msgDelCltUpdateSvrPrompt	= '<%= Resources.StringDef.MsgDelCltUpdateSvrPrompt %>';
		var msgModifyCltUpdateSvr		= '<%= Resources.StringDef.ModifyCltUpdateSvr %>';

		var msgUpdateSvrStateNormal		= '<%= Resources.StringDef.UpdateSvrStateNormal %>';
		var msgUpdateSvrStateError		= '<%= Resources.StringDef.UpdateSvrStateError %>';

		var msgTaskQueueFormat			= '<%= Resources.StringDef.MsgTaskQueueFormat %>';
		var msgOpSuc					= '<%= Resources.StringDef.OpSuc %>';
		var msgClearFileTaskConfirm		= '<%= Resources.StringDef.MsgClearFileTaskConfirm %>';
		var msgNoSelectedFileOrFolder	= '<%= Resources.StringDef.MsgNoSelectedFileOrFolder %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var ftpOp				= 0;				//操作：0表示新加，1表示修改。
			var m_ftpId				= 0;
			
			var renderFilePercent = function( value, metadata, record, rowIndex, colIndex, store ) {
				var machineId	= record.get( 'Id' );
				var progressId	= 'rowProgress' + machineId;
				var renderHtml	= "<span id='" + progressId + "' style='float:left;'></span>";
				
				return renderHtml;
			};
			
			var renderSpeed = function( value, metadata, record, rowIndex, colIndex, store ) {
				var speed = record.get( 'TransSpeed' )
				if( speed != -1 ) {
					return "<span style='line-height:18px;'>" + getSpeedText( speed ) + "</span>";
				} else {
					return '';
				}
			};
			
			var renderSvrState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						metadata.css = 'updatesvrnormal';
						return msgUpdateSvrStateNormal;
					case 1:
						metadata.css = 'updatesvrerr';
						return msgUpdateSvrStateError;
				}
			};
			
			var renderQueueCount = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value > 1 ) {
					return String.format( msgTaskQueueFormat, value );
				} else {
					return '';
				}
			};
			
			var lazyRenderProgress = function( store, records, options ) {
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					var filePercent	= records[nLoopCount].data.FilePercent;
					if( filePercent >= 0 ) {
						var ftpId	= records[nLoopCount].get( 'Id' );
						var progressId	= 'rowProgress' + ftpId;
						var proBarId	= 'proBar' + ftpId;
						
						createProgressBar( proBarId, progressId, filePercent );
					}
				}
			};
			
			var prepareFtpAgentToolbar = function( grid, toolbar, rowIndex, record ) {
			};

			var addFtpAgent = function( ) {
				#{FormPanelFtpAgent}.reset( );
				
				#{TextFieldFtpPort}.setValue( 21 );
				#{TextFieldFtpRemotePath}.setValue( "/" );
				#{TextFieldFtpEncodeName}.setValue( "utf-8" );
				
				#{ButtonFtpOp}.setText( msgOK );
				#{WindowFtpAgent}.setTitle( msgAddCltUpdateSvr );
				#{WindowFtpAgent}.show( );
				
				ftpOp = 0;
			};

			var deleteFtpAgent = function( ) {
				var grid = #{GridPanelFtpAgent};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelCltUpdateSvrPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteFtpAgent( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryFtpAgent( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyFtpAgent = function( ) {
				var record = #{GridPanelFtpAgent}.getSelectionModel( ).getSelected( );
				showFtpDetail( record );				
				
				ftpOp = 1;
			};
			
			var showFtpDetail = function( record ) {
				#{TextFieldFtpId}.setValue( record.data.Id );
				#{TextFieldFtpAddress}.setValue( record.data.Address );
				#{TextFieldFtpComment}.setValue( record.data.Comment );
				#{TextFieldFtpPort}.setValue( record.data.Port );
				#{TextFieldFtpUserName}.setValue( record.data.UserName );
				#{TextFieldFtpPassword}.setValue( '' );
				#{TextFieldFtpRemotePath}.setValue( record.data.RemotePath );
				#{TextFieldFtpEncodeName}.setValue( record.data.EncodeName );

				#{CheckClientFull}.setValue( ( record.data.UpdateType & 1 ) > 0 );
				#{CheckClientTiny}.setValue( ( record.data.UpdateType & 2 ) > 0 );
				#{CheckClientWeb}.setValue( ( record.data.UpdateType & 4 ) > 0 );
				#{CheckClientSvrList}.setValue( ( record.data.UpdateType & 8 ) > 0 );

				#{ButtonFtpOp}.setText( msgSave );
				
				#{WindowFtpAgent}.setTitle( msgModifyCltUpdateSvr );
				#{WindowFtpAgent}.show( );
			};
			
			var setFtpAgent = function( ) {
				Ext.net.DirectMethods.SetFtpAgent( ftpOp, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowFtpAgent}.hide( );
							queryFtpAgent( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryFtpAgent( );
						}
					}
				});
			};
			
			var updateSvrSelAll = function( ) {
				var checkSvrs = #{CheckBoxGroupSvr}.items;
				for( var nLoopCount = 0; nLoopCount < checkSvrs.length; ++nLoopCount ) {
					checkSvrs.items[nLoopCount].setValue( true );
				}
			};
			
			var updateSvrSelNone = function( ) {
				var checkSvrs = #{CheckBoxGroupSvr}.items;
				for( var nLoopCount = 0; nLoopCount < checkSvrs.length; ++nLoopCount ) {
					checkSvrs.items[nLoopCount].setValue( false );
				}
			};
			
			var updateSvrSelOpp = function( ) {
				var checkSvrs = #{CheckBoxGroupSvr}.items;
				for( var nLoopCount = 0; nLoopCount < checkSvrs.length; ++nLoopCount ) {
					checkSvrs.items[nLoopCount].setValue( !checkSvrs.items[nLoopCount].checked );
				}
			};
			
			var updateSvrSelErr = function( ) {
				var checkSvrs = #{CheckBoxGroupSvr}.items;
				for( var nLoopCount = 0; nLoopCount < checkSvrs.length; ++nLoopCount ) {
					var svrId = eval( checkSvrs.items[nLoopCount].tag );
					var index = #{StoreFtpAgentState}.findExact( "Id", svrId );
					if( index == -1 )
						continue;
					
					var state = #{StoreFtpAgentState}.getAt( index ).get( 'State' );
					checkSvrs.items[nLoopCount].setValue( state == 1 );
				}
			};
			
			var gridFtpAgentSelectionChange = function( el ) {
				#{BtnDelFtpAgent}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyFtpAgent}.setDisabled( el.getCount( ) < 1 );
			};
			
			var gridFtpAgentRowDBClick = function( grid, rowIndex, e ) {
				var record = grid.store.getAt( rowIndex );
				showSvrInfo( record );
			};
			
			var gridFtpAgentOnCommand = function( command, record, rowIndex, colIndex ) {
			
				switch( command ) {
					case "Clear":
						{
							var ftpId = record.data.Id;
							var result = showConfirmMsg( msgTitle, msgClearFileTaskConfirm, function( btn ) {
								if( btn == "yes" ) {
									Ext.net.DirectMethods.ClearTask( ftpId, {
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
							} );
						}
						break;
				}
			};
			
			var showSvrInfo = function( record ) {
				var win = #{WindowFtpFile};
				win.setTitle( record.data.Address );
				win.load( {
					url: 'ftpsvrinfo.aspx',
					params: { ftpId: record.data.Id },
					discardUrl: false,
					nocache: true,
					timeout: 30
				});
				
				#{WindowFtpFile}.show( );
			}
			
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
			
			var updateFtpAgentState = function( ) {
				var paramStart = 0;
				var paramLimit = #{PagingFtpAgent}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( #{StoreFtpAgent}.lastOptions ) {
					paramStart = #{StoreFtpAgent}.lastOptions.params.start;
				}
				
				#{StoreFtpAgentState}.load( {
					params: { start: paramStart, limit: paramLimit },
					callback : function( records, options, success ) {
						if( success ) {
							for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
								var index = #{StoreFtpAgent}.findExact( "Id", records[nLoopCount].data.Id );
								if( index != -1 ) {
									var srcRecord = #{StoreFtpAgent}.getAt( index );
									
									srcRecord.set( 'State', records[nLoopCount].get( 'State' ) );
									srcRecord.set( 'FilePercent', records[nLoopCount].get( 'FilePercent' ) );
									srcRecord.set( 'TransSpeed', records[nLoopCount].get( 'TransSpeed' ) );
									srcRecord.set( 'TaskDesc', records[nLoopCount].get( 'TaskDesc' ) );
									srcRecord.set( 'QueueCount', records[nLoopCount].get( 'QueueCount' ) );
									
									srcRecord.commit( );
									
									var ftpId		= records[nLoopCount].get( 'Id' );
									var progressId	= 'rowProgress' + ftpId;
									var proBarId	= 'proBar' + ftpId;
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
			
			var queryFtpAgent = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingFtpAgent}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreFtpAgent}.lastOptions ) {
					paramStart = #{StoreFtpAgent}.lastOptions.params.start;
				}
				#{StoreFtpAgent}.load( {
					params: { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
			var btnUploadClick = function( ) {
				var selFilePath = fileManGetSelFile( );
				if( !selFilePath ) {
					showErrMsg( msgTitle, msgNoSelectedFileOrFolder );
					return;
				}
			
				#{RadioOverwrite}.setValue( true );
				#{CheckboxClearErr}.setValue( true );
				#{WindowUpload}.show( );
			};
			
			var uploadFile = function( ) {
				var ftpIds		= '';
				var filePath	= fileManGetSelFile( );
			
				var checkSvrs = #{CheckBoxGroupSvr}.items;
				for( var nLoopCount = 0; nLoopCount < checkSvrs.length; ++nLoopCount ) {
					if( checkSvrs.items[nLoopCount].checked ) {
						if( checkSvrs.items[nLoopCount].tag ) {
							ftpIds += checkSvrs.items[nLoopCount].tag;
							ftpIds += ',';
						}
					}
				}
			
				Ext.net.DirectMethods.Upload( ftpIds, filePath, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowUpload}.hide( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var showErrTip = function( ) {
				var rowIndex	= #{GridPanelFtpAgent}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelFtpAgent}.view.findCellIndex( this.triggerElement );
				var record = #{StoreFtpAgent}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				if( record.data.State == 0 ) {
					this.hide( );
					return;
				}
				
				if( cellIndex != 5 ) {
					this.hide( );
					return;	
				}
				
				m_ftpId = record.get( 'Id' );
			};
			
			var updateErrTip = function( ) {
				var tip = #{ToolTipErrInfo};
				if( !tip.isVisible( ) ) {
					return;
				}
				
				Ext.net.DirectMethods.Tip.UpdateFtpAgentTip( m_ftpId, 10, {
					method : 'GET',
					success: function( result ) {
						if( result.Success ) {
							tip.body.dom.innerHTML = result.Result;
						}
					}
				} );
			};
			
			var initData = function( ) {
				queryFtpAgent( );
				
				setInterval( updateFtpAgentState, 2000 );
				setInterval( updateErrTip, 3000 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreFtpAgent" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="FtpAgentRefresh" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelFtpAgent}.body" />
		</DirectEventConfig>
		<Listeners>
			<Load Fn="lazyRenderProgress" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Address" Mapping="Address" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="Port" Mapping="Port" Type="Int" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="RemotePath" Mapping="RemotePath" Type="String" />
					<ext:RecordField Name="EncodeName" Mapping="EncodeName" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="String" />
					<ext:RecordField Name="TaskDesc" Mapping="TaskDesc" Type="String" />
					<ext:RecordField Name="QueueCount" Mapping="QueueCount" Type="Int" />
					<ext:RecordField Name="UpdateType" Mapping="UpdateType" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreFtpAgentState" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="FtpAgentStateRefresh">
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Listeners>
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="FilePercent" Mapping="FilePercent" Type="Float" />
					<ext:RecordField Name="TransSpeed" Mapping="TransSpeed" Type="Int" />
					<ext:RecordField Name="TaskDesc" Mapping="TaskDesc" Type="String" />
					<ext:RecordField Name="QueueCount" Mapping="QueueCount" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:Panel ID="Panel1" runat="Server" Height="400" Margins="10" ButtonAlign="Center">
						<Items>
							<ext:Container ID="Container2" runat="server" Height="360">
								<Content>
									<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false" Title="<%$ Resources:StringDef, CltUpdatePak %>">
									</sat:FileMan2>
								</Content>
							</ext:Container>
						</Items>
						<Buttons>
							<ext:Button ID="BtnUpload" runat="Server" Text="<%$ Resources:StringDef, Upload %>" >
								<Listeners>
									<Click Fn="btnUploadClick" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:Panel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelFtpAgent" runat="Server" Border="true" StoreID="StoreFtpAgent" ColumnLines="true"
						AutoExpandColumn="TaskDesc" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, CltUpdateSvr %>">
						<View>
							<ext:GroupingView ID="GroupingView1" runat="server" MarkDirty="false" ShowGroupName="false" EnableNoGroups="true" HideGroupedColumn="true" />
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnAddFtpAgent" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addFtpAgent" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelFtpAgent" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteFtpAgent" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyFtpAgent" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyFtpAgent" />
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
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="40" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, IpAddress %>" DataIndex="Address" Width="100">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Port %>" DataIndex="Port" Width="40">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" Width="100" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="80" Align="Center" >
									<Renderer Fn="renderSvrState" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RemotePath %>" DataIndex="RemotePath" Width="80" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, EncodeName %>" DataIndex="EncodeName" Width="120" Hidden="true" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CurrentTask %>" DataIndex="TaskDesc" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Progress %>" DataIndex="FilePercent" Width="120" Align="Center">
									<Renderer Fn="renderFilePercent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Speed %>" DataIndex="Speed" Width="100" Align="Center">
									<Renderer Fn="renderSpeed" />
								</ext:Column>
								<ext:Column DataIndex="QueueCount" Width="150" Align="Center">
									<Renderer Fn="renderQueueCount" />
								</ext:Column>
								<ext:CommandColumn Width="80">
									<Commands>
										<ext:GridCommand CommandName="Clear" Text="<%$ Resources:StringDef, Clear %>" Icon="ServerGo" />
									</Commands>
									<PrepareToolbar Fn="prepareFtpAgentToolbar" />
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingFtpAgent" runat="server" PageSize="2000" StoreID="StoreFtpAgent" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridFtpAgentSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridFtpAgentRowDBClick" />
							<Command Fn="gridFtpAgentOnCommand" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowFtpAgent" runat="server" Resizable="false" Width="600"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelFtpAgent" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldFtpId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Hidden="true" >
					</ext:TextField>
					<ext:TextField ID="TextFieldFtpAddress" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, IpAddress %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldFtpComment" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Comment %>">
					</ext:TextField>
					<ext:NumberField ID="TextFieldFtpPort" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Port %>">
					</ext:NumberField>
					<ext:TextField ID="TextFieldFtpUserName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, UserName %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldFtpPassword" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Password %>"
						InputType="Password" Note="<%$ Resources:StringDef, MsgEmptyUseOriPwd %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldFtpRemotePath" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, RemotePath %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldFtpEncodeName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, EncodeName %>">
					</ext:TextField>
					<ext:CompositeField ID="CompositeField1" runat="Server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Type %>">
						<Items>
							<ext:Checkbox runat="Server" ID="CheckClientFull" BoxLabel="<%$ Resources:StringDef, ClientFull %>" Checked="true">
							</ext:Checkbox>
							<ext:Checkbox runat="Server" ID="CheckClientTiny" BoxLabel="<%$ Resources:StringDef, ClientTiny %>" Checked="true">
							</ext:Checkbox>
							<ext:Checkbox runat="Server" ID="CheckClientWeb" BoxLabel="<%$ Resources:StringDef, ClientWeb %>" Checked="true">
							</ext:Checkbox>
							<ext:Checkbox runat="Server" ID="CheckClientSvrList" BoxLabel="<%$ Resources:StringDef, ClientSvrList %>" Checked="true">
							</ext:Checkbox>
						</Items>
					</ext:CompositeField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonFtpOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setFtpAgent" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button3" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowFtpAgent}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:Window ID="WindowFtpFile" runat="server" Resizable="true" Maximizable="true"
		Width="1280" Height="700" Padding="10" CloseAction="Hide" Collapsible="false"
		Hidden="true" Modal="true" BodyStyle="background-color:#FFF;" >
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowUpload" runat="server" Resizable="true" Width="600" Height="300" AutoScroll="true"
		CloseAction="Hide" Collapsible="false" Hidden="true" Modal="true" BodyStyle="background-color:#FFF;">
		<Items>
			<ext:FormPanel ID="FormPanelUpload" runat="Server" Border="false" Padding="10" LabelAlign="Right">
				<Items>
					<ext:RadioGroup ID="RadioGroup1" runat="Server" FieldLabel="<%$ Resources:StringDef, Option %>" Width="100">
						<Items>
							<ext:Radio ID="RadioOverwrite" runat="Server" BoxLabel="<%$ Resources:StringDef, Overwrite %>" Checked="true"></ext:Radio>
							<ext:Radio ID="RadioAppend" runat="Server" BoxLabel="<%$ Resources:StringDef, Append %>"></ext:Radio>
						</Items>
					</ext:RadioGroup>
					<ext:CheckboxGroup runat="Server" ID="CheckBoxGroupSvr" FieldLabel="<%$ Resources:StringDef, CltUpdateSvr %>"
						ColumnsNumber="2">
						<Items>
							<ext:Checkbox ID="Checkbox1" runat="server" Hidden="true" />
						</Items>
					</ext:CheckboxGroup>
					<ext:CompositeField runat="server" ID="ComFieldSel">
						<Items>
							<ext:LinkButton runat="server" ID="BtnSelAll" Text="<%$ Resources:StringDef, SelectAll %>">
								<Listeners>
									<Click Fn="updateSvrSelAll" />
								</Listeners>
							</ext:LinkButton>
							<ext:LinkButton runat="server" ID="BtnSelNone" Text="<%$ Resources:StringDef, UnselectAll %>">
								<Listeners>
									<Click Fn="updateSvrSelNone" />
								</Listeners>
							</ext:LinkButton>
							<ext:LinkButton runat="server" ID="BtnSelOpp" Text="<%$ Resources:StringDef, SelectOpposite %>">
								<Listeners>
									<Click Fn="updateSvrSelOpp" />
								</Listeners>
							</ext:LinkButton>
							<ext:LinkButton runat="server" ID="BtnSelErr" Text="<%$ Resources:StringDef, SelectErrSvr %>">
								<Listeners>
									<Click Fn="updateSvrSelErr" />
								</Listeners>
							</ext:LinkButton>
						</Items>
					</ext:CompositeField>
					<ext:Checkbox runat="Server" ID="CheckboxClearErr" FieldLabel="<%$ Resources:StringDef, Option %>" Checked="true" BoxLabel="<%$ Resources:StringDef, ClearErrState %>" ></ext:Checkbox>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button runat="Server" ID="BtnUploadFile" Text="<%$ Resources:StringDef, OK %>" >
				<Listeners>
					<Click Fn="uploadFile" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" ID="BtnUploadCancel" Text="<%$ Resources:StringDef, Cancel %>" >
				<Listeners>
					<Click Handler="
						#{WindowUpload}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTipErrInfo" runat="server" Target="#{GridPanelFtpAgent}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" Width="300">
		<CustomConfig>
			<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
		</CustomConfig>
		<Listeners>
			<Show Fn="showErrTip" />
		</Listeners>
	</ext:ToolTip>
	
	<sat:Tip ID="Tip1" runat="Server" />
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
