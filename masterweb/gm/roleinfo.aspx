<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_roleinfo, App_Web_roleinfo.aspx.b931aa99" theme="default" %>

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
	
	</script>
	
	<ext:XScript runat="Server">
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
			
			var renderOnline = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value ) {
					return msgSymbolRound;
				} else {
					return msgSymbolCross;
				}
			};
			
			var storeRoleGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var account		= #{TextFieldQueryAcc}.getValue( );
				var accExact	= #{CheckboxAccExact}.getValue( );
				var roleName	= #{TextFieldQueryRoleName}.getValue( );
				var roleExact	= #{CheckboxRoleNameExact}.getValue( );
				
				var roleGUID	= #{TextFieldQueryRoleGUID}.getValue( );
				var ipAddr		= #{TextFieldQueryIpAddress}.getValue( );

				options.params.SvrId		= svrId;
				options.params.Account		= account;
				options.params.AccExact		= accExact;
				options.params.RoleName		= roleName;
				options.params.RoleExact	= roleExact;
				options.params.RoleGUID		= roleGUID;
				options.params.IpAddress	= ipAddr;
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingRole}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreRole}.lastOptions ) {
					paramStart = #{StoreRole}.lastOptions.params.start;
				}
			
				#{StoreRole}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelRole}.setVisible( true );
					m_ggId = svrComboGetSelectedSvrId( );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var prepareRoleToolbar = function( grid, toolbar, rowIndex, record ) {
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

			var batchFreezeRole = function( ) {
				var selItems = #{GridPanelRole}.getSelectionModel( ).getSelections( );
				if( selItems ) {
					var accNameBatch = '';
					var roleNameBatch = '';
					for( var nLoopCount = 0; nLoopCount < selItems.length; ++nLoopCount ) {
						var record = selItems[nLoopCount];
						accNameBatch	+= record.get( 'AccountName' ) + ',';
						roleNameBatch	+= record.get( 'RoleName' ) + ',';
					}
				}
				
				gmOpSetRoleNoLoginBatch( m_ggId, accNameBatch, roleNameBatch, true, function( result ) {
					if( result ) {
						btnQueryClick( false );
					}
				} );
			};
			
			var batchFreezeAccount = function( ) {
				var selItems = #{GridPanelRole}.getSelectionModel( ).getSelections( );
				if( selItems ) {
					var accNameBatch	= '';
					var roleNameBatch	= '';
					var accIdBatch		= '';
					for( var nLoopCount = 0; nLoopCount < selItems.length; ++nLoopCount ) {
						var record = selItems[nLoopCount];
						accNameBatch	+= record.get( 'AccountName' ) + ',';
						roleNameBatch	+= record.get( 'RoleName' ) + ',';
						accIdBatch		+= record.get( 'AccID' ) + ',';
					}
				}
				
				gmOpSetAccountNoLoginBatch( m_ggId, accNameBatch, roleNameBatch, accIdBatch, true, m_gameId );
			};
			
			var gridRoleSelectionChange = function( el ) {
				#{BtnSetRoleLoginState}.setDisabled( el.getCount( ) < 1 );
				#{BtnSetAccFreezeState}.setDisabled( el.getCount( ) < 1 );
			};

		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" runat="Server">
	<ext:Store ID="StoreRole" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="RoleInfoRefresh"
		AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
				CustomTarget="#{GridPanelRole}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeRoleGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="RoleType" Mapping="RoleType" Type="Int" />
					<ext:RecordField Name="RoleLevel" Mapping="RoleLevel" Type="Int" />
					<ext:RecordField Name="Online" Mapping="Online" Type="Boolean" />
					<ext:RecordField Name="NoChat" Mapping="NoChat" Type="String" />
					<ext:RecordField Name="NoLogin" Mapping="NoLogin" Type="String" />
					<ext:RecordField Name="RoleGUID" Mapping="RoleGUID" Type="String" />
					<ext:RecordField Name="AccID" Mapping="AccID" Type="Int" />
					<ext:RecordField Name="RoleID" Mapping="RoleID" Type="Int" />
					<ext:RecordField Name="Exp" Mapping="Exp" Type="Int" />
					<ext:RecordField Name="LastPlayingDate" Mapping="LastPlayingDate" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="RoleName" Direction="ASC" />
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;">
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, QueryCondition %>" Height="225" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>"
								Width="550">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField runat="Server" FieldLabel="<%$ Resources:StringDef, Account %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryAcc" Width="200">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>"
										Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, RoleName %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRoleName" Width="200">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>"
										Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, RoleGUID %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRoleGUID" Width="270">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField4" runat="Server" FieldLabel="<%$ Resources:StringDef, IpAddress %>"
								Width="550">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryIpAddress" Width="270">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:DisplayField ID="FieldNote" runat="Server" Text="<%$ Resources:StringDef, MsgRoleInfoQueryNote %>"
								StyleSpec="font-weight:bold;color:red;" />
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
					<ext:GridPanel ID="GridPanelRole" runat="Server" Border="true" StoreID="StoreRole"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>">
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="BtnSetRoleLoginState" runat="server" Text="<%$ Resources:StringDef, FreezeRole %>" Icon="Decline">
										<Listeners>
											<Click Fn="batchFreezeRole" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnSetAccFreezeState" runat="server" Text="<%$ Resources:StringDef, FreezeAccount %>" Icon="UserCross" >
										<Listeners>
											<Click Fn="batchFreezeAccount" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarFill />
								</Items>
							</ext:Toolbar>
						</TopBar>
						
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="160">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleID %>" DataIndex="RoleID" Width="80">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName"
									Width="180">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, AccID %>" DataIndex="AccID" Width="80">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleType %>" DataIndex="RoleType" Width="120"
									Align="Center">
									<Renderer Fn="renderRoleType" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleLevel %>" DataIndex="RoleLevel"
									Width="50" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, OnlineState %>" DataIndex="Online" Width="100"
									Align="Center">
									<Renderer Fn="renderOnline" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LastPlayingDate %>" DataIndex="LastPlayingDate" Width="130"
									Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NoChatDate %>" DataIndex="NoChat" Width="160"
									Align="Center" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NoLoginDate %>" DataIndex="NoLogin"
									Width="160" Align="Center" Sortable="false">
								</ext:Column>
								<%--<ext:CommandColumn Width="350">
									<Commands>
										<ext:GridCommand CommandName="NoChat" Text="<%$ Resources:StringDef, DisableChat %>" Icon="BulletMinus" />
										<ext:GridCommand CommandName="Chat" Text="<%$ Resources:StringDef, EnableChat %>" Icon="ClockStart" />
										<ext:GridCommand CommandName="Freeze" Text="<%$ Resources:StringDef, Freeze %>" Icon="Build" />
										<ext:GridCommand CommandName="Unfreeze" Text="<%$ Resources:StringDef, Unfreeze %>" Icon="FolderGo" />
									</Commands>
									<PrepareToolbar Fn="prepareRoleToolbar" />
								</ext:CommandColumn>--%>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingRole" runat="server" PageSize="50" StoreID="StoreRole">
								<Items>
									<ext:ToolbarSeparator />
									<ext:DisplayField runat="Server" ID="DisplayMsg" StyleSpec="font-weight:bold;" />
								</Items>
								<Content>
									<table>
										<tr>
											<td>
												<ext:Hidden ID="FieldHiddenAcc" runat="server" />
												<ext:Hidden ID="FieldHiddenAccId" runat="server" />
											</td>
										</tr>
									</table>
								</Content>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
								<Listeners>
									<SelectionChange Fn="gridRoleSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridQueryResultRowDBClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<sat:TabRole runat="Server" />
	<sat:GMBaseOp runat="Server" />
</asp:Content>
