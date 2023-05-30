<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_announce, App_Web_announce.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrSel" Src="~/common/svrsel.ascx" %>
<%@ Register TagPrefix="sat" TagName="SvrSel2" Src="~/common/svrsel2.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
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
		var msgDeleteAnnounceConfirmFormat	= '<%= Resources.StringDef.MsgDeleteAnnounceConfirmFormat %>';
		var msgTimingAnnouncement			= '<%= Resources.StringDef.TimingAnnouncement %>';
		var msgAdd							= '<%= Resources.StringDef.Add %>';
		var msgModify						= '<%= Resources.StringDef.Modify %>';
		var msgAllGameServer				= '<%= Resources.StringDef.AllGameServer %>';
		var msgCommonOpConfirm				= '<%= Resources.StringDef.MsgCommonOpConfirm %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_selAnn;					//选择的公告
		
			var renderDateTime = function( value, metadata, record, rowIndex, colIndex, store ) {
				return value.replace( / /g, "<br />" );
			};
			
			var renderContent = function( value, metadata, record, rowIndex, colIndex, store ) {
				return String.format( "<div style='white-space:normal;'>{0}</div>", value );
			};
			
			var renderSvr = function( value, metadata, record, rowIndex, colIndex, store ) {
				var allgamegroups = record.data.AllGameGroups;
				if( allgamegroups ) {
					return msgAllGameServer;
				} else {
					return record.data.GameGroupNames;
				}
			};
		
			var btnSendClick = function( ) {
				var content = #{TextAnnContent}.getValue( );
				var svrs	= svrselGetSelSvrs( );
				
				Ext.net.DirectMethods.SendRealTimeAnnounce( svrs, content, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							showSuccessMsg( msgTitle, msgSendSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var annContentKeydown = function( el, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					e.stopEvent( );
				}
			};
			
			var btnAddAnnounceClick = function( ) {
				#{FormPanelTimingAnnounce}.reset( );
				
				svrsel2SetSelSvrs( "-1" );
				
				var now		= new Date( );
				var begin	= now.clearTime( );
				var finish	= begin.add( Date.DAY, 1 ).add( Date.SECOND, -1 );
				#{DateFieldBeginTime}.setValue( begin );
				#{DateFieldFinishTime}.setValue( finish );
				#{NumberFieldInterval}.setValue( 60 );
				
				#{WindowAnnounce}.setTitle( msgTimingAnnouncement + " - " + msgAdd );
				#{WindowAnnounce}.show( );
			};
			
			var btnSetTimingAnnClick = function( ) {
				var annId		= #{TextAnnId}.getValue( );
				var annDesc		= #{TextFieldAnnDesc}.getValue( );
				var beginTime	= getDateTimeString( #{DateFieldBeginTime}.getValue( ) );
				var finishTime	= getDateTimeString( #{DateFieldFinishTime}.getValue( ) );
				var interval	= #{NumberFieldInterval}.getValue( );
				var content		= #{TextTimingAnnContent}.getValue( );
				var svrs		= svrsel2GetSelSvrs( );
			
				Ext.net.DirectMethods.SetTimingAnnounce( annId, annDesc, beginTime, finishTime, interval, svrs, content, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							//showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowAnnounce}.hide( );
							#{StoreAnnounce}.reload( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var gridOnCommand = function( command, record, rowIndex, colIndex ) {
				m_selAnn = record;
				
				switch( command ) {
					case "Modify":
						{
							modifyTimingAnn( );
						}
						break;
					case "Delete":
						{
							deleteTimingAnn( );
						}
						break;
					case "Execute":
						{
							executeTimingAnn( );
						}
						break;
				}
			};
			
			var modifyTimingAnn = function( ) {
				#{FormPanelTimingAnnounce}.reset( );
				
				#{TextAnnId}.setValue( m_selAnn.data.Id );
				#{TextFieldAnnDesc}.setValue( m_selAnn.data.Name );
				#{DateFieldBeginTime}.setValue( m_selAnn.data.BeginTime );
				#{DateFieldFinishTime}.setValue( m_selAnn.data.FinishTime );
				#{NumberFieldInterval}.setValue( m_selAnn.data.Interval );
				#{TextTimingAnnContent}.setValue( m_selAnn.data.Content );
				
				if( m_selAnn.data.AllGameGroups )
					svrsel2SetSelSvrs( "-1" );
				else
					svrsel2SetSelSvrs( m_selAnn.data.GameGroupNames );
				
				#{WindowAnnounce}.setTitle( msgTimingAnnouncement + " - " + msgModify + String.format( "[{0}]", m_selAnn.data.Name ) );
				#{WindowAnnounce}.show( );
			};
			
			var deleteTimingAnn = function( ) {
				var annId	= m_selAnn.data.Id;
				var annDesc	= m_selAnn.data.Name;
			
				showConfirmMsg( msgTitle, String.format( msgDeleteAnnounceConfirmFormat, annDesc ), function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteTimingAnnounce( annId, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									//showSuccessMsg( msgTitle, msgSendSuc );
									#{StoreAnnounce}.reload( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var executeTimingAnn = function( ) {
				var annId	= m_selAnn.data.Id;
				var annDesc	= m_selAnn.data.Name;
			
				showConfirmMsg( msgTitle, msgCommonOpConfirm, function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.ExecuteTimingAnnounce( annId, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgSendSuc );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var gridDblClick = function( grid, rowIndex, e ) {
				m_selAnn = grid.store.getAt( rowIndex );
				modifyTimingAnn( );
			};
			
			var showSvrTip = function( ) {
				var rowIndex	= #{GridPanelAnnounce}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelAnnounce}.view.findCellIndex( this.triggerElement );
				var record		= #{StoreAnnounce}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				if( cellIndex != 7 ) {
					this.hide( );
					return;
				}
				
				if( record.data.AllGameGroups ) {
					this.hide( );
					return;
				}
				
				var el = #{GridPanelAnnounce}.view.getCell( rowIndex, cellIndex );
				this.body.dom.innerHTML = el.innerHTML;
			};
			
			var initData = function( ) {
				#{StoreAnnounce}.reload( );
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreAnnounce" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreAnnounceRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelAnnounce}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="BeginTime" Mapping="BeginTime" Type="String" />
					<ext:RecordField Name="FinishTime" Mapping="FinishTime" Type="String" />
					<ext:RecordField Name="NextExecuteTime" Mapping="NextExecuteTime" Type="String" />
					<ext:RecordField Name="Interval" Mapping="Interval" Type="Int" />
					<ext:RecordField Name="Enabled" Mapping="Enabled" Type="Boolean" />
					<ext:RecordField Name="AllGameGroups" Mapping="AllGameGroups" Type="Boolean" />
					<ext:RecordField Name="GameGroupNames" Mapping="GameGroupNames" Type="String" />
					<ext:RecordField Name="Content" Mapping="Content" Type="String" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="PanelRealTimeAnnounce" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, RealTimeAnnouncement %>" Height="200" Padding="10" 
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
							<ext:TextArea ID="TextAnnContent" runat="Server" Width="500" Height="80" FieldLabel="<%$ Resources:StringDef, Content %>" EnableKeyEvents="true">
								<Listeners>
									<KeyDown Fn="annContentKeydown" />
								</Listeners>
							</ext:TextArea>
						</Items>
						<Buttons>
							<ext:Button ID="BtnSend" runat="Server" Text="<%$ Resources:StringDef, ImmediateSend %>">
								<Listeners>
									<Click Fn="btnSendClick" />
								</Listeners>
							</ext:Button>
						</Buttons>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:GridPanel ID="GridPanelAnnounce" runat="Server" Border="true" StoreID="StoreAnnounce" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, TimingAnnouncement %>" ColumnLines="true" AutoExpandColumn="Content" >
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="40" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Name" Width="100">
									<Renderer Fn="renderContent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, BeginTime %>" DataIndex="BeginTime" Width="80" Align="Center">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, FinishTime %>" DataIndex="FinishTime" Width="80" Align="Center">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Interval %>" DataIndex="Interval" Width="60" Align="Center" >
								</ext:Column>
								<ext:BooleanColumn Header="<%$ Resources:StringDef, State %>" DataIndex="Enabled"
									Width="60" Align="Center" TrueText="<%$ Resources:StringDef, Enabled %>" FalseText="<%$ Resources:StringDef, Disabled %>">
								</ext:BooleanColumn>
								<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="GameGroupNames" Width="80" Align="Center">
									<Renderer Fn="renderSvr" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Content %>" DataIndex="Content" Align="Left" Wrap="true">
									<Renderer Fn="renderContent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NextExecuteTime %>" DataIndex="NextExecuteTime" Width="90" Align="Center">
									<Renderer Fn="renderDateTime" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Publisher %>" DataIndex="UserName" Align="Center" Width="100">
								</ext:Column>
								<ext:CommandColumn Width="150">
									<Commands>
										<ext:GridCommand CommandName="Modify" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" />
										<ext:GridCommand CommandName="Delete" Text="<%$ Resources:StringDef, Delete %>" Icon="Decline" />
										<ext:GridCommand CommandName="Execute" Text="<%$ Resources:StringDef, Execute %>" Icon="PlayGreen" />
									</Commands>
									<%--<PrepareToolbar Fn="prepareRoleToolbar" />--%>
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<TopBar>
							<ext:Toolbar runat="Server">
								<Items>
									<ext:Button runat="Server" ID="BtnAddAnnounce" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="btnAddAnnounceClick" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingAnnounce" runat="server" PageSize="100" StoreID="StoreAnnounce" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
						<Listeners>
							<Command Fn="gridOnCommand" />
							<RowDblClick Fn="gridDblClick" />
						</Listeners>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<ext:Window ID="WindowAnnounce" runat="Server" Width="650" Height="300" CloseAction="Hide"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, TimingAnnouncement %>" BodyBorder="false">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:FormPanel ID="FormPanelTimingAnnounce" runat="Server" LabelAlign="Right" LabelWidth="100"
						Padding="10" ButtonAlign="Center" Border="false" 
						AnchorHorizontal="100%" StyleSpec="border:1px solid #8DB2E3;">
						<Items>
							<ext:TextField ID="TextAnnId" runat="Server" Hidden="true"></ext:TextField>
							<ext:TextField ID="TextFieldAnnDesc" runat="Server" FieldLabel="<%$ Resources:StringDef, Desc %>" Width="500"></ext:TextField>
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container2" runat="Server">
										<Content>
											<sat:SvrSel2 ID="SvrSel2" runat="Server"></sat:SvrSel2>
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:DateField runat="Server" ID="DateFieldBeginTime" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, BeginTime %>" Width="500"></ext:DateField>
							<ext:DateField runat="Server" ID="DateFieldFinishTime" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, FinishTime %>" Width="500"></ext:DateField>
							<ext:NumberField runat="Server" ID="NumberFieldInterval" FieldLabel="<%$ Resources:StringDef, IntervalMin %>" Width="500"></ext:NumberField>
							<ext:TextArea ID="TextTimingAnnContent" runat="Server" Width="500" Height="80" FieldLabel="<%$ Resources:StringDef, Content %>" EnableKeyEvents="true">
								<Listeners>
									<KeyDown Fn="annContentKeydown" />
								</Listeners>
							</ext:TextArea>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnSetTimingAnn" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="btnSetTimingAnnClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowAnnounce}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTip" runat="server" Target="#{GridPanelAnnounce}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" ShowDelay="0">
		<Listeners>
			<Show Fn="showSvrTip" />
		</Listeners>
	</ext:ToolTip>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

