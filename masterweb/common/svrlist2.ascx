<%@ control language="C#" autoeventwireup="true" inherits="common_svrlist2, App_Web_svrlist2.ascx.38131f0b" %>

<script type="text/javascript">
	var msgTotalFormat		= '<%= Resources.StringDef.TotalFormat %>';
</script>

<ext:XScript ID="XScript1" runat="server">
	<script type="text/javascript">

		var svrlist2Refresh = function( ) {
			#{StoreComboRegion}.load( {
				callback : function( ) {
					#{ComboRegion}.selectAll( );
					#{StoreRegion}.load( { 
						callback : function( ) {
							#{StoreGameGroup}.load( { callback : svrlist2RefreshItems } );
						}
					} );
				}
			} );
		};
		
		var svrlist2RefreshItems = function( ) {
			#{PanelGameGroupSel}.removeAll( true );

			var keyword		= #{TxtFieldKeyword}.getValue( );
			var netStatus	= #{ComboNetStatus}.getValue( );
			var gameStatus	= #{ComboGameStatus}.getValue( );
			var mark		= #{ComboMark}.getValue( );
			var selRegions	= #{ComboRegion}.getSelectedRecords( );
			var ggCount		= 0;
			var regions		= selRegions;
			
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				
				var records		= new Array( );
				for( var nLoopCount = 0; nLoopCount < #{StoreGameGroup}.data.items.length; ++nLoopCount ) {
					var ggRecord = #{StoreGameGroup}.data.items[nLoopCount];
					if( ggRecord.get( 'RegionId' ) != regionId )
						continue;
					
					/* NetStatus */
					if( netStatus != -2 && ggRecord.get( 'NetStatus' ) != netStatus )
						continue;
					
					/* GameStatus */
					if( gameStatus != -2 && ggRecord.get( 'GameStatus' ) != gameStatus )
						continue;
				
					/* ComboMark */
					if( mark != -2 && ggRecord.get( 'Mark' ) != mark )
						continue;
				
					/* Keyword */
					if( keyword.length > 0 && ggRecord.get( 'Name' ).toLowerCase( ).indexOf( keyword.toLowerCase( ) ) == -1 )
						continue;
					
					records.push( #{StoreGameGroup}.data.items[nLoopCount] );
				}
				
				if( records.length > 0 ) {
					var ggItemArray = new Array( );
					
					for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
						var gamegroup	= records[nLoopCount];
						var chkggId		= 'checkbox2_' + regionId + '_' + gamegroup.get( 'Id' );
						
						ggItemArray.push( {
							boxLabel	: gamegroup.get( 'Name' ),
							id			: chkggId,
							tag			: gamegroup.get( 'Id' )
						} );
						
						++ggCount;
					}
					
					var colNum		= Math.floor( ( #{PanelGameGroupSel}.getWidth( ) - 80 ) / 150 );
					var chkgroupId	= 'checkgroup2_' + regionId;
					var chkgroupName= region.get( 'Name' );
					
					var chkgroup	= new Ext.form.CheckboxGroup( {
						id			: chkgroupId,
						xtype		: 'checkboxgroup',
						labelWidth	: 100,
						fieldLabel	: chkgroupName,
						itemCls		: 'x-check-group-alt',
						columns		: colNum,
						items		: ggItemArray
					} );
					
					#{PanelGameGroupSel}.add( chkgroup );
				}
			}
			
			#{LabelSummary}.setText( String.format( msgTotalFormat, ggCount ) );
			
			#{PanelGameGroupSel}.doLayout( );
		};
		
		var svrlist2BtnSelAllClick = function( ) {
			svrlist2SelSvr( 1 );
		};
		
		var svrlist2BtnSelNoneClick = function( ) {
			svrlist2SelSvr( 2 );
		};
		
		var svrlist2BtnSelOppClick = function( ) {
			svrlist2SelSvr( 3 );
			
			svrlist2GetSelectedSvr( );
		};
		
		var svrlist2SelSvr = function( selop ) {
			var regions = #{ComboRegion}.getSelectedRecords( );
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup2_' + regionId;
				var chkgroup	= Ext.getCmp( chkgroupId );
				
				if( chkgroup ) {
					var gamegroups = chkgroup.items.items;
					for( var nLoopCount = 0; nLoopCount < gamegroups.length; ++nLoopCount )
					{
						/* selop : 1-Select All 2-Select None 3-Select Opposite */
						switch( selop ) {
							case 1:
								gamegroups[nLoopCount].setValue( true );
								break;
							case 2:
								gamegroups[nLoopCount].setValue( false );
								break;
							case 3:
								gamegroups[nLoopCount].setValue( !gamegroups[nLoopCount].getValue( ) );
								break;
						}
					}
				}
			}
			
			#{PanelGameGroupSel}.doLayout( );
		};
		
		var svrlist2KeywordsSpecialKey = function( textField, e ) {
			if( e.getKey( ) == Ext.EventObject.ENTER ) {
				svrlist2RefreshItems( );
				
				e.stopEvent( );
			}
		};
		
		var svrlist2GetSelectedSvr = function( ) {
			var selSvrIds = '';
		
			var regions = #{ComboRegion}.getSelectedRecords( );
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup2_' + regionId;
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
		
		var svrlist2GetSelectedSvrName = function( ) {
			var selSvrNames = '';
	
			var regions = #{ComboRegion}.getSelectedRecords( );
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup2_' + regionId;
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
		
		var svrlist2GetSelectedSvrCnt = function( ) {
			var selSvrCnt = 0;
	
			var regions = #{ComboRegion}.getSelectedRecords( );
			for( var nRegionIndex = 0; nRegionIndex < regions.length; ++nRegionIndex ) {
				var region		= regions[nRegionIndex];
				var regionId	= region.get( 'Id' );
				var chkgroupId	= 'checkgroup2_' + regionId;
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
		
		var comboSelect2 = function( ) {
			svrlist2RefreshItems( );
		};
		
	</script>
</ext:XScript>

<ext:Store ID="StoreRegion" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="RegionRefresh">
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
				<ext:RecordField Name="Platform" Mapping="Platform" Type="String" />
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:Store ID="StoreComboRegion" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="ComboRegionRefresh">
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

<ext:Store ID="StoreGameGroup" runat="server" RemotePaging="true" RemoteSort="true" AutoLoad="false" OnRefreshData="GameGroupRefresh" >
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
				<ext:RecordField Name="Mark" Mapping="Mark" Type="Int" />
				<ext:RecordField Name="RegionId" Mapping="RegionId" Type="Int" />
				<ext:RecordField Name="NetStatus" Mapping="NetStatus" Type="Int" />
				<ext:RecordField Name="GameStatus" Mapping="GameStatus" Type="Int" />
				<%--<ext:RecordField Name="Region" Mapping="Region" Type="String" />
				<ext:RecordField Name="PaymentStatus" Mapping="PaymentStatus" Type="Int" />
				<ext:RecordField Name="DBStatus" Mapping="DBStatus" Type="Int" />--%>
			</Fields>
		</ext:JsonReader>
	</Reader>
</ext:Store>

<ext:BorderLayout runat="Server">
	<Center>
		<ext:Panel runat="Server" ID="PanelGameGroupSel" PaddingSummary="10px 10px 10px 10px" AutoScroll="true" Border="false">
			<TopBar>
				<ext:Toolbar ID="Toolbar1" runat="Server">
					<Items>
						<ext:Button ID="BtnSelAll" runat="Server" Text="<%$ Resources:StringDef, SelectAll %>" Icon="Tick">
							<Listeners>
								<Click Fn="svrlist2BtnSelAllClick" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnSelNone" runat="Server" Text="<%$ Resources:StringDef, UnselectAll %>" Icon="Erase">
							<Listeners>
								<Click Fn="svrlist2BtnSelNoneClick" />
							</Listeners>
						</ext:Button>
						<ext:Button ID="BtnSelOpp" runat="Server" Text="<%$ Resources:StringDef, SelectOpposite %>" Icon="Wrench">
							<Listeners>
								<Click Fn="svrlist2BtnSelOppClick" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarFill />
						<ext:MultiCombo ID="ComboRegion" StoreID="StoreComboRegion" runat="server" Width="250" ValueField="Id"
							DisplayField="Name" Mode="Local" Editable="false">
							<Listeners>
								<Select Fn="comboSelect2" />
							</Listeners>
						</ext:MultiCombo>
						<ext:ToolbarSpacer />
						<ext:ComboBox ID="ComboNetStatus" runat="server" Width="100" Editable="false" SelectedIndex="0">
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, NetStatus %>" Value="-2" />
								<ext:ListItem Text="<%$ Resources:StringDef, Connected %>" Value="1" />
								<ext:ListItem Text="<%$ Resources:StringDef, Disconnected %>" Value="0" />
							</Items>
							<Listeners>
								<Select Fn="comboSelect2" />
							</Listeners>
						</ext:ComboBox>
						<ext:ToolbarSpacer />
						<ext:ComboBox ID="ComboGameStatus" runat="server" Width="100" Editable="false" SelectedIndex="0">
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, GameStatus %>" Value="-2" />
								<ext:ListItem Text="<%$ Resources:StringDef, GSUnknown %>" Value="0" />
								<ext:ListItem Text="<%$ Resources:StringDef, GSStop %>" Value="1" />
								<ext:ListItem Text="<%$ Resources:StringDef, GSStarting %>" Value="2" />
								<ext:ListItem Text="<%$ Resources:StringDef, GSRunning %>" Value="3" />
								<ext:ListItem Text="<%$ Resources:StringDef, GSStopping %>" Value="4" />
							</Items>
							<Listeners>
								<Select Fn="comboSelect2" />
							</Listeners>
						</ext:ComboBox>
						<ext:ToolbarSpacer />
						<%--<ext:ComboBox ID="ComboBox1" runat="server" Width="250" Editable="false"
							DisplayField="Desc" ValueField="Value" Mode="Local" TriggerAction="All" EmptyText="Select a country...">
							<Store>
								<ext:Store ID="StoreMark" runat="server">
									<Reader>
										<ext:ArrayReader>
											<Fields>
												<ext:RecordField Name="Name" />
												<ext:RecordField Name="Desc" />
												<ext:RecordField Name="Value" />
											</Fields>
										</ext:ArrayReader>
									</Reader>
								</ext:Store>
							</Store>
							<Template ID="Template1" runat="server">
								<Html>
									<tpl for=".">
										{Desc}
									</tpl>
								</Html>
							</Template>
							<Listeners>
								<Select Handler="this.setIconCls(record.get('iconCls'));" />
							</Listeners>
						</ext:ComboBox>--%>
						<ext:ComboBox ID="ComboMark" runat="server" Width="80" Editable="false" SelectedIndex="0" >
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, Mark %>" Value="-2" />
								<ext:ListItem Text="<%$ Resources:StringDef, MarkNone %>" Value="0" />
								<ext:ListItem Text="<%$ Resources:StringDef, MarkStar %>" Value="1" />
								<ext:ListItem Text="<%$ Resources:StringDef, MarkFlag %>" Value="2" />
							</Items>
							<Listeners>
								<Select Fn="comboSelect2" />
							</Listeners>
						</ext:ComboBox>
						<ext:ToolbarSpacer />
						<ext:TextField ID="TxtFieldKeyword" runat="Server" Width="100" EmptyText="<%$ Resources:StringDef, Keyword %>">
							<Listeners>
								<SpecialKey Fn="svrlist2KeywordsSpecialKey" />
							</Listeners>
						</ext:TextField>
						<ext:ToolbarSpacer />
						<ext:Button ID="Button2" runat="Server" Icon="Magnifier" Text="<%$ Resources:StringDef, Filter %>">
							<Listeners>
								<Click Handler="svrlist2RefreshItems( );" />
							</Listeners>
						</ext:Button>
						<ext:ToolbarSpacer />
						<ext:ToolbarSeparator />
						<ext:Button ID="BtnRefresh" runat="Server" Icon="ArrowRefresh" Text="<%$ Resources:StringDef, Refresh %>">
							<Listeners>
								<Click Handler="svrlist2Refresh( );" />
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

