<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_questionstat, App_Web_questionstat.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrSel" Src="~/common/svrsel.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';

		var msgReplyCanNotBeNull		= '<%= Resources.StringDef.MsgReplyCanNotBeNull %>';
		var msgReplySuccess				= '<%= Resources.StringDef.MsgReplySuccess %>';
		var msgDeleteSuccess			= '<%= Resources.StringDef.MsgDeleteSuccess %>';
		var msgQuestionSummaryFormat	= '<%= Resources.StringDef.MsgQuestionSummaryFormat %>';
		var msgAssignedQuestion			= '<%= Resources.StringDef.AssignedQuestion %>';
		var msgExpiryDateFormat			= '<%= Resources.StringDef.MsgExpiryDateFormat %>';

		var msgStatStateUnknown			= '<%= Resources.StringDef.Unknown %>';
		var msgStatStateSuc				= '<%= Resources.StringDef.QuerySuc %>';
		var msgStatStateFail			= '<%= Resources.StringDef.QueryFail %>';
		var msgStatStateTimeout			= '<%= Resources.StringDef.QueryTimeout %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var m_startTime;
			var m_endTime;
			var m_gamegroupId;
			var m_infoDel;
		
			var renderDateTime = function( value, metadata, record, rowIndex, colIndex, store ) {
				return value.replace( / /g, "<br />" );
			};
			
			var renderContent = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
			
			var renderPercent = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value > 0 ) {
					return ( ( record.data.ReplyCount / value ) * 100 ).toFixed( 2 ) + '%';
				} else {
					return 'N/A';
				}
			};
			
			var gridQuestionSelectionChange = function( el ) {
			};
			
			var getQuestionStatParams = function( store, options ) {
				var svrs		= svrselGetSelSvrs( );
				
				options.params.Svrs			= svrs;
				options.params.StartTime	= m_startTime;
				options.params.EndTime		= m_endTime;
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( ) {
				m_startTime		= #{DateFieldStartTime}.getValue( );
				m_endTime		= #{DateFieldEndTime}.getValue( );
				
				#{StoreQuestionStat}.load( { callback: function( records, options, success ) {
					#{GridPanelQuestionStat}.setVisible( true );
				} } );
			};
			
			var queryQuestionInfo = function( ) {
//				#{WindowQuestionInfo}.show( );
//				#{StoreQuestion}.load( { callback: function( records, options, success ) {
//				} } );
			};
			
			var gridQuestionOnCommand = function( command, record, rowIndex, colIndex ) {
				m_gamegroupId = record.data.GameGroupId;
				
				switch( command ) {
					case "ReplyInfo":
						{
							m_infoDel = false;
							queryQuestionInfo( );
						}
						break;
					case "DeleteInfo":
						{
							m_infoDel = true;
							queryQuestionInfo( );
						}
						break;
				}
			};
			
			var initData = function( ) {
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreQuestionStat" runat="server" OnRefreshData="StoreQuestionStatRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelQuestionStat}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Listeners>
			<BeforeLoad Fn="getQuestionStatParams" />
		</Listeners>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="ReplyCount" Mapping="ReplyCount" Type="Int" />
					<ext:RecordField Name="TotalCount" Mapping="TotalCount" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="180" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField ID="CompositeField5" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrSel ID="SvrSel1" runat="Server"></sat:SvrSel>
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:DateField ID="DateFieldStartTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="500">
								<Listeners>
									<%--<SpecialKey Fn="textFieldQuerySpecialKey" />--%>
								</Listeners>
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="500">
								<Listeners>
									<%--<SpecialKey Fn="textFieldQuerySpecialKey" />--%>
								</Listeners>
							</ext:DateField>
							<ext:DisplayField ID="FieldNote" runat="Server" Text="<%$ Resources:StringDef, MsgQuestionStatNote %>" StyleSpec="font-weight:bold;color:red;" />
						</Items>
						<Buttons>
							<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Statistic %>">
								<Listeners>
									<Click Handler="btnQueryClick( true );" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelQuestionStat" runat="Server" Border="true" StoreID="StoreQuestionStat" ColumnLines="true" StripeRows="true" Hidden="true"
						Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, ReplyStat %>" HideMode="Offsets">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, GMAccount %>" DataIndex="UserName" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ReplyCount %>" DataIndex="ReplyCount" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, TotalCount %>" DataIndex="TotalCount" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Percent %>" DataIndex="TotalCount" Width="150">
									<Renderer Fn="renderPercent" />
								</ext:Column>
								<%--<ext:CommandColumn Width="200">
									<Commands>
										<ext:GridCommand CommandName="ReplyInfo" Text="<%$ Resources:StringDef, ViewReplyInfo %>" Icon="ApplicationViewList" />
										<ext:GridCommand CommandName="DeleteInfo" Text="<%$ Resources:StringDef, ViewDeleteInfo %>" Icon="ApplicationViewGallery" />
									</Commands>
								</ext:CommandColumn>--%>
							</Columns>
						</ColumnModel>
						<Listeners>
							<Command Fn="gridQuestionOnCommand" />
						</Listeners>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server" SingleSelect="true">
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

