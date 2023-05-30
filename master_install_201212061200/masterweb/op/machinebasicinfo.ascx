<%@ control language="C#" autoeventwireup="true" inherits="op_machinebasicinfo, App_Web_machinebasicinfo.ascx.b81705c1" %>

<%--<ext:PropertyGrid ID="PropertyGridInfo" runat="server" Width="700" AutoHeight="true" Editable="false" DisableSelection="true" HideHeaders="true" Title="<%$ Resources:StringDef, BasicInfo %>" >
	<Source>
		<ext:PropertyGridParameter Name="ID" Value="-1" />
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
</ext:PropertyGrid>
--%>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		initMachineBasicInfo = function( ) {
			#{StoreMachineBasicInfo}.reload( );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreMachineBasicInfo" runat="server" RemotePaging="false" RemoteSort="false"
	AutoLoad="true" OnRefreshData="MachineBasicInfoRefresh" EnableViewState="false">
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
<ext:GridPanel ID="GridPanelBasicInfo" runat="Server" StoreID="StoreMachineBasicInfo" Width="700" AutoHeight="true"
	Title="<%$ Resources:StringDef, BasicInfo %>" AutoExpandColumn="Value" EnableViewState="false" HideHeaders="true" ColumnLines="true" >
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
