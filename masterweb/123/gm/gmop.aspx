<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_gmop, App_Web_gmop.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
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
			var m_ggId		= 0;			//选择的服务器ID
						
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
			
			var renderOnline = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value ) {
					return msgOnline;
				} else {
					return msgOffline;
				}
			};
			
			var storeOpLogGetQueryParams = function( store, options ) {
				
				var oper		= #{TextFieldQueryOperator}.getValue( );
				var operExact	= #{CheckboxOperExact}.getValue( );
				var account		= #{TextFieldQueryAcc}.getValue( );
				var accExact	= #{CheckboxAccExact}.getValue( );
				var roleName	= #{TextFieldQueryRoleName}.getValue( );
				var roleExact	= #{CheckboxRoleNameExact}.getValue( );
				var startTime	= #{DateFieldStartTime}.getValue( );
				var endTime		= #{DateFieldEndTime}.getValue( );
				
				var opTypes		= '';
				for( var nIndex = 0; nIndex < #{CheckboxGroupOpType}.items.length; ++nIndex ) {
					if( #{CheckboxGroupOpType}.items.items[nIndex].checked ) {
						opTypes += #{CheckboxGroupOpType}.items.items[nIndex].tag + ',';
					}
				}
				
				if( opTypes.length > 0 ) {
					opTypes = opTypes.substr( 0, opTypes.length - 1 );
				}
				
				options.params.Oper			= oper;
				options.params.OperExact	= operExact;
				options.params.Account		= account;
				options.params.AccExact		= accExact;
				options.params.RoleName		= roleName;
				options.params.RoleExact	= roleExact;
				options.params.StartTime	= startTime;
				options.params.EndTime		= endTime;
				options.params.OpTypes		= opTypes;
				
			};
		
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingOpLog}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreOpLog}.lastOptions ) {
					paramStart = #{StoreOpLog}.lastOptions.params.start;
				}
			
				#{StoreOpLog}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelOpLog}.setVisible( true );
					//m_ggId = svrComboGetSelectedSvrId( );
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreOpLog" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="OpLogRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelOpLog}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeOpLogGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="OperationTime" Mapping="OperationTime" Type="String" />
					<ext:RecordField Name="Operator" Mapping="Operator" Type="String" />
					<ext:RecordField Name="OpType" Mapping="OpType" Type="String" />
					<ext:RecordField Name="OpInfo" Mapping="OpInfo" Type="String" />
					<ext:RecordField Name="OpParam" Mapping="OpParam" Type="String" />
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="SvrId" Mapping="SvrId" Type="Int" />
					<ext:RecordField Name="Reason" Mapping="Reason" Type="String" />
					<ext:RecordField Name="Interval" Mapping="Interval" Type="String" />
					<ext:RecordField Name="SvrInfo" Mapping="SvrInfo" Type="String" />
					<ext:RecordField Name="Detail" Mapping="Detail" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="OperationTime" Direction="DESC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="180" Title="<%$ Resources:StringDef, QueryCondition %>" Height="260" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<%--<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>--%>
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, Operator %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryOperator" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxOperExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, Account %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryAcc" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, RoleName %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRoleName" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:DateField ID="DateFieldStartTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="200">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
								</Listeners>
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="200">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
								</Listeners>
							</ext:DateField>
							<ext:CheckboxGroup ID="CheckboxGroupOpType" runat="Server" Width="810" ColumnsNumber="9" FieldLabel="<%$ Resources:StringDef, Operation %>" Vertical="true" >
								<Items>
									<ext:Checkbox runat="server" Tag="1" BoxLabel="<%$ Resources:StringDef, FreezeAccount %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="2" BoxLabel="<%$ Resources:StringDef, UnfreezeAccount %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="3" BoxLabel="<%$ Resources:StringDef, FreezeRole %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="4" BoxLabel="<%$ Resources:StringDef, UnfreezeRole %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="5" BoxLabel="<%$ Resources:StringDef, DisableChat %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="6" BoxLabel="<%$ Resources:StringDef, EnableChat %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="7" BoxLabel="<%$ Resources:StringDef, SetBoxPwd %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="8" BoxLabel="<%$ Resources:StringDef, KickRole %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="9" BoxLabel="<%$ Resources:StringDef, ExecRoleGMCommand %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="10" BoxLabel="<%$ Resources:StringDef, ExecOnlineGMCommand %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="13" BoxLabel="<%$ Resources:StringDef, FreezeIPAddress %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="14" BoxLabel="<%$ Resources:StringDef, UnfreezeIPAddress %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="12" BoxLabel="<%$ Resources:StringDef, ResumeRole %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="15" BoxLabel="<%$ Resources:StringDef, ClearMoney %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="17" BoxLabel="<%$ Resources:StringDef, TrusteeAccount %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="18" BoxLabel="<%$ Resources:StringDef, UntrusteeAccount %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="11" BoxLabel="<%$ Resources:StringDef, ExecGlobalGMCommand %>" Checked="true" />
									<ext:Checkbox runat="server" Tag="16" BoxLabel="<%$ Resources:StringDef, ExecSqlScript %>" Checked="true" />
								</Items>
							</ext:CheckboxGroup>
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
					<ext:GridPanel ID="GridPanelOpLog" runat="Server" Border="true" StoreID="StoreOpLog"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>"
						AutoExpandColumn="Reason">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="SvrInfo" Width="100" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="OpType" Width="100" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Detail %>" DataIndex="OpInfo" Width="120" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Param %>" DataIndex="OpParam" Width="100" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" Width="120" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="120" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Reason %>" DataIndex="Reason" Width="200" Align="Left" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LastInterval %>" DataIndex="Interval" Width="80" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Operator %>" DataIndex="Operator" Width="130" Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, OperationTime %>" DataIndex="OperationTime" Align="Center" Width="130">
								</ext:Column>
								<ext:Column DataIndex="Detail" Align="Center" Width="200" Hidden="true">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingOpLog" runat="server" PageSize="50" StoreID="StoreOpLog" />
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
