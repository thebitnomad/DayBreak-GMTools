<%@ control language="C#" autoeventwireup="true" inherits="op_cpubasicinfo, App_Web_cpubasicinfo.ascx.b81705c1" %>

<%--<ext:PropertyGrid ID="PropertyGridInfo" runat="server" Width="700" AutoHeight="true" Editable="false" DisableSelection="true" HideHeaders="true" Title="<%$ Resources:StringDef, CpuInfo %>" LabelWidth="100" LabelPad="50" >
	<Source>
		<ext:PropertyGridParameter Name="Name" DisplayName="<%$ Resources:StringDef, Name %>" />
	</Source>
	<View>
		<ext:GridView ID="GridView1" ForceFit="true" ScrollOffset="2" runat="server">
			<Listeners>
				<Refresh Handler="
					this.grid.colModel.setColumnWidth(0, 150);
					this.grid.colModel.setColumnWidth(1, 550);
				" />
			</Listeners>
		</ext:GridView>
	</View>
</ext:PropertyGrid>--%>


<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initCpuBasicInfo = function( ) {
			#{StoreBasicInfo}.reload( );
		};
		
		var cpuInfoShowTip = function( ) {
			var rowIndex	= #{GridPanelBasicInfo}.view.findRowIndex( this.triggerElement );
			var cellIndex	= #{GridPanelBasicInfo}.view.findCellIndex( this.triggerElement );
			var record		= #{StoreBasicInfo}.getAt( rowIndex );
			if( !record ) {
				this.hide( );
				return;
			}
			if( cellIndex != 1 || rowIndex != 1 ) {
				this.hide( );
				return;
			}
			
			this.body.dom.innerHTML = record.data.Value;
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreBasicInfo" runat="server" RemotePaging="false" RemoteSort="false"
	AutoLoad="true" OnRefreshData="BasicInfoRefresh" EnableViewState="false">
	<DirectEventConfig Type="Load">
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="Key" Mapping="Key" Type="String" />
				<ext:RecordField Name="Value" Mapping="Value" Type="String" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:GridPanel ID="GridPanelBasicInfo" runat="Server" StoreID="StoreBasicInfo" Width="700" AutoHeight="true"
	Title="<%$ Resources:StringDef, CpuInfo %>" AutoExpandColumn="Value" EnableViewState="false" HideHeaders="true" ColumnLines="true" >
	<View>
		<ext:GridView ID="GridView2" runat="Server" ScrollOffset="1">
		</ext:GridView>
	</View>
	<ColumnModel>
		<Columns>
			<ext:Column DataIndex="Key" Width="150">
			</ext:Column>
			<ext:Column DataIndex="Value">
			</ext:Column>
		</Columns>
	</ColumnModel>
</ext:GridPanel>

<ext:ToolTip ID="ToolTipGameGroup" runat="server" Target="#{GridPanelBasicInfo}.getView( ).mainBody" TrackMouse="true" AutoHide="false"
	Delegate=".x-grid3-cell" Width="300" ShowDelay="0">
	<Listeners>
		<Show Fn="cpuInfoShowTip" />
	</Listeners>
</ext:ToolTip>