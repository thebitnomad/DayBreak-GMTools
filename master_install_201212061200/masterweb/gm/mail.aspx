<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_mail, App_Web_mail.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="TabRole" Src="~/gm/tabrole.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgMailState0	= '<%= Resources.StringDef.MailState0 %>';
		var msgMailState1	= '<%= Resources.StringDef.MailState1 %>';

		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ggId		= 0;			//选择的服务器ID
			
			var renderState = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgMailState0;
					case 1:
						return msgMailState1;
					default:
						return value;
				}
			};
			
			var storeMailGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var sender		= #{TextFieldQuerySender}.getValue( );
				var receiver	= #{TextFieldQueryReceiver}.getValue( );

				options.params.SvrId		= svrId;
				options.params.Sender		= sender;
				options.params.Receiver		= receiver;
			};
		
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingMail}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreMail}.lastOptions ) {
					paramStart = #{StoreMail}.lastOptions.params.start;
				}
			
				#{StoreMail}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelMail}.setVisible( true );
					m_ggId = svrComboGetSelectedSvrId( );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var gridQueryResultRowDBClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var roleGUID	= record.data.RoleGUID;
				var roleName	= record.data.RoleName;
				var accName		= record.data.AccountName;
				
				tabRoleLoadRoleInfo( m_ggId, roleGUID, roleName );
			};
			
		</script>
	</ext:XScript>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
	<ext:Store ID="StoreMail" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="MailInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelMail}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeMailGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Sender" Mapping="Sender" Type="String" />
					<ext:RecordField Name="Receiver" Mapping="Receiver" Type="String" />
					<ext:RecordField Name="Title" Mapping="Title" Type="String" />
					<ext:RecordField Name="PostTime" Mapping="PostTime" Type="String" />
					<ext:RecordField Name="ExpireTime" Mapping="ExpireTime" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="MailData" Mapping="MailData" Type="String" />
					<ext:RecordField Name="PostMoney" Mapping="PostMoney" Type="Int" />
					<ext:RecordField Name="MailCost" Mapping="MailCost" Type="Int" />
					<ext:RecordField Name="HaveMailPlus" Mapping="HaveMailPlus" Type="Boolean" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="Id" Direction="DESC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="165" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, Sender %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQuerySender" Width="276" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, Receiver %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryReceiver" Width="276" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<%--<ext:DisplayField ID="FieldNote" runat="Server" Text="<%$ Resources:StringDef, MsgRoleInfoQueryNote %>" StyleSpec="font-weight:bold;color:red;" />--%>
						</Items>
						<Buttons>
							<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Query %>">
								<Listeners>
									<Click Handler="btnQueryClick( true );" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelMail" runat="Server" Border="true" StoreID="StoreMail" Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Sender %>" DataIndex="Sender" Width="120" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Receiver %>" DataIndex="Receiver" Width="120" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Title %>" DataIndex="Title" Width="220" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Content %>" DataIndex="MailData" Width="220" Sortable="false" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PostTime %>" DataIndex="PostTime" Width="130" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ExpireTime %>" DataIndex="ExpireTime" Width="130" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="60" Align="Center">
									<Renderer Fn="renderState" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PostMoney %>" DataIndex="PostMoney" Width="80" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, CostMoney %>" DataIndex="MailCost" Width="80" Align="Center" Sortable="false">
								</ext:Column>
								<ext:BooleanColumn Header="<%$ Resources:StringDef, MailPlus %>" TrueText="<%$ Resources:StringDef, MailPlusText %>" FalseText="" DataIndex="HaveMailPlus" Width="80" Align="Center" Sortable="false">
								</ext:BooleanColumn>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingMail" runat="server" PageSize="50" StoreID="StoreMail">
							</ext:PagingToolbar>
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
	
	<sat:TabRole ID="TabRole1" runat="Server" />

</asp:Content>

