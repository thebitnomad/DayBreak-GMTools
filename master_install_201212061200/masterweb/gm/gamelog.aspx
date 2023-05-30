<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_gamelog, App_Web_gamelog.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="TabRole" Src="~/gm/tabrole.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
		var msgCannotBeNullFormat			= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var msgLogEvent						= '<%= Resources.StringDef.LogEvent %>';
		var msgLogEvent						= '<%= Resources.StringDef.LogEvent %>';
		var msgGameLogQueryConditionWarning	= '<%= Resources.StringDef.MsgGameLogQueryConditionWarning %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_ggId		= 0;			//选择的服务器ID
			
			var renderLogEvent = function( value, metadata, record, rowIndex, colIndex, store ) {
				var index = #{StoreEvent}.find( "LogEvent", value );
				if( index != -1 ) {
					return #{StoreEvent}.getAt( index ).data.EvtDesc;
				}
				else {
					return value;
				}
			}; 
			
			var storeRoleGetQueryParams = function( store, options ) {
				var svrId		= svrComboGetSelectedSvrId( );
				
				var logStr1		= #{TextFieldQueryLogStr1}.getValue( );
				var logStr2		= #{TextFieldQueryLogStr2}.getValue( );
				var logStr3		= #{TextFieldQueryLogStr3}.getValue( );
				var logStr4		= #{TextFieldQueryLogStr4}.getValue( );
				var logInt64	= #{TextFieldQueryLogInt64}.getValue( );
				
				var evtIds		= #{TextFieldQueryEvtIds}.getValue( );
				var roleName1	= #{CheckStr1RoleName}.getValue( );
				var roleName2	= #{CheckStr2RoleName}.getValue( );
				var startTime	= #{DateStart}.getValue( );
				var endTime		= #{DateEnd}.getValue( );

				options.params.LogStr1		= logStr1;
				options.params.LogStr2		= logStr2;
				options.params.LogStr3		= logStr3;
				options.params.LogStr4		= logStr4;
				options.params.LogInt64		= logInt64;
				
				options.params.RoleName1	= roleName1;
				options.params.RoleName2	= roleName2;
	
				options.params.EvtIds		= evtIds;
				options.params.StartTime	= startTime;
				options.params.EndTime		= endTime;
				
				options.params.SvrId		= svrId;
			};
		
			var btnQueryClick = function( reset, force ) {
				var evtIds = #{TextFieldQueryEvtIds}.getValue( );
				if( evtIds.length == 0 ) {
					showErrMsg( msgTitle, String.format( msgCannotBeNullFormat, msgLogEvent ) );
					return;
				}
				
				var logstr1 = #{TextFieldQueryLogStr1}.getValue( );
				var logstr2 = #{TextFieldQueryLogStr2}.getValue( );
				
				if( force || logstr1.length > 0 || logstr2.length > 0 ) {
					var paramStart = 0;
					var paramLimit = #{PagingLog}.pageSize;
					
					/* If lastOptions is not null, use the start and limit parameters. */
					if( !reset && #{StoreLog}.lastOptions ) {
						paramStart = #{StoreLog}.lastOptions.params.start;
					}

					#{StoreLog}.load( { params: { start: paramStart, limit: paramLimit }, callback: function( records, options, success ) {
						#{GridPanelLog}.setVisible( true );
						m_ggId = svrComboGetSelectedSvrId( );
					} } );
				} else {
					showConfirmMsg( msgTitle, msgGameLogQueryConditionWarning, function( btn ){
						if( btn == "yes" ) {
							btnQueryClick( reset, true );
						}
					} );
				}
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					btnQueryClick( );
					
					e.stopEvent( );
				}
			};
			
			var prepareRoleToolbar = function( grid, toolbar, rowIndex, record ) {
//				var btnStartGame	= toolbar.items.get( 0 );
//				var btnStopGame		= toolbar.items.get( 1 );
//				var btnUpdateGame	= toolbar.items.get( 2 );
//				var btnSvrUpload	= toolbar.items.get( 3 );
//				var btnModify		= toolbar.items.get( 4 );
//				var btnConfig		= toolbar.items.get( 5 );

//				btnStartGame.setDisabled( record.data.GameStatus != 1 );
//				btnStopGame.setDisabled( record.data.GameStatus != 3 );
//				btnSvrUpload.setDisabled( record.data.NetStatus != 1 );
//				btnUpdateGame.setDisabled( record.data.NetStatus != 1 );
//				btnConfig.setDisabled( record.data.ProcId == -1 );
			};
			
			var gridQueryResultRowDBClick = function( grid, rowIndex, e ) {
				var record		= grid.store.getAt( rowIndex );
				var roleGUID	= record.data.RoleGUID;
				var roleName	= record.data.RoleName;
				
				tabRoleLoadRoleInfo( m_ggId, roleGUID, roleName );
			};
			
			var evtCheckGroupCollapse = function( checkgroupid, check ) {
				var el = Ext.getCmp( "ctl00_ContentHolder_" + checkgroupid );
				for( var nLoopCount = 0; nLoopCount < el.items.length; ++nLoopCount ) {
					if( el.items.items ) {
						el.items.items[nLoopCount].setValue( check );
					}
				}
			};
			
			var setSelState = function( checkgroupid, type ) {
				var el = Ext.getCmp( "ctl00_ContentHolder_" + checkgroupid );
				for( var nLoopCount = 0; nLoopCount < el.items.length; ++nLoopCount ) {
					if( el.items.items ) {
						switch( type ) {
							case 0:
								el.items.items[nLoopCount].setValue( true );
								break;
							case 1:
								el.items.items[nLoopCount].setValue( false );
								break;
							case 2:
								el.items.items[nLoopCount].setValue( !el.items.items[nLoopCount].getValue( ) );
								break;
						}
					}
				}
			};
			
			var showEvtWin = function( ) {
				#{WindowEvent}.show( );
			};
			
			var setSelEvent = function( ) {
				#{TextFieldQueryEvtIds}.setValue( getEvtIds( ) );
				#{WindowEvent}.hide( );
			};
			
			var getEvtIds = function( ) {
				var evtIds = '';
				for( var nFieldSetIndex = 0; nFieldSetIndex < #{PanelEvt}.items.length; ++nFieldSetIndex ) {
					var checkgroup = #{PanelEvt}.items.items[nFieldSetIndex].items.items[0];
					for( var nCheckIndex = 0; nCheckIndex < checkgroup.items.length; ++nCheckIndex ) {
						if( checkgroup.items.items[nCheckIndex].checked ) {
							evtIds += checkgroup.items.items[nCheckIndex].tag;
							evtIds += ',';
						}
					}
				}
				
				if( evtIds.length > 0 )
					evtIds = evtIds.substr( 0, evtIds.length - 1 );
					
				return evtIds;
			};
			
			var showGameLogTip = function( ) {
				var rowIndex	= #{GridPanelLog}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelLog}.view.findCellIndex( this.triggerElement );
				var record = #{StoreLog}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				
				var index = #{StoreEvent}.find( "LogEvent", record.data.LogEvent );
				if( index == -1 ) {
					this.hide( );
					return;
				}
				
				var evtInfo = #{StoreEvent}.getAt( index );
				
				switch( cellIndex )
				{
					case 3:
						this.body.dom.innerHTML = evtInfo.data.LogStr1Desc;
						break;
					case 4:
						this.body.dom.innerHTML = evtInfo.data.LogStr2Desc;
						break;
					case 5:
						this.body.dom.innerHTML = evtInfo.data.LogStr3Desc;
						break;
					case 6:
						this.body.dom.innerHTML = evtInfo.data.LogStr4Desc;
						break;
					case 7:
						this.body.dom.innerHTML = evtInfo.data.LogInt64Desc;
						break;
					case 8:
						this.body.dom.innerHTML = evtInfo.data.LogInt32Desc;
						break;
					case 9:
						this.body.dom.innerHTML = evtInfo.data.LogUint32Desc;
						break;
					default:
						{
							this.hide( );
							break;
						}
				}
				
				if( this.body.dom.innerHTML.length == 0 ) {
					this.hide( );
				}
			};
			
			var initData = function( ) {
				#{StoreEvent}.load( );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreLog" runat="server" RemoteSort="true" RemotePaging="true" OnRefreshData="GameLogRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelLog}.body" MinDelay="100" />
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeRoleGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="LogTime" Mapping="LogTime" Type="String" />
					<ext:RecordField Name="LogEvent" Mapping="LogEvent" Type="Int" />
					<ext:RecordField Name="LogStr1" Mapping="LogStr1" Type="String" />
					<ext:RecordField Name="LogStr2" Mapping="LogStr2" Type="String" />
					<ext:RecordField Name="LogStr3" Mapping="LogStr3" Type="String" />
					<ext:RecordField Name="LogStr4" Mapping="LogStr4" Type="String" />
					<ext:RecordField Name="LogInt64" Mapping="LogInt64" Type="Int" />
					<ext:RecordField Name="LogInt32" Mapping="LogInt32" Type="Int" />
					<ext:RecordField Name="LogUInt32" Mapping="LogUInt32" Type="Int" />
				</Fields>
			</ext:JsonReader>
		</Reader>
		<SortInfo Field="Id" Direction="DESC" />
	</ext:Store>
	
	<ext:Store ID="StoreEvent" runat="server" RemoteSort="false" RemotePaging="false" OnRefreshData="EventInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelLog}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="LogEvent" Mapping="LogEvent" Type="Int" />
					<ext:RecordField Name="EvtDesc" Mapping="EvtDesc" Type="String" />
					<ext:RecordField Name="LogStr1Desc" Mapping="LogStr1Desc" Type="String" />
					<ext:RecordField Name="LogStr2Desc" Mapping="LogStr2Desc" Type="String" />
					<ext:RecordField Name="LogStr3Desc" Mapping="LogStr3Desc" Type="String" />
					<ext:RecordField Name="LogStr4Desc" Mapping="LogStr4Desc" Type="String" />
					<ext:RecordField Name="LogInt64Desc" Mapping="LogInt64Desc" Type="String" />
					<ext:RecordField Name="LogInt32Desc" Mapping="LogInt32Desc" Type="String" />
					<ext:RecordField Name="LogUint32Desc" Mapping="LogUint32Desc" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200" Title="<%$ Resources:StringDef, QueryCondition %>" Height="305" PaddingSummary="10px 10px 0px 10px" ButtonAlign="Center" Border="true" Margins="10px 10px 0px 10px" AutoScroll="true">
						<Items>
							<ext:CompositeField ID="CompositeField0" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeFieldEvt" runat="Server" FieldLabel="<%$ Resources:StringDef, Event %>" Width="900">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryEvtIds" Width="290" >
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Button runat="Server" ID="BtnSelEvent" Text="..." Width="45">
										<Listeners>
											<Click Fn="showEvtWin" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField5" runat="Server" FieldLabel="<%$ Resources:StringDef, Time %>" Width="900">
								<Items>
									<ext:DateField runat="Server" ID="DateStart" Format="Y-n-j H:i:s" Width="160">
									</ext:DateField>
									<ext:DisplayField runat="Server" Text=" ~ ">
									</ext:DisplayField>
									<ext:DateField runat="Server" ID="DateEnd" Format="Y-n-j H:i:s" Width="160">
									</ext:DateField>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, LogKey1 %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryLogStr1" Width="340">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckStr1RoleName" BoxLabel="<%$ Resources:StringDef, RoleName %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, LogKey2 %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryLogStr2" Width="340">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<ext:Checkbox runat="Server" ID="CheckStr2RoleName" BoxLabel="<%$ Resources:StringDef, RoleName %>" Checked="true" />
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField4" runat="Server" FieldLabel="<%$ Resources:StringDef, LogKey3 %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryLogStr3" Width="340">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField3" runat="Server" FieldLabel="<%$ Resources:StringDef, LogKey4 %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryLogStr4" Width="340">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
									<%--<ext:Checkbox runat="Server" ID="CheckboxLogStr4Exact" BoxLabel="<%$ Resources:StringDef, Exact %>" Checked="true" />--%>
								</Items>
							</ext:CompositeField>
							<ext:CompositeField ID="CompositeField6" runat="Server" FieldLabel="<%$ Resources:StringDef, LogInt64 %>" Width="600">
								<Items>
									<ext:TextField runat="Server" ID="TextFieldQueryLogInt64" Width="340">
										<Listeners>
											<SpecialKey Fn="textFieldQuerySpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:CompositeField>
							<ext:DisplayField ID="FieldNote" runat="Server" Text="<%$ Resources:StringDef, MsgGameLogQueryNote %>" StyleSpec="font-weight:bold;color:red;" />
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
					<ext:GridPanel ID="GridPanelLog" runat="Server" Border="true" StoreID="StoreLog" Margins="10px 10px 10px 10px" Hidden="true" Title="<%$ Resources:StringDef, QueryResult %>" AutoExpandColumn="LogStr4">
						<%--<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server">
								<Items>
									<ext:Button ID="BtnAddRegion" runat="server" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="addRegion" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnDelRegion" runat="server" Text="<%$ Resources:StringDef, Delete %>" Icon="Delete" Disabled="true">
										<Listeners>
											<Click Fn="deleteRegion" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnModifyRegion" runat="server" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" Disabled="true">
										<Listeners>
											<Click Fn="modifyRegion" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>--%>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, LogEvent %>" DataIndex="LogEvent" Width="100" Sortable="false">
									<Renderer Fn="renderLogEvent" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="LogTime" Width="125">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogKey1 %>" DataIndex="LogStr1" Width="310" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogKey2 %>" DataIndex="LogStr2" Width="310" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogKey3 %>" DataIndex="LogStr3" Width="100" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogKey4 %>" DataIndex="LogStr4" Width="100" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogInt64 %>" DataIndex="LogInt64" Width="80">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogInt32 %>" DataIndex="LogInt32" Width="60">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, LogUInt32 %>" DataIndex="LogUInt32" Width="60">
								</ext:Column>
								<ext:Column DataIndex="LogClass" Width="20" Sortable="false">
								</ext:Column>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingLog" runat="server" PageSize="200" StoreID="StoreLog">
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
	
	<ext:Window ID="WindowEvent" runat="server" Resizable="true" Maximizable="true" Title="<%$ Resources:StringDef, Event %>"
		Border="false" Width="1000" Height="550" Collapsible="false" Hidden="true" Modal="true" AutoScroll="true">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Panel runat="server" ID="PanelEvt" AutoHeight="true" PaddingSummary="5px 20px 5px 5px"><%----%>
						<Items>
							<%--<ext:FieldSet runat="Server" CheckboxToggle="true" Title="222">
								<Items>
									<ext:CheckboxGroup>
										<Items>
											<ext:Checkbox BoxLabel="11" />
											<ext:Checkbox BoxLabel="22" />
										</Items>
									</ext:CheckboxGroup>
									<ext:CompositeField runat="Server" AnchorHorizontal="90%">
										<Items>
											<ext:LinkButton ID="LinkButton3" runat="Server" Text="123132" />
											<ext:LinkButton ID="LinkButton1" runat="Server" Text="123132" />
										</Items>
									</ext:CompositeField>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet runat="Server">
								<Items>
									<ext:CheckboxGroup>
										<Items>
											<ext:Checkbox BoxLabel="11" />
										</Items>
									</ext:CheckboxGroup>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet ID="FieldSet1" runat="Server">
								<Items>
									<ext:CheckboxGroup>
										<Items>
											<ext:Checkbox BoxLabel="11" />
										</Items>
									</ext:CheckboxGroup>
								</Items>
							</ext:FieldSet>--%>
						</Items>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button runat="Server" ID="BtnEvtOK" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="setSelEvent" />
				</Listeners>
			</ext:Button>
			<ext:Button runat="Server" ID="BtnCancel" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowEvent}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTipLogDesc" runat="server" Target="#{GridPanelLog}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" ShowDelay="0">
		<CustomConfig>
			<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
		</CustomConfig>
		<Listeners>
			<Show Fn="showGameLogTip" />
		</Listeners>
	</ext:ToolTip>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

