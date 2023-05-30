<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_accrole, App_Web_accrole.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgRoleTypeQS				= '<%= Resources.StringDef.RoleTypeQS %>';
		var msgRoleTypeSJLR				= '<%= Resources.StringDef.RoleTypeSJLR %>';
		var msgRoleTypeMDS				= '<%= Resources.StringDef.RoleTypeMDS %>';
		var msgRoleTypeKLS				= '<%= Resources.StringDef.RoleTypeKLS %>';

		var msgOnline					= '<%= Resources.StringDef.Online %>';
		var msgOffline					= '<%= Resources.StringDef.Offline %>';
	
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
			
			var storeAccountRoleGetQueryParams = function( store, options ) {
				var account		= #{TextFieldQueryAcc}.getValue( );
				var roleName	= #{TextFieldQueryRoleName}.getValue( );
				var roleExact	= #{CheckboxRoleNameExact}.getValue( );

				options.params.Account		= account;
				options.params.RoleName		= roleName;
				options.params.RoleExact	= roleExact;
			};
		
			var btnQueryClick = function( ) {
				#{StoreAccountRole}.load( { callback: function( records, options, success ) {
					#{GridPanelAccountRole}.setVisible( true );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var loadRoleInfo = function( ggId, roleName ) {
				var tab = #{TabPanelRoleInfo}.getItem( roleName );

				if( !tab ) {
					tab = #{TabPanelRoleInfo}.add( {
						id: roleName,
						title: roleName,
						closable: true,
						autoLoad: {
							showMask: true,
							url: 'roledetail.aspx?ggId=' + ggId + '&rname=' + encodeURI( roleName ),
							mode: "iframe",
							maskMsg: msgLoading
						},
						listeners: {
							update: {
								fn: function( tab, cfg ) {
									cfg.iframe.setHeight( cfg.iframe.getSize( ).height );
								},
								scope: this,
								single: true
							}
						}
					});
				}

				#{TabPanelRoleInfo}.setActiveTab( tab );
				#{WindowRoleInfo}.show( );
			};
			
			var gridQueryResultRowDBClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var roleName	= record.data.RoleName;
				var ggId		= record.data.GameGroupId;
				
				loadRoleInfo( ggId, roleName );
			};
			
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreAccountRole" runat="server" OnRefreshData="AccountRoleInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelAccountRole}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeAccountRoleGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Account" Mapping="Account" Type="String" />
					<ext:RecordField Name="AccID" Mapping="AccID" Type="Int" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="RoleID" Mapping="RoleID" Type="Int" />
					<ext:RecordField Name="Gateway" Mapping="Gateway" Type="String" />
					<ext:RecordField Name="GameGroupId" Mapping="GameGroupId" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>

	<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="380" Width="1000"
		Title="<%$ Resources:StringDef, QueryCondition %>" Height="105" Padding="10"
		ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px" StyleSpec="margin:10px;">
		<Items>
			<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, Account %>" Width="500">
				<Items>
					<ext:TextField runat="Server" ID="TextFieldQueryAcc" Width="200" >
						<Listeners>
							<SpecialKey Fn="textFieldQuerySpecialKey" />
						</Listeners>
					</ext:TextField>
					<ext:Checkbox runat="Server" ID="CheckboxAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
				</Items>
			</ext:CompositeField>
			<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, RoleName %>" Hidden="true">
				<Items>
					<ext:TextField runat="Server" ID="TextFieldQueryRoleName" Width="200" >
						<Listeners>
							<SpecialKey Fn="textFieldQuerySpecialKey" />
						</Listeners>
					</ext:TextField>
					<ext:Checkbox runat="Server" ID="CheckboxRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>" />
				</Items>
			</ext:CompositeField>
		</Items>
		<Buttons>
			<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Query %>">
				<Listeners>
					<Click Fn="btnQueryClick" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:FormPanel>
	
	<ext:GridPanel ID="GridPanelAccountRole" runat="Server" Border="true" StoreID="StoreAccountRole" Width="1000" Height="460"
		Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>" StyleSpec="margin:10px;">
		<%--<TopBar>
			<ext:Toolbar ID="Toolbar1" runat="server">
				<Items>
					<ext:Button ID="BtnAddRegion" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
						<Listeners>
							<Click Fn="addRegion" />
						</Listeners>
					</ext:Button>
					<ext:Button ID="BtnDelRegion" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
						<Listeners>
							<Click Fn="deleteRegion" />
						</Listeners>
					</ext:Button>
					<ext:Button ID="BtnModifyRegion" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
						<Listeners>
							<Click Fn="modifyRegion" />
						</Listeners>
					</ext:Button>
				</Items>
			</ext:Toolbar>
		</TopBar>--%>
		<ColumnModel>
			<Columns>
				<ext:RowNumbererColumn>
					<Renderer Handler="return ''; " />
				</ext:RowNumbererColumn>
				<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="Account" Width="150">
				</ext:Column>
				<ext:Column Header="<%$ Resources:StringDef, AccID %>" DataIndex="AccID" Width="150">
				</ext:Column>
				<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="150">
				</ext:Column>
				<ext:Column Header="<%$ Resources:StringDef, RoleID %>" DataIndex="RoleID" Width="150">
				</ext:Column>
				<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="Gateway" Width="200" Align="Center">
				</ext:Column>
				<%--<ext:CommandColumn Width="150">
					<Commands>
						<ext:GridCommand CommandName="NoChat" Text="<%$ Resources:StringDef, DisableChat %>" Icon="BulletMinus" />
					</Commands>
				</ext:CommandColumn>--%>
			</Columns>
		</ColumnModel>
		<BottomBar>
			<ext:PagingToolbar ID="PagingAccountRole" runat="server" PageSize="500" StoreID="StoreAccountRole" />
		</BottomBar>
		<SelectionModel>
			<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
			</ext:RowSelectionModel>
		</SelectionModel>
		<Listeners>
			<RowDblClick Fn="gridQueryResultRowDBClick" />
		</Listeners>
	</ext:GridPanel>
	
	<ext:Window ID="WindowRoleInfo" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, RoleInfo %>"
		Width="1000" Height="600" CloseAction="Hide" Collapsible="false" PaddingSummary="5px 0px 0px 0px"
		Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="server">
				<Center>
					<ext:TabPanel runat="Server" ID="TabPanelRoleInfo" Plain="true" Border="false">
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
