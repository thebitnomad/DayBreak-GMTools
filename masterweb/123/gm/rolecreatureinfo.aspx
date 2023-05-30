<%@ page language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_rolecreatureinfo, App_Web_rolecreatureinfo.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgLoading = '<%= Resources.StringDef.Loading %>';
	</script>
	
	<style type="text/css">
		
		div.skill-wrap{
			float : left;
			border : 1px solid transparent;
			margin : 20px 20px 10px 25px;
			width : 60px;
			height : 60px;
			text-align : center;
		}
		
		div.skill-wrap span{
			display: block;
			overflow: hidden;
			text-align: center;
		}
		
		.items-view .x-view-over{
			border:1px solid #dddddd;
			background: #efefef;
		}
		
		.creature .x-tree-ec-icon
		{
			display:none;
			padding-left:10px;
		}
		
		.creature .x-tree-node-icon
		{
			display:none;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.creature
		{
			font-size:14px;
			font-weight:bold;
			margin:2px;
			padding:2px;
		}
		.creaturestar
		{
			background-image:url( '../images/daybreak/sat_common_ui_0/sstar1.png' ) !important;
			width:90px;
	        height:25px;
		}
		.creaturestar-view
		{
			background-image:url( '../images/daybreak/sat_common_ui_0/sstar0.png' ) !important;

			height:25px;	
		}
	</style>
	
	<ext:XScript ID="XScript1" runat="Server" >
		
		<script type="text/javascript">
			var m_roleName;
			var m_BaseStarOffset = 4;				//固定值
			var m_SAT_MAX_CREATURE_MAX_LEVEL = 10;	//星级最大值
			var m_MAX_WIDTH = 90;					//底图的最大宽度
			var initData = function(  ) {

				queryRoleCreature( true );
			};
			
			var queryRoleCreature =function( reset, callback ) {
				
				var paramStart = 0;
				#{StoreRoleCreature}.load( {
					params : { start: paramStart },
					callback:function ( ) {
						defaultSelectFirstChildNode( );
					}
				} );
			};
			
			var defaultSelectFirstChildNode = function( ) {

				var node = #{TreePanelRoleCreature}.getRootNode( );
				var hasChildNode = node.hasChildNodes( );
				if( hasChildNode ) {
					var childNode = node.firstChild;
					childNode.select( );
					getRoleCreatureInfo( childNode );
				}
			};
			
			var getRoleCreatureInfo = function( node ) {

				var value = node.attributes.id;
				var guardIndex = #{StoreRoleCreature}.find( 'GUID', value );
				if( guardIndex != -1 ) {
					var record =  #{StoreRoleCreature}.getAt( guardIndex );
					#{FormPaneRoleCreatureBasicInfo}.reset( );
					#{FormPaneRoleCreatureAttribute}.reset( );
					#{FormPaneRoleCreatureAttributeAddVal}.reset( );
					#{FormPaneRoleCreatureBasicInfo}.getForm( ).loadRecord( record );
					#{FormPaneRoleCreatureAttribute}.getForm( ).loadRecord( record );
					#{FormPaneRoleCreatureAttributeAddVal}.getForm( ).loadRecord( record );
				}
				if( record.data.CreatureSkills != null ) {
					#{StoreRoleCreatureSkills}.loadData( record.data.CreatureSkills );
				}
				if( record.data.StarLevel != 0 ) {
					var starLvInfo = renderCreatureStarLevel( record.data.StarLevel );
					#{DisplayFieldCreatureStarLevel}.setValue( starLvInfo );
				}
			};
			
			var renderCreatureStarLevel = function( starLevel ) {
				
				var levelVal = ( starLevel + m_BaseStarOffset )/m_SAT_MAX_CREATURE_MAX_LEVEL;
				if( levelVal > m_SAT_MAX_CREATURE_MAX_LEVEL) {
					levelVal = m_SAT_MAX_CREATURE_MAX_LEVEL;
				}
				var starVal = ( levelVal * 0.1 ).toFixed(1);	
				return String.format( '<div class="creaturestar"><div class="creaturestar-view" style="width:{0}px"></div></div>', m_MAX_WIDTH * starVal );
			};		
			
			var showRoleCreatureSkillTip = function( ) {

				var tip = #{ToolTipSkill};
				var triggerElem = this.triggerElement;
				
				var skillId = triggerElem.id;
				if( skillId == 0 ) {
					tip.hide( );
					return;
				}
				
				if( triggerElem.Tip != undefined ) {
					tip.body.dom.innerHTML = triggerElem.Tip;
					
					setTimeout( "adjustTipPops( );", 500 );
				} else {
					this.body.dom.innnerHTML = "<div class='tip'>" + msgLoading + "</div>";
					Ext.net.DirectMethods.Tip.GetSkillTemplateTip( skillId, {
						method: 'GET',
						success: function( result ) {
							triggerElem.Tip			= result.Result;
							tip.body.dom.innerHTML	= triggerElem.Tip;
								
							adjustTipPops( );
						}
					} );
				}
			};
			
			var adjustTipPops = function () {
				var tip = #{ToolTipSkill};
				
				var height = tip.body.dom.childNodes[0].clientHeight;
				var posX = tip.targetXY[0];
				var posY = tip.targetXY[1];
				
				if( posX + tip.maxWidth > document.body.clientWidth && posX > tip.maxWidth ) {
					posX = posX - tip.maxWidth;
					tip.setPosition( posX, posY );
				}
				if( posY + height > document.body.clientHeight && posY > height ) {
					posY = posY - height;
					tip.setPosition( posX,posY );
				}
			};
			
		</script>
	</ext:XScript>
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	
	<ext:Store ID="StoreRoleCreature" runat="Server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreCreatureRefresh" >
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="GUID" Mapping="GUID" Type="String" />
					<ext:RecordField Name="Level" Mapping="Level" Type="Int"/>
					<ext:RecordField Name="GrowUp" Mapping="GrowUp" Type="String"/>
					<ext:RecordField Name="Fit" Mapping="Fit" Type="Int" />
					<ext:RecordField Name="Genius" Mapping="Genius" Type="String"/>
					<ext:RecordField Name="Color" Mapping="Color"/>
					<ext:RecordField Name="StarLevel" Mapping="StarLevel"/>
					<ext:RecordField Name="CreatureType" Mapping="CreatureType" Type="String"/>
					<ext:RecordField Name="MixProb" Mapping="MixProb" Type="String"/>
					<ext:RecordField Name="PhysicalAttackAttr" Mapping="PhysicalAttackAttr" Type="String"/>
					<ext:RecordField Name="MagicAttackAttr" Mapping="MagicAttackAttr" Type="String"/>
					<ext:RecordField Name="MortalAttackAttr" Mapping="MortalAttackAttr" Type="String"/>
					<ext:RecordField Name="PhysicalDefenseAttr" Mapping="PhysicalDefenseAttr" Type="String"/>
					<ext:RecordField Name="MagicDefenseAttr" Mapping="MagicDefenseAttr" Type="String"/>
					<ext:RecordField Name="MortalDefenseAttr" Mapping="MortalDefenseAttr" Type="String"/>
					<ext:RecordField Name="PhysicalAttackAddVal" Mapping="PhysicalAttackAddVal" Type="Int"/>
					<ext:RecordField Name="MagicAttackAddVal" Mapping="MagicAttackAddVal" Type="Int"/>
					<ext:RecordField Name="MortalAttackAddVal" Mapping="MortalAttackAddVal" Type="Int"/>
					<ext:RecordField Name="PhysicalDefAddVal" Mapping="PhysicalDefAddVal" Type="Int"/>
					<ext:RecordField Name="MagicDefAddVal" Mapping="MagicDefAddVal" Type="Int"/>
					<ext:RecordField Name="MortalDefAddVal" Mapping="MortalDefAddVal" Type="Int"/>
					<ext:RecordField Name="CreatureSkills" IsComplex="true"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
    </ext:Store>
    
    <ext:Store ID="StoreRoleCreatureSkills" runat="Server" RemotePaging="false" RemoteSort="false" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" />
		</DirectEventConfig>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="CreatureSkillId" Mapping="CreatureSkillId" />
					<ext:RecordField Name="IconUrl" Mapping="IconUrl" />
					<ext:RecordField Name="Name" Mapping="Name"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
    </ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server"  StyleSpec="background-color:#FFF;">
				<Center>
					<ext:Panel ID="PanelCreature" runat="Server" Border="false">
						<Items>
							<ext:BorderLayout runat="Server" StyleSpec="background-color:#FFF;">
								<West>
									<ext:TreePanel ID="TreePanelRoleCreature" runat="Server" Width="250"  RootVisible="false" TrackMouseOver="true"
										Border="false" AutoScroll="false" StyleSpec="margi-bottom:1px;border-bottom:1px solid #8DB2E3; ">
										<Root>
										</Root>
										<Listeners>
											<Click Handler="getRoleCreatureInfo( node );" />
											<BeforeClick Handler="return node.isLeaf( );" />
										</Listeners>
										<SelectionModel>
											<ext:DefaultSelectionModel>
											</ext:DefaultSelectionModel>
										</SelectionModel>
									</ext:TreePanel>
								</West>	
								<Center>
									<ext:Panel ID="PanelRoleCreatureBasicInfo" runat="Server" Border="false" Padding="10">
										<Items>
											<ext:BorderLayout runat="Server" StyleSpec="background-color:#FFF;">
												<North>
													<ext:FormPanel ID="FormPaneRoleCreatureBasicInfo" runat="Server" LabelWidth="80" LabelAlign="Right" StyleSpec="border-left:1px solid #8DB2E3; background-color:white;"
														 Padding="10" AnchorHorizontal="100%" Border = "false" Height="100" >
														<Items>
															<ext:Container ID="Container1" runat="Server" Layout="Column" Height="30">
																<Items>
																	<ext:Container ID="Container2" runat="server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField2" runat="Server" Width="100" FieldLabel="<%$ Resources:StringDef, Level %>" DataIndex="Level"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																	<ext:Container ID="Container3" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField3" runat="Server" Width="100" FieldLabel="<%$ Resources:StringDef, CreatureGrowUp %>" DataIndex="GrowUp"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																	<ext:Container ID="Container4" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField4" runat="server" FieldLabel="<%$ Resources:StringDef, CreatureFit %>" DataIndex="Fit"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																</Items>
															</ext:Container>
															<ext:Container ID="Container5" runat="Server" Layout="Column" Height="30">
																<Items>
																	<ext:Container ID="Container6" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField5" runat="Server" Width="100" FieldLabel="<%$ Resources:StringDef, CreatureGenius %>" DataIndex="Genius"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																	<ext:Container ID="Container7" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField6" runat="Server" Width="100" FieldLabel="<%$ Resources:StringDef, Type %>" DataIndex="CreatureType"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																	<ext:Container ID="Container8" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField7" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureStartIntelligenceAttr %>" DataIndex="MixProb"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																</Items>
															</ext:Container>
														</Items>
													</ext:FormPanel>
												</North>
												<Center>
													<ext:Panel runat="Server">
														<Items>
															<ext:BorderLayout runat="Server" StyleSpec="background-color:#FFF;">
																<Center>
																	<ext:Panel runat="Server" Border="false" Width="400">
																		<Items>
																			<ext:BorderLayout runat="Server" StyleSpec="background-color:#FFF;">
																				<Center>
																					<ext:FormPanel ID="FormPaneRoleCreatureAttribute" runat="Server" Padding="20" Height="275" Border="false" 
																						StyleSpec="solid #8DB2E3; background-color:white;">
																						<Items>
																							<ext:Container ID="Container24" runat="Server" Height="25" Layout="Column">
																								<Items>
																									<ext:Container ID="Container25" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField1" runat="Server" FieldLabel="<%$ Resources:StringDef, CreaturePhysicalAttackAttr%>" DataIndex="PhysicalAttackAttr"/>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container39" runat="Server" Height="25" Layout="Column">
																								<Items>
																									<ext:Container ID="Container47" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField8" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureMagicAttackAttr %>" DataIndex="MagicAttackAttr" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container48" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container49" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField9" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureMortalAttackAttr %>" DataIndex="MortalAttackAttr"/>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container50" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container51" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField10" runat="Server" FieldLabel="<%$ Resources:StringDef, CreaturePhysicalDefenseAttr %>" DataIndex="PhysicalDefenseAttr" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container52" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container53" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField11" runat="Server" FieldLabel="<%$ Resources:StringDef,CreatureMagicDefenseAttr %>" DataIndex="MagicDefenseAttr" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container54" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container55" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField12" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureMortalDefenseAttr %>" DataIndex="MortalDefenseAttr" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container58" runat="server" Height="40">
																							</ext:Container>
																							<ext:Container ID="Container56" runat="Server" Layout="Column" Height="22">
																								<Items>
																									<ext:Container ID="Container57" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayFieldCreatureStarLevel" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureStarRating %>" 
																												Text="<div class='creaturestar'><div class='creaturestar-view'></div></div>" >
																											</ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																						</Items>
																					</ext:FormPanel>
																				</Center>
																			</ext:BorderLayout>
																		</Items>
																	</ext:Panel>
																</Center>
																<East>
																	<ext:Panel ID="Panel1" runat="Server" Width="450" Border="false">
																		<Items>
																			<ext:BorderLayout  runat="Server" StyleSpec="background-color:#FFF;">
																				<Center>
																					<ext:FormPanel ID="FormPaneRoleCreatureAttributeAddVal" runat="Server" Padding="20" Height="275" Border="false" Margins="0px 0px 0px 0px"
																						StyleSpec="margin-left:0px; border-left:1px solid #8DB2E3; background-color:white;">
																						<Items>
																							<ext:Container ID="Container26" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container27" runat="server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField13" runat="Server" FieldLabel="<%$ Resources:StringDef, CreaturePhysicalAttackAddVal %>" DataIndex="PhysicalAttackAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container28" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container29" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField14" runat="Server" FieldLabel="<%$ Resources:StringDef,CreatureMagicAttackAddVal %>" DataIndex="MagicAttackAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container30" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container31" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField15" runat="Server" FieldLabel="<%$ Resources:StringDef, CreatureMortalAttackAddVal %>" DataIndex="MortalAttackAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container32" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container33" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField16" runat="Server" FieldLabel="<%$ Resources:StringDef,CreaturePhysicalDefAddVal %>" DataIndex="PhysicalDefAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container34" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container35" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField17" runat="Server" FieldLabel="<%$ Resources:StringDef,CreatureMagicDefAddVal %>" DataIndex="MagicDefAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container36" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container37" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField18" runat="Server" FieldLabel="<%$ Resources:StringDef,CreatureMortalDefAddVal %>" DataIndex="MortalDefAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																						</Items>
																					</ext:FormPanel>
																				</Center>
																			</ext:BorderLayout>
																		</Items>
																	</ext:Panel>
																</East>
															</ext:BorderLayout>
														</Items>
													</ext:Panel>
												</Center>
											</ext:BorderLayout>
										</Items>
									</ext:Panel>
								</Center>
							</ext:BorderLayout>
						</Items>
					</ext:Panel>
				</Center>
				<South>
					<ext:Panel ID="PanelRoleCreatureSkillInfo" runat="Server" Cls="Items-view" Layout="fit" Border="false" Height="100" AutoScroll="false" >
						<Items>
							<ext:DataView ID="RoleCreatureSkillView" runat="Server" StoreID="StoreRoleCreatureSkills" MultiSelect="true" OverClass="x-view-over" ItemSelector="div.skill-wrap" AutoScroll="false">
								<Template ID="Template1" runat="server">
									<Html>
										<tpl for=".">
											<div id="{CreatureSkillId}" class="skill-wrap">
												<div class="icon">
													<img src="{IconUrl}"></img>
												</div>
												<span class='{Color}'>{Name}</span>
											</div>
										</tpl>
									<div class="x-clear"></div>
									</Html>
								</Template>
								<ToolTips>
									<ext:ToolTip ID="ToolTipSkill" runat="Server" Delegate=".skill-wrap" TrackMouse="true" AutoHide="false">
										<CustomConfig>
											<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw"></ext:ConfigItem>
										</CustomConfig>
										<Listeners>
											<Show Fn="showRoleCreatureSkillTip" />
										</Listeners>
									</ext:ToolTip>
								</ToolTips>
							</ext:DataView>
						</Items>
					</ext:Panel>
				</South>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<sat:Tip runat="Server" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
