<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="automation_schetask, App_Web_schetask.aspx.457e0403" theme="default" %>

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
		var msgAdd							= '<%= Resources.StringDef.Add %>';
		var msgModify						= '<%= Resources.StringDef.Modify %>';
		var msgAllGameServer				= '<%= Resources.StringDef.AllGameServer %>';
		var msgDeleteTaskConfirmFormat		= '<%= Resources.StringDef.MsgDeleteTaskConfirmFormat %>';
		var msgExecuteTaskConfirmFormat		= '<%= Resources.StringDef.MsgExecuteTaskConfirmFormat %>';

		var msgTaskTypeDayOfWeek			= '<%= Resources.StringDef.ScheTaskTypeDayOfWeek %>';
		var msgTaskTypeOnce					= '<%= Resources.StringDef.ScheTaskTypeOnce %>';
		var msgTaskTypeRepeat				= '<%= Resources.StringDef.ScheTaskTypeRepeat %>';
		
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_selTask;					//选择的任务
		
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
			
			var renderTaskType = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( value ) {
					case 0:
						return msgTaskTypeOnce;
					case 1:
						return msgTaskTypeRepeat;
					case 2:
						return msgTaskTypeDayOfWeek;
					default:
						return value;
				}
			};
			
			var btnAddTaskClick = function( ) {
				#{FormPanelTask}.reset( );
				
				svrsel2SetSelSvrs( "-1" );
				
				var now		= new Date( );
				var begin	= now.clearTime( );
				var finish	= begin.add( Date.DAY, 1 ).add( Date.SECOND, -1 );
				#{RepeatDateFieldBeginTime}.setValue( begin );
				#{RepeatDateFieldFinishTime}.setValue( finish );
				#{RepeatFieldInterval}.setValue( 60 );
				
				#{ComboTaskType}.fireEvent( "select", #{ComboTaskType} );
				#{ComboAutomation}.fireEvent( "select", #{ComboAutomation} );
				
				#{WindowTask}.setTitle( msgAdd );
				#{WindowTask}.show( );
			};
			
			var btnSetTaskClick = function( ) {
				/* DateField使用format会导致在服务器端不能正确获取其值 所以通过参数传 */
				var svrs				= svrsel2GetSelSvrs( );
				var repeatBeginTime		= #{RepeatDateFieldBeginTime}.getValue( );
				if( repeatBeginTime ) {
					repeatBeginTime = getDateTimeString( repeatBeginTime );
				}
				var repeatFinishTime	= #{RepeatDateFieldFinishTime}.getValue( );
				if( repeatFinishTime ) {
					repeatFinishTime = getDateTimeString( repeatFinishTime );
				}
				var onceExecTime		= #{OnceDateFieldExecTime}.getValue( );
				if( onceExecTime ) {
					onceExecTime = getDateTimeString( onceExecTime );
				}
				
				Ext.net.DirectMethods.SetTask( svrs, repeatBeginTime, repeatFinishTime, onceExecTime, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							//showSuccessMsg( msgTitle, msgOpSuc );
							#{WindowTask}.hide( );
							#{StoreTask}.reload( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var gridOnCommand = function( command, record, rowIndex, colIndex ) {
				m_selTask = record;
				
				switch( command ) {
					case "Modify":
						{
							modifyTask( );
						}
						break;
					case "Delete":
						{
							deleteTask( );
						}
						break;
					case "Execute":
						{
							executeTask( );
						}
						break;
				}
			};
			
			var modifyTask = function( ) {
				#{FormPanelTask}.reset( );
				
				#{TextTaskId}.setValue( m_selTask.data.Id );
				#{TextFieldTaskDesc}.setValue( m_selTask.data.Name );
				
				if( m_selTask.data.AllGameGroups )
					svrsel2SetSelSvrs( "-1" );
				else
					svrsel2SetSelSvrs( m_selTask.data.GameGroupNames );
				
				Ext.net.DirectMethods.LoadTask( m_selTask.data.Id, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
							var autoIndex	= #{StoreAutomation}.findExact( "GUID", result.Result );
							var autoRecord	= #{StoreAutomation}.getAt( autoIndex );
							#{ComboAutomation}.fireEvent( "select", #{ComboAutomation}, autoRecord );
							
							#{WindowTask}.setTitle( msgModify + String.format( "[{0}]", m_selTask.data.Name ) );
							#{WindowTask}.show( );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
				
			};
			
			var deleteTask = function( ) {
				var taskId		= m_selTask.data.Id;
				var taskDesc	= m_selTask.data.Name;
			
				showConfirmMsg( msgTitle, String.format( msgDeleteTaskConfirmFormat, taskDesc ), function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.DeleteTask( taskId, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									//showSuccessMsg( msgTitle, msgSendSuc );
									#{StoreTask}.reload( );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						} );
					}
				} );
			};
			
			var executeTask = function( ) {
				var taskId		= m_selTask.data.Id;
				var taskDesc	= m_selTask.data.Name;
			
				showConfirmMsg( msgTitle, String.format( msgExecuteTaskConfirmFormat, taskDesc ), function( btn ) {
					if( btn == "yes" ) {
						Ext.net.DirectMethods.ExecuteTask( taskId, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgOpSuc );
									//#{StoreTask}.reload( );
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
				m_selTask = grid.store.getAt( rowIndex );
				modifyTask( );
			};
			
			var showSvrTip = function( ) {
				var rowIndex	= #{GridPanelTask}.view.findRowIndex( this.triggerElement );
				var cellIndex	= #{GridPanelTask}.view.findCellIndex( this.triggerElement );
				var record		= #{StoreTask}.getAt( rowIndex );
				if( !record ) {
					this.hide( );
					return;
				}
				if( cellIndex != 4 ) {
					this.hide( );
					return;
				}
				
				if( record.data.AllGameGroups ) {
					this.hide( );
					return;
				}
				
				var el = #{GridPanelTask}.view.getCell( rowIndex, cellIndex );
				this.body.dom.innerHTML = el.innerHTML;
			};
			
			var comboTaskTypeSelect = function( ) {
				#{RepeatDateFieldBeginTime}.setVisible( false );
				#{RepeatDateFieldFinishTime}.setVisible( false );
				#{RepeatFieldInterval}.setVisible( false );
				#{RepeatTimeFieldStartTime}.setVisible( false );
				#{RepeatTimeFieldEndTime}.setVisible( false );
				#{OnceDateFieldExecTime}.setVisible( false );
				#{DayCheckWeekday}.setVisible( false );
				#{DayCheckWeekdayExecTime}.setVisible( false );
				
				var taskType = #{ComboTaskType}.getValue( );
				switch( eval( taskType ) ) {
					case 0:
						{
							#{OnceDateFieldExecTime}.setVisible( true );
						}
						break;
					case 1:
						{
							#{RepeatDateFieldBeginTime}.setVisible( true );
							#{RepeatDateFieldFinishTime}.setVisible( true );
							#{RepeatFieldInterval}.setVisible( true );
							#{RepeatTimeFieldStartTime}.setVisible( true );
							#{RepeatTimeFieldEndTime}.setVisible( true );
						}
						break;
					case 2:
						{
							#{DayCheckWeekday}.setVisible( true );
							#{DayCheckWeekdayExecTime}.setVisible( true );
						}
						break;
				}
			};
			
			var comboAutoSelect = function( combo, record, index ) {
				#{FieldGlobalExpAddPercentValue}.setVisible( false );
				#{FieldSvrListUploadSvrIds}.setVisible( false );
				#{FieldDBBackupType}.setVisible( false );
				#{FieldDBBackupDir}.setVisible( false );
				
				if( !record )
					return;
				
				switch( record.data.GUID ) {
					case "{C1BAFA22-B45D-4d5f-A7CA-50990BD2D224}":
						{
							#{FieldGlobalExpAddPercentValue}.setVisible( true );
						}
						break;
					case "{AEF11166-7348-4993-A5B7-9060A349FAA1}":
						{
							#{FieldSvrListUploadSvrIds}.setVisible( true );
						}
						break;
					case "{01BBAB49-2ACC-4afb-980A-8791F55060AB}":
						{
							#{FieldDBBackupType}.setVisible( true );
							#{FieldDBBackupDir}.setVisible( true );
						}
						break;
				}
			};
			
			var initData = function( ) {
				#{StoreTask}.reload( );
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreTask" runat="server" RemotePaging="true" RemoteSort="false" OnRefreshData="StoreTaskRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelTask}.body" MinDelay="100" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
					<ext:RecordField Name="NextExecuteTime" Mapping="NextExecuteTime" Type="String" />
					<ext:RecordField Name="Enabled" Mapping="Enabled" Type="Boolean" />
					<ext:RecordField Name="UserName" Mapping="UserName" Type="String" />
					<ext:RecordField Name="AllGameGroups" Mapping="AllGameGroups" Type="Boolean" />
					<ext:RecordField Name="GameGroupNames" Mapping="GameGroupNames" Type="String" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="Task" Mapping="Task" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreAutomation" runat="server" RemotePaging="false" RemoteSort="false" OnRefreshData="StoreAutomationRefresh" AutoLoad="true">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="GUID" Mapping="GUID" Type="String" />
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:GridPanel ID="GridPanelTask" runat="Server" Border="false" StoreID="StoreTask" ColumnLines="true" AutoExpandColumn="Task" >
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, Id %>" DataIndex="Id" Width="40" Hidden="true">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Name" Width="300">
								</ext:Column>
								<ext:BooleanColumn Header="<%$ Resources:StringDef, State %>" DataIndex="Enabled"
									Width="70" Align="Center" TrueText="<%$ Resources:StringDef, Enabled %>" FalseText="<%$ Resources:StringDef, Disabled %>">
								</ext:BooleanColumn>
								<ext:Column Header="<%$ Resources:StringDef, GameServer %>" DataIndex="GameGroupNames" Width="150" Align="Center">
									<Renderer Fn="renderSvr" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Type %>" DataIndex="Type" Width="100" Align="Center">
									<Renderer Fn="renderTaskType" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Task %>" DataIndex="Task" Width="300" Align="Center">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, NextExecuteTime %>" DataIndex="NextExecuteTime" Width="150" Align="Center">
									<%--<Renderer Fn="renderDateTime" />--%>
								</ext:Column>
								<ext:CommandColumn Width="150">
									<Commands>
										<ext:GridCommand CommandName="Modify" Text="<%$ Resources:StringDef, Modify %>" Icon="NoteEdit" />
										<ext:GridCommand CommandName="Delete" Text="<%$ Resources:StringDef, Delete %>" Icon="Decline" />
										<ext:GridCommand CommandName="Execute" Text="<%$ Resources:StringDef, Execute %>" Icon="PlayGreen" />
									</Commands>
								</ext:CommandColumn>
							</Columns>
						</ColumnModel>
						<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="Server">
								<Items>
									<ext:Button runat="Server" ID="BtnAddTask" Text="<%$ Resources:StringDef, Add %>" Icon="Add">
										<Listeners>
											<Click Fn="btnAddTaskClick" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<BottomBar>
							<ext:PagingToolbar ID="PagingTask" runat="server" PageSize="100" StoreID="StoreTask" />
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
	
	<ext:Window ID="WindowTask" runat="Server" Width="720" Height="530" CloseAction="Hide" AutoScroll="true"
		Hidden="true" Modal="true" BodyBorder="false">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:FormPanel ID="FormPanelTask" runat="Server" LabelAlign="Right" LabelWidth="100" AutoScroll="true"
						PaddingSummary="10px 20px 10px 10px" ButtonAlign="Center" Border="false" AnchorHorizontal="100%" StyleSpec="border:1px solid #8DB2E3;">
						<Items>
							<ext:FieldSet ID="FieldSet1" runat="server" Title="<%$ Resources:StringDef, BaseInfo %>" Collapsible="true" Layout="form">
								<Items>
									<ext:TextField ID="TextTaskId" runat="Server" Hidden="true"></ext:TextField>
									<ext:TextField ID="TextFieldTaskDesc" runat="Server" FieldLabel="<%$ Resources:StringDef, Desc %>" Width="500">
									</ext:TextField>
									<ext:CompositeField ID="CompositeField1" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
										<Items>
											<ext:Container ID="Container2" runat="Server">
												<Content>
													<sat:SvrSel2 ID="SvrSel2" runat="Server"></sat:SvrSel2>
												</Content>
											</ext:Container>
										</Items>
									</ext:CompositeField>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet ID="FieldSet2" runat="server" Title="<%$ Resources:StringDef, TimeConfig %>" Collapsible="true" Layout="form">
								<Items>
									<ext:ComboBox runat="Server" ID="ComboTaskType" Width="500" Editable="false" SelectedIndex="0" FieldLabel="<%$ Resources:StringDef, ScheTaskType %>">
										<Items>
											<ext:ListItem Text="<%$ Resources:StringDef, ScheTaskTypeRepeat %>" Value="1" />
											<ext:ListItem Text="<%$ Resources:StringDef, ScheTaskTypeDayOfWeek %>" Value="2" />
											<ext:ListItem Text="<%$ Resources:StringDef, ScheTaskTypeOnce %>" Value="0" />
										</Items>
										<Listeners>
											<Select Fn="comboTaskTypeSelect" />
										</Listeners>
									</ext:ComboBox>
									<ext:DateField runat="Server" ID="OnceDateFieldExecTime" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, ExecuteTime %>" Width="500"></ext:DateField>
									<ext:DateField runat="Server" ID="RepeatDateFieldBeginTime" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, BeginTime %>" Width="500"></ext:DateField>
									<ext:DateField runat="Server" ID="RepeatDateFieldFinishTime" Format="Y-n-j H:i:s" FieldLabel="<%$ Resources:StringDef, FinishTime %>" Width="500"></ext:DateField>
									<ext:TimeField runat="Server" ID="RepeatTimeFieldStartTime" Text="0:00" FieldLabel="<%$ Resources:StringDef, RepeatStartTime %>" Width="500" Increment="1"></ext:TimeField>
									<ext:TimeField runat="Server" ID="RepeatTimeFieldEndTime" Text="23:59" FieldLabel="<%$ Resources:StringDef, RepeatEndTime %>" Width="500" Increment="1"></ext:TimeField>
									<ext:SpinnerField runat="Server" ID="RepeatFieldInterval" FieldLabel="<%$ Resources:StringDef, RepeatInterval %>" Width="500" MinValue="0"></ext:SpinnerField>
									<ext:CheckboxGroup runat="Server" ID="DayCheckWeekday">
										<Items>
											<ext:Checkbox ID="DayCheck1" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Monday %>" Tag="1" />
											<ext:Checkbox ID="DayCheck2" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Tuesday %>" Tag="2" />
											<ext:Checkbox ID="DayCheck3" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Wednesday %>" Tag="3" />
											<ext:Checkbox ID="DayCheck4" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Thursday %>" Tag="4" />
											<ext:Checkbox ID="DayCheck5" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Friday %>" Tag="5" />
											<ext:Checkbox ID="DayCheck6" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Saturday %>" Tag="6" />
											<ext:Checkbox ID="DayCheck0" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, Sunday %>" Tag="0" />
										</Items>
									</ext:CheckboxGroup>
									<ext:TimeField runat="Server" ID="DayCheckWeekdayExecTime" Text="0:00" FieldLabel="<%$ Resources:StringDef, ExecuteTime %>" Width="500" Increment="10"></ext:TimeField>
								</Items>
							</ext:FieldSet>
							<ext:FieldSet ID="FieldSet3" runat="server" Title="<%$ Resources:StringDef, TaskConfig %>" Collapsible="true" Layout="form">
								<Items>
									<ext:ComboBox runat="Server" ID="ComboAutomation" Width="500" FieldLabel="<%$ Resources:StringDef, Task %>"
										SelectedIndex="0" Editable="false" Mode="Local" ForceSelection="true" DisplayField="Desc" ValueField="GUID" StoreID="StoreAutomation">
										<Listeners>
											<Select Fn="comboAutoSelect" />
										</Listeners>
									</ext:ComboBox>
									<ext:SpinnerField runat="server" ID="FieldGlobalExpAddPercentValue" FieldLabel="<%$ Resources:StringDef, AutomationGlobalExpAddPercent %>" Width="500" MinValue="0" MaxValue="500" Text="0" NoteAlign="Down" Note="<%$ Resources:StringDef, MsgGlobalExpAddPercentValueNote %>">
									</ext:SpinnerField>
									<ext:TextField runat="Server" ID="FieldSvrListUploadSvrIds" FieldLabel="<%$ Resources:StringDef, CltUpdateSvr %>" Width="500" NoteAlign="Down" Note="<%$ Resources:StringDef, MsgSvrListUploadSvrIdsNote %>">
									</ext:TextField>
									<ext:ComboBox runat="server" ID="FieldDBBackupType" FieldLabel="<%$ Resources:StringDef, Type %>" Width="500" Editable="false" SelectedIndex="0">
										<Items>
											<ext:ListItem Text="<%$ Resources:StringDef, BackupDbCore %>" Value="0" />
											<ext:ListItem Text="<%$ Resources:StringDef, BackupDbAll %>" Value="1" />
										</Items>
									</ext:ComboBox>
									<ext:TextField runat="Server" ID="FieldDBBackupDir" Text="/home/lmzg/server/daybreakdatabak" FieldLabel="<%$ Resources:StringDef, BKDir %>" Width="500" >
									</ext:TextField>
								</Items>
							</ext:FieldSet>
						</Items>
					</ext:FormPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnSetTask" runat="Server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="btnSetTaskClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowTask}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
	<ext:ToolTip ID="ToolTip" runat="server" Target="#{GridPanelTask}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
		Delegate=".x-grid3-cell" ShowDelay="0">
		<Listeners>
			<Show Fn="showSvrTip" />
		</Listeners>
	</ext:ToolTip>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

