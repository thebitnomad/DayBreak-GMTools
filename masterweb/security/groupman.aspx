<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="security_groupman, App_Web_groupman.aspx.cecc3084" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgAddGroup		= '<%= Resources.StringDef.AddGroup %>';
		var msgModifyGroup	= '<%= Resources.StringDef.ModifyGroup %>';
		var msgRemoveGroupConfirm	= '<%= Resources.StringDef.MsgRemoveGroupConfirm %>';
		var removeGroupConfirmTitle	= '<%= Resources.StringDef.RemoveGroup %>';
		var groupMemberFormat		= '<%= Resources.StringDef.GroupMemListFormat %>';
		var msgAddUserToGroupPrompt	= '<%= Resources.StringDef.MsgAddUserToGroupPrompt %>';
		var msgMultiSelPrompt		= '<%= Resources.StringDef.MsgMultiSelPrompt %>';
	</script>
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var operation = 0;				//操作：0表示新加，1表示修改。
			
			var renderFlag = function( value, metadata, record, rowIndex, colIndex, store ) {
				var flag = record.get( 'Flag' );
				
				var flagDesc = '';
				
				return flagDesc;
			};
			
			var removeGroups = function( ) {
				var grid = #{GridPanelGroup};
				var records = grid.getSelectionModel( ).getSelections( );
				
				var ids = '';
				for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
					ids += records[nLoopCount].data.Id;
					ids += ',';
				}
				
				var result = showConfirmMsg( removeGroupConfirmTitle, msgRemoveGroupConfirm, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.RemoveGroups( ids, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ){
								if( result.Success ){
									queryGroup( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var setGroup = function( ) {
				Ext.net.DirectMethods.SetGroup( operation, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ){
						if( result.Success ){
							#{WindowGroup}.hide( );
							queryGroup( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var addGroup = function( ) {
				#{FormPanelGroup}.reset( );
				#{TextFieldGroupName}.setDisabled( false );
				
				#{ButtonSetGroup}.setText( msgOK );
				#{WindowGroup}.setTitle( msgAddGroup );
				#{WindowGroup}.show( );
				
				operation = 0;
			};
			
			var modifyGroup = function( ) {
				#{TextFieldGroupName}.setDisabled( true );
			
				var record = #{GridPanelGroup}.getSelectionModel( ).getSelected( );
				showDetail( record );
				
				operation = 1;
			};
			
			var showDetail = function( record ) {
				#{TextFieldGroupId}.setValue( record.data.Id );
				#{TextFieldGroupName}.setValue( record.data.Name );
				#{TextFieldGroupComment}.setValue( record.data.Comment );
				
				#{ButtonSetGroup}.setText( msgSave );
				#{WindowGroup}.setTitle( msgModifyGroup );
				#{WindowGroup}.show( );
			};
			
			var gridRowDBClick = function( grid, rowIndex, e ) {
				#{TextFieldGroupName}.setDisabled( true );
			
				var record = grid.store.getAt( rowIndex );
				showDetail( record );
				
				operation = 1;
			};
			
			var showGroupFlag = function( ) {
				var rowIndex = #{GridPanelGroup}.view.findRowIndex( this.triggerElement );
				var cellIndex = #{GridPanelGroup}.view.findCellIndex( this.triggerElement );
				var fieldName = #{GridPanelGroup}.getColumnModel( ).getDataIndex( cellIndex );
				var record = #{StoreGroupData}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				var flag = record.get( fieldName );
				
				if( fieldName == "Flag" ) {
					var flagDesc = '';
					if( ( flag & 1 ) > 0 ) {
						flagDesc += "<li>" + msgGroupFlagArtDesc + "</li>"
					}
					if( flagDesc.length > 0 )
						this.body.dom.innerHTML = flagDesc;
					else
						this.hide( );
				} else {
					this.hide( );
				}
			};
			
			var hideGroupWin = function( ) {
				#{WindowGroup}.hide( );
			};
			
			var hideGroupUserWin = function( ) {
				#{WindowGroupUser}.hide( );
			};
			
			var configUsers = function( ) {
				var grid = #{GridPanelGroup};
				var record = grid.getSelectionModel( ).getSelected( );
				
				Ext.net.DirectMethods.LoadGroupUserInfo( record.data.Id, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ){
						if( result.Success ){
							#{StoreGroupUser}.loadData( result.Result.GroupUserData );
							#{StoreGroupUserLeft}.loadData( result.Result.GroupLeftUserData );

							#{TextFieldGroupUserKeywords}.reset( );
							#{TextFieldGroupLeftUserKeywords}.reset( );
							#{TextFieldGroupUserKeywords}.triggers[0].hide( );
							#{TextFieldGroupLeftUserKeywords}.triggers[0].hide( );

							var titleGroupMem = String.format( groupMemberFormat, record.data.Name, record.data.Comment );
							#{GridPanelGroupUser}.setTitle( titleGroupMem );
							#{WindowGroupUser}.show( );
						}
						else {
							if( result.ErrorMessage )
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var saveGroupUserInfo = function( ) {
				var userIdAddInfo = "";
				#{TextFieldGroupUserKeywords}.reset( );
				#{StoreGroupUser}.clearFilter( false );
				for( var nLoopCount = 0; nLoopCount < #{StoreGroupUser}.data.items.length; ++nLoopCount ) {
					if( userIdAddInfo.length == 0 )
						userIdAddInfo += #{StoreGroupUser}.data.items[nLoopCount].data.Id;
					else
						userIdAddInfo += "," + #{StoreGroupUser}.data.items[nLoopCount].data.Id;
				}
				
				var userIdRemoveInfo = "";
				#{TextFieldGroupLeftUserKeywords}.reset( );
				#{StoreGroupUserLeft}.clearFilter( false );
				for( var nLoopCount = 0; nLoopCount < #{StoreGroupUserLeft}.data.items.length; ++nLoopCount ) {
					if( userIdRemoveInfo.length == 0 )
						userIdRemoveInfo += #{StoreGroupUserLeft}.data.items[nLoopCount].data.Id;
					else
						userIdRemoveInfo += "," + #{StoreGroupUserLeft}.data.items[nLoopCount].data.Id;
				}
				
				var grid = #{GridPanelGroup};
				var record = grid.getSelectionModel( ).getSelected( );
				Ext.net.DirectMethods.SaveGroupUserInfo( record.data.Id, userIdAddInfo, userIdRemoveInfo, {
					eventMask: {
						showMask: true,
						minDelay: 500,
						msg: msgSaving
					},
					success: function( result ){
						if( result.Success ){
							hideGroupUserWin( );
							queryGroup( );
						}
						else{
							if( result.ErrorMessage )
								showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var queryGroup = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingToolbarGroup}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreGroupData}.lastOptions ) {
					paramStart = #{StoreGroupData}.lastOptions.params.start;
				}
				#{StoreGroupData}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var gridGroupSelectionChange = function( el ) {
				#{TbarButtonModifyGroup}.setDisabled( el.getCount( ) < 1 );
				#{TbarButtonRemoveGroup}.setDisabled( el.getCount( ) < 1 );
				#{TbarButtonConfigUsers}.setDisabled( el.getCount( ) < 1 );
			};
			
			var notifyDropRmvUser = function( ddSource, e, data ) {
				Ext.each( ddSource.dragData.selections, function( record ) {
					addRow( #{StoreGroupUserLeft}, record, ddSource );
				});
				
				#{StoreGroupUserLeft}.sort( #{StoreGroupUserLeft}.sortInfo.field, #{StoreGroupUserLeft}.sortInfo.direction );
				return true;
			};
		
			var notifyDropAddUser = function( ddSource, e, data ) {
				Ext.each( ddSource.dragData.selections, function( record ) {
					addRow( #{StoreGroupUser}, record, ddSource );
				});
				
				#{StoreGroupUser}.sort( #{StoreGroupUser}.sortInfo.field, #{StoreGroupUser}.sortInfo.direction );
				return true;
			};
			
			var addRow = function( store, record, ddSource ) {
				// Search for duplicates
				var foundItem = store.findExact( 'Id' , record.data.Id );
				
				// if not found
				if( foundItem  == -1 ) {
					//Remove Record from the source
					ddSource.grid.store.remove( record );
					store.add( record );
				}
			};
			
			/* 过滤功能 */
			var groupLeftUserKeywordFilter = function( textField, e ) {
				applyGroupLeftUserFilter( );
				
				if( Ext.isWebKit )
					e.stopEvent( );
			};
			
			var groupUserKeywordFilter = function( textField, e ) {
				applyGroupUserFilter( );
					
				if( Ext.isWebKit )
					e.stopEvent( );
			};
			
			var applyGroupLeftUserFilter = function( ) {
				var filterFn = getGroupLeftUserRecordFilter( );
				if( filterFn ) {
					#{StoreGroupUserLeft}.filterBy( filterFn );
					#{TextFieldGroupLeftUserKeywords}.triggers[0].show( );
				}
				else {
					#{StoreGroupUserLeft}.clearFilter( false );
					#{TextFieldGroupLeftUserKeywords}.triggers[0].hide( );
				}
			};
			
			var applyGroupUserFilter = function( ) {
				var filterFn = getGroupUserRecordFilter( );
				if( filterFn ) {
					#{StoreGroupUser}.filterBy( filterFn );
					#{TextFieldGroupUserKeywords}.triggers[0].show( );
				}
				else {
					#{StoreGroupUser}.clearFilter( false );
					#{TextFieldGroupUserKeywords}.triggers[0].hide( );
				}
			};
			
			var getGroupUserRecordFilter = function( ) {
				var keywords = #{TextFieldGroupUserKeywords}.getValue( );
				if( keywords.length > 0 )
					return function( record ) { 
						return filterString( keywords, 'UserName', record ) || filterString( keywords, 'RealName', record );
					}
				else
					return null;
			};
			
			var getGroupLeftUserRecordFilter = function( ) {
				var keywords = #{TextFieldGroupLeftUserKeywords}.getValue( );
				if( keywords.length > 0 )
					return function( record ) {
						return filterString( keywords, 'UserName', record ) || filterString( keywords, 'RealName', record );
					}
				else
					return null;
			};
			
			var filterString = function( value, dataIndex, record ) {
				var val = record.get( dataIndex );
				if( typeof val != "string" ) {
					return value.length == 0;
				}
				return val.toLowerCase( ).indexOf( value.toLowerCase( ) ) > -1;
			};
			
			var groupLeftUserTriggerClick = function( item, trigger, index, tag, e ) {
				item.reset( );
				trigger.hide( );
				
				#{StoreGroupUserLeft}.clearFilter( false );
			};
			
			var groupUserTriggerClick = function( item, trigger, index, tag, e ) {
				item.reset( );
				trigger.hide( );
				
				#{StoreGroupUser}.clearFilter( false );
			};
			
			var showMultiSelMsg = function( ) {
				showNotification( msgMultiSelPrompt );
			};

		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreGroupData" runat="server" OnRefreshData="GroupDataRefresh" RemoteSort="true" RemotePaging="true" AutoLoad="false">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelGroup}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<SortInfo Field="Name" Direction="ASC" />
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="Flag" Mapping="Flag" Type="Int" />
					<ext:RecordField Name="UserInfo" Mapping="UserInfo" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreGroupUserLeft" runat="server">
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="RealName" Mapping="RealName" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
		<CustomConfig>
			<ext:ConfigItem Name="applySort" Value="storeSortFixedFunc" />
		</CustomConfig>
		<SortInfo Field="UserName" Direction="ASC" />
	</ext:Store>
	
	<ext:Store ID="StoreGroupUser" runat="server">
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="RealName" Mapping="RealName" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
		<CustomConfig>
			<ext:ConfigItem Name="applySort" Value="storeSortFixedFunc" />
		</CustomConfig>
		<SortInfo Field="UserName" Direction="ASC" />
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="server">
				<Center>
					<ext:GridPanel ID="GridPanelGroup" runat="server" StoreID="StoreGroupData" AutoExpandColumn="UserInfo" 
						Border="false" MaskDisabled="false">
						<View>
							<ext:GridView ID="GridView1" runat="server" MarkDirty="true" />
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="TbarButtonAddGroup" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="GroupAdd" >
										<Listeners>
											<Click Fn="addGroup" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="TbarButtonModifyGroup" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="GroupEdit" Disabled="true" >
										<Listeners>
											<Click Fn="modifyGroup" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="TbarButtonRemoveGroup" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true" >
										<Listeners>
											<Click Fn="removeGroups" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator />
									<ext:Button ID="TbarButtonConfigUsers" runat="server" Text="<%$ Resources:StringDef, ConfigUsers %>" Icon="UserAdd" Disabled="true" >
										<Listeners>
											<Click Fn="configUsers" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarFill />
									<%--<ext:Button ID="TbarButtonRefresh" runat="server" Text="<%$ Resources:StringDef, Refresh %>" Icon="TableRefresh" >
										<Listeners>
											<Click Handler="queryGroup( true );" />
										</Listeners>
									</ext:Button>--%>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingToolbarGroup" runat="server" PageSize="50" StoreID="StoreGroupData" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel runat="server" SingleSelect="false">
								<Listeners>
									<SelectionChange Fn="gridGroupSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn />
								<ext:Column ColumnID="Id" Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="50" Sortable="true" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, GroupName %>" DataIndex="Name" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Comment %>" DataIndex="Comment" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, UserInfo %>" DataIndex="UserInfo" Sortable="false">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<Listeners>
							<RowDblClick Fn="gridRowDBClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:ToolTip ID="ToolTipFlag" runat="server" Target="#{GridPanelGroup}.getView( ).mainBody"
		Delegate=".x-grid3-cell">
		<Listeners>
			<Show Fn="showGroupFlag" />
		</Listeners>
	</ext:ToolTip>
	
	<ext:Window ID="WindowGroup" runat="server" Resizable="false" Width="400" AutoHeight="true"
		Title="<%$ Resources:StringDef, GroupInfo %>" CloseAction="Hide" Hidden="true"
		AnimateTarget="#{TbarButtonAddGroup}" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelGroup" runat="server" ButtonAlign="Right" PaddingSummary="10 0 5 0"
				LabelWidth="120" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldGroupId" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, Id %>" Hidden="true" >
					</ext:TextField>
					<ext:TextField ID="TextFieldGroupName" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, GroupName %>"
						AllowBlank="false" BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>" MsgTarget="Side">
					</ext:TextField>
					<ext:TextField ID="TextFieldGroupComment" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, Comment %>"
						BlankText="<%$ Resources:StringDef,FieldCanNotBeNull %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonSetGroup" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setGroup" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="ButtonSetCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Fn="hideGroupWin" />
				</Listeners>
			</ext:Button>
		</Buttons>
		<Listeners>
			<Show Handler="#{TextFieldGroupName}.focus( );" Delay="50" />
		</Listeners>
	</ext:Window>
	
	<ext:Window ID="WindowGroupUser" runat="Server" Title="<%$ Resources:StringDef, ConfigUsers %>"
		CloseAction="Hide" Hidden="true" Width="600" Height="450" AnimateTarget="#{TbarButtonConfigUsers}"
		Modal="true" BodyBorder="false" Resizable="false">
		<Items>
			<ext:BorderLayout ID="BorderLayoutGroupUser" runat="server">
				<West>
					<ext:GridPanel ID="GridPanelGroupUser" runat="server" DDGroup="firstGridDDGroup" StoreID="StoreGroupUser"
						EnableDragDrop="true" StripeRows="true" Width="300" Title="<%$ Resources:StringDef, ConfigUsers %>" AutoExpandColumn="RealName">
						<ColumnModel>
							<Columns>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" Width="50" DataIndex="Id" Hidden="true" />
								<ext:Column Header="<%$ Resources:StringDef, UserName %>" Width="140" DataIndex="UserName" />
								<ext:Column Header="<%$ Resources:StringDef, RealName %>" DataIndex="RealName" />
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel runat="server" />
						</SelectionModel>
						<BottomBar>
							<ext:Toolbar ID="Toolbar3" runat="server">
								<Items>
									<ext:TriggerField ID="TextFieldGroupUserKeywords" runat="server" Width="294" EmptyText="<%$ Resources:StringDef, QuickSearch %>" EnableKeyEvents="true">
										<Triggers>
											<ext:FieldTrigger Icon="Clear" HideTrigger="true" />
										</Triggers>
										<Listeners>
											<KeyUp Fn="groupUserKeywordFilter" />
											<TriggerClick Fn="groupUserTriggerClick" />
										</Listeners>
									</ext:TriggerField>
								</Items>
							</ext:Toolbar>
						</BottomBar>
					</ext:GridPanel>
				</West>
				<Center MarginsSummary="0 0 0 5">
					<ext:GridPanel ID="GridPanelLeftUser" runat="server" DDGroup="secondGridDDGroup" Width="290" StoreID="StoreGroupUserLeft"
						EnableDragDrop="true" StripeRows="true" Title="<%$ Resources:StringDef, NonmemberList %>" AutoExpandColumn="RealName">
						<ColumnModel>
							<Columns>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" Width="50" DataIndex="Id" Hidden="true" />
								<ext:Column Header="<%$ Resources:StringDef, UserName %>" Width="140" DataIndex="UserName" />
								<ext:Column Header="<%$ Resources:StringDef, RealName %>" DataIndex="RealName" />
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel runat="server" />
						</SelectionModel>
						<BottomBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:TriggerField ID="TextFieldGroupLeftUserKeywords" runat="server" Width="277" EmptyText="<%$ Resources:StringDef, QuickSearch %>" EnableKeyEvents="true">
										<Triggers>
											<ext:FieldTrigger Icon="Clear" HideTrigger="true" />
										</Triggers>
										<Listeners>
											<KeyUp Fn="groupLeftUserKeywordFilter" />
											<TriggerClick Fn="groupLeftUserTriggerClick" />
										</Listeners>
									</ext:TriggerField>
								</Items>
							</ext:Toolbar>
						</BottomBar>
					</ext:GridPanel>
				</Center>
				<South MarginsSummary="3 3 1 3">
					<ext:Label runat="Server" Text="<%$ Resources:StringDef, MsgAddUserToGroupPrompt %>" />
				</South>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="Button1" runat="server" Text="<%$ Resources:StringDef, Save %>">
				<Listeners>
					<Click Fn="saveGroupUserInfo" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button2" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Fn="hideGroupUserWin" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:DropTarget ID="DropTarget1" runat="server" Target="#{GridPanelLeftUser}.view.scroller.dom" Group="firstGridDDGroup">
		<NotifyDrop Fn="notifyDropRmvUser" />
	</ext:DropTarget>       
	<ext:DropTarget ID="DropTarget2" runat="server" Target="#{GridPanelGroupUser}.view.scroller.dom" Group="secondGridDDGroup">
		<NotifyDrop Fn="notifyDropAddUser" />
	</ext:DropTarget>
</asp:Content>
