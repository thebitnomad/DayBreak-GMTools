<%@ control language="C#" autoeventwireup="true" inherits="common_svrcombo2, App_Web_svrcombo2.ascx.38131f0b" %>

<ext:XScript runat="server">
	<script type="text/javascript">
		/* Todo: 第一次选择Region时，过滤不起作用的问题。 */
		var svrCombo2RegionSelect = function( ) {
			#{ComboGameGroup}.clearValue( );
			var selRegionId = #{ComboRegion}.getValue( );
			if( selRegionId != -1 ) {
				#{StoreGameGroup}.filter( 'RegionId', selRegionId );
			} else {
				#{StoreGameGroup}.clearFilter( );
			}
		};

		var svrCombo2GetSelectedSvrId = function( ) {
			return #{ComboGameGroup}.getValue( );
		};
		
		var svrCombo2SetSelectedSvrId = function( ggId ) {
			#{ComboGameGroup}.setValue( ggId );
		};
		
		var svrCombo2InitData = function( ggId ) {
			#{StoreRegion}.load( { callback: function( records, options, success ) {
				if( records.length > 0 ) {
					#{ComboRegion}.setValue( records[0].data.Id );
				}
			} } );
			#{StoreGameGroup}.load( { callback: function( records, options, success ) {
				if( records.length > 0 ) {
					var record = records[0];
					if( ggId ) {
						for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
							if( records[nLoopCount].data.Id == ggId ) {
								record = records[nLoopCount];
								break;
							}
						}
					}
						
					#{ComboGameGroup}.setValue( record.data.Id );
					#{ComboGameGroup}.fireEvent( "select", #{ComboGameGroup}, record );
				}
			} } );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreRegion" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="RegionRefresh">
	<DirectEventConfig Type="Load">
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
				<ext:RecordField Name="Name" Mapping="Name" Type="String" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:Store ID="StoreGameGroup" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="GameGroupRefresh" >
	<DirectEventConfig Type="Load">
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
				<ext:RecordField Name="Name" Mapping="Name" Type="String" />
				<ext:RecordField Name="RegionId" Mapping="RegionId" Type="Int" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:CompositeField runat="Server" Width="300">
	<Items>
		<ext:ComboBox ID="ComboRegion" StoreID="StoreRegion" runat="server" LazyInit="false" ValueField="Id"
			DisplayField="Name" ForceSelection="true" Mode="Local" Width="120">
			<Listeners>
				<Select Fn="svrComboRegionSelect" />
			</Listeners>
		</ext:ComboBox>
		<ext:ComboBox ID="ComboGameGroup" StoreID="StoreGameGroup" runat="server" LazyInit="false" ValueField="Id"
			DisplayField="Name" ForceSelection="true" Mode="Local" Width="150">
		</ext:ComboBox>
	</Items>
</ext:CompositeField>

