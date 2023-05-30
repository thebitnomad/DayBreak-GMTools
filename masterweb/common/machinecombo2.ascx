<%@ control language="C#" autoeventwireup="true" inherits="common_machinecombo2, App_Web_machinecombo2.ascx.38131f0b" %>

<ext:XScript ID="XScript1" runat="server">
	<script type="text/javascript">
		/* Todo: 第一次选择Region时，过滤不起作用的问题。 */
		var machineCombo2CabinetSelect = function( ) {
			#{ComboMachine}.clearValue( );
			var selCabinetId = #{ComboCabinet}.getValue( );
			if( selCabinetId != -1 ) {
				#{StoreMachine}.filter( 'CabinetId', selCabinetId );
			} else {
				#{StoreMachine}.clearFilter( );
			}
		};

		var machineCombo2GetSelectedSvrId = function( ) {
			return #{ComboMachine}.getValue( );
		};
		
		var machineCombo2GetSelectedRecord = function( ) {
			var machineId = #{ComboMachine}.getValue( );
			var index = #{StoreMachine}.findExact( 'Id', machineId );
			if( index != -1 ) {
				return #{StoreMachine}.getAt( index );
			}
			
			return '';
		};
		
		var machineCombo2SetSelectedMachineId = function( machineId ) {
			#{ComboMachine}.setValue( machineId );
		};
		
		var machineCombo2InitData = function( machineId ) {
			#{StoreCabinet}.load( { callback: function( records, options, success ) {
				if( records.length > 0 ) {
					#{ComboCabinet}.setValue( records[0].data.Id );
				}
			} } );
			#{StoreMachine}.load( { callback: function( records, options, success ) {
				if( records.length > 0 ) {
					var record = records[0];
					if( machineId ) {
						for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
							if( records[nLoopCount].data.Id == machineId ) {
								record = records[nLoopCount];
								break;
							}
						}
					}
						
					#{ComboMachine}.setValue( record.data.Id );
					#{ComboMachine}.fireEvent( "select", #{ComboMachine}, record );
				}
			} } );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreCabinet" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="CabinetRefresh">
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

<ext:Store ID="StoreMachine" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="MachineRefresh" >
	<DirectEventConfig Type="Load">
	</DirectEventConfig>
	<Proxy>
		<ext:PageProxy />
	</Proxy>
	<Reader>
		<ext:JsonReader>
			<Fields>
				<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
				<ext:RecordField Name="IpAddress" Mapping="IpAddress" Type="String" />
				<ext:RecordField Name="IpAddressInner" Mapping="IpAddressInner" Type="String" />
				<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
				<ext:RecordField Name="CabinetId" Mapping="CabinetId" Type="Int" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:CompositeField ID="CompositeField1" runat="Server" Width="400">
	<Items>
		<ext:ComboBox ID="ComboCabinet" StoreID="StoreCabinet" runat="server" LazyInit="false" ValueField="Id"
			DisplayField="Name" ForceSelection="true" Mode="Local" Width="140">
			<Listeners>
				<Select Fn="machineComboCabinetSelect" />
			</Listeners>
		</ext:ComboBox>
		<ext:ComboBox ID="ComboMachine" StoreID="StoreMachine" runat="server" LazyInit="false" ValueField="Id" Resizable="true"
			DisplayField="IpAddress" ForceSelection="true" Mode="Local" Width="200" ItemSelector="div.list-item">
			<Template ID="Template5" runat="server">
				<Html>
					<tpl for=".">
						<div class="list-item">
							 <h3>{IpAddress}</h3>
							 {Comment}{IpAddressInner}
						</div>
					</tpl>
				</Html>
			</Template>
		</ext:ComboBox>
	</Items>
</ext:CompositeField>
