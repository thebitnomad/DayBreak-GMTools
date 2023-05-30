<%@ control language="C#" autoeventwireup="true" inherits="op_netcardinfo, App_Web_netcardinfo.ascx.b81705c1" %>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		initNetcardInfo = function( ) {
			#{StoreNetcardInfo}.reload( );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreNetcardInfo" runat="server" RemotePaging="false" RemoteSort="false"
	AutoLoad="true" OnRefreshData="NetcardInfoRefresh" EnableViewState="false">
	<DirectEventConfig Type="Load">
		<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget"
			CustomTarget="#{GridPanelNetcardInfo}.body" />
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="Desc" Mapping="Desc" Type="String" />
				<ext:RecordField Name="IPAddress" Mapping="IPAddress" Type="String" />
				<ext:RecordField Name="Mask" Mapping="Mask" Type="String" />
				<ext:RecordField Name="MacAddress" Mapping="MacAddress" Type="String" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>
<ext:GridPanel ID="GridPanelNetcardInfo" runat="Server" StoreID="StoreNetcardInfo" Width="700" AutoHeight="true"
	Title="<%$ Resources:StringDef, NetcardInfo %>" AutoExpandColumn="Desc" EnableViewState="false" ColumnLines="true" >
	<View>
		<ext:GridView runat="Server" ScrollOffset="1">
			<CustomConfig>
				<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
			</CustomConfig>
		</ext:GridView>
	</View>
	<ColumnModel>
		<Columns>
			<ext:Column Header="<%$ Resources:StringDef, Desc %>" DataIndex="Desc" Width="100">
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, IPAddress %>" DataIndex="IPAddress" Width="150" Align="Center">
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, NetMask %>" DataIndex="Mask" Width="150" Align="Center">
			</ext:Column>
			<ext:Column Header="<%$ Resources:StringDef, MacAddress %>" DataIndex="MacAddress" Width="150" Align="Center">
			</ext:Column>
		</Columns>
	</ColumnModel>
	<SelectionModel>
		<ext:RowSelectionModel runat="Server">
		</ext:RowSelectionModel>
	</SelectionModel>
<%--	<BottomBar>
		<ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="500" StoreID="StoreProcessInfo" />
	</BottomBar>--%>
</ext:GridPanel>
