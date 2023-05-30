<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_eventlog, App_Web_eventlog.aspx.b81705c1" validaterequest="false" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgProcessing	= '<%= Resources.StringDef.Processing %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgEvtLevelNormal		= '<%= Resources.StringDef.EvtLevelNormal %>';
		var msgEvtLevelImportant	= '<%= Resources.StringDef.EvtLevelImportant %>';
		var msgEvtLevelException	= '<%= Resources.StringDef.EvtLevelException %>';
		var msgEvtLevelError		= '<%= Resources.StringDef.EvtLevelError %>';
		var msgDelEventLogPrompt	= '<%= Resources.StringDef.MsgDelEventLogPrompt %>';

		var msgQueryConditionCanNotBeNull = '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ggId		= 0;			//选择的服务器ID
			
			var renderLevel = function( value, metadata, record, rowIndex, colIndex, store ) {
				var levelText = '';
				switch( value ) {
					case 0:
						levelText = msgEvtLevelNormal;
						break;
					case 1:
						levelText = msgEvtLevelImportant;
						break;
					case 2:
						levelText = msgEvtLevelException;
						break;
					case 3:
						levelText = msgEvtLevelError;
						break;
				}
				
				return levelText;
			};
			
			var renderMsg = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
			
			var storeEventLogGetQueryParams = function( store, options ) {
				var svrId			= svrComboGetSelectedSvrId( );
				var startTime		= #{DateFieldStartTime}.getValue( );
				var endTime			= #{DateFieldEndTime}.getValue( );
				var keywordMsg1		= #{Msg1Filter}.getValue( );
				var keywordUser		= #{UserFilter}.getValue( );
				var eventId			= #{EventFilter}.getValue( );
				
				options.params.SvrId			= m_ggId ? m_ggId : svrId;
				options.params.StartTime		= startTime;
				options.params.EndTime			= endTime;
				options.params.Msg1				= keywordMsg1;
				options.params.User				= keywordUser;
				options.params.EventId			= eventId;
			};
		
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingEventLog}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreEventLog}.lastOptions ) {
					paramStart = #{StoreEventLog}.lastOptions.params.start;
				}
				
				#{StoreEventLog}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelEventLog}.setVisible( true );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var deleteEventLog = function( ) {
				var selItems = #{GridPanelEventLog}.getSelectionModel( ).getSelections( );
				if( selItems ) {
					var idValue = '';
					for( var nLoopCount = 0; nLoopCount < selItems.length; ++nLoopCount ) {
						var record = selItems[nLoopCount];
						
						idValue += record.get( 'Id' );
						if( nLoopCount != selItems.length -1 )
							idValue += ',';
					}
					
					showConfirmMsg( msgTitle, msgDelEventLogPrompt, function( btn ){
						if( btn == "yes" ) {
							Ext.net.DirectMethods.DeleteEventLog( idValue, {
								eventMask: {
									showMask: true,
									minDelay: 200,
									msg: msgProcessing
								},
								success: function( result ){
									if( result.Success ) {
										btnQueryClick( );
									}
									else if( result.ErrorMessage ) {
										showErrMsg( msgTitle, result.ErrorMessage );
									}
								}
							});
						}
					});
				}
			};
			
			var exportEventLog = function( ) {
				#{GridPanelEventLog}.submitData(false);
			};
			
			var gridEventSelectionChange = function( el ) {
				#{BtnDel}.setDisabled( el.getCount( ) < 1 );
			};
			
			var initData = function( ) {
				#{StoreEvent}.load( { 
					callback : function( ) {
						btnQueryClick( true );
						if( #{StoreEvent}.data.length > 0 ) {
							#{EventFilter}.setValue( #{StoreEvent}.data.items[0].data.EventID );
						}
					}
				} );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreEventLog" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="EventLogRefresh" OnSubmitData="EventLogSubmit" AutoLoad="false">
		<DirectEventConfig IsUpload="true">
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeEventLogGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="EventID" Mapping="EventID" Type="String" />
					<ext:RecordField Name="Level" Mapping="Level" Type="Int" />
					<ext:RecordField Name="RefID" Mapping="RefID" Type="Int" />
					<ext:RecordField Name="Msg1" Mapping="Msg1" Type="String" />
					<ext:RecordField Name="Msg2" Mapping="Msg2" Type="String" />
					<ext:RecordField Name="Msg3" Mapping="Msg3" Type="String" />
					<ext:RecordField Name="Time" Mapping="Time" Type="String" />
					<ext:RecordField Name="Oper" Mapping="Oper" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="Id" Direction="DESC" />
	</ext:Store>
	
	<ext:Store ID="StoreEvent" runat="server" AutoLoad="false" OnRefreshData="EventRefresh">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="EventID" Mapping="EventID" Type="Int" />
					<ext:RecordField Name="EvtDesc" Mapping="EvtDesc" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="160" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:DateField ID="DateFieldStartTime" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="276">
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="276">
							</ext:DateField>
						</Items>
						<Buttons>
							<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Query %>">
								<Listeners>
									<Click Fn="btnQueryClick" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelEventLog" runat="Server" Border="true" StoreID="StoreEventLog" ColumnLines="true"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>" AutoExpandColumn="Msg1">
						<View>
							<ext:GridView ID="GroupingView1" runat="server" MarkDirty="false">
								<CustomConfig>
									<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
								</CustomConfig>
								<HeaderRows>
									<ext:HeaderRow>
										<Columns>
											<ext:HeaderColumn>
												<Component>
													<ext:Label runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:Label runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:Label ID="Label2" runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:ComboBox ID="EventFilter" runat="server" StoreID="StoreEvent" Editable="false" ValueField="EventID" DisplayField="EvtDesc" ForceSelection="true" Mode="Local" >
														<Listeners>
															<Select Handler="
																btnQueryClick( true );
															" />
														</Listeners>
													</ext:ComboBox>
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:Label runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn Cls="x-small-editor">
												<Component>
													<ext:TextField ID="Msg1Filter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
														<Listeners>
															<SpecialKey Fn="textFieldQuerySpecialKey" />
														</Listeners>
													</ext:TextField>
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn Cls="x-small-editor">
												<Component>
													<ext:TextField ID="UserFilter" runat="server" EmptyText="<%$ Resources:StringDef, Keyword %>">
														<Listeners>
															<SpecialKey Fn="textFieldQuerySpecialKey" />
														</Listeners>
													</ext:TextField>
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:Label ID="Label1" runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn>
												<Component>
													<ext:Label runat="Server" />
												</Component>
											</ext:HeaderColumn>
										</Columns>
									</ext:HeaderRow>
								</HeaderRows>
							</ext:GridView>
						</View>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="40" Align="Left">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="Time" Width="130" Align="Left">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Event %>" DataIndex="EventID" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Level %>" DataIndex="Level" Width="60" Align="Center">
									<Renderer Fn="renderLevel" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Message %>" DataIndex="Msg1" Align="Left" Sortable="false">
									<Renderer Fn="renderMsg" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, User %>" DataIndex="Oper" Width="100" Align="Left" Sortable="false">
								</ext:Column>
								<ext:Column DataIndex="Msg2" Width="150" Align="Left" Sortable="false" Hidden="true">
									<Renderer Fn="renderMsg" />
								</ext:Column>
								<ext:Column DataIndex="Msg3" Width="150" Align="Left" Sortable="false" Hidden="true">
									<Renderer Fn="renderMsg" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingEventLog" runat="server" PageSize="50" StoreID="StoreEventLog">
								<Items>
									<ext:ToolbarSeparator />
									<ext:Button runat="Server" ID="BtnDel" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteEventLog" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSeparator />
									<ext:Button runat="Server" ID="BtnExport" Icon="PageCode">
										<Listeners>
											<Click Fn="exportEventLog" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridEventSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<%--<ext:ToolTip ID="ToolTipMsg" runat="server" Target="#{GridPanelEventLog}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" Width="300">
		<Listeners>
			<Show Fn="showMsgTip" />
		</Listeners>
	</ext:ToolTip>--%>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

