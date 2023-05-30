<%@ page language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_society, App_Web_society.aspx.b931aa99" theme="default" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

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
		
		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">	
			var m_ggId		= 0;
			
			var renderOnline = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( value ) 
				{
					return msgOnline;
				} 
				else 
				{
					return msgOffline;
				}
			};
			
			var storeSocietyGetQueryParams = function( store, options ) {
				var svrId				= svrComboGetSelectedSvrId( );
				var societyname			= #{TextFieldQuerySocietyName}.getValue( );
				var societynameExact	= #{CheckboxSocietyNameExact}.getValue( );
				var leadername			= #{TextFieldQueryLeaderName}.getValue( );
				var leadernameExact		= #{CheckboxLeaderNameExact}.getValue( );
				var societyGUID			= #{TextFieldQuerySocietyGUID}.getValue( );

				options.params.SvrId			= svrId;
				options.params.SocietyName		= societyname;
				options.params.SocietyNameExact	= societynameExact;
				options.params.LeaderName		= leadername;
				options.params.LeaderNameExact	= leadernameExact;
				options.params.SocietyGUID		= societyGUID;
			};
		
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingSociety}.pageSize;

				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreSociety}.lastOptions ) {
					paramStart = #{StoreSociety}.lastOptions.params.start;
				}
			
				#{StoreSociety}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelSociety}.setVisible( true );
					m_ggId = svrComboGetSelectedSvrId( );
				} } );
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					#{GridPanelSociety}.show( );
					#{StoreSociety}.DataBind( );

					
					e.stopEvent( );
				}
			};

			var gridQueryResultRowDBClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var societyGUID	= record.data.GUID;
				var societyName	= record.data.Name;
				var societyTab = new Ext.Panel({
					id : societyGUID,
					xtype : 'panel',
					closable : true,
					title : societyName,
					autoLoad : {
					url : 'societymem.aspx?guid=' + societyGUID + '&ggId=' + m_ggId,
					mode : 'iframe',
					script : 'true'
					}
				});
				
				#{TabPanelSocietyInfo}.add( societyTab );
				#{WindowSocietyInfo}.show( );
				#{TabPanelSocietyInfo}.setActiveTab( societyTab );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" runat="server">
	<ext:Store ID="StoreSociety" runat="server" RemoteSort="true" RemotePaging="true"
		OnRefreshData="SocietyInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
				CustomTarget="#{GridPanelSociety}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeSocietyGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="GUID" Mapping="GUID" Type="String" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="LeaderName" Mapping="LeaderName" Type="String" />
					<ext:RecordField Name="LeaderGUID" Mapping="LeaderGUID" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="Level" Mapping="Level" Type="Int" />
					<ext:RecordField Name="CurrMemCount" Mapping="CurrMemCount" Type="Int" />
					<ext:RecordField Name="MaxMemCount" Mapping="MaxMemCount" Type="Int" />
					<ext:RecordField Name="Gold" Mapping="Gold" Type="Int" />
					<ext:RecordField Name="CofferLv" Mapping="CofferLv" Type="Int" />
					<ext:RecordField Name="ShopLv" Mapping="ShopLv" Type="Int" />
					<ext:RecordField Name="HouseLv" Mapping="HouseLv" Type="Int" />
					<ext:RecordField Name="StoreLv" Mapping="StoreLv" Type="Int" />
					<ext:RecordField Name="CollegeLv" Mapping="CollegeLv" Type="Int" />
					<ext:RecordField Name="Prosperity" Mapping="Prosperity" Type="Int" />
					<ext:RecordField Name="GroupID" Mapping="GroupID" Type="Int" />
					<ext:RecordField Name="CreateTime" Mapping="CreateTime" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="server" StyleSpec="background-color:#FFF;">
				<North>
					<ext:FormPanel ID="QueryPanel" runat="server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, QueryCondition %>" Height="200" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
						<Items>
							<ext:CompositeField ID="CompositeField2" runat="server" FieldLabel="<%$ Resources:StringDef, GameServer %>"
								Width="550">
								<Items>
									<ext:Container ID="Container1" runat="server">
										<Content>
											<sat:SvrCombo runat="server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField runat="server" FieldLabel="<%$ Resources:StringDef, SocietyName %>"
								Width="550">
								<Items>
									<ext:TextField runat="server" ID="TextFieldQuerySocietyName" Width="200">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="server" ID="CheckboxSocietyNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>"
										Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField1" runat="server" FieldLabel="<%$ Resources:StringDef, LeaderName %>"
								Width="550">
								<Items>
									<ext:TextField runat="server" ID="TextFieldQueryLeaderName" Width="200">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="server" ID="CheckboxLeaderNameExact" BoxLabel="<%$ Resources:StringDef, Exact %>"
										Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="server" FieldLabel="<%$ Resources:StringDef, SocietyGUID %>"
								Width="550">
								<Items>
									<ext:TextField runat="server" ID="TextFieldQuerySocietyGUID" Width="270">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
						</Items>
						<Buttons>
							<ext:Button ID="BtnQuery" runat="server" Text="<%$ Resources:StringDef, Query %>">
								<Listeners>
									<Click Handler="btnQueryClick( true );" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelSociety" runat="server" Border="true" StoreID="StoreSociety"
						Hidden="true" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, QueryResult %>">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="
										return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, SocietyName %>" DataIndex="Name" Width="120" />
								<ext:Column Header="<%$ Resources:StringDef, SocietyGUID %>" DataIndex="GUID" Width="320"
									Hidden="false" />
								<ext:Column Header="<%$ Resources:StringDef, LeaderName %>" DataIndex="LeaderName"
									Width="120" />
								<ext:Column Header="<%$ Resources:StringDef, LeaderGUID %>" DataIndex="LeaderGUID"
									Width="80" Hidden="true" />
								<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, SocietyLevel %>" DataIndex="Level" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, CurrMemCount %>" DataIndex="CurrMemCount"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, MaxMemCount %>" DataIndex="MaxMemCount"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, Gold %>" DataIndex="Gold" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, CofferLv %>" DataIndex="CofferLv" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, ShopLv %>" DataIndex="ShopLv" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, HouseLv %>" DataIndex="HouseLv" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, StoreLv %>" DataIndex="StoreLv" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, CollegeLv %>" DataIndex="CollegeLv"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, Prosperity %>" DataIndex="Prosperity"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, GroupID %>" DataIndex="GroupID" Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, CreateTime %>" DataIndex="CreateTime"
									Width="200" />
							</Columns>
						</ColumnModel>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
						</SelectionModel>
						<LoadMask ShowMask="true" />
						<BottomBar>
							<ext:PagingToolbar ID="PagingSociety" runat="server" PageSize="50" StoreID="StoreSociety">
								<Items>
									<ext:ToolbarSeparator />
									<ext:DisplayField runat="Server" ID="DisplayMsg" StyleSpec="font-weight:bold;" />
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<Listeners>
							<RowDblClick Fn="gridQueryResultRowDBClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<ext:Window ID="WindowSocietyInfo" runat="server" Resizable="true" Maximizable="true"
		Title="<%$ Resources:StringDef, SocietyInfo %>" Width="1100" Height="680" CloseAction="Hide"
		Collapsible="false" PaddingSummary="5px 0px 0px 0px" Hidden="true" Modal="true">
		<Items>
			<ext:BorderLayout ID="BorderLayout3" runat="server">
				<Center>
					<ext:TabPanel runat="Server" ID="TabPanelSocietyInfo" Plain="true" Border="false">
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Window>
</asp:Content>
