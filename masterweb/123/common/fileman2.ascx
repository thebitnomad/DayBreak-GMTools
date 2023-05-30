<%@ control language="C#" autoeventwireup="true" inherits="common_fileman2, App_Web_fileman2.ascx.38131f0b" %>

<script type="text/javascript">
	var msgTitle				= '<%= Resources.StringDef.SystemName %>';
	var msgUploading			= '<%= Resources.StringDef.Uploading %>';
	var msgUploadFileSuccess	= '<%= Resources.StringDef.MsgUploadFileSuccess %>';
	var msgDeleteFileSuccess	= '<%= Resources.StringDef.MsgDeleteFileSuccess %>';
	var msgDeleteFileConfirm	= '<%= Resources.StringDef.MsgDeleteFileConfirm %>';
	var msgClearFileConfirm		= '<%= Resources.StringDef.MsgClearFileConfirm %>';
	var msgRenameFileSuccess	= '<%= Resources.StringDef.MsgRenameFileSuccess %>';
	var msgCreateDirSuccess		= '<%= Resources.StringDef.MsgCreateDirSuccess %>';
	var msgUnzipSuccess			= '<%= Resources.StringDef.MsgUnzipSuccess %>';
	var msgUnzipConfirm			= '<%= Resources.StringDef.MsgUnzipConfirm %>';
	var msgFolder				= '<%= Resources.StringDef.Folder %>';
	var msgFile					= '<%= Resources.StringDef.File %>';
	
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var m_selDirName;
		var m_downloadurl;
		var m_relDir;
		
		var fileManShowUploadWin = function( ) {
			//#{FileFieldSelFile}.reset( );
			#{WindowUploadFile}.show( );
		};
		
