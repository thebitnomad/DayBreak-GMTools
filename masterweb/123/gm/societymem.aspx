<%@ page language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_societymem, App_Web_societymem.aspx.b931aa99" theme="default" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentHolder" runat="Server">

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

		var msgLeader			= '<%= Resources.StringDef.Leader %>';
		var msgViceLeader		= '<%= Resources.StringDef.ViceLeader %>';
		var msgOfficial			= '<%= Resources.StringDef.Official %>';
		var msgElite			= '<%= Resources.StringDef.Elite %>';
		var msgMember			= '<%= Resources.StringDef.Member %>';

		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
		
	</script>

	<ext:XScript ID="XScript2" runat="Server">
		<script type="text/javascript">
			var m_ggId			= 0;			//选择的服务器ID
			
			var queryPlatform = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingSocietymem}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreSocietymem}.lastOptions ) 
				{
					paramStart = #{StoreSocietymem}.lastOptions.params.start;
				}
				#{StoreSocietymem}.load( { 
					params : { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
			var initData = function( )
			 {
				queryPlatform( );
			 };
		
			var storeSocietyGetQueryParams = function( store, options ) {
			};
							
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
			
			var renderPosition = function( value, metadata, record, rowIdex, colIndex, store ){
				switch( value ) {
				case 0:
					return msgLeader;
				case 1:
					return msgViceLeader;
				case 2:
					return msgOfficial;
				case 3:
					return msgElite;
				case 4:
					return msgMember;
				}
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" runat="Server">
	<ext:Store ID="StoreSocietymem" runat="server" RemoteSort="true" RemotePaging="true"
		OnRefreshData="SocietymemInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
				CustomTarget="#{GridPanelSocietymem}.body" MinDelay="100" />
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
					<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
					<ext:RecordField Name="RoleLevel" Mapping="RoleLevel" Type="Int" />
					<ext:RecordField Name="Position" Mapping="Position" Type="Int" />
					<ext:RecordField Name="RoleType" Mapping="RoleType" Type="Int" />
					<ext:RecordField Name="OnLine" Mapping="OnLine" Type="Boolean" />
					<ext:RecordField Name="AllContribute" Mapping="AllContribute" Type="Int" />
					<ext:RecordField Name="CurContribute" Mapping="CurContribute" Type="Int" />
					<ext:RecordField Name="JoinTime" Mapping="JoinTime" Type="String" />
					<ext:RecordField Name="LastPlayingDate" Mapping="LastPlayingDate" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport2" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="server" StyleSpec="background-color:#FFF;">
				<Center>
					<ext:GridPanel ID="GridPanelSocietymem" runat="server" Border="false" StoreID="StoreSocietymem">
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '' ; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="150" />
								<ext:Column Header="<%$ Resources:StringDef, RoleLevel %>" DataIndex="RoleLevel"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, Position %>" DataIndex="Position" Width="80">
									<Renderer Fn="renderPosition" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, RoleType %>" DataIndex="RoleType" Width="80">
									<Renderer Fn="renderRoleType" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, OnLine %>" DataIndex="OnLine" Width="100">
									<Renderer Fn="renderOnline" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, AllContirbute %>" DataIndex="AllContribute"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, CurContribute %>" DataIndex="CurContribute"
									Width="80" />
								<ext:Column Header="<%$ Resources:StringDef, JoinTime %>" DataIndex="JoinTime" Width="100" />
								<ext:Column Header="<%$ Resources:StringDef, LastPlayingDate %>" DataIndex="LastPlayingDate"
									Width="200" />
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingSocietymem" runat="server" PageSize="50" StoreID="StoreSocietymem">
								<Items>
									<ext:ToolbarSeparator />
									<ext:DisplayField ID="DisplayMsg" runat="server" StyleSpec="font-weight:bold;" />
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel runat="server" />
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
