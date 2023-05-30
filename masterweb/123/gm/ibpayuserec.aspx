<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_ibpayuserec, App_Web_ibpayuserec.aspx.b931aa99" theme="default" %>

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
		
			var storeIBPayUseRecGetQueryParams = function( store, options ) {
				var svrId			= svrComboGetSelectedSvrId( );
				var account			= #{TextFieldQueryAcc}.getValue( );
				var accExact		= #{CheckboxAccExact}.getValue( );
				var roleName		= #{TextFieldQueryRoleName}.getValue( );
				var roleExact		= #{CheckboxRoleNameExact}.getValue( );
				var userAccount		= #{TextFieldQueryUserAcc}.getValue( );
				var userAccExact	= #{CheckboxUserAccExact}.getValue( );
				var userRoleName	= #{TextFieldQueryUserRoleName}.getValue( );
				var userRoleExact	= #{CheckboxUserRoleNameExact}.getValue( );
				var startTime		= #{DateFieldStartTime}.getValue( );
				var endTime			= #{DateFieldEndTime}.getValue( );
				var type			= #{ComboType}.getValue( );
				var typeDetail		= #{TextFieldTypeDetail}.getValue( );
				
				options.params.SvrId			= svrId;
				options.params.AccountName		= account;
				options.params.AccExact			= accExact;
				options.params.RoleName			= roleName;
				options.params.RoleExact		= roleExact;
				options.params.UserAccountName	= userAccount;
				options.params.UserAccExact		= userAccExact;
				options.params.UserRoleName		= userRoleName;
				options.params.UserRoleExact	= userRoleExact;
				options.params.StartTime		= startTime;
				options.params.EndTime			= endTime;
				options.params.Type				= type;
				options.params.TypeDetail		= typeDetail;
			};
		
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingIBPayUseRec}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreIBPayUseRec}.lastOptions ) {
					paramStart = #{StoreIBPayUseRec}.lastOptions.params.start;
				}
			
				#{StoreIBPayUseRec}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelIBPayUseRec}.setVisible( true );
				} } );
			};
		</script>
	</ext:XScript>
	
	<ext:Store ID="StoreIBPayUseRec" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="StoreIBPayUseRecRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelIBPayUseRec}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeIBPayUseRecGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="DetailID" Mapping="DetailID" Type="Int" />
					<ext:RecordField Name="AccId" Mapping="AccId" Type="Int" />
					<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="UserIP" Mapping="UserIP" Type="String" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="TypeDetail" Mapping="TypeDetail" Type="String" />
					<ext:RecordField Name="Count" Mapping="Count" Type="Int" />
					<ext:RecordField Name="Price" Mapping="Price" Type="Int" />
					<ext:RecordField Name="DiscountPrice" Mapping="DiscountPrice" Type="Int" />
					<ext:RecordField Name="BindDiscountPrice" Mapping="BindDiscountPrice" Type="Int" />
					<ext:RecordField Name="Time" Mapping="Time" Type="String" />
					<ext:RecordField Name="UseAccId" Mapping="UseAccId" Type="Int" />
					<ext:RecordField Name="UseAccountName" Mapping="UseAccountName" Type="String" />
					<ext:RecordField Name="UseRoleName" Mapping="UseRoleName" Type="String" />
					<ext:RecordField Name="UseUserIP" Mapping="UseUserIP" Type="String" />
					<ext:RecordField Name="UseTime" Mapping="UseTime" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="Time" Direction="DESC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, IBPayUseRecord %>" Height="240" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
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
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, IBPayerAccountName %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryAcc" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, IBPayerRoleName %>" Width="500">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryRoleName" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField4" runat="Server" FieldLabel="<%$ Resources:StringDef, IBUserAccountName %>" Width="500" Hidden="true">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryUserAcc" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxUserAccExact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField5" runat="Server" FieldLabel="<%$ Resources:StringDef, IBUserRoleName %>" Width="500" Hidden="true">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryUserRoleName" Width="200" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckboxUserRoleNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField6" runat="Server" FieldLabel="<%$ Resources:StringDef, Type %>" Width="500">
								<Items>
									<ext:ComboBox ID="ComboType" runat="Server" SelectedIndex="0" Editable="false" Width="100" >
										<Items>
											<ext:ListItem Text="<%$ Resources:StringDef, All %>" Value="-1" />
											<ext:ListItem Text="<%$ Resources:StringDef, IBTypeItem %>" Value="4" />
										</Items>
									</ext:ComboBox>
									<ext:TextField ID="TextFieldTypeDetail" runat="Server" Width="170">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
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
					<ext:GridPanel ID="GridPanelIBPayUseRec" runat="Server" Border="true" StoreID="StoreIBPayUseRec"
						Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>" >
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, DetailID %>" DataIndex="DetailID" Width="150">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, IBPayerAccountName %>" DataIndex="AccountName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, IBPayerRoleName %>" DataIndex="RoleName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PayTime %>" DataIndex="Time" Width="130" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Type" Width="60" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, TypeDetail %>" DataIndex="TypeDetail" Width="120" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Count %>" DataIndex="Count" Width="60" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Price %>" DataIndex="Price" Width="60" Align="Center" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DiscountPrice %>" DataIndex="DiscountPrice" Width="60" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, BindDiscountPrice %>" DataIndex="BindDiscountPrice" Width="60" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, IBUserAccountName %>" DataIndex="UseAccountName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, IBUserRoleName %>" DataIndex="UseRoleName" Width="120">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, UseTime %>" DataIndex="UseTime" Width="130" Align="Center">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingIBPayUseRec" runat="server" PageSize="50" StoreID="StoreIBPayUseRec">
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
