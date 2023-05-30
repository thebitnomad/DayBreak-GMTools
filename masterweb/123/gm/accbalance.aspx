<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_accbalance, App_Web_accbalance.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>

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
		
			var storeAccBalanceGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var account		= #{TextFieldQueryAcc}.getValue( );
				var accExact	= #{CheckboxAccExact}.getValue( );
				
				options.params.SvrId		= svrId;
				options.params.Account		= account;
				options.params.AccExact		= accExact;
			};
		
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingAccBalance}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreAccBalance}.lastOptions ) {
					paramStart = #{StoreAccBalance}.lastOptions.params.start;
				}
			
				#{StoreAccBalance}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelAccBalance}.setVisible( true );
				} } );
			};
		</script>
	</ext:XScript>
	
	<ext:Store ID="StoreAccBalance" runat="server" RemotePaging="true" RemoteSort="true" OnRefreshData="StoreAccBalanceRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelAccBalance}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeAccBalanceGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="AccId" Mapping="AccId" Type="Int" />
					<ext:RecordField Name="AccName" Mapping="AccName" Type="String" />
					<ext:RecordField Name="Balance" Mapping="Balance" Type="Int" />
					<ext:RecordField Name="TotalCharge" Mapping="TotalCharge" Type="Int" />
					<ext:RecordField Name="TotalPay" Mapping="TotalPay" Type="Int" />
					<ext:RecordField Name="BindBalance" Mapping="BindBalance" Type="Int" />
					<ext:RecordField Name="VIPPoint" Mapping="VIPPoint" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, AccBalance %>" Height="140" Padding="10"
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
					<ext:GridPanel ID="GridPanelAccBalance" runat="Server" Border="true" StoreID="StoreAccBalance"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>" >
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, AccId %>" DataIndex="AccId" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccName" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Balance %>" DataIndex="Balance" Width="200" Align="Right">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, BindBalance %>" DataIndex="BindBalance" Width="200" Align="Right">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, TotalCharge %>" DataIndex="TotalCharge" Align="Right">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, TotalPay %>" DataIndex="TotalPay" Align="Right">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, VIPPoint %>" DataIndex="VIPPoint" Align="Right">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingAccBalance" runat="server" PageSize="50" StoreID="StoreAccBalance" />
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
