<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svrfile, App_Web_svrfile.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
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

		var msgUpdateSvrDelFileConfirm		= '<%= Resources.StringDef.MsgUpdateSvrDelFileConfirm %>';
		var msgAbortFileTaskConfirm			= '<%= Resources.StringDef.MsgAbortFileTaskConfirm %>';
		var msgAlreadyAddToFileTransQueue	= '<%= Resources.StringDef.MsgAlreadyAddToFileTransQueue %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ftpId;				//Id
			var m_selDirName;
			var template = '<span class="{0}">{1}</span>';
		
			var storeSvrFileGetQueryParams = function( store, options ) {
				options.params.FtpId			= m_ftpId;
				options.params.DirName			= m_selDirName;
				options.params.RemotePath		= #{FieldRemotePath}.getValue( );
			};
			
			var listDir = function( ) {
				#{StoreSvrFile}.load( { 
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
			
			var btnDownloadFile = function( ) {
				var records = #{GridPanelSvrFileInfo}.getSelectionModel( ).getSelections( );
				
				if( records.length == 0 )
					return;
				
				var remotePath = #{FieldRemotePath}.getValue( );
				
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					var record = records[nLoopCount];
					if( !record.data.Directory ) {
						Ext.net.DirectMethods.DownloadFile( remotePath, record.data.Name, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgAlreadyAddToFileTransQueue )
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				}
			};
			
			var btnDelFile = function( ) {
				var records = #{GridPanelSvrFileInfo}.getSelectionModel( ).getSelections( );
				
				if( records.length == 0 )
					return;
				
				var remotePath = #{FieldRemotePath}.getValue( );
				
				showConfirmMsg( msgTitle, msgUpdateSvrDelFileConfirm, function( btn ){
					if( btn == "yes" ) {
						/* 最好修改为一个方法中一块儿删除 */
						for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
							var record = records[nLoopCount];
							Ext.net.DirectMethods.DeleteRemoteFile( m_ftpId, remotePath, record.data.Name, record.data.Directory, {
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
			
			var gridSvrFileDblClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var name		= record.data.Name;
				
				if( !record.data.Directory ) {
					return;
				}
				
				m_selDirName	= name;
				listDir( );
			};
			
			var initData = function( ) {
			};
			
		</script>
	</ext:XScript>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreSvrFile" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreSvrFileRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelSvrFileInfo}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeSvrFileGetQueryParams" />
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
	
	<ext:Hidden runat="Server" ID="FieldRemotePath" />
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelSvrFileInfo" runat="Server" Border="false" StoreID="StoreSvrFile"
						AutoExpandColumn="Name">
						<ColumnModel>
							<Columns>
								<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="150">
									<Renderer Fn="renderFileName" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Size %>" DataIndex="Size" Width="120" Align="Right">
									<Renderer Fn="renderFileSize" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Attribute %>" DataIndex="Attribute" Width="130" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LastModifyTime %>" DataIndex="ModifyTime" Width="150" Align="Center">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="Server">
								<Items>
									<ext:ToolbarSpacer />
									<ext:DisplayField ID="DisplayFieldRemotePath" runat="Server"></ext:DisplayField>
									<ext:ToolbarFill />
									<ext:Button ID="BtnDownload" runat="Server" Text="<%$ Resources:StringDef, Download %>" Icon="PageSave">
										<Listeners>
											<Click Fn="btnDownloadFile" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelFile" runat="Server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Hidden="true">
										<Listeners>
											<Click Fn="btnDelFile" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingSvrFile" runat="server" PageSize="2000" StoreID="StoreSvrFile">
								<Items>
									<ext:ToolbarSeparator />
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
							<RowDblClick Fn="gridSvrFileDblClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
