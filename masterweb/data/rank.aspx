<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="data_rank, App_Web_rank.aspx.551d078a" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="TabRole" Src="~/gm/tabrole.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<style type="text/css">
		.rank
		{
			font-weight:bold !important;
		}
	</style>
	
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';

		var msgCannotBeNullFormat	= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgRankType				= '<%= Resources.StringDef.RankType %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ggId			= 0;			//选择的服务器ID
			var m_textTpl		= "<span class='{0}'>{1}</span>";
			
			var renderRank = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( m_textTpl, 'rank', value );
			};
			
			var storeRankGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				var rankType	= #{ComboboxRankType}.getValue( );

				options.params.SvrId		= svrId;
				options.params.RankType		= rankType;
			};
			
			var btnQueryClick = function( reset ) {
				var paramStart = 0;
				var paramLimit = #{PagingRank}.pageSize;
				
				var rankType	= #{ComboboxRankType}.getValue( );
				if( !rankType ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgRankType ) )
					return;
				}
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreRank}.lastOptions ) {
					paramStart = #{StoreRank}.lastOptions.params.start;
				}
			
				#{StoreRank}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
					#{GridPanelRank}.setVisible( true );
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
			
			var exportData = function( ) {
				#{GridPanelRank}.submitData( false );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
	<ext:Store ID="StoreRank" runat="server" RemoteSort="false" RemotePaging="true" OnRefreshData="RankInfoRefresh" OnSubmitData="RankInfoSubmit" AutoLoad="false">
		<DirectEventConfig IsUpload="true">
			<%--<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelRank}.body" MinDelay="100" />--%>
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeRankGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="ObjInfo1" Mapping="ObjInfo1" Type="String" />
					<ext:RecordField Name="ObjInfo2" Mapping="ObjInfo2" Type="String" />
					<ext:RecordField Name="ObjInfo3" Mapping="ObjInfo3" Type="String" />
					<ext:RecordField Name="Score" Mapping="Score" Type="Int" />
					<ext:RecordField Name="EqualValue" Mapping="EqualValue" Type="Int" />
					<ext:RecordField Name="RangeValue" Mapping="RangeValue" Type="Int" />
					<ext:RecordField Name="Rank" Mapping="Rank" Type="Int" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
		<SortInfo Field="Rank" Direction="ASC" />
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="140" Padding="10" ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px">
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
							<ext:ComboBox runat="Server" ID="ComboboxRankType" FieldLabel="<%$ Resources:StringDef, RankType %>" ForceSelection="true" Editable="false" Width="275" SelectedIndex="0">
								<Items>
								</Items>
							</ext:ComboBox>
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
					<ext:GridPanel ID="GridPanelRank" runat="Server" Border="true" StoreID="StoreRank" Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn Sortable="false">
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Rank %>" DataIndex="Rank" Width="50" Align="Center" Sortable="false">
									<Renderer Fn="renderRank" />
								</ext:Column>
								<ext:Column DataIndex="ObjGUID" Width="200" Hidden="true" Sortable="false">
								</ext:Column>
								<ext:Column DataIndex="ObjInfo1" Width="200" Sortable="false">
								</ext:Column>
								<ext:Column DataIndex="ObjInfo2" Width="300" Sortable="false">
								</ext:Column>
								<ext:Column DataIndex="ObjInfo3" Width="200" Hidden="true" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Score %>" DataIndex="Score" Width="200" Align="Center" Sortable="false">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingRank" runat="server" PageSize="300" StoreID="StoreRank">
								<Items>
									<ext:ToolbarSeparator />
									<ext:Button runat="Server" ID="BtnExport" Icon="PageCode">
										<Listeners>
											<Click Fn="exportData" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
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
	
	<sat:TabRole runat="Server" />
</asp:Content>
