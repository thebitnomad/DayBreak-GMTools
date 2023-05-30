<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_effstat, App_Web_effstat.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';

		var msgOpSuc		= '<%= Resources.StringDef.OpSuc %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var renderMsg = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var setEffStatMode = function( mode ) {
				Ext.net.DirectMethods.SetEffStatMode( mode, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
							setTimeout( "queryStatInfo( true );", 3000 );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};

			var queryStatInfo = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingStatInfo}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreStatInfo}.lastOptions ) {
					paramStart = #{StoreStatInfo}.lastOptions.params.start;
				}
			
				#{StoreStatInfo}.load( { params: { start: paramStart, limit: paramLimit } } );
			};
			
			var initData = function( ) {
				//setInterval( queryStatInfo, 30000 );
				setTimeout( "queryStatInfo( true );", 3000 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreStatInfo" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="StatInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelStatInfo}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Time" Mapping="Time" Type="String" />
					<ext:RecordField Name="Msg" Mapping="Msg" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:GridPanel ID="GridPanelStatInfo" runat="Server" Border="false" StoreID="StoreStatInfo" ColumnLines="true" AutoExpandColumn="Msg">
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
								<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="Time" Width="130" Align="Left" Sortable="false">
								</ext:Column>
								<ext:Column DataIndex="Msg" Align="Left" Sortable="false">
									<Renderer Fn="renderMsg" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<TopBar>
							<ext:Toolbar runat="Server">
								<Items>
									<ext:Button runat="Server" ID="BtnNormalStat" Text="<%$ Resources:StringDef, SetEffStatInfoNormal %>" Icon="ApplicationGet">
										<Listeners>
											<Click Handler="
												setEffStatMode( 1 );
											" />
										</Listeners>
									</ext:Button>
									<ext:Button runat="Server" ID="BtnDetailStat" Text="<%$ Resources:StringDef, SetEffStatInfoDetail %>" Icon="ApplicationViewDetail">
										<Listeners>
											<Click Handler="
												setEffStatMode( 2 );
											" />
										</Listeners>
									</ext:Button>
									<%--<ext:Button runat="Server" ID="BtnCloseStat">
										<Listeners>
											<Click Handler="
												setEffStatMode( 0 );
											" />
										</Listeners>
									</ext:Button>--%>
									<ext:ToolbarFill />
									<ext:Button runat="Server" ID="BtnRefresh" Text="<%$ Resources:StringDef, Refresh %>" Icon="ArrowRefresh">
										<Listeners>
											<Click Handler="
												queryStatInfo( );
											" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingStatInfo" runat="server" PageSize="50" StoreID="StoreStatInfo" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
