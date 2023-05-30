<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="automation_strategy, App_Web_strategy.aspx.457e0403" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.note
		{
			color:red !important;
			font-weight:bold;
		}
	</style>
	
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';

		var msgSendSuc						= '<%= Resources.StringDef.SendSuc %>';
		var msgOpSuc						= '<%= Resources.StringDef.OpSuc %>';
		var msgAdd							= '<%= Resources.StringDef.Add %>';
		var msgModify						= '<%= Resources.StringDef.Modify %>';
		var msgAllGameServer				= '<%= Resources.StringDef.AllGameServer %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_selStrategy;				//选择的策略
		
			var btnAddStrategyClick = function( ) {
				

				//#{WindowStrategy}.setTitle( msgTimingAnnouncement + " - " + msgAdd );
				#{WindowStrategy}.show( );
			};
			
			var btnSetStrategyClick = function( ) {
//				var id			= #{TextAnnId}.getValue( );
//				var annDesc		= #{TextFieldAnnDesc}.getValue( );
//				var beginTime	= getDateTimeString( #{DateFieldBeginTime}.getValue( ) );
//				var finishTime	= getDateTimeString( #{DateFieldFinishTime}.getValue( ) );
//				var interval	= #{NumberFieldInterval}.getValue( );
//				var content		= #{TextTimingAnnContent}.getValue( );
			
//				Ext.net.DirectMethods.SetStrategy( annId, annDesc, beginTime, finishTime, interval, svrs, content, {
//					eventMask: {
//						showMask: true,
//						minDelay: 200,
//						msg: msgSubmitting
//					},
//					success: function( result ) {
//						if( result.Success ) {
//							#{WindowStrategy}.hide( );
//							#{StoreStrategy}.reload( );
//						}
//						else if( result.ErrorMessage ) {
//							showErrMsg( msgTitle, result.ErrorMessage );
//						}
//					}
//				} );
			};
			
			var gridOnCommand = function( command, record, rowIndex, colIndex ) {
				m_selAnn = record;
				
				switch( command ) {
					case "Modify":
						{
							modifyStrategy( );
						}
						break;
					case "Delete":
						{
							deleteStrategy( );
						}
						break;
				}
			};
			
			var modifyStrategy = function( ) {
//				#{FormPanelTimingAnnounce}.reset( );
//				
//				#{TextAnnId}.setValue( m_selAnn.data.Id );
//				#{TextFieldAnnDesc}.setValue( m_selAnn.data.Name );
//				#{DateFieldBeginTime}.setValue( m_selAnn.data.BeginTime );
//				#{DateFieldFinishTime}.setValue( m_selAnn.data.FinishTime );
//				#{NumberFieldInterval}.setValue( m_selAnn.data.Interval );
//				#{TextTimingAnnContent}.setValue( m_selAnn.data.Content );
//				
//				#{WindowStrategy}.setTitle( msgTimingAnnouncement + " - " + msgModify + String.format( "[{0}]", m_selAnn.data.Name ) );
//				#{WindowStrategy}.show( );
			};
			
			var deleteStrategy = function( ) {
//				var annId	= m_selAnn.data.Id;
//				var annDesc	= m_selAnn.data.Name;
//			
//				showConfirmMsg( msgTitle, String.format( msgDeleteAnnounceConfirmFormat, annDesc ), function( btn ) {
//					if( btn == "yes" ) {
//						Ext.net.DirectMethods.DeleteTimingAnnounce( annId, {
//							eventMask: {
//								showMask: true,
//								minDelay: 200,
//								msg: msgSubmitting
//							},
//							success: function( result ) {
//								if( result.Success ) {
//									//showSuccessMsg( msgTitle, msgSendSuc );
//									#{StoreAnnounce}.reload( );
//								}
//								else if( result.ErrorMessage ) {
//									showErrMsg( msgTitle, result.ErrorMessage );
//								}
//							}
//						} );
//					}
//				} );
			};
			
			var gridDblClick = function( grid, rowIndex, e ) {
				m_selStrategy = grid.store.getAt( rowIndex );
				modifyStrategy( );
			};
			
			var refreshStopUnexpect = function( ) {
				Ext.net.DirectMethods.RefreshStopUnexpect( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
							#{FieldStopUnexpectId}.setValue( result.Result.Id );
							#{FieldStopUnexpectMail}.setValue( result.Result.MailReceivers );
							#{FieldStopUnexpectSMS}.setValue( result.Result.SMSReceivers );
							#{ComboStopUnexpectAutoStart}.setValue( result.Result.AutoRestart );
							#{FieldStopUnexpectNote}.setVisible( result.Result.Id <= 0 );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var btnStopUnexpectSaveClick = function( ) {
			
				var id				= #{FieldStopUnexpectId}.getValue( );
				var mailReceivers	= #{FieldStopUnexpectMail}.getValue( );
				var smsReceivers	= #{FieldStopUnexpectSMS}.getValue( );
				var autoRestart		= #{ComboStopUnexpectAutoStart}.getValue( );
				
				Ext.net.DirectMethods.SetStopUnexpect( id, mailReceivers, smsReceivers, autoRestart, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgOpSuc );
						
							refreshStopUnexpect( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var initData = function( ) {
				refreshStopUnexpect( );
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<%--<ext:Store ID="StoreStrategy" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreStrategyRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelStrategy}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
					<ext:RecordField Name="Event" Mapping="Event" Type="String" />
					<ext:RecordField Name="Automation" Mapping="Automation" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>--%>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:TabPanel ID="TabPanel1" runat="Server" Border="false" TabPosition="Top">
						<Items>
							<ext:FormPanel ID="PanelStopUnexpect" runat="Server" LabelAlign="Right" LabelWidth="80" Width="600"
								Title="<%$ Resources:StringDef, GameStopUnexpect %>" Height="180" Padding="10" AnchorHorizontal="100%" ButtonAlign="Center" Border="true">
								<Items>
									<ext:TextField ID="FieldStopUnexpectId" runat="Server" Width="500" Hidden="true">
									</ext:TextField>
									<ext:TextArea ID="FieldStopUnexpectMail" runat="Server" FieldLabel="<%$ Resources:StringDef, MailReceivers %>" Width="500">
									</ext:TextArea>
									<ext:TextArea ID="FieldStopUnexpectSMS" runat="Server" FieldLabel="<%$ Resources:StringDef, SMSReceivers %>" Width="500">
									</ext:TextArea>
									<ext:ComboBox ID="ComboStopUnexpectAutoStart" runat="Server" FieldLabel="<%$ Resources:StringDef, AutoRestart %>" Editable="false" Width="500" SelectedIndex="0">
										<Items>
											<ext:ListItem Value="1" Text="<%$ Resources:StringDef, On %>" />
											<ext:ListItem Value="0" Text="<%$ Resources:StringDef, Off %>" />
										</Items>
									</ext:ComboBox>
									<ext:DisplayField ID="FieldStopUnexpectNote" runat="Server" Text="<%$ Resources:StringDef, MsgStrategyNotConfig %>" Cls="note" Hidden="true">
									</ext:DisplayField>
									<ext:DisplayField ID="DisplayField1" runat="Server">
									</ext:DisplayField>
									<ext:CompositeField ID="FieldStopUnexpectBtn" runat="Server">
										<Items>
											<ext:Button ID="BtnStopUnexpectSave" runat="Server" Text="<%$ Resources:StringDef, Save %>" Width="80">
												<Listeners>
													<Click Fn="btnStopUnexpectSaveClick" />
												</Listeners>
											</ext:Button>
										</Items>
									</ext:CompositeField>
								</Items>
							</ext:FormPanel>
						</Items>
					</ext:TabPanel>
				
					<%--<ext:GridPanel ID="GridPanelStrategy" runat="Server" Border="false" StoreID="StoreStrategy" ColumnLines="true" >
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="40" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Name" Width="100">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Event %>" DataIndex="Event" Width="80" Align="Center">
								</ext:Column>
								<ext:BooleanColumn Header="<%$ Resources:StringDef, State %>" DataIndex="Enabled"
									Width="60" Align="Center" TrueText="<%$ Resources:StringDef, Enabled %>" FalseText="<%$ Resources:StringDef, Disabled %>">
								</ext:BooleanColumn>
								<ext:CommandColumn Width="100">
									<Commands>
										<ext:GridCommand CommandName="Modify" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" />
										<ext:GridCommand CommandName="Delete" Text="<%$ Resources:StringDef, Delete %>" Icon="Decline" />
									</Commands>
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="Server">
								<Items>
									<ext:Button runat="Server" ID="BtnAddStrategy" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="btnAddStrategyClick" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingStrategy" runat="server" PageSize="100" StoreID="StoreStrategy" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<Command Fn="gridOnCommand" />
							<RowDblClick Fn="gridDblClick" />
						</Listeners>
					</ext:GridPanel>--%>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowStrategy" runat="Server" Width="650" Height="300" CloseAction="Hide"
		Hidden="true" Modal="true" BodyBorder="false">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:FormPanel ID="FormPanelStrategy" runat="Server" LabelAlign="Right" LabelWidth="100"
						Padding="10" ButtonAlign="Center" Border="false" 
						AnchorHorizontal="100%" StyleSpec="border:1px solid #8DB2E3;">
						<Items>
							<ext:TextField ID="TextAnnId" runat="Server" Hidden="true"></ext:TextField>
							<ext:TextField ID="TextFieldAnnDesc" runat="Server" FieldLabel="<%$ Resources:StringDef, Desc %>" Width="500"></ext:TextField>
							<ext:ComboBox ID="ComboEvent" runat="Server" FieldLabel="<%$ Resources:StringDef, Event %>">
							</ext:ComboBox>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnSetStrategy" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="btnSetStrategyClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowStrategy}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

