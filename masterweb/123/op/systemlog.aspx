<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_systemlog, App_Web_systemlog.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" runat="server">
	<script type="text/javascript">
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			
			var m_ggId		= 0;			//选择服务器ID
			
			var storeSysEventLogGetQueryParams = function( store, options ) {
				debugger
				var svrId						= svrComboGetSelectedSvrId( );
				var startTime					= #{DateFieldStartTime}.getValue( );
				var endTime						= #{DateFieldEndTime}.getValue( );
				var keywordMsg					= #{SysLogMessageFilter}.getValue( );
				var eventId						= #{SysEventFilter}.getValue( );
				
				options.params.SvrId			= m_ggId ? m_ggId : svrId;
				options.params.StartTime		= startTime;
				options.params.EndTime			= endTime;
				options.params.LogMessage       = keywordMsg;
				options.params.EventId          = eventId;
			}
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingSysEventLog}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreSysEventLog}.lastOptions ) {
					paramStart = #{StoreSysEventLog}.lastOptions.params.start;
				}
				
				#{StoreSysEventLog}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelSysEventLog}.setVisible( true );
				} } );
			};
			
			var textFieldQuerySpecialKey = function(textField, e) {
				if (e.getKey() == Ext.EventObject.ENTER) {
					btnQueryClick(true);

					e.stopEvent();
				}
			};
			
			var initData = function( ) {
				#{StoreEvent}.load({
					callback : function( ) {
						btnQueryClick( true );
						if( #{StoreEvent}.data.length > 0 ) {
							#{SysEventFilter}.setValue( #{StoreEvent}.data.items[0].data.EventID );
						}
					}
				});
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
	<ext:Store ID="StoreSysEventLog" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="SysEventLogRefresh" AutoLoad="false">
		<DirectEventConfig IsUpload="true">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>"/>
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad  Fn="storeSysEventLogGetQueryParams"/>
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int"/>
					<ext:RecordField Name="LogTime" Mapping="LogTime" Type="String" />
					<ext:RecordField Name="EventID" Mapping="EventID" Type="String"/>
					<ext:RecordField Name="LogMessage" Mapping="LogMessage" Type="String"/>
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="Id" Direction="DESC" />
	</ext:Store> 
	
	<ext:Store ID="StoreEvent" runat="Server" AutoLoad="false" OnRefreshData="SysEventRefresh">
		<DirectEventConfig>
			<EventMask  ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>"/>
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="EventID" Mapping="EventID" Type="Int"/>
					<ext:RecordField Name="EvtDesc" Mapping="EvtDesc" Type="String"/>
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;">
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
					<ext:GridPanel ID="GridPanelSysEventLog" runat="Server" Border="true" StoreID="StoreSysEventLog" ColumnLines="true"
						Margins="10px 10px 10px 10px" Hidden="true" AutoExpandColumn="LogMessage" >
						<View>
							<ext:GridView ID="GridView1" runat="Server" MarkDirty="false">
								<CustomConfig>
								<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw"/>
							</CustomConfig>
							<HeaderRows>
								<ext:HeaderRow>
									<Columns>
										<ext:HeaderColumn >
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
												<ext:ComboBox ID="SysEventFilter" runat="Server" StoreID="StoreEvent" Editable="false" ValueField="EventID" DisplayField="EvtDesc" ForceSelection="true" Mode="Local">
													<Listeners>
														<Select Handler="btnQueryClick( true );"/>
													</Listeners>
												</ext:ComboBox>
											</Component>
										</ext:HeaderColumn>
										<ext:HeaderColumn Cls="x-small-editor">
											<Component>
												<ext:TextField ID="SysLogMessageFilter" runat="Server" EmptyText="<%$ Resources:StringDef, Keyword %>">
													<Listeners>
														<SpecialKey Fn="textFieldQuerySpecialKey" />
													</Listeners>
												</ext:TextField>
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
								<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="70" Align="Left">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef,Time %>" DataIndex="LogTime" Width="200" Align="Left" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef,Event %>" DataIndex="EventID" Width="200" Align="Left">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef,SysLogMessage %>" DataIndex="LogMessage" Align="Left" Sortable="false">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolBar ID="PagingSysEventLog" runat="server" PageSize="50" StoreID="StoreSysEventLog">
							</ext:PagingToolBar>
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
