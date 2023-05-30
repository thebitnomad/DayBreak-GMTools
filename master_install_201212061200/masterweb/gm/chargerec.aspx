<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_chargerec, App_Web_chargerec.aspx.b931aa99" theme="default" %>

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
		
			var storeChargeRecGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var account		= #{TextFieldQueryAcc}.getValue( );
				var accExact	= #{CheckboxAccExact}.getValue( );
				var startTime	= #{DateFieldStartTime}.getValue( );
				var endTime		= #{DateFieldEndTime}.getValue( );
				
				options.params.SvrId		= svrId;
				options.params.Account		= account;
				options.params.AccExact		= accExact;
				options.params.StartTime	= startTime;
				options.params.EndTime		= endTime;
			};
		
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingChargeRec}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreChargeRec}.lastOptions ) {
					paramStart = #{StoreChargeRec}.lastOptions.params.start;
				}
			
				#{StoreChargeRec}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelChargeRec}.setVisible( true );
				} } );
			};
		</script>
	</ext:XScript>
	
	<ext:Store ID="StoreChargeRec" runat="server" RemotePaging="true" RemoteSort="true" OnRefreshData="StoreChargeRecRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelChargeRec}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeChargeRecGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="DetailID" Mapping="DetailID" Type="Int" />
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="AccId" Mapping="AccId" Type="Int" />
					<ext:RecordField Name="GameId" Mapping="GameId" Type="Int" />
					<ext:RecordField Name="Amount" Mapping="Amount" Type="Int" />
					<ext:RecordField Name="ChargeTime" Mapping="ChargeTime" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="ChargeTime" Direction="DESC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, ChargeRecord %>" Height="180" Padding="10"
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
							<ext:DateField ID="DateFieldStartTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="276">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
								</Listeners>
							</ext:DateField>
							<ext:DateField ID="DateFieldEndTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="276">
								<Listeners>
									<SpecialKey Fn="textFieldQuerySpecialKey" />
								</Listeners>
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
					<ext:GridPanel ID="GridPanelChargeRec" runat="Server" Border="true" StoreID="StoreChargeRec"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>"
						AutoExpandColumn="ChargeTime">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, DetailID %>" DataIndex="DetailID" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, AccId %>" DataIndex="AccId" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Amount %>" DataIndex="Amount" Width="200">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeTime %>" DataIndex="ChargeTime" Align="Center">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingChargeRec" runat="server" PageSize="50" StoreID="StoreChargeRec">
								<Items>
									<ext:ToolbarSeparator />
									<ext:DisplayField runat="Server" ID="DisplayMsg" StyleSpec="font-weight:bold;" />
								</Items>
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
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

