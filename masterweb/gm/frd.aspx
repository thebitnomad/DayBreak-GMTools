<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_frd, App_Web_frd.aspx.b931aa99" theme="default" %>


<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="TabRole" Src="~/gm/tabrole.ascx" %>
<%@ Register TagPrefix="sat" TagName="GMBaseOp" Src="~/gm/baseop.ascx" %>

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
		var msgResumeRoleConfirmFormat		= '<%= Resources.StringDef.MsgResumeRoleConfirmFormat %>';
		var msgResuleRoleSuccess			= '<%= Resources.StringDef.MsgResuleRoleSuccess %>';
		var msgSymbolCross					= '<%= Resources.StringDef.SymbolCross %>';
		var msgSymbolRound					= '<%= Resources.StringDef.SymbolRound %>';
		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';

		var msgFrdAppellationFamiliar		= '<%= Resources.StringDef.FrdAppellationFamiliar %>';
		var msgFrdAppellationPreparedCouple	= '<%= Resources.StringDef.FrdAppellationPreparedCouple %>';
		var msgFrdAppellationCouple			= '<%= Resources.StringDef.FrdAppellationCouple %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ggId		= 0;			//选择的服务器ID
			var m_gameId;
						
			var renderRoleType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgRoleTypeQS;
					case 1:
						return msgRoleTypeSJLR;
					case 2:
						return msgRoleTypeMDS;
					case 3:
						return msgRoleTypeKLS;
				}
			};
			
			var renderAppellation = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 1:
						return msgFrdAppellationFamiliar;
					case 4:
						return msgFrdAppellationPreparedCouple;
					case 5:
						return msgFrdAppellationCouple;
					default:
						return value;
				}
			};
			
			var storeFrdGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var role1Name	= #{TextFieldQueryRole1Name}.getValue( );
				var role2Name	= #{TextFieldQueryRole2Name}.getValue( );

				options.params.SvrId		= svrId;
				options.params.Role1Name	= role1Name;
				options.params.Role2Name	= role2Name;
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingFrd}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreFrd}.lastOptions ) {
					paramStart = #{StoreFrd}.lastOptions.params.start;
				}
			
				#{StoreFrd}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelFrd}.setVisible( true );
					m_ggId = svrComboGetSelectedSvrId( );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var prepareFrdToolbar = function( grid, toolbar, rowIndex, record ) {
//				var btnStartGame	= toolbar.items.get( 0 );
//				var btnStopGame		= toolbar.items.get( 1 );
//				var btnUpdateGame	= toolbar.items.get( 2 );
//				var btnSvrUpload	= toolbar.items.get( 3 );
//				var btnModify		= toolbar.items.get( 4 );
//				var btnConfig		= toolbar.items.get( 5 );

//				btnStartGame.setDisabled( record.data.GameStatus != 1 );
//				btnStopGame.setDisabled( record.data.GameStatus != 3 );
//				btnSvrUpload.setDisabled( record.data.NetStatus != 1 );
//				btnUpdateGame.setDisabled( record.data.NetStatus != 1 );
//				btnConfig.setDisabled( record.data.ProcId == -1 );
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
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" runat="Server">
	<ext:Store ID="StoreFrd" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="FrdRefresh"
		AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
				CustomTarget="#{GridPanelFrd}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeFrdGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="UUID" Mapping="UUID" Type="String" />
					<ext:RecordField Name="Role1Name" Mapping="Role1Name" Type="String" />
					<ext:RecordField Name="Role2Name" Mapping="Role2Name" Type="String" />
					<ext:RecordField Name="Apellation" Mapping="Apellation" Type="Int" />
					<ext:RecordField Name="DivorceTime" Mapping="DivorceTime" Type="String" />
					<ext:RecordField Name="DivorceName" Mapping="DivorceName" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;">
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, QueryCondition %>" Height="160" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>"
								Width="550">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, Role1Name %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRole1Name" Width="275">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, Role2Name %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRole2Name" Width="275">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
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
					<ext:GridPanel ID="GridPanelFrd" runat="Server" Border="true" StoreID="StoreFrd"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, GUID %>" DataIndex="UUID" Width="320">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Role1Name %>" DataIndex="Role1Name" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Role2Name %>" DataIndex="Role2Name" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Apellation %>" DataIndex="Apellation"
									Width="80" Align="Center">
									<Renderer Fn="renderAppellation" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DivorceTime %>" DataIndex="DivorceTime" Width="130"
									Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DivorceName %>" DataIndex="DivorceName" Width="120"
									Align="Center">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingFrd" runat="server" PageSize="50" StoreID="StoreFrd">
								<Items>
									<ext:ToolbarSeparator />
									<ext:DisplayField runat="Server" ID="DisplayMsg" StyleSpec="font-weight:bold;" />
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<%--<RowDblClick Fn="gridQueryResultRowDBClick" />--%>
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<sat:TabRole ID="TabRole1" runat="Server" />
</asp:Content>