//		var fileManUploadFile = function( ) {
//			var path = '';
//			
//			#{DirectMethods}.UploadFile( path, {
//				eventMask: {
//					showMask: true,
//					minDelay: 200,
//					msg: msgUploading
//				},
//				success: function( result ) {
//					if( result.Success ) {
//						#{WindowUploadFile}.hide( );
//						showSuccessMsg( msgTitle, msgUploadFileSuccess );
//						
//						#{TreePanelFile}.root.reload( );
//					}
//					else if( result.ErrorMessage ) {
//						showErrMsg( msgTitle, result.ErrorMessage );
//					}
//				}
//			});
//		};

		var fileManRenderFileName = function( value, metadata, record, rowIndex, colIndex, store ) {
			if( record.data.Directory ) {
				return "<span class='folder'>&nbsp;</span>" + "<snap style='line-height:24px;padding-left:5px;'>" + value + "</span>";
			} else {
				return "<span class='file'>&nbsp;</span>" + "<snap style='line-height:24px;padding-left:5px;'>" + value + "</span>";
			}
		};
		
		var fileManRenderFileSize = function( value, metadata, record, rowIndex, colIndex, store ) {
			return fileManRenderCommon( getSizeText( value ), metadata, record, rowIndex, colIndex, store );
		};
		
		var fileManRenderType = function( value, metadata, record, rowIndex, colIndex, store ) {
			var typeText = '';
			if( value ) {
				typeText = msgFolder;
			} else {
				typeText = msgFile;
			}
			
			return fileManRenderCommon( typeText, metadata, record, rowIndex, colIndex, store );
		};
		
		var fileManRenderCommon = function( value, metadata, record, rowIndex, colIndex, store ) {
			return "<snap style='line-height:24px;'>" + value + "</span>"
		};
		
		var fileManDeleteFile = function( ) {		    
			showConfirmMsg( 
				msgTitle,
				msgDeleteFileConfirm,
				function( btnID ) {
					if( btnID != "yes" )
						return;
					var filePath = fileManGetSelFile( );
					if( filePath.length < 1 )
						return;
					#{DirectMethods}.DeleteFile(
						filePath, {
						eventMask: {
							showMask: true,
							minDelay: 200,
							msg: msgSubmitting
						},
						success: function( result ){
							if( result.Success ) {
								//showSuccessMsg( msgTitle, msgDeleteFileSuccess );
								fileManRefreshDir( );
							}
							else if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
						 }
					});
			});
		};
		
		var fileManClear = function( ) {
			showConfirmMsg( msgTitle, msgClearFileConfirm,
				function( btnID ) {
					if( btnID != "yes" )
						return;
						
					#{DirectMethods}.Clear( {
						success: function( result ) {
							if( result.Success ) {
								fileManRefreshDir( );
							}
							else if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
						}
					} );
				}
			);
		};
		
		var fileManUnzip = function( ) {
			var filePath = fileManGetSelFile( );
			if( filePath.length < 1 )
				return;
		
			showConfirmMsg( msgTitle, msgUnzipConfirm,
				function( btnID ) {
					if( btnID != "yes" )
						return;
		
					#{DirectMethods}.UnzipFile(
						filePath, {
						success: function( result ){
							if( result.Success ) {
								//showSuccessMsg( msgTitle, msgUnzipSuccess );
								fileManRefreshDir( );
							}
							else if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
						 }
					});
				}
			);
		};

		var fileManDownload = function( ) {
			var filePath = fileManGetSelFile( );
			if( filePath.length < 1 )
				return;
			
			var url = m_downloadurl + "&fpath=" + encodeURI( filePath );
			window.open( url );
			
		};
		
		var fileManShowRenameFile = function( ) {
			var fullFileName = fileManGetSelFile( );
			if( fullFileName == null || fullFileName == '' ) {
				return;
			}
			var splitIdx = fullFileName.lastIndexOf( '\\' );
			var fileName;
			var dirName;
			if( splitIdx < 0 ) {
				fileName = fullFileName;
				dirName = '';
			}
			else {
				fileName = fullFileName.substring( splitIdx + 1 );
				dirName = fullFileName.substring( 0, splitIdx );
			}
			#{TextRenameFile}.OriName = fileName;
			#{TextRenameFile}.DirName = dirName;
			#{TextRenameFile}.setValue( fileName );
			#{WindowRenameFile}.show( );
		};
		
		var fileManRenameFile = function( ) {
			#{WindowRenameFile}.hide( );
			#{DirectMethods}.RenameFile(
				#{TextRenameFile}.DirName,
				#{TextRenameFile}.OriName,
				#{TextRenameFile}.getValue( ), {
					success: function( result ) {
						if( !result.Success ) {
							if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
							return;
						}
						//showSuccessMsg( msgTitle, msgRenameFileSuccess );
						fileManRefreshDir( );
					}
				}
			);
		};
		
		var fileManShowCreateDir = function( ) {
			#{WindowCreateDir}.DirPath = fileManGetSelFile( );
			#{WindowCreateDir}.show( );
		};
		
		var fileManRefreshDir = function( ) {
			fileManListDir( );
		};
		
		var fileManStoreFileGetQueryParams = function( store, options ) {
			options.params.RelDir	= #{FieldRelDirPath}.getValue( );
			options.params.DirName	= m_selDirName;
		};
		
		var fileManListDir = function( ) {
			#{StoreFile}.load( { 
				params : { },
				callback : function( ) {
					m_selDirName = '';
				}
			} );
		};
		
		var fileManCreateDir = function( ) {
			#{DirectMethods}.CreateDir(
				#{TextCreateDir}.DirPath,
				#{TextCreateDir}.getValue( ), {
					success: function( result ) {
						#{WindowCreateDir}.hide( );
						if( result.Success ) {
							//showSuccessMsg( msgTitle, msgCreateDirSuccess );
							fileManRefreshDir( );
						}
						else {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				}
			);
		};
		
		var fileManGridFileDblClick = function( grid, rowIndex, e ) {
			var record		= grid.store.getAt( rowIndex );
			var name		= record.data.Name;
			
			if( !record.data.Directory ) {
				return;
			}
			
			m_selDirName	= name;
			fileManListDir( );
		};
		
		var fileManPriNodeLoad = function( node ) {
			#{DirectMethods}.NodeLoad( node.id, {
				success: function( result ) {
					var data = eval( "(" + result.Result + ")" );
					node.loadNodes( data );
				}
			} );
		};
		
		var fileSelectionChange = function( el ) {
			#{BtnDeleteFile}.setDisabled( el.getCount( ) < 1 );
			#{BtnRenameFile}.setDisabled( el.getCount( ) < 1 );
			#{BtnUnzip}.setDisabled( el.getCount( ) < 1 );
		};
		
		var fileManGetSelFile = function( ) {
			var record = #{GridPanelFile}.getSelectionModel( ).getSelected( );
			if( record ) {
				return m_relDir + #{FieldRelDirPath}.getValue( ) + record.data.Name;
			} else {
				return '';
			}
		};
		
		var fileManGetSelFileName = function( ) {
			var record = #{GridPanelFile}.getSelectionModel( ).getSelected( );
			if( record ) {
				return record.data.Name;
			} else {
				return '';
			}
		};
		
		var fileManWinUploadFileHide = function( ) {
			fileManRefreshDir( );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreFile" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreFileRefresh" AutoLoad="false">
	<DirectEventConfig>
		<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelFile}.body" />
	</DirectEventConfig>
	<Listeners>
		<BeforeLoad Fn="fileManStoreFileGetQueryParams" />
	</Listeners>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:ArrayReader>
			<Fields>
				<ext:RecordField Name="Name" Mapping="Name" Type="String" />
				<ext:RecordField Name="Size" Mapping="Size" Type="Int" />
				<ext:RecordField Name="ModifyTime" Mapping="ModifyTime" Type="String" />
				<ext:RecordField Name="Directory" Mapping="Directory" Type="Boolean" />
				<ext:RecordField Name="Extension" Mapping="Extension" Type="String" />
			</Fields>
		</ext:ArrayReader>
	</Reader>
