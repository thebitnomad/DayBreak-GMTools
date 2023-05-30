<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_chathistory, App_Web_chathistory.aspx.b931aa99" theme="default" %>

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
		
		var msgRoleTypeQS					= '<%= Resources.StringDef.RoleTypeQS %>';
		var msgRoleTypeSJLR					= '<%= Resources.StringDef.RoleTypeSJLR %>';
		var msgRoleTypeMDS					= '<%= Resources.StringDef.RoleTypeMDS %>';
		var msgRoleTypeKLS					= '<%= Resources.StringDef.RoleTypeKLS %>';
		var msgOnline						= '<%= Resources.StringDef.Online %>';
		var msgOffline						= '<%= Resources.StringDef.Offline %>';

		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_svrId		= 0;
		
			var renderRoleName = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<a href='#' onclick='showRoleInfo( \"{0}\" );'>{0}</a>", value );
			};
		
			var renderMessage = function( value, metadata, record, rowIndex, colIndex, store ) {
				return htmlencode( value );
			};
		
			var storeChatHisGetQueryParams = function( store, options ) {
				var account		= #{TextFieldQueryAcc}.getValue( );
				var accExact	= #{CheckboxAccExact}.getValue( );
				var roleName	= #{TextFieldQueryRoleName}.getValue( );
				var roleExact	= #{CheckboxRoleNameExact}.getValue( );
				var startTime	= #{DateFieldStartTime}.getValue( );
				var endTime		= #{DateFieldEndTime}.getValue( );
				var keyword1	= #{TextFieldQueryKeyword1}.getValue( );
				var keyword2	= #{TextFieldQueryKeyword2}.getValue( );
				var keyword3	= #{TextFieldQueryKeyword3}.getValue( );

				m_svrId			= svrComboGetSelectedSvrId( );
				
				options.params.SvrId		= m_svrId;
				options.params.Account		= account;
				options.params.AccExact		= accExact;
				options.params.RoleName		= roleName;
				options.params.RoleExact	= roleExact;
				options.params.Keyword1		= keyword1;
				options.params.Keyword2		= keyword2;
				options.params.Keyword3		= keyword3;
				options.params.StartTime	= startTime;
				options.params.EndTime		= endTime;
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingChatHis}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreChatHis}.lastOptions ) {
					paramStart = #{StoreChatHis}.lastOptions.params.start;
				}
			
				#{StoreChatHis}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelChatHis}.setVisible( true );
				} } );
			};
			
			var chatRowDblClick = function( ) {
				//tabRoleLoadRoleInfo( m_svrId, roleName, roleName );
			};
			
			var showRoleInfo = function( roleName ) {
				tabRoleLoadRoleInfo( m_svrId, roleName, roleName );
			};
			
		</script>
	</ext:XScript>
	
	<ext:Store ID="StoreChatHis" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="StoreChatHisRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelChatHis}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeChatHisGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Sender" Mapping="Sender" Type="String" />
					<ext:RecordField Name="SenderAccount" Mapping="SenderAccount" Type="String" />
					<ext:RecordField Name="SendTime" Mapping="SendTime" Type="String" />
					<ext:RecordField Name="Message" Mapping="Message" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="SendTime" Direction="DESC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, ChatInfoHistory %>" Height="232" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
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
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, SenderAccount %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryAcc" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, SenderRoleName %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRoleName" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField4" runat="Server" FieldLabel="<%$ Resources:StringDef, Keyword %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryKeyword1" Width="90" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:TextField runat="Server" ID="TextFieldQueryKeyword2" Width="90" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:TextField runat="Server" ID="TextFieldQueryKeyword3" Width="85" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:DateField ID="DateFieldStartTime" runat="Server" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="276">
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" runat="Server" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="276">
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
					<ext:GridPanel ID="GridPanelChatHis" runat="Server" Border="true" StoreID="StoreChatHis" ColumnLines="true"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>"
						AutoExpandColumn="Message">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, SenderRoleName %>" DataIndex="Sender" Width="120">
									<Renderer Fn="renderRoleName" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SenderAccount %>" DataIndex="SenderAccount" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="SendTime" Width="140">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Message %>" DataIndex="Message">
									<Renderer Fn="renderMessage" />
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingChatHis" runat="server" PageSize="50" StoreID="StoreChatHis" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="chatRowDblClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<sat:TabRole ID="TabRole1" runat="Server" />
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
