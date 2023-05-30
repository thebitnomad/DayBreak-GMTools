<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_ftpsvrinfo, App_Web_ftpsvrinfo.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
	.taskdoing
	{
	    font-weight:bold;
	}
	
	.taskdone
	{
		color:#AAA;
	}
	
	.warning
	{
	    font-weight:bold;
	    color:red;
	}
	
	</style>
	
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgTaskInit		= '<%= Resources.StringDef.TaskInit %>';
		var msgTaskDoing	= '<%= Resources.StringDef.TaskDoing %>';
		var msgTaskDone		= '<%= Resources.StringDef.TaskDone %>';

		var msgSuccess		= '<%= Resources.StringDef.Success %>';
		var msgFailure		= '<%= Resources.StringDef.Failure %>';
		var msgAbort		= '<%= Resources.StringDef.Abort %>';

		var msgUpdateSvrDelFileConfirm	= '<%= Resources.StringDef.MsgUpdateSvrDelFileConfirm %>';
		var msgAbortFileTaskConfirm		= '<%= Resources.StringDef.MsgAbortFileTaskConfirm %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ftpId;				//Id
			var m_remotePath;			//远程路径
			var m_selDirName;
			var template = '<span class="{0}">{1}</span>';
		
			var storeFtpFileGetQueryParams = function( store, options ) {
				options.params.FtpId			= m_ftpId;
				options.params.DirName			= m_selDirName;
				options.params.RemotePath		= #{FieldRemotePath}.getValue( );
			};
			
			var listDir = function( ) {
				#{StoreFtpFile}.load( { 
					params : { },
					callback : function( ) {
						m_selDirName = '';
					}
				} );
			};
			
			var renderFileName = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( record.data.Directory ) {
					return "<span class='folder'>&nbsp;</span>" + "<snap style='line-height:24px;padding-left:5px;'>" + value + "</span>";
				} else {
					return "<span class='file'>&nbsp;</span>" + "<snap style='line-height:24px;padding-left:5px;'>" + value + "</span>";
				}
			};
			
			var renderFileSize = function( value, metadata, record, rowIndex, colIndex, store ) {
				return getSizeText( value );
			};
			
			var renderProgress = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( isNaN( value ) )
					return 'N/A';
			
				var progressText = ( value * 100 ).toFixed( 2 ) + '%';
				return renderCommonMsg( progressText, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return renderCommonMsg( msgTaskInit, metadata, record, rowIndex, colIndex, store );
					case 1:
						return renderCommonMsg( msgTaskDoing, metadata, record, rowIndex, colIndex, store );
					case 2:
						{
							var resultValue	= record.data.Result;
							var stateMsg	= msgTaskDone + " - " + renderResult( resultValue, metadata, record, rowIndex, colIndex, store );
							
							return renderCommonMsg( stateMsg, metadata, record, rowIndex, colIndex, store );
						}
					default:
						return value;
				}
			};
			
			var renderResult = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgSuccess;
					case 1:
						return msgFailure;
					case 2:
						return msgAbort;
					default:
						return value;
				}
			};
			
			var renderSpeed = function( value, metadata, record, rowIndex, colIndex, store ) {
				var speedText = msgNotAvailable;
				
				if( isNaN( value ) ) {
					return msgNotAvailable;
				} else if( value != -1 ) {
					speedText = getSpeedText( value );
				}
				
				return renderCommonMsg( speedText, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderCommonMsg = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( record.data.State )
				{
					case 0:
						return value;
					case 1:
						return String.format( template, "taskdoing", value );
					case 2:
						{
							if( record.data.Result != 0 )
								return String.format( template, "warning", value );
							else
								return String.format( template, "taskdone", value );
						}
					default:
						return value;
				}
			};
			
			var gridFtpInfoSelectionChange = function( el ) {
				#{BtnDelFile}.setDisabled( el.getCount( ) < 1 );
			};
			
			var btnDelFile = function( ) {
				var records = #{GridPanelFtpInfo}.getSelectionModel( ).getSelections( );
				
				if( records.length == 0 )
					return;
				
				showConfirmMsg( msgTitle, msgUpdateSvrDelFileConfirm, function( btn ){
					if( btn == "yes" ) {
						/* 最好修改为一个方法中一块儿删除 */
						for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
							var record = records[nLoopCount];
							Ext.net.DirectMethods.DeleteRemoteFile( m_ftpId, m_remotePath, record.data.Name, record.data.Directory, {
								eventMask: {
									showMask: true,
									minDelay: 200,
									msg: msgSubmitting
								},
								success: function( result ){
									if( result.Success ) {
										listDir( );
									}
									else if( result.ErrorMessage ) {
										showErrMsg( msgTitle, result.ErrorMessage );
									}
								}
							});
						}
					}
				});
			};
			
			var gridFtpFileDblClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var name		= record.data.Name;
				
				if( !record.data.Directory ) {
					return;
				}
				
				m_selDirName	= name;
				listDir( );
			};
			
			var gridTaskSelectionChange = function( el ) {
			};
			
			var refreshTask = function( ) {
				#{StoreTask}.load( );
			};
			
			var gridTaskOnCommand = function( command, record, rowIndex, colIndex ) {
			
				switch( command ) {
					case "Abort":
						{
							showConfirmMsg( msgTitle, msgAbortFileTaskConfirm, function( btn ) {
								if( btn == "yes" ) {
									var guid = record.data.GUID;
									Ext.net.DirectMethods.AbortTask( guid, {
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
									} );
								}
							} );
						}
						break;
				}
			};
			
			var prepareFtpAgentToolbar = function( grid, toolbar, rowIndex, record ) {
				var btnAbort = toolbar.items.get( 0 );

				btnAbort.setDisabled( record.data.State != 0 );
			};
			
			var initData = function( ) {
				setInterval( refreshTask, 2000 );
			};
			
		</script>
	</ext:XScript>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreFtpFile" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreFtpFileRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelFtpInfo}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeFtpFileGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Size" Mapping="Size" Type="Int" />
					<ext:RecordField Name="Owner" Mapping="Owner" Type="String" />
					<ext:RecordField Name="ModifyTime" Mapping="ModifyTime" Type="String" />
					<ext:RecordField Name="Directory" Mapping="Directory" Type="Boolean" />
					<ext:RecordField Name="Attribute" Mapping="Attribute" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreTask" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreTaskRefresh" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="false" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelTask}.body" />
		</DirectEventConfig>
		<Listeners>
			<%--<Load Fn="lazyRenderProgress" />--%>
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="GUID" Mapping="GUID" Type="String" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="Result" Mapping="Result" Type="Int" />
					<ext:RecordField Name="RemotePath" Mapping="RemotePath" Type="String" />
					<ext:RecordField Name="Progress" Mapping="Progress" Type="Float" />
					<ext:RecordField Name="Speed" Mapping="Speed" Type="Int" />
					<ext:RecordField Name="ErrMsg" Mapping="ErrMsg" Type="String" />
					<ext:RecordField Name="StartTime" Mapping="StartTime" Type="String" />
					<ext:RecordField Name="FinishTime" Mapping="FinishTime" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>

	<ext:Hidden runat="Server" ID="FieldRemotePath" />
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:RowLayout runat="Server" Margin="10">
				<Rows>
					<ext:LayoutRow RowHeight="0.6" >
						<ext:GridPanel ID="GridPanelFtpInfo" runat="Server" Border="true" StoreID="StoreFtpFile" Title="<%$ Resources:StringDef, CltUpdateSvr %>"
							Margins="10px 10px 10px 10px" AutoExpandColumn="Name">
							<ColumnModel>
								<Columns>
									<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="150">
										<Renderer Fn="renderFileName" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Size %>" DataIndex="Size" Width="120" Align="Right">
										<Renderer Fn="renderFileSize" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Owner %>" DataIndex="Owner" Width="120" Align="Center">
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Attribute %>" DataIndex="Attribute" Width="130" Align="Center">
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, LastModifyTime %>" DataIndex="ModifyTime" Width="150" Align="Center">
									</ext:Column>
								</Columns>
							</ColumnModel>
							<TopBar>
								<ext:Toolbar runat="Server">
									<Items>
										<ext:Button ID="BtnDelFile" runat="Server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete">
											<Listeners>
												<Click Fn="btnDelFile" />
											</Listeners>
										</ext:Button>
									</Items>
								</ext:Toolbar>
							</TopBar>
							<BottomBar>
								<ext:PagingToolbar ID="PagingFtpFile" runat="server" PageSize="2000" StoreID="StoreFtpFile">
									<Items>
										<ext:ToolbarSeparator />
										<ext:DisplayField runat="Server" ID="DisplayErrMsg" StyleSpec="font-weight:bold; color:red;" />
									</Items>
								</ext:PagingToolbar>
							</BottomBar>
							<SelectionModel>
								<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
									<Listeners>
										<SelectionChange Fn="gridFtpInfoSelectionChange" />
									</Listeners>
								</ext:RowSelectionModel>
							</SelectionModel>
							<Listeners>
								<RowDblClick Fn="gridFtpFileDblClick" />
							</Listeners>
						</ext:GridPanel>
					</ext:LayoutRow>
					<ext:LayoutRow RowHeight="0.4">
						<ext:GridPanel ID="GridPanelTask" runat="Server" Title="<%$ Resources:StringDef, TaskQueue %>" Border="true" StoreID="StoreTask" Height="200"
							Margins="10px 10px 10px 10px" AutoExpandColumn="ErrMsg">
							<View>
								<ext:GridView ID="GridView1" runat="server" MarkDirty="false">
									<CustomConfig>
										<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
									</CustomConfig>
								</ext:GridView>
							</View>
							<ColumnModel>
								<Columns>
									<ext:RowNumbererColumn>
										<Renderer Handler="return ''; " />
									</ext:RowNumbererColumn>
									<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="GUID" Width="50" Hidden="true" Sortable="false">
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Desc" Width="400" Sortable="false">
										<Renderer Fn="renderCommonMsg" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="100" Sortable="false" Align="Center">
										<Renderer Fn="renderState" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Progress %>" DataIndex="Progress" Width="80" Align="Center" Sortable="false">
										<Renderer Fn="renderProgress" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, Speed %>" DataIndex="Speed" Width="80" Align="Center" Sortable="false">
										<Renderer Fn="renderSpeed" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, StartTime %>" DataIndex="StartTime" Width="128" Sortable="false" Align="Center">
										<Renderer Fn="renderCommonMsg" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, FinishTime %>" DataIndex="FinishTime" Width="128" Sortable="false" Align="Center">
										<Renderer Fn="renderCommonMsg" />
									</ext:Column>
									<ext:Column Header="<%$ Resources:StringDef, ErrorInfo %>" DataIndex="ErrMsg" Width="80" Align="Center" Sortable="false">
										<Renderer Fn="renderCommonMsg" />
									</ext:Column>
									<ext:CommandColumn Width="60">
										<Commands>
											<ext:GridCommand CommandName="Abort" Text="<%$ Resources:StringDef, Cancel %>" Icon="Decline" />
										</Commands>
										<PrepareToolbar Fn="prepareFtpAgentToolbar" />
									</ext:CommandColumn>
								</Columns>
							</ColumnModel>
							<BottomBar>
								<ext:PagingToolbar ID="PagingFileTask" runat="server" PageSize="2000" StoreID="StoreTask" />
							</BottomBar>
							<SelectionModel>
								<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server">
									<Listeners>
										<SelectionChange Fn="gridTaskSelectionChange" />
									</Listeners>
								</ext:RowSelectionModel>
							</SelectionModel>
							<Listeners>
								<Command Fn="gridTaskOnCommand" />
							</Listeners>
						</ext:GridPanel>
					</ext:LayoutRow>
				</Rows>
			</ext:RowLayout>
		</Items>
	</ext:Viewport>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
