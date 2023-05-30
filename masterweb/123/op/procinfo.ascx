<%@ control language="C#" autoeventwireup="true" inherits="op_procinfo, App_Web_procinfo.ascx.b81705c1" %>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		initProcUpdateInterval = function( interval ) {
			setInterval( updateProcInfo, interval );
		};

		updateProcInfo = function( ) {
			#{StoreProcessInfo}.reload( );
		};
		
		renderSize = function( value ) {
			return getSizeText( value * 1024 );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreProcessInfo" runat="server" RemotePaging="false" RemoteSort="false"
	AutoLoad="true" OnRefreshData="ProcessInfoRefresh" EnableViewState="false">
	<DirectEventConfig Type="Load">
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="ProcName" Mapping="ProcName" Type="String" />
				<ext:RecordField Name="Pid" Mapping="Pid" Type="Int" />
				<ext:RecordField Name="CpuTime" Mapping="CpuTime" Type="Int" />
				<ext:RecordField Name="MemUse" Mapping="MemUse" Type="Int" />
				<ext:RecordField Name="VmSize" Mapping="VmSize" Type="Int" />
				<ext:RecordField Name="ThreadCount" Mapping="ThreadCount" Type="Int" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>
<ext:GridPanel ID="GridPanelProcessInfo" runat="Server" StoreID="StoreProcessInfo" Width="700" Height="300"
	Title="<%$ Resources:StringDef, ProcessInfo %>" AutoExpandColumn="ProcName" EnableViewState="false" >
	<View>
		<ext:GridView runat="Server">
			<CustomConfig>
				<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
			</CustomConfig>
		</ext:GridView>
	</View>
	<ColumnModel>
		<Columns>
			<ext:Column Header="<%$ Resources:StringDef, ProcName %>" DataIndex="ProcName" Width="200">
			</ext:Column>
			<ext:Column Header="Pid" DataIndex="Pid" Width="40">
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, CpuTime %>" DataIndex="CpuTime" Width="80" Align="Right">
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, MemUse %>" DataIndex="MemUse" Width="100" Align="Right">
				<Renderer Fn="renderSize" />
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, VmSize %>" DataIndex="VmSize" Width="100" Align="Right">
				<Renderer Fn="renderSize" />
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, ThreadCount %>" DataIndex="ThreadCount" Width="60">
			</ext:Column>
		</Columns>
	</ColumnModel>
	<SelectionModel>
		<ext:RowSelectionModel runat="Server">
		</ext:RowSelectionModel>
	</SelectionModel>
	<BottomBar>
		<ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="500" StoreID="StoreProcessInfo" HideRefresh="true" />
	</BottomBar>
</ext:GridPanel>
