<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_machinedetail, App_Web_machinedetail.aspx.b81705c1" theme="default" %>

<%@ Register Src="cpuline.ascx" TagName="cpuline" TagPrefix="sat" %>
<%@ Register Src="cpubasicinfo.ascx" TagName="cpubasicinfo" TagPrefix="sat" %>
<%@ Register Src="cpuload.ascx" TagName="cpuload" TagPrefix="sat" %>
<%@ Register Src="memchart.ascx" TagName="memchart" TagPrefix="sat" %>
<%@ Register Src="diskchart.ascx" TagName="diskchart" TagPrefix="sat" %>
<%@ Register Src="netflowline.ascx" TagName="netflowline" TagPrefix="sat" %>
<%@ Register Src="machinebasicinfo.ascx" TagName="machinebasicinfo" TagPrefix="sat" %>
<%@ Register Src="procinfo.ascx" TagName="procinfo" TagPrefix="sat" %>
<%@ Register Src="netcardinfo.ascx" TagName="netcardinfo" TagPrefix="sat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
	.taskdoing
	{
		font-weight:bold;
	}
	
	.taskdone
	{
		color:#AAA;
	}
	
	.warning
	{
		font-weight:bold;
		color:red;
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

		var msgTaskInit		= '<%= Resources.StringDef.TaskInit %>';
		var msgTaskDoing	= '<%= Resources.StringDef.TaskDoing %>';
		var msgTaskDone		= '<%= Resources.StringDef.TaskDone %>';

		var msgSuccess		= '<%= Resources.StringDef.Success %>';
		var msgFailure		= '<%= Resources.StringDef.Failure %>';
		var msgAbort		= '<%= Resources.StringDef.Abort %>';

		var msgUpdateSvrDelFileConfirm	= '<%= Resources.StringDef.MsgUpdateSvrDelFileConfirm %>';
		var msgAbortFileTaskConfirm		= '<%= Resources.StringDef.MsgAbortFileTaskConfirm %>';
		
		var msgFileTaskStateCreated		= '<%= Resources.StringDef.FileTaskStateCreated %>';
		var msgFileTaskStateQueuing		= '<%= Resources.StringDef.FileTaskStateQueuing %>';
		var msgFileTaskStateProcessing	= '<%= Resources.StringDef.FileTaskStateProcessing %>';
		var msgFileTaskStatePaused		= '<%= Resources.StringDef.FileTaskStatePaused %>';
		var msgFileTaskStateAborting	= '<%= Resources.StringDef.FileTaskStateAborting %>';
		var msgFileTaskStateStopped		= '<%= Resources.StringDef.FileTaskStateStopped %>';
		var msgFileTaskStateCompleted	= '<%= Resources.StringDef.FileTaskStateCompleted %>';
		
	</script>
	
	<script type="text/javascript" src="../resources/Visifire.js"></script>
	<ext:XScript runat="Server">
		<script type="text/javascript">
			var template		= '<span class="{0}">{1}</span>';
			var m_machineId		= 0;
			
			function initializeChart( ) {
				initCpuBasicInfo( );
				initCPULine(700, 160, m_machineId, 5000, 0);
				setTimeout( "initMemChart(700, 70, m_machineId, 10000 );", 2000 );
				setTimeout( "initNetFlowLine(700, 160, m_machineId, 5000, 0);", 4000 );
				setTimeout( "initNetcardInfo( );", 4000 );
				setTimeout( "initDiskChart(150, 150, m_machineId, 30000, 0);", 8000 );
				setTimeout( "initProcUpdateInterval( 5000 );", 10000 );
			};
			
			var renderState = function( value, metadata, record, rowIndex, colIndex, store ) {
				var stateText = '';
				switch( value ) {
					case 0:
						stateText = msgFileTaskStateCreated;
						break;
					case 1:
						stateText = msgFileTaskStateQueuing;
						break;
					case 2:
						stateText = msgFileTaskStateProcessing;
						break;
					case 3:
						stateText = msgFileTaskStatePaused;
						break;
					case 4:
						stateText = msgFileTaskStateAborting;
						break;
					case 5:
						stateText = msgFileTaskStateStopped;
						break;
					case 6:
						stateText = msgFileTaskStateCompleted;
						break;
					default:
						stateText = msgFileTaskStateCreated;
						break;
				}
				
				return renderCommonMsg( stateText, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderProgress = function( value, metadata, record, rowIndex, colIndex, store ) {
				if( isNaN( value ) )
					return 'N/A';
			
				var progressText = ( value * 100 ).toFixed( 2 ) + '%';
				return renderCommonMsg( progressText, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderSpeed = function( value, metadata, record, rowIndex, colIndex, store ) {
				var speedText = msgNotAvailable;
				
				if( isNaN( value ) ) {
					return msgNotAvailable;
				} else if( value != -1 ) {
					speedText = getSpeedText( value );
				}
				
				return renderCommonMsg( speedText, metadata, record, rowIndex, colIndex, store );
			};
			
			var renderCommonMsg = function( value, metadata, record, rowIndex, colIndex, store ) {
				switch( record.data.State )
				{
					case 0:
					case 1:
					case 3:
						return value;
					case 2:
						return String.format( template, "taskdoing", value );
					case 4:
					case 5:
						return String.format( template, "warning", value );
					case 6:
						return String.format( template, "taskdone", value );
					default:
						return value;
				}
			};
			
			var prepareTaskToolbar = function( grid, toolbar, rowIndex, record ) {
				var btnAbort = toolbar.items.get( 0 );

				var abort = record.data.State == 0 || record.data.State == 1 || record.data.State == 2 || record.data.State == 3;

				btnAbort.setDisabled( !abort );
			};
			
			var gridTaskOnCommand = function( command, record, rowIndex, colIndex ) {
				switch( command ) {
					case "Abort":
						{
							showConfirmMsg( msgTitle, msgAbortFileTaskConfirm, function( btn ) {
								if( btn == "yes" ) {
									var guid = record.data.GUID;
									Ext.net.DirectMethods.AbortTask( guid, {
										eventMask: {
											showMask: true,
											minDelay: 200,
											msg: msgSubmitting
										},
										success: function( result ) {
											if( result.Success ) {
												showSuccessMsg( msgTitle, msgOpSuc );
											}
											else if( result.ErrorMessage ) {
												showErrMsg( msgTitle, result.ErrorMessage );
											}
										}
									} );
								}
							} );
						}
						break;
				}
			};
			
			var refreshTask = function( ) {
				#{StoreTask}.load( );
			};
			
			var initData = function( ) {
				setInterval( refreshTask, 3000 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreTask" runat="server" RemotePaging="true" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreTaskRefresh" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="false" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelTask}.body" />
		</DirectEventConfig>
		<Listeners>
			<%--<Load Fn="lazyRenderProgress" />--%>
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="GUID" Mapping="GUID" Type="String" />
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
					<ext:RecordField Name="State" Mapping="State" Type="Int" />
					<ext:RecordField Name="Progress" Mapping="Progress" Type="Float" />
					<ext:RecordField Name="Speed" Mapping="Speed" Type="Int" />
					<ext:RecordField Name="StartTime" Mapping="StartTime" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:white;">
				<Center>
					<ext:Panel ID="Panel1" runat="server" Border="false" AutoScroll="true" PaddingSummary="10px 10px 10px 10px" EnableViewState="false">
						<Content>
							<div>
								<sat:machinebasicinfo ID="MachineBasicInfo" runat="server" />
							</div>
							<div>
								<ext:GridPanel ID="GridPanelTask" runat="Server" Title="<%$ Resources:StringDef, TaskQueue %>"
									Border="true" StoreID="StoreTask" Height="150" Width="700" AutoExpandColumn="Desc" StyleSpec="margin-top:10px;">
									<View>
										<ext:GridView ID="GridView1" runat="server" MarkDirty="false">
											<CustomConfig>
												<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
											</CustomConfig>
										</ext:GridView>
									</View>
									<ColumnModel>
										<Columns>
											<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="GUID" Width="50" Hidden="true" Sortable="false">
											</ext:Column>
											<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Desc" Sortable="false">
												<Renderer Fn="renderCommonMsg" />
											</ext:Column>
											<ext:Column Header="<%$ Resources:StringDef, State %>" DataIndex="State" Width="50" Sortable="false" Align="Center">
												<Renderer Fn="renderState" />
											</ext:Column>
											<ext:Column Header="<%$ Resources:StringDef, Progress %>" DataIndex="Progress" Width="60" Align="Center" Sortable="false">
												<Renderer Fn="renderProgress" />
											</ext:Column>
											<ext:Column Header="<%$ Resources:StringDef, Speed %>" DataIndex="Speed" Width="60" Align="Center" Sortable="false">
												<Renderer Fn="renderSpeed" />
											</ext:Column>
											<ext:Column Header="<%$ Resources:StringDef, StartTime %>" DataIndex="StartTime" Width="128" Sortable="false" Align="Center">
												<Renderer Fn="renderCommonMsg" />
											</ext:Column>
											<ext:CommandColumn Width="60">
												<Commands>
													<ext:GridCommand CommandName="Abort" Text="<%$ Resources:StringDef, Cancel %>" Icon="Decline" />
												</Commands>
												<PrepareToolbar Fn="prepareTaskToolbar" />
											</ext:CommandColumn>
										</Columns>
									</ColumnModel>
									<%--<BottomBar>
										<ext:PagingToolbar ID="PagingFileTask" runat="server" PageSize="2000" StoreID="StoreTask" />
									</BottomBar>--%>
									<SelectionModel>
										<ext:RowSelectionModel ID="RowSelectionModel2" runat="Server">
											<Listeners>
												<%--<SelectionChange Fn="gridTaskSelectionChange" />--%>
											</Listeners>
										</ext:RowSelectionModel>
									</SelectionModel>
									<Listeners>
										<Command Fn="gridTaskOnCommand" />
									</Listeners>
								</ext:GridPanel>
							</div>
							<div style="padding-top:10px;">
								<sat:cpubasicinfo ID="CPUBasicInfo" runat="server" />
							</div>
							<div>
								<sat:cpuline ID="CPULine" runat="server" />
							</div>
							<%--<div>
								<sat:cpuload ID="CPULoad" runat="server" />
							</div>--%>
							<div>
								<sat:memchart ID="MemChart" runat="server" />
							</div>
							<div>
								<sat:netcardinfo ID="NetcardInfo" runat="server" />
							</div>
							<div>
								<sat:netflowline ID="NetFlowLine" runat="Server" />
							</div>
							<div>
								<sat:diskchart ID="DiskChart" runat="server" />
							</div>
							<div style="clear:both;">
								<sat:procinfo ID="ProcInfo" runat="Server" />
							</div>
						</Content>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

