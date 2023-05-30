<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="data_chargereward, App_Web_chargereward.aspx.551d078a" theme="default" %>

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
		
		var msgAddRewardCfg					= '<%= Resources.StringDef.AddRewardCfg %>';
		var msgDelRewardCfgPrompt			= '<%= Resources.StringDef.MsgDelRewardCfgPrompt %>';
		var msgModifyRewardCfg				= '<%= Resources.StringDef.ModifyRewardCfg %>';
		var msgCannotBeNullFormat			= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgName							= '<%= Resources.StringDef.Name %>';
		
		var msgChargeRewardTypeFirstCharge	= '<%= Resources.StringDef.ChargeRewardTypeFirstCharge %>';
		var msgChargeRewardTypeSingleCharge	= '<%= Resources.StringDef.ChargeRewardTypeSingleCharge %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var op		= 0;				//操作：0表示新加，1表示修改。
			
			var renderType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgChargeRewardTypeFirstCharge;
					case 1:
						return msgChargeRewardTypeSingleCharge;
					default:
						return value;
				}
			}; 
			
			var getRewardCfgQueryParams = function( store, options ) {
			};
			
			var queryRewardCfg = function( reset, callback ) {
				var paramStart = 0;
				var paramLimit = #{PagingRewardCfg}.pageSize;
				
				/* If lastOptions is not null, use the start and limit parameters. */
				if( !reset && #{StoreRewardCfg}.lastOptions ) {
					paramStart = #{StoreRewardCfg}.lastOptions.params.start;
				}
				#{StoreRewardCfg}.load( { 
					params : { start: paramStart, limit: paramLimit },
					callback : callback
				} );
			};
			
			var addRewardCfg = function( ) {
				#{FormPanelRewardCfg}.reset( );
				#{ButtonRewardCfgOp}.setText( msgOK );
				#{WindowRewardCfg}.setTitle( msgAddRewardCfg );
				#{WindowRewardCfg}.show( );
				
				op = 0;
			};

			var deleteRewardCfg = function( ) {
				var grid = #{GridPanelRewardCfg};
				var record = grid.getSelectionModel( ).getSelected( );
				
				var result = showConfirmMsg( msgTitle, msgDelRewardCfgPrompt, function( btn ){
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteRewardCfg( record.data.Name, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									queryRewardCfg( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var modifyRewardCfg = function( ) {
				var record = #{GridPanelRewardCfg}.getSelectionModel( ).getSelected( );
				showRewardCfgDetail( record );				
				
				op = 1;
			};
			
			var setRewardCfg = function( ) {
				var oldName		= #{TextFieldOldName}.getValue( );
				var startTime	= getDateTimeString( #{DateFieldStartTime}.getValue( ) );
				var endTime		= getDateTimeString( #{DateFieldEndTime}.getValue( ) );
				
				Ext.net.DirectMethods.SetRewardCfg( op, oldName, startTime, endTime, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowRewardCfg}.hide( );
							queryRewardCfg( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
							queryRewardCfg( );
						}
					}
				});
			};
			
			var gridDblClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				
				showRewardCfgDetail( record );
				
				op = 1;
			};
			
			var showRewardCfgDetail = function( record ) {
				
				#{TextFieldOldName}.setValue( record.data.Name );
				#{TextFieldName}.setValue( record.data.Name );
				#{ComboType}.setValue( record.data.Type );
				#{TextFieldMin}.setValue( record.data.Min );
				#{TextFieldMax}.setValue( record.data.Max );
				#{DateFieldStartTime}.setValue( record.data.StartTime );
				#{DateFieldEndTime}.setValue( record.data.EndTime );
				#{TextFieldGiftID}.setValue( record.data.GiftID );
				#{TextFieldScript}.setValue( record.data.Script );
				
				#{WindowRewardCfg}.setTitle( msgModifyRewardCfg );
				#{WindowRewardCfg}.show( );
			};
			
			var initData = function( ) {
				queryRewardCfg( );
			};
			
			var gridRewardCfgSelectionChange = function( el ) {
				#{BtnDelRewardCfg}.setDisabled( el.getCount( ) < 1 );
				#{BtnModifyRewardCfg}.setDisabled( el.getCount( ) < 1 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreRewardCfg" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="RewardCfgRefresh" >
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelRewardCfg}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Name" Type="String" />
					<ext:RecordField Name="Type" Type="Int" />
					<ext:RecordField Name="Min" Type="String" />
					<ext:RecordField Name="Max" Type="String" />
					<ext:RecordField Name="StartTime" Type="String" />
					<ext:RecordField Name="EndTime" Type="String" />
					<ext:RecordField Name="GiftID" Type="Int" />
					<ext:RecordField Name="Script" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelRewardCfg" runat="Server" Border="false" StoreID="StoreRewardCfg" AutoExpandColumn="Name">
						<View>
							<ext:GridView ID="GridView2" runat="Server" ScrollOffset="20">
							</ext:GridView>
						</View>
						<TopBar>
							<ext:Toolbar ID="Toolbar2" runat="server">
								<Items>
									<ext:Button ID="BtnAddRewardCfg" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addRewardCfg" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyRewardCfg" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="Note" Disabled="true">
										<Listeners>
											<Click Fn="modifyRewardCfg" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelRewardCfg" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteRewardCfg" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Name %>" DataIndex="Name" Width="130" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Type" Width="120">
									<Renderer Fn="renderType" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeRewardMin %>" DataIndex="Min" Width="90">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeRewardMax %>" DataIndex="Max" Width="90">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeRewardStartTime %>" DataIndex="StartTime" Width="140" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeRewardEndTime %>" DataIndex="EndTime" Width="140" >
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, ChargeRewardGiftID %>" DataIndex="GiftID" Width="80" Align="Center" >
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingRewardCfg" runat="server" PageSize="1000" StoreID="StoreRewardCfg" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
								<Listeners>
									<SelectionChange Fn="gridRewardCfgSelectionChange" />
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
	
	<ext:Window ID="WindowRewardCfg" runat="server" Resizable="false" Width="600"
		AutoHeight="true" CloseAction="Hide" Hidden="true" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelRewardCfg" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="100" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldOldName" runat="server" AnchorHorizontal="90%" Hidden="true">
					</ext:TextField>
					<ext:TextField ID="TextFieldName" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Name %>">
					</ext:TextField>
					<ext:ComboBox ID="ComboType" runat="Server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, Type %>" Editable="false" SelectedIndex="0">
						<Items>
							<ext:ListItem Text="<%$ Resources:StringDef, ChargeRewardTypeFirstCharge %>" Value="0" />
							<ext:ListItem Text="<%$ Resources:StringDef, ChargeRewardTypeSingleCharge %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:TextField ID="TextFieldMin" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ChargeRewardMin %>" Note="<%$ Resources:StringDef, ChargeRewardMinNote %>">
					</ext:TextField>
					<ext:TextField ID="TextFieldMax" runat="server" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ChargeRewardMax %>" Note="<%$ Resources:StringDef, ChargeRewardMaxNote %>">
					</ext:TextField>
					<ext:CompositeField runat="Server" AnchorHorizontal="90%" >
						<Items>
							<ext:DateField runat="Server" ID="DateFieldStartTime" Width="314" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, ChargeRewardStartTime %>">
							</ext:DateField>
							<ext:Button runat="Server" Width="40" Text="MIN">
								<Listeners>
									<Click Handler="
										#{DateFieldStartTime}.setValue( '0001-1-1 0:00:00' );
									" />
								</Listeners>
							</ext:Button>
							<ext:Button runat="Server" Width="40" Text="MAX">
								<Listeners>
									<Click Handler="
										#{DateFieldStartTime}.setValue( '9999-1-1 0:00:00' );
									" />
								</Listeners>
							</ext:Button>
						</Items>	
					</ext:CompositeField>
					<ext:CompositeField ID="CompositeField1" runat="Server" AnchorHorizontal="90%" >
						<Items>
							<ext:DateField runat="Server" ID="DateFieldEndTime" Width="314" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, ChargeRewardEndTime %>">
							</ext:DateField>
							<ext:Button ID="Button1" runat="Server" Width="40" Text="MIN">
								<Listeners>
									<Click Handler="
										#{DateFieldEndTime}.setValue( '0001-1-1 0:00:00' );
									" />
								</Listeners>
							</ext:Button>
							<ext:Button ID="Button3" runat="Server" Width="40" Text="MAX">
								<Listeners>
									<Click Handler="
										#{DateFieldEndTime}.setValue( '9999-1-1 0:00:00' );
									" />
								</Listeners>
							</ext:Button>
						</Items>	
					</ext:CompositeField>
					<ext:NumberField runat="Server" ID="TextFieldGiftID" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ChargeRewardGiftID %>" Note="<%$ Resources:StringDef, ChargeRewardGiftIDNote %>">
					</ext:NumberField>
					<ext:TextField runat="Server" ID="TextFieldScript" AnchorHorizontal="90%" FieldLabel="<%$ Resources:StringDef, ChargeRewardScript %>" Note="<%$ Resources:StringDef, ChargeRewardScriptNote %>">
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonRewardCfgOp" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setRewardCfg" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button2" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowRewardCfg}.hide( );
					"/>
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
