<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_roletaskinfo, App_Web_roletaskinfo.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.x-tree-node div.taskgroup
		{
			background:#eee url(../images/menu/cmp-bg.gif) repeat-x;
			margin-top:1px;
			border-top:1px solid #ddd;
			border-bottom:1px solid #ccc;
			padding-top:2px;
			padding-bottom:1px;
		}
		
		.taskgroup .x-tree-node-icon, .task .x-tree-node-icon
		{
			display:none;
		}
		
		.task
		{
			border:1px solid #fff;
			margin:2px;
		}
		
		.task a span
		{
			vertical-align: middle;
			height:22px;
			line-height :22px;
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
			font-weight:bold;
		}
		
		.ext-ie8 .task a span
		{
			padding-top:7px;
			display: inline-block;
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
		var msgExecSuccess	= '<%= Resources.StringDef.ExecSuccess %>';
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_roleName;

			var getTaskDesc = function( node ) {
debugger
				var taskDescEl = document.getElementById( "divTaskDesc" );
				if( node.TaskDesc == undefined ) {
					taskDescEl.innerHTML = msgLoading;
					var taskId = node.attributes.TaskId;
					Ext.net.DirectMethods.GetTaskDesc( m_roleName, taskId, {
						eventMask: {
							showMask: true,
							minDelay: 200,
							msg: msgLoading
						},
						success: function( result ) {
							if( result.Success ) {
								node.TaskDesc = result.Result;
								taskDescEl.innerHTML =  node.TaskDesc;
							}
							else if( result.ErrorMessage ) {
								showErrMsg( msgTitle, result.ErrorMessage );
							}
						}
					} );
				} else {
					taskDescEl.innerHTML = node.TaskDesc;
				}
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport2" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="server">
				<West>
					<ext:TreePanel ID="TreePanelTask" runat="server" Width="240" RootVisible="false" TrackMouseOver="true" 
						Border="false" AutoScroll="true" StyleSpec="border-right:1px solid #8DB2E3;" >
						<Root>
						</Root>
						<Listeners>
							<Click Handler="getTaskDesc( node );" />
							<BeforeClick Handler="return node.isLeaf( );" />
						</Listeners>
					</ext:TreePanel>
				</West>
				<Center>
					<ext:Panel ID="PanelTaskInfo" runat="Server" Border="false" Padding="15">
						<Content>
							<div id='divTaskDesc'></div>
						</Content>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

