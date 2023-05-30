<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_dbinfo, App_Web_dbinfo.aspx.b81705c1" theme="default" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">

			var renderValue = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
		
			var nameKeywordFilter = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					applyVarFilter( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var valueKeywordFilter = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					applyVarFilter( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var applyVarFilter = function( ) {
				var filterFn = getVarRecordFilter( );
				if( filterFn )
					#{StoreVarInfo}.filterBy( filterFn );
				else
					#{StoreVarInfo}.clearFilter( false );
			};
			
			var getVarRecordFilter = function( ) {
				var filterArray = [];

				var keywordName = #{NameFilter}.getValue( );
				if( keywordName.length > 0 ) {
					filterArray.push({
						filter: function( record ) {
							return filterString( keywordName, 'Name', record );
						}
					});
				}
				
				var keywordValue = #{ValueFilter}.getValue( );
				if( keywordValue.length > 0 ) {
					filterArray.push({
						filter: function( record ) {
							return filterString( keywordValue, 'Value', record );
						}
					});
				}
				
				var len = filterArray.length;
				if( len == 0 )
					return null;
				
				return function( record ) {
					for( var nLoopCount = 0; nLoopCount < len; ++nLoopCount ) {
						if( !filterArray[nLoopCount].filter( record ) ) {
							return false;
						}
					}
					return true;
				};
			};
			
			var statVarNameKeywordFilter = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					applyStatFilter( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var statValueKeywordFilter = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					applyStatFilter( );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var applyStatFilter = function( ) {
				var filterFn = getStatRecordFilter( );
				if( filterFn )
					#{StoreStatInfo}.filterBy( filterFn );
				else
					#{StoreStatInfo}.clearFilter( false );
			};
			
			var getStatRecordFilter = function( ) {
				var filterArray = [];

				var statKeywordName = #{StatNameFilter}.getValue( );
				if( statKeywordName.length > 0 ) {
					filterArray.push({
						filter: function( record ) {
							return filterString( statKeywordName, 'VarName', record );
						}
					});
				}
				
				var statKeywordValue = #{StatValueFilter}.getValue( );
				if( statKeywordValue.length > 0 ) {
					filterArray.push({
						filter: function( record ) {
							return filterString( statKeywordValue, 'Value', record );
						}
					});
				}
				
				var len = filterArray.length;
				if( len == 0 )
					return null;
				
				return function( record ) {
					for( var nLoopCount = 0; nLoopCount < len; ++nLoopCount ) {
						if( !filterArray[nLoopCount].filter( record ) ) {
							return false;
						}
					}
					return true;
				};
			};
			
			var filterString = function( value, dataIndex, record ) {
				var val = record.get( dataIndex );
				return String( val ).toLowerCase( ).indexOf( value.toLowerCase( ) ) > -1;
			};
			
			var storeVarInfoLoad = function( ) {
				applyVarFilter( );
			};
			
			var storeStatInfoLoad = function( ) {
				applyStatFilter( );
			};

			var initData = function( ) {
				#{StoreProcList}.load( )
				#{StoreVarInfo}.load( );
				#{StoreStatInfo}.load( );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreProcList" runat="server" RemoteSort="false" RemotePaging="true" OnRefreshData="ProcListRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelProcList}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="User" Mapping="User" Type="String" />
					<ext:RecordField Name="Host" Mapping="Host" Type="String" />
					<ext:RecordField Name="Database" Mapping="Database" Type="String" />
					<ext:RecordField Name="Command" Mapping="Command" Type="String" />
					<ext:RecordField Name="Time" Mapping="Time" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="String" />
					<ext:RecordField Name="Info" Mapping="Info" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreVarInfo" runat="server" RemoteSort="false" RemotePaging="true" OnRefreshData="VarInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelVarInfo}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Listeners>
			<Load Fn="storeVarInfoLoad" />
		</Listeners>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="Value" Mapping="Value" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreStatInfo" runat="server" RemoteSort="false" RemotePaging="true" OnRefreshData="StatInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelStatInfo}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Listeners>
			<Load Fn="storeStatInfoLoad" />
		</Listeners>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="VarName" Mapping="VarName" Type="String" />
					<ext:RecordField Name="Value" Mapping="Value" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanelInfo" runat="Server" Border="false" TabPosition="Bottom" DeferredRender="false">
						<Items>
							<ext:GridPanel ID="GridPanelProcList" runat="Server" StoreID="StoreProcList" ColumnLines="true"
								Title="<%$ Resources:StringDef, ProcList %>" AutoExpandColumn="Info">
								<View>
									<ext:GridView ID="GridView2" runat="Server">
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
										<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="60" Align="Left">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, User %>" DataIndex="User" Width="120" Align="Left">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Host %>" DataIndex="Host" Width="150">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Database %>" DataIndex="Database" Width="100">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="Time" Width="60">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="180">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Info %>" DataIndex="Info">
										</ext:Column>
									</Columns>
								</ColumnModel>
								<BottomBar>
									<ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="2000" StoreID="StoreProcList" />
								</BottomBar>
								<SelectionModel>
									<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server">
									</ext:RowSelectionModel>
								</SelectionModel>
							</ext:GridPanel>
							
							<ext:GridPanel ID="GridPanelVarInfo" runat="Server" StoreID="StoreVarInfo" ColumnLines="true"
								Title="<%$ Resources:StringDef, VarInfo %>" AutoExpandColumn="Value">
								<View>
									<ext:GridView ID="GridView1" runat="Server">
										<HeaderRows>
											<ext:HeaderRow>
												<Columns>
													<ext:HeaderColumn>
														<Component>
															<ext:Label ID="Label1" runat="Server" />
														</Component>
													</ext:HeaderColumn>
													<ext:HeaderColumn Cls="x-small-editor">
														<Component>
															<ext:TextField ID="NameFilter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
																<Listeners>
																	<SpecialKey Fn="nameKeywordFilter" />
																</Listeners>
															</ext:TextField>
														</Component>
													</ext:HeaderColumn>
													<ext:HeaderColumn Cls="x-small-editor">
														<Component>
															<ext:TextField ID="ValueFilter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
																<Listeners>
																	<SpecialKey Fn="valueKeywordFilter" />
																</Listeners>
															</ext:TextField>
														</Component>
													</ext:HeaderColumn>	
												</Columns>
											</ext:HeaderRow>
										</HeaderRows>
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
										<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="300" Align="Left">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Value %>" DataIndex="Value" Align="Left">
											<Renderer Fn="renderValue" />
										</ext:Column>
									</Columns>
								</ColumnModel>
								<BottomBar>
									<ext:PagingToolbar ID="PagingVarInfo" runat="server" PageSize="2000" StoreID="StoreVarInfo" />
								</BottomBar>
								<SelectionModel>
									<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
									</ext:RowSelectionModel>
								</SelectionModel>
							</ext:GridPanel>
							
							<ext:GridPanel ID="GridPanelStatInfo" runat="Server" StoreID="StoreStatInfo" ColumnLines="true"
								Title="<%$ Resources:StringDef, StatInfo %>" AutoExpandColumn="Value">
								<View>
									<ext:GridView ID="GridView3" runat="Server">
										<HeaderRows>
											<ext:HeaderRow>
												<Columns>
													<ext:HeaderColumn>
														<Component>
															<ext:Label runat="Server" />
														</Component>
													</ext:HeaderColumn>
													<ext:HeaderColumn Cls="x-small-editor">
														<Component>
															<ext:TextField ID="StatNameFilter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
																<Listeners>
																	<SpecialKey Fn="statVarNameKeywordFilter" />
																</Listeners>
															</ext:TextField>
														</Component>
													</ext:HeaderColumn>
													<ext:HeaderColumn Cls="x-small-editor">
														<Component>
															<ext:TextField ID="StatValueFilter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
																<Listeners>
																	<SpecialKey Fn="statValueKeywordFilter" />
																</Listeners>
															</ext:TextField>
														</Component>
													</ext:HeaderColumn>	
												</Columns>
											</ext:HeaderRow>
										</HeaderRows>
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
										<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="VarName" Width="300" Align="Left">
										</ext:Column>
										<ext:Column Header="<%$ Resources:StringDef, Value %>" DataIndex="Value" Align="Left">
											<Renderer Fn="renderValue" />
										</ext:Column>
									</Columns>
								</ColumnModel>
								<BottomBar>
									<ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="2000" StoreID="StoreStatInfo" />
								</BottomBar>
								<SelectionModel>
									<ext:RowSelectionModel ID="RowSelectionModel3" runat="Server">
									</ext:RowSelectionModel>
								</SelectionModel>
							</ext:GridPanel>
						</Items>
					</ext:TabPanel>			
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