</ext:Store>

<ext:BorderLayout ID="BorderLayout1" runat="Server">
	<Center>
		<ext:GridPanel ID="GridPanelFile" runat="Server" Border="true" StoreID="StoreFile" AutoExpandColumn="Name">
			<View>
				<ext:GridView ID="GridView1" runat="server" MarkDirty="false">
					<CustomConfig>
						<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
					</CustomConfig>
				</ext:GridView>
			</View>
			<TopBar>
				<ext:Toolbar ID="Toolbar2" runat="Server">
					<Items>
						<ext:Button ID="BtnRefresh" runat="server" Text="<%$ Resources:StringDef, Refresh %>"
							Icon="ArrowRefresh">
							<Listeners>
								<Click Fn="fileManRefreshDir" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarSeparator />
						<ext:Button ID="BtnUploadFile" runat="server" Text="<%$ Resources:StringDef, UploadFile %>"
							Icon="PageAdd">
							<Listeners>
								<Click Fn="fileManShowUploadWin" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnDeleteFile" runat="server" Text="<%$ Resources:StringDef, Delete %>"
							Icon="PageDelete" Disabled="true">
							<Listeners>
								<Click Fn="fileManDeleteFile" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnRenameFile" runat="server" Text="<%$ Resources:StringDef, Rename %>"
							Icon="PagePaintbrush" Disabled="true">
							<Listeners>
								<Click Fn="fileManShowRenameFile" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnCreateDir" runat="server" Text="<%$ Resources:StringDef, CreateDir %>"
							Icon="FolderAdd" Hidden="true">
							<Listeners>
								<Click Fn="fileManShowCreateDir" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnClear" runat="server" Text="<%$ Resources:StringDef, Clear %>"
							Icon="PageDelete" Hidden="true">
							<Listeners>
								<Click Fn="fileManClear" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarSeparator />
						<ext:Button ID="BtnUnzip" runat="server" Text="<%$ Resources:StringDef, Unzip %>"
							Icon="BrickGo" Disabled="true">
							<Listeners>
								<Click Fn="fileManUnzip" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarSeparator />
						<ext:Button ID="BtnDownload" runat="server" Text="<%$ Resources:StringDef, Download %>"
							Icon="PageSave">
							<Listeners>
								<Click Fn="fileManDownload" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarFill />
					</Items>
				</ext:Toolbar>
			</TopBar>
			<ColumnModel>
				<Columns>
					<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name">
						<Renderer Fn="fileManRenderFileName" />
					</ext:Column>
					<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Directory">
						<Renderer Fn="fileManRenderType" />
					</ext:Column>
					<ext:Column Header="<%$ Resources:StringDef, Size %>" DataIndex="Size" Width="150" Align="Right">
						<Renderer Fn="fileManRenderFileSize" />
					</ext:Column>
					<ext:Column Header="<%$ Resources:StringDef, LastModifyTime %>" DataIndex="ModifyTime" Width="180" Align="Center">
						<Renderer Fn="fileManRenderCommon" />
					</ext:Column>
					<ext:Column Header="<%$ Resources:StringDef, Extension %>" DataIndex="Extension" Width="100" Align="Center">
						<Renderer Fn="fileManRenderCommon" />
					</ext:Column>
				</Columns>
			</ColumnModel>
			<BottomBar>
				<ext:Toolbar runat="server" Height="25">
					<Items>
						<ext:DisplayField runat="Server" ID="FieldRelDirPath" LabelWidth="30" FieldLabel="<%$ Resources:StringDef, Path %>" />
					</Items>
				</ext:Toolbar>
				<%--<ext:PagingToolbar ID="PagingFile" runat="server" PageSize="20000" StoreID="StoreFile">
					<Items>
						<ext:ToolbarSeparator />
						<ext:DisplayField runat="Server" ID="FieldRelDirPath" StyleSpec="font-weight:bold;" />
					</Items>
				</ext:PagingToolbar>--%>
			</BottomBar>
			<SelectionModel>
				<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server" SingleSelect="true">
					<Listeners>
						<SelectionChange Fn="fileSelectionChange" />
					</Listeners>
				</ext:RowSelectionModel>
			</SelectionModel>
			<Listeners>
				<RowDblClick Fn="fileManGridFileDblClick" />
			</Listeners>
		</ext:GridPanel>
	</Center>
