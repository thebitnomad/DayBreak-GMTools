<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_questionhis, App_Web_questionhis.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrSel" Src="~/common/svrsel.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.x-form-group .x-form-group-header-text {
			background-color: #dfe8f6;
		}
		
		.x-label-text {
			font-weight: bold;
		}
		
		.question {
			border: solid 1px #CCC !important;
			color: #666;
		}
	</style>
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
			var m_replyer;
			var m_startTime;
			var m_endTime;
			var m_gamegroupId;
			var m_infoDel;
		
			var renderDateTime = function( value, metadata, record, rowIndex, colIndex, store ) {
				return value.replace( / /g, "<br />" );
			};
			
			var renderStatState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value )
				{
					case 0:
						return msgStatStateUnknown;
					case 1:
						return msgStatStateSuc;
					case 2:
						return msgStatStateFail + ' ' + record.data.ErrMsg;
					case 3:
						return msgStatStateTimeout;
				}
			};
			
			var renderContent = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
			
			var gridQuestionSelectionChange = function( el ) {
			};
			
			var getQuestionStatParams = function( store, options ) {
				var svrs		= svrselGetSelSvrs( );
				
				options.params.Svrs			= svrs;
				options.params.Replyer		= m_replyer;
				options.params.StartTime	= m_startTime;
				options.params.EndTime		= m_endTime;
			};
			
			var getQuestionQueryParams = function( store, options ) {
				var svrs		= svrselGetSelSvrs( );
				
				options.params.GameGroupId	= m_gamegroupId;
				options.params.InfoDel		= m_infoDel;
				options.params.Replyer		= m_replyer;
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
				m_replyer		= #{TextFieldReplyer}.getValue( );
				m_startTime		= #{DateFieldStartTime}.getValue( );
				m_endTime		= #{DateFieldEndTime}.getValue( );
				
				#{StoreQuestionStat}.load( { callback: function( records, options, success ) {
					#{GridPanelQuestionStat}.setVisible( true );
				} } );
			};
			
			var queryQuestionInfo = function( ) {
				#{WindowQuestionInfo}.show( );
				#{StoreQuestion}.load( { callback: function( records, options, success ) {
				} } );
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
					<ext:RecordField Name="GameGroupName" Mapping="GameGroupName" Type="String" />
					<ext:RecordField Name="TotalReplyCount" Mapping="TotalReplyCount" Type="Int" />
					<ext:RecordField Name="TotalDeleteCount" Mapping="TotalDeleteCount" Type="Int" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="ErrMsg" Mapping="ErrMsg" Type="String" />
					<ext:RecordField Name="GameGroupId" Mapping="GameGroupId" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Store ID="StoreQuestion" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="StoreQuestionRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridQuestion}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getQuestionQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="CommitTime" Mapping="CommitTime" Type="String" />
					<ext:RecordField Name="Question" Mapping="Question" Type="String" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="Reply" Mapping="Reply" Type="String" />
					<ext:RecordField Name="Replyer" Mapping="Replyer" Type="String" />
					<ext:RecordField Name="ReplyTime" Mapping="ReplyTime" Type="String" />
					<ext:RecordField Name="IsFeedback" Mapping="IsFeedback" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="205" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
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
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, Replyer %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldReplyer" Width="500" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:DateField ID="DateFieldStartTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="500">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
								</Listeners>
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="500">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
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
						Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, ReplyStat %>" HideMode="Offsets"  >
						<%--<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:DisplayField ID="FieldSummary" runat="Server"></ext:DisplayField>
									<ext:ToolbarFill />
									<ext:Button ID="Button1" runat="server" Icon="Accept" Scale="Medium" Text="<%$ Resources:StringDef, Redistribute %>" >
										<Listeners>
											<Click Fn="btnAssignClick" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>--%>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="GameGroupName" Width="180">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="150">
									<Renderer Fn="renderStatState" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ReplyCount %>" DataIndex="TotalReplyCount" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DeleteCount %>" DataIndex="TotalDeleteCount" Width="150">
								</ext:Column>
								<ext:CommandColumn Width="200">
									<Commands>
										<ext:GridCommand CommandName="ReplyInfo" Text="<%$ Resources:StringDef, ViewReplyInfo %>" Icon="ApplicationViewList" />
										<ext:GridCommand CommandName="DeleteInfo" Text="<%$ Resources:StringDef, ViewDeleteInfo %>" Icon="ApplicationViewGallery" />
									</Commands>
								</ext:CommandColumn>
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
	
	<ext:Window ID="WindowQuestionInfo" runat="Server" Width="1050" Height="500" CloseAction="Hide" Resizable="true" Maximizable="true"
		Hidden="true" Modal="false" Title="<%$ Resources:StringDef, DetailInfo %>">
		<Items>
			<ext:BorderLayout ID="BorderLayout3" runat="Server">
				<Center>
					<ext:GridPanel ID="GridQuestion" runat="Server" Border="false" StoreID="StoreQuestion" StripeRows="true"
						AutoExpandColumn="Question">
						<ColumnModel>
							<Columns>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="100" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CommitTime %>" DataIndex="CommitTime" Width="90" Align="Center">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Question %>" DataIndex="Question" Align="Left" Sortable="false">
									<Renderer Fn="renderContent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Replyer %>" DataIndex="Replyer" Align="Left" Width="60" Sortable="false" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ReplyTime %>" DataIndex="ReplyTime" Align="Center" Width="90">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Reply %>" DataIndex="Reply" Align="Left" Width="300" Sortable="false" >
									<Renderer Fn="renderContent" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingQuestion" runat="server" PageSize="20" StoreID="StoreQuestion" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server" SingleSelect="true">
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

