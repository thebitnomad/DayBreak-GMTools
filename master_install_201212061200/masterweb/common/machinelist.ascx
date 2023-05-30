<%@ control language="C#" autoeventwireup="true" inherits="common_machinelist, App_Web_machinelist.ascx.38131f0b" %>

<script type="text/javascript">
	var msgTotalFormat		= '<%= Resources.StringDef.TotalFormat %>';
</script>

<ext:XScript ID="XScript1" runat="server">
	<script type="text/javascript">

		var machinelistRefresh = function( ) {
			#{StoreComboCabinet}.load( {
				callback : function( ) {
					#{StoreCabinet}.load( { 
						callback : function( ) {
						#{StoreMachine}.load( {
							callback : machinelistRefreshItems
						} );
				} } );	
			} } );
		};
		
		var machinelistRefreshItems = function( ) {
			#{PanelMachineSel}.removeAll( true );

			var keyword			= #{TxtFieldKeyword}.getValue( );
			var selCabinetId	= #{ComboCabinet}.getValue( );
			var netStatus		= #{ComboNetStatus}.getValue( );
			
			#{StoreMachine}.filterBy( function( record ) {
				/* Cabinet */
				if( selCabinetId != -2 ) {
					if( record.get( 'GroupId' ) != selCabinetId )
						return false;
				}
				
				/* NetStatus */
				if( netStatus != -2 ) {
					if( record.get( 'NetStatus' ) != netStatus )
						return false;
				}
			
				/* Keyword */
				if( keyword.length > 0 ) {
					if( record.get( 'Name' ).toLowerCase( ).indexOf( keyword.toLowerCase( ) ) == -1 )
						return false;
				}
				
				return true;
			} );
		
			var ggCount = 0;
		
			var cabinets = #{StoreCabinet}.data.items;
			for( var nIndex = 0; nIndex < cabinets.length; ++nIndex ) {
				var cabinet		= cabinets[nIndex];
				var cabinetsId	= cabinet.get( 'Id' );
				
				var records		= new Array( );
				for( var nLoopCount = 0; nLoopCount < #{StoreMachine}.data.items.length; ++nLoopCount ) {
					if( #{StoreMachine}.data.items[nLoopCount].get( 'GroupId' ) == cabinetsId ) {
						records.push( #{StoreMachine}.data.items[nLoopCount] );
					}
				}
				
				if( records.length > 0 ) {
					var ggItemArray = new Array( );
					
					for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
						var machine	= records[nLoopCount];
						var chkggId		= 'checkbox_' + cabinetsId + '_' + machine.get( 'Id' );
						
						ggItemArray.push( {
							boxLabel	: machine.get( 'IpAddress' ),
							id			: chkggId,
							tag			: machine.get( 'Id' )
						} );
						
						++ggCount;
					}
					
					var colNum		= Math.floor( ( #{PanelMachineSel}.getWidth( ) - 80 ) / 150 );
					var chkgroupId	= 'checkgroup_' + cabinetsId;
					var chkgroupName= cabinet.get( 'Name' );
					
					var chkgroup	= new Ext.form.CheckboxGroup( {
						id			: chkgroupId,
						xtype		: 'checkboxgroup',
						labelWidth	: 80,
						fieldLabel	: chkgroupName,
						itemCls		: 'x-check-group-alt',
						columns		: colNum,
						items		: ggItemArray
					} );
					
					#{PanelMachineSel}.add( chkgroup );
				}
			}
			
			#{LabelSummary}.setText( String.format( msgTotalFormat, ggCount ) );
			
			#{PanelMachineSel}.doLayout( );
		};
		
		var machinelistBtnSelAllClick = function( ) {
			machinelistSelSvr( 1 );
		};
		
		var machinelistBtnSelNoneClick = function( ) {
			machinelistSelSvr( 2 );
		};
		
		var machinelistBtnSelOppClick = function( ) {
			machinelistSelSvr( 3 );
			
			machinelistGetSelectedSvr( );
		};
		
		var machinelistSelSvr = function( selop ) {
			var cabinets = #{StoreCabinet}.data.items;
			for( var nIndex = 0; nIndex < cabinets.length; ++nIndex ) {
				var cabinet		= cabinets[nIndex];
				var cabinetId	= cabinet.get( 'Id' );
				var chkgroupId	= 'checkgroup_' + cabinetId;
				var chkgroup	= Ext.getCmp( chkgroupId );
				
				if( chkgroup ) {
					var machines = chkgroup.items.items;
					for( var nLoopCount = 0; nLoopCount < machines.length; ++nLoopCount )
					{
						/* selop : 1-Select All 2-Select None 3-Select Opposite */
						switch( selop ) {
							case 1:
								machines[nLoopCount].setValue( true );
								break;
							case 2:
								machines[nLoopCount].setValue( false );
								break;
							case 3:
								machines[nLoopCount].setValue( !machines[nLoopCount].getValue( ) );
								break;
						}
					}
				}
			}
			
			#{PanelMachineSel}.doLayout( );
		};
		
		var machinelistKeywordsSpecialKey = function( textField, e ) {
			if( e.getKey( ) == Ext.EventObject.ENTER ) {
				machinelistRefreshItems( );
				
				e.stopEvent( );
			}
		};
		
		var machinelistGetSelectedSvr = function( ) {
			var selSvrIds = '';
		
			var regions = #{StoreCabinet}.data.items;
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup_' + regionId;
				var chkgroup	= Ext.getCmp( chkgroupId );
				
				if( chkgroup ) {
					var gamegroups = chkgroup.items.items;
					for( var nLoopCount = 0; nLoopCount < gamegroups.length; ++nLoopCount )
					{	
						if( gamegroups[nLoopCount].checked ) {
							/* Use tag to save gamegroup's Id */
							selSvrIds += gamegroups[nLoopCount].tag;
							selSvrIds += ',';
						}
					}
				}
			}
			
			return selSvrIds;
		};
		
		var machinelistGetSelectedSvrName = function( ) {
			var selSvrNames = '';
	
			var regions = #{StoreCabinet}.data.items;
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup_' + regionId;
				var chkgroup	= Ext.getCmp( chkgroupId );
				
				if( chkgroup ) {
					var gamegroups = chkgroup.items.items;
					for( var nLoopCount = 0; nLoopCount < gamegroups.length; ++nLoopCount )
					{	
						if( gamegroups[nLoopCount].checked ) {
							/* Use tag to save gamegroup's Id */
							selSvrNames += gamegroups[nLoopCount].boxLabel;
							selSvrNames += ',';
						}
					}
				}
			}
			
			if( selSvrNames.length > 0 ) {
				selSvrNames = selSvrNames.substr( 0, selSvrNames.length - 1 );
			}
						
			return selSvrNames;
		};
		
		var machinelistGetSelectedSvrCnt = function( ) {
			var selSvrCnt = 0;
	
			var regions = #{StoreCabinet}.data.items;
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup_' + regionId;
				var chkgroup	= Ext.getCmp( chkgroupId );
				
				if( chkgroup ) {
					var gamegroups = chkgroup.items.items;
					for( var nLoopCount = 0; nLoopCount < gamegroups.length; ++nLoopCount )
					{	
						if( gamegroups[nLoopCount].checked ) {
							++selSvrCnt;
						}
					}
				}
			}
									
			return selSvrCnt;
		};
		
		var comboSelect = function( ) {
			machinelistRefreshItems( );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreCabinet" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="CabinetRefresh">
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
				<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:Store ID="StoreComboCabinet" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="ComboCabinetRefresh">
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

<ext:Store ID="StoreMachine" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="MachineRefresh" >
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
					<ext:RecordField Name="Comment" Mapping="Comment" Type="String" />
					<ext:RecordField Name="IpAddress" Mapping="IpAddress" Type="String" />
					<ext:RecordField Name="OSType" Mapping="OSType" Type="Int" />
					<ext:RecordField Name="Type" Mapping="Type" Type="Int" />
					<ext:RecordField Name="GroupId" Mapping="GroupId" Type="Int" />
					<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:BorderLayout ID="BorderLayout1" runat="Server">
	<Center>
		<ext:Panel runat="Server" ID="PanelMachineSel" PaddingSummary="10px 10px 10px 10px" AutoScroll="true" Border="false">
			<TopBar>
				<ext:Toolbar ID="Toolbar1" runat="Server">
					<Items>
						<ext:Button ID="BtnSelAll" runat="Server" Text="<%$ Resources:StringDef, SelectAll %>" Icon="Tick">
							<Listeners>
								<Click Fn="machinelistBtnSelAllClick" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnSelNone" runat="Server" Text="<%$ Resources:StringDef, UnselectAll %>" Icon="Erase">
							<Listeners>
								<Click Fn="machinelistBtnSelNoneClick" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnSelOpp" runat="Server" Text="<%$ Resources:StringDef, SelectOpposite %>" Icon="Wrench">
							<Listeners>
								<Click Fn="machinelistBtnSelOppClick" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarFill />
						<ext:ComboBox ID="ComboCabinet" StoreID="StoreCabinet" runat="server" Width="100" ValueField="Id"
							DisplayField="Name" Mode="Local" Editable="false" SelectedIndex="0">
							<Listeners>
								<Select Fn="comboSelect" />
							</Listeners>
						</ext:ComboBox>
						<ext:ToolbarSpacer />
						<ext:ComboBox ID="ComboNetStatus" runat="server" Width="100" Editable="false" SelectedIndex="0">
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, NetStatus %>" Value="-2" />
								<ext:ListItem Text="<%$ Resources:StringDef, Connected %>" Value="1" />
								<ext:ListItem Text="<%$ Resources:StringDef, Disconnected %>" Value="0" />
							</Items>
							<Listeners>
								<Select Fn="comboSelect" />
							</Listeners>
						</ext:ComboBox>
						<ext:ToolbarSpacer />
						<ext:TextField ID="TxtFieldKeyword" runat="Server" Width="100" EmptyText="<%$ Resources:StringDef, Keyword %>">
							<Listeners>
								<SpecialKey Fn="machinelistKeywordsSpecialKey" />
							</Listeners>
						</ext:TextField>
						<ext:ToolbarSpacer />
						<ext:Button ID="Button2" runat="Server" Icon="Magnifier" Text="<%$ Resources:StringDef, Filter %>">
							<Listeners>
								<Click Handler="machinelistRefreshItems( );" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarSpacer />
						<ext:ToolbarSeparator />
						<ext:Button ID="BtnRefresh" runat="Server" Icon="ArrowRefresh" Text="<%$ Resources:StringDef, Refresh %>">
							<Listeners>
								<Click Handler="machinelistRefresh( );" />
							</Listeners>
						</ext:Button>
					</Items>
				</ext:Toolbar>
			</TopBar>
			<BottomBar>
				<ext:Toolbar ID="StatusBar1" runat="Server" Height="22">
					<Items>
						<ext:ToolbarSpacer />
						<ext:Label runat="Server" ID="LabelSummary" />
					</Items>
				</ext:Toolbar>
			</BottomBar>
			<Items>
			</Items>
		</ext:Panel>
	</Center>
</ext:BorderLayout>
