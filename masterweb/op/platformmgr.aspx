<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_platformmgr, App_Web_platformmgr.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
	</style>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgAddPlatform				= '<%= Resources.StringDef.AddPlatform %>';
		var msgDelPlatformPrompt		= '<%= Resources.StringDef.MsgDelPlatformPrompt %>';
		var msgModifyPlatform			= '<%= Resources.StringDef.ModifyPlatform %>';
		var msgCannotBeNullFormat		= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgName						= '<%= Resources.StringDef.Name %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var platformOp		= 0;				//操作：0表示新加，1表示修改。
			
			var getPlatformQueryParams = function( store, options ) {
				
			};
			
			var queryPlatform = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingPlatform}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StorePlatform}.lastOptions ) {
					paramStart = #{StorePlatform}.lastOptions.params.start;
				}
				#{StorePlatform}.load( { 
					params : { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
			var addPlatform = function( ) {
				#{TextFieldId}.setVisible( false );
			
				#{FormPanelPlatform}.reset( );
				#{ButtonPlatformOp}.setText( msgOK );
				#{WindowPlatform}.setTitle( msgAddPlatform );
				#{WindowPlatform}.show( );
				
				platformOp = 0;
			};

			var deletePlatform = function( ) {
				var grid = #{GridPanelPlatform};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelPlatformPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeletePlatform( parseInt( record.data.Id, 10 ), {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryPlatform( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyPlatform = function( ) {
				#{TextFieldId}.setVisible( true );
			
				var record = #{GridPanelPlatform}.getSelectionModel( ).getSelected( );
				showPlatformDetail( record );				
				
				platformOp = 1;
			};
			
			var setPlatform = function( ) {
				var platformName = #{TextFieldName}.getValue( );
				if( platformName.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgName ) );
					return;
				}
				
				var platformId = #{TextFieldId}.getValue( );
				Ext.net.DirectMethods.SetPlatform( platformOp, platformId, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowPlatform}.hide( );
							queryPlatform( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryPlatform( );
						}
					}
				});
			};
			
			var gridDblClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				
				showPlatformDetail( record );
				
				platformOp = 1;
			};
			
			var showPlatformDetail = function( record ) {
				
				#{TextFieldId}.setValue( record.data.Id );
				#{TextFieldName}.setValue( record.data.Name );
				#{TextFieldShortName}.setValue( record.data.ShortName );
				#{TextFieldDomainName}.setValue( record.data.DomainName );
				#{TextFieldErrUrl}.setValue( record.data.ErrUrl );
				#{TextFieldMaintainUrl}.setValue( record.data.MaintainUrl );
				#{TextFieldChargeUrl}.setValue( record.data.ChargeUrl );
				#{TextFieldHomepageUrl}.setValue( record.data.HomepageUrl );
				#{TextFieldKefuUrl}.setValue( record.data.KefuUrl );
				#{TextFieldBBSUrl}.setValue( record.data.BBSUrl );
				#{TextFieldFCMUrl}.setValue( record.data.FCMUrl );
				#{TextFieldFavUrl}.setValue( record.data.FavUrl );
				#{TextFieldUpdateVer}.setValue( record.data.UpdateVer );
				#{TextFieldSelfUpdateVer}.setValue( record.data.SelfUpdateVer );
				#{TextFieldPriorityVer}.setValue( record.data.PriorityVer );
				#{TextFieldPaymentGameId}.setValue( record.data.PaymentGameId );
				
				#{WindowPlatform}.setTitle( msgModifyPlatform );
				#{WindowPlatform}.show( );
			};
			
			var initData = function( ) {
				queryPlatform( );
			};
			
			var gridPlatformSelectionChange = function( el ) {
				#{BtnDelPlatform}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyPlatform}.setDisabled( el.getCount( ) < 1 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StorePlatform" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="PlatformRefresh" >
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelPlatform}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="ShortName" Mapping="ShortName" Type="String" />
					<ext:RecordField Name="DomainName" Mapping="DomainName" Type="String" />
					<ext:RecordField Name="ErrUrl" Mapping="ErrUrl" Type="String" />
					<ext:RecordField Name="MaintainUrl" Mapping="MaintainUrl" Type="String" />
					<ext:RecordField Name="ChargeUrl" Mapping="ChargeUrl" Type="String" />
					<ext:RecordField Name="HomepageUrl" Mapping="HomepageUrl" Type="String" />
					<ext:RecordField Name="KefuUrl" Mapping="KefuUrl" Type="String" />
					<ext:RecordField Name="BBSUrl" Mapping="BBSUrl" Type="String" />
					<ext:RecordField Name="FCMUrl" Mapping="FCMUrl" Type="String" />
					<ext:RecordField Name="FavUrl" Mapping="FavUrl" Type="String" />
					<ext:RecordField Name="UpdateVer" Mapping="UpdateVer" Type="String" />
					<ext:RecordField Name="SelfUpdateVer" Mapping="SelfUpdateVer" Type="String" />
					<ext:RecordField Name="PriorityVer" Mapping="PriorityVer" Type="String" />
					<ext:RecordField Name="SvrCount" Mapping="SvrCount" Type="Int" />
					<ext:RecordField Name="PaymentGameId" Mapping="PaymentGameId" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelPlatform" runat="Server" Border="false" StoreID="StorePlatform" > <%--ColumnLines="true"--%>
						<View>
							<ext:GridView ID="GridView2" runat="Server" ScrollOffset="20">
							</ext:GridView>
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnAddPlatform" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addPlatform" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelPlatform" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deletePlatform" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyPlatform" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="Note" Disabled="true">
										<Listeners>
											<Click Fn="modifyPlatform" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="50" Align="Center" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="150" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ShortName %>" DataIndex="ShortName" Width="100" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SvrCount %>" DataIndex="SvrCount" Width="100" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, DomainName %>" DataIndex="DomainName" Width="200" Align="Center" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PaymentGameId %>" DataIndex="PaymentGameId" Width="150" Align="Center" >
								</ext:Column>
								<%--<ext:Column Header="<%$ Resources:StringDef, UpdateVer %>" DataIndex="UpdateVer" Width="120" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, SelfUpdateVer %>" DataIndex="SelfUpdateVer" Width="120" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, PriorityVer %>" DataIndex="PriorityVer" Width="120" Align="Center" >
								</ext:Column>--%>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingPlatform" runat="server" PageSize="1000" StoreID="StorePlatform" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridPlatformSelectionChange" />
								</Listeners>
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<RowDblClick Fn="gridDblClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowPlatform" runat="server" Resizable="false" Width="600"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelPlatform" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Id %>" Disabled="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldShortName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ShortName %>" Note="<%$ Resources:StringDef, MsgShortNameNote %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldDomainName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, DomainName %>" Note="<%$ Resources:StringDef, MsgDomainNameNote %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldErrUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ErrUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldMaintainUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, MaintainUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldChargeUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ChargeUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldHomepageUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, HomepageUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldKefuUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, KefuUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldBBSUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, BBSUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldFCMUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, FCMUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldFavUrl" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, FavUrl %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldUpdateVer" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, UpdateVer %>" Note="<%$ Resources:StringDef, MsgUpdateVerNote %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldSelfUpdateVer" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, SelfUpdateVer %>" Note="<%$ Resources:StringDef, MsgSelfUpdateVerNote %>" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldPriorityVer" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, PriorityVer %>" Note="<%$ Resources:StringDef, MsgPriorityVerNote %>" Hidden="true">
					</ext:TextField>
					<ext:NumberField ID="TextFieldPaymentGameId" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, PaymentGameId %>" Note="<%$ Resources:StringDef, MsgPaymentGameIdNote %>">
					</ext:NumberField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonPlatformOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setPlatform" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button2" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowPlatform}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