</ext:BorderLayout>

<ext:Window ID="WindowUploadFile" runat="server" Width="500" Height="300" Resizable="false" Title="<%$ Resources:StringDef, UploadFile %>"
	CloseAction="Hide" AnimateTarget="#{BtnUploadFile}"
	Hidden="true" Modal="true">
	<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="~/common/fileupload.aspx" >
	</AutoLoad>
	<Listeners>
		<Hide Fn="fileManWinUploadFileHide" />
	</Listeners>
</ext:Window>

<ext:Window ID="WindowRenameFile" runat="server" Width="400" Height="110" Resizable="false" Title="<%$ Resources:StringDef, RenameFile %>"
	CloseAction="Hide" Padding="10" AnimateTarget="#{BtnRenameFile}"
	Hidden="true" Modal="true" ButtonAlign="Right"  LabelWidth="40">
	<Items>
		<ext:TextField ID="TextRenameFile" runat="server" Width = "360" FieldLabel="<%$ Resources:StringDef, Name %>" >
		</ext:TextField>
	</Items>
	<Buttons>
		<ext:Button ID="ButtonRenameFileOK" runat="server" Text="<%$ Resources:StringDef, OK %>">
			<Listeners>
				<Click Fn="fileManRenameFile" />
			</Listeners>
		</ext:Button>
		<ext:Button ID="ButtonRenameFileCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
			<Listeners>
				<Click Handler="#{WindowRenameFile}.hide( );" />
			</Listeners>
		</ext:Button>
	</Buttons>
</ext:Window>

<ext:Window ID="WindowCreateDir" runat="server" Width="400" Height="110" Resizable="true" Title="<%$ Resources:StringDef, CreateDir %>"
	CloseAction="Hide" Padding="10" AnimateTarget="#{BtnCreateDir}"
	Hidden="true" Modal="true" ButtonAlign="Right" LabelWidth="50">
	<Items>
		<ext:TextField ID="TextCreateDir" runat="server" Width = "360" FieldLabel="<%$ Resources:StringDef, Name %>" >
		</ext:TextField>
		<ext:FileUploadField ID="FileUpload1" runat="Server" />
	</Items>
	<Buttons>
		<ext:Button ID="BtnCreateDirOK" runat="server" Text="<%$ Resources:StringDef, OK %>">
			<Listeners>
				<Click Fn="fileManCreateDir" />
			</Listeners>
		</ext:Button>
		<ext:Button ID="BtnCreateDirCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
			<Listeners>
				<Click Handler="#{WindowCreateDir}.hide( );" />
			</Listeners>
		</ext:Button>
	</Buttons>
</ext:Window>