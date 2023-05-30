<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_vip, App_Web_vip.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrSel" Src="~/common/svrsel.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.gmidx-normal, .gmidx-curr
		{
			border:1px solid #fff;
			margin:2px;
		}
		
		.gmidx-normal .x-tree-ec-icon, .gmidx-curr .x-tree-ec-icon
		{
			display:none;
		}
		
		.gmidx-normal a span
		{
			vertical-align: middle;
			height:22px;
			line-height :22px;
		}
		
		.gmidx-curr a span
		{
			vertical-align: middle;
			height:22px;
			line-height :22px;
			font-weight:bold;
		}
		
		.ext-ie8 .gmidx-normal a span, .ext-ie8 .gmidx-curr a span
		{
			padding-top:7px;
			display: inline-block;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.x-tree-selected a span
		{
			background:transparent;
			color:#15428b;
		}
				
		.gmidx-icon
		{
			height:22px !important;
			width:22px !important;
			background-image: url('../images/yellow.png') !important;
			background-repeat: no-repeat;
			vertical-align:middle !important;
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
		
		var msgQueryConditionCanNotBeNull		= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
		var msgVIPRoleGMCommandConfirmFormat	= '<%= Resources.StringDef.MsgVIPRoleGMCommandConfirmFormat %>';
		var msgAllExecSuccess					= '<%= Resources.StringDef.MsgAllExecSuccess %>';
		var msgVIPRoleGMCommandFailFormat		= '<%= Resources.StringDef.MsgVIPRoleGMCommandFailFormat %>';
		var msgNoVIPRoleSelected				= '<%= Resources.StringDef.MsgNoVIPRoleSelected %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
		
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( true );
					
					e.stopEvent( );
				}
			};
			
			var btnQueryClick = function( ) {
				
				var svrs			= svrselGetSelSvrs( );
				var minTotalCharge	= #{TextFieldMinTotalCharge}.getValue( );
				var maxTotalCharge	= #{TextFieldMaxTotalCharge}.getValue( );
				var minRoleLevel	= #{TextFieldRoleLevel}.getValue( );
				
				#{StoreVIPRoleInfo}.load( { params: { MinTotalCharge: minTotalCharge, MaxTotalCharge: maxTotalCharge, RoleLevel: minRoleLevel, SelSvr: svrs }, callback: function( records, options, success ) {
					#{GridPanelVIPRoleInfo}.setVisible( true );
				} } );
			};
		
			var switchCmd = function( node ) {
				var index = eval( node.id );
				#{PanelGMCommand}.layout.setActiveItem( #{PanelGMCommand}.items.items[index] );
			};
			
			var initData = function( ) {
				if( #{TreePanelCmdIndex}.root.childNodes.length > 0 ) {
					#{TreePanelCmdIndex}.selectPath( #{TreePanelCmdIndex}.root.childNodes[0].getPath( ) );
				}
			};
			
			var btnExecClick = function( ) {
				#{WindowConfirm}.show( );
			};
			
			var execGMCommand = function( ) {
				var records = #{GridPanelVIPRoleInfo}.getSelectionModel( ).getSelections( );
				showConfirmMsg( msgTitle, String.format( msgVIPRoleGMCommandConfirmFormat, records.length ), function( btn ){
					if( btn == "yes" ) {
						var currPanel	= #{PanelGMCommand}.layout.activeItem;
						var currIndex	= #{PanelGMCommand}.items.indexOf( currPanel );
						var reason		= #{FieldReason}.getValue( );
						var cmd			= currPanel.cmdTpl;
						var typeDesc	= currPanel.typeDesc;

						var ggIdArray	= new Array( );
						var accArray	= new Array( );
						var roleArray	= new Array( );
						for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
							ggIdArray.push( records[nLoopCount].data.GGId );
							accArray.push( records[nLoopCount].data.AccountName );
							roleArray.push( records[nLoopCount].data.RoleName );
						}
						debugger
						var paramList	= new Array( );
						for( var itemIndex = 0; currPanel.items.length; ++itemIndex ) {
							var itemId		= String.format( "ctl00_ContentHolder_GM{0}_Param{1}", currIndex, itemIndex );
							var paramItem	= Ext.get( itemId );
							if( !paramItem )
								break;
							
							var paramValue	= paramItem.getValue( );
												
		//					var paramHolder	= "{" + itemIndex + "}";
		//					cmd = cmd.replace( paramHolder, paramValue ); 

							paramList.push( paramValue );
						}
						
						Ext.net.DirectMethod.request( {
							url					: "gmservice.asmx/BatchExecGMCommand",
							cleanRequest		: true,
							json				: true,
							params				: {
								jsonggId		: ggIdArray,
								jsonAccounts	: accArray,
								jsonRoleNames	: roleArray,
								cmdTpl			: cmd,
								typeDesc		: typeDesc,
								reason			: reason,
								jsonParam		: paramList
							},
							eventMask: {
								showMask : true,
								minDelay : 200,
								msg      : msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									if( result.Result.length > 0 ) {
										showErrMsg( msgTitle, String.format( msgVIPRoleGMCommandFailFormat, result.Result.length ) + '<br />' + result.Result );
									} else {
										showSuccessMsg( msgTitle, msgAllExecSuccess );
									}
									
									#{WindowConfirm}.hide( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
		
		</script>
	</ext:XScript>
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">

<ext:Store ID="StoreVIPRoleInfo" runat="server" RemoteSort="false" RemotePaging="false" OnRefreshData="VIPRoleInfoRefresh"
	AutoLoad="false" GroupField="GGName">
	<DirectEventConfig Type="Load">
		<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
			CustomTarget="#{GridPanelVIPRoleInfo}.body" MinDelay="100" />
	</DirectEventConfig>
	<Listeners>
	</Listeners>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:ArrayReader>
			<Fields>
				<ext:RecordField Name="TotalCharge" Mapping="TotalCharge" Type="Int" />
				<ext:RecordField Name="AccountName" Mapping="AccountName" Type="String" />
				<ext:RecordField Name="AccID" Mapping="AccID" Type="Int" />
				<ext:RecordField Name="RoleName" Mapping="RoleName" Type="String" />
				<ext:RecordField Name="RoleID" Mapping="RoleID" Type="Int" />
				<ext:RecordField Name="RoleLevel" Mapping="RoleLevel" Type="Int" />
				<ext:RecordField Name="GGId" Mapping="GGId" Type="Int" />
				<ext:RecordField Name="GGName" Mapping="GGName" Type="String" />
			</Fields>
		</ext:ArrayReader>
	</Reader>
	<SortInfo Field="RoleName" Direction="ASC" />
</ext:Store>

<ext:Viewport ID="Viewport1" runat="Server">
	<Items>
		<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
			<North>
				<ext:FormPanel ID="PanelRealTimeAnnounce" runat="Server" LabelAlign="Right" LabelWidth="200"
					Title="<%$ Resources:StringDef, VIP %>" Height="160" Padding="10" 
					ButtonAlign="Center" Border="false" Margins="10px 10px 10px 10px" AnchorHorizontal="100%" StyleSpec="border:1px solid #8DB2E3;">
					<Items>
						<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
							<Items>
								<ext:Container ID="Container1" runat="Server">
									<Content>
										<sat:SvrSel ID="SvrSel1" runat="Server"></sat:SvrSel>
									</Content>
								</ext:Container>
							</Items>
						</ext:CompositeField>
						<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, TotalCharge %>"
							Width="550">
							<Items>
								<ext:NumberField runat="Server" ID="TextFieldMinTotalCharge" Width="120" Text="20000">
									<Listeners>
										<SpecialKey Fn="textFieldQuerySpecialKey" />
									</Listeners>
								</ext:NumberField>
								<ext:DisplayField runat="Server" Text=" ~ ">
								</ext:DisplayField>
								<ext:NumberField runat="Server" ID="TextFieldMaxTotalCharge" Width="120">
									<Listeners>
										<SpecialKey Fn="textFieldQuerySpecialKey" />
									</Listeners>
								</ext:NumberField>
							</Items>
						</ext:CompositeField>
						<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, RoleLevel %>"
							Width="550">
							<Items>
								<ext:TextField runat="Server" ID="TextFieldRoleLevel" Width="259" Text="20">
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
								<Click Fn="btnQueryClick" />
							</Listeners>
						</ext:Button>
					</Buttons>
				</ext:FormPanel>
			</North>
			<Center>
				<ext:GridPanel ID="GridPanelVIPRoleInfo" runat="Server" Border="true" StoreID="StoreVIPRoleInfo" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, VIPRoleInfo %>" >
					<View>
						<ext:GroupingView ID="GroupingView1" runat="server" MarkDirty="false" ShowGroupName="false" EnableNoGroups="true" HideGroupedColumn="true" >
						</ext:GroupingView>
					</View>
					<ColumnModel>
						<Columns>
							<ext:Column Header="<%$ Resources:StringDef, GameGroup  %>" DataIndex="GGName" Width="200" >
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, TotalCharge %>" DataIndex="TotalCharge" Width="200">
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, Account %>" DataIndex="AccountName" Width="250" >
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, AccID %>" DataIndex="AccID" Width="100" >
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, RoleName %>" DataIndex="RoleName" Width="200" >
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, RoleID %>" DataIndex="RoleID" Width="120" >
							</ext:Column>
							<ext:Column Header="<%$ Resources:StringDef, RoleLevel %>" DataIndex="RoleLevel" Width="100" >
							</ext:Column>
						</Columns>
					</ColumnModel>
					<TopBar>
						<ext:Toolbar ID="Toolbar1" runat="server">
							<Items>
								<ext:Button ID="BtnExecGMCmd" runat="server" Text="<%$ Resources:StringDef, ExecGMCommand %>" Icon="ApplicationOsxKey">
									<Listeners>
										<Click Handler="
											var records		= #{GridPanelVIPRoleInfo}.getSelectionModel( ).getSelections( );
											if( records.length == 0 ) {
												showErrMsg( msgTitle, msgNoVIPRoleSelected );
												return;
											}
											
											#{WindowExecGMCommand}.show( );
										" />
									</Listeners>
								</ext:Button>
								<ext:ToolbarFill />
							</Items>
						</ext:Toolbar>
					</TopBar>
					<BottomBar>
						<ext:PagingToolbar ID="PagingVIPRoleInfo" runat="server" PageSize="1000000" StoreID="StoreVIPRoleInfo" HideRefresh="true" />
					</BottomBar>
					<SelectionModel>
						<ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" >
							<Listeners>
							</Listeners>
						</ext:CheckboxSelectionModel>
					</SelectionModel>
					<Listeners>
						<%--<Command Fn="gridOnCommand" />
						<RowDblClick Fn="gridDblClick" />--%>
					</Listeners>
				</ext:GridPanel>
			</Center>
		</ext:BorderLayout>
	</Items>
</ext:Viewport>

<ext:Window ID="WindowExecGMCommand" runat="server" Maximizable="false" BodyBorder="false" Width="880" Height="460" 
	CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;" Title="<%$ Resources:StringDef, ExecGMCommand %>"	Hidden="true" Modal="true">
	<Items>
		<ext:BorderLayout runat="server">
			<West>
				<ext:TreePanel ID="TreePanelCmdIndex" runat="server" Width="240" RootVisible="false" TrackMouseOver="true" 
					Border="true" AutoScroll="true" Title="<%$ Resources:StringDef, GMCommand %>">
					<Root>
					</Root>
					<Listeners>
						<Click Handler="switchCmd( node );" />
					</Listeners>
				</ext:TreePanel>
			</West>
			<Center>
				<ext:Panel ID="Panel1" runat="Server" Border="false">
					<Items>
						<ext:BorderLayout runat="Server" StyleSpec="background-color:white;">
							<Center>
								<ext:Panel ID="PanelGMCommand" runat="server" Padding="15" Height="300" Layout="card" Border="false"
									ActiveIndex="0" Title="<%$ Resources:StringDef, Param %>" StyleSpec="margin-left:5px; border:1px solid #8DB2E3; background-color:white;" ButtonAlign="Center" >
									<Items>
									</Items>
									<Buttons>
										<ext:Button ID="btnExec" runat="server" Text="<%$ Resources:StringDef, Execute %>" Scale="Medium" Width="150" Icon="BulletGo">
											<Listeners>
												<Click Fn="btnExecClick" />
											</Listeners>
										</ext:Button>
									</Buttons>
								</ext:Panel>				
							</Center>
						</ext:BorderLayout>
					</Items>
				</ext:Panel>
			</Center>
		</ext:BorderLayout>
	</Items>
</ext:Window>

<ext:Window ID="WindowConfirm" runat="server" Resizable="false" Maximizable="false"
	Width="500" Height="110" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
	Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
	<Items>
		<ext:BorderLayout ID="BorderLayout3" runat="server">
			<Center>
				<ext:FormPanel ID="PanelConfirm" runat="Server" LabelAlign="Right" LabelWidth="80"
					ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
					<Items>
						<ext:ComboBox ID="FieldReason" AnchorHorizontal="95%" runat="Server" FieldLabel="<%$ Resources:StringDef, Reason %>" Editable="true" ForceSelection="false">
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason1 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason2 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason3 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason4 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason5 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason6 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason7 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason8 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason9 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason10 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason11 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason12 %>" />
							</Items>
						</ext:ComboBox>
					</Items>
				</ext:FormPanel>
			</Center>
		</ext:BorderLayout>
	</Items>
	<Buttons>
		<ext:Button ID="BtnConfirm" runat="Server" Text="<%$ Resources:StringDef, Ok %>">
			<Listeners>
				<Click Fn="execGMCommand" />
			</Listeners>
		</ext:Button>
		<ext:Button ID="BtnConfirmCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
			<Listeners>
				<Click Handler="
					#{WindowConfirm}.hide( );
				" />
			</Listeners>
		</ext:Button>
	</Buttons>
</ext:Window>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>