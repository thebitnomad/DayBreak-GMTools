<%@ page language="C#" autoeventwireup="true" masterpagefile="~/common/main.master" inherits="gm_rolerideinfo, App_Web_rolerideinfo.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ContentPlaceHolderID="HeaderHolder" Runat="server">

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
		
		.ride .x-tree-ec-icon
		{
			display:none;
			padding-left:10px;
		}
		
		.ride .x-tree-node-icon
		{
			display:none;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.ride
		{
			font-size:14px;
			font-weight:bold;
			margin:2px;
			padding:2px;
		}
		
	</style>
	
	<ext:XScript ID="XScript1" runat="Server" >
	
		<script type="text/javascript">
			var m_roleName;
			var initData = function(  ) {
				
				queryRoleRide( true );
			};
			
			var queryRoleRide =function( reset, callback ) {
			
				var paramStart = 0;
				#{StoreRoleRide}.load( {
					params : { start: paramStart },
					callback:function ( ) {
						defaultSelectFirstChildNode( );
					}
				} );
			};
			
			var defaultSelectFirstChildNode = function( ) {
		
				var node = #{TreePanelRoleRide}.getRootNode( );
				var hasChildNode = node.hasChildNodes( );
				if( hasChildNode ) {
					var childNode = node.firstChild;
					childNode.select( );
					getRoleRideInfo( childNode );
				}
			};
			
			var getRoleRideInfo = function( node ) {

				var value = node.attributes.id;
				var rideIndex = #{StoreRoleRide}.find( 'GUID', value );
				if( rideIndex != -1 ) {
					var record =  #{StoreRoleRide}.getAt( rideIndex );
					#{FormPaneRoleRideBasicInfo}.reset( );
					#{FormPaneRoleRideAttribute}.reset( );
					#{FormPaneRoleRideAttributeAddVal}.reset( );
					#{FormPaneRoleRideBasicInfo}.getForm( ).loadRecord( record );
					#{FormPaneRoleRideAttribute}.getForm( ).loadRecord( record );
					#{FormPaneRoleRideAttributeAddVal}.getForm( ).loadRecord( record );
				}
				if( record.data.RideSkills != null ) {
					#{StoreRoleRideSkills}.loadData( record.data.RideSkills );
				}
			};
			
			var showRoleRideSkillTip = function( ) {

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
				}else{
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
	
	<ext:Store ID="StoreRoleRide" runat="Server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreRoleRideRefresh" >
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
					<ext:RecordField Name="Name" Mapping="Name" Type="String"/>
					<ext:RecordField Name="Color" Mapping="Color" Type="Int"/>
					<ext:RecordField Name="Score" Mapping="Score" Type="Int"/>
					<ext:RecordField Name="Exp" Mapping="Exp" Type="String"/>
					<ext:RecordField Name="FeedLevel" Mapping="FeedLevel" Type="int"/>
					<ext:RecordField Name="AllAttrAddVal" Mapping="AllAttrAddVal" Type="String"/>
					<ext:RecordField Name="LifeGrowVal" Mapping="LifeGrowVal" Type="String"/>
					<ext:RecordField Name="FrostDamageGrowVal" Mapping="FrostDamageGrowVal" Type="String"/>
					<ext:RecordField Name="FireDamageGrowVal" Mapping="FireDamageGrowVal" Type="String"/>
					<ext:RecordField Name="ThunderDamageGrowVal" Mapping="ThunderDamageGrowVal" Type="String"/>
					<ext:RecordField Name="DarkDamageGrowVal" Mapping="DarkDamageGrowVal" Type="String"/>
					<ext:RecordField Name="LightDamageGrowVal" Mapping="LightDamageGrowVal" Type="String"/>
					<ext:RecordField Name="LifeAddVal" Mapping="LifeAddVal" Type="String"/>
					<ext:RecordField Name="FrostDamageAddVal" Mapping="FrostDamageAddVal" Type="String"/>
					<ext:RecordField Name="FireDamageAddVal" Mapping="FireDamageAddVal" Type="String"/>
					<ext:RecordField Name="ThunderDamageAddVal" Mapping="ThunderDamageAddVal" Type="String"/>
					<ext:RecordField Name="DarkDamageAddVal" Mapping="DarkDamageAddVal" Type="String"/>
					<ext:RecordField Name="LightDamageAddVal" Mapping="LightDamageAddVal" Type="String"/>
					<ext:RecordField Name="RideSkills" Mapping="RideSkills" IsComplex="true"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Store ID="StoreRoleRideSkills" runat="Server" RemotePaging="false" RemoteSort="false" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" />
		</DirectEventConfig>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="RideSkillId" Mapping="RideSkillId" />
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
					<ext:Panel ID="PanelRide" runat="Server" Border="false">
						<Items>
							<ext:BorderLayout ID="BorderLayout2" runat="Server" StyleSpec="background-color:#FFF;">
								<West>
									<ext:TreePanel ID="TreePanelRoleRide" runat="Server" Width="250"  RootVisible="false" TrackMouseOver="true"
										Border="false" AutoScroll="false" StyleSpec="margi-bottom:1px;border-bottom:1px solid #8DB2E3; ">
										<Root>
										</Root>
										<Listeners>
											<Click Handler="getRoleRideInfo( node );" />
											<BeforeClick Handler="return node.isLeaf( );" />
										</Listeners>
										<SelectionModel>
											<ext:DefaultSelectionModel>
											</ext:DefaultSelectionModel>
										</SelectionModel>
									</ext:TreePanel>
								</West>	
								<Center>
									<ext:Panel ID="PanelRoleRideBasicInfo" runat="Server" Border="false" Padding="10">
										<Items>
											<ext:BorderLayout ID="BorderLayout3" runat="Server" StyleSpec="background-color:#FFF;">
												<North>
													<ext:FormPanel ID="FormPaneRoleRideBasicInfo" runat="Server" LabelWidth="60" LabelAlign="Right" StyleSpec=" border-left:1px solid #8DB2E3; background-color:white;"
														 Padding="10"  AnchorHorizontal="100%" Border = "false" Height="100" >
														<Items>
															<ext:Container ID="Container1" runat="Server" Layout="Column" Height="30">
																<Items>
																	<ext:Container ID="Container2" runat="server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField1" runat="Server" Width="80" FieldLabel="<%$ Resources:StringDef, RideScore %>" DataIndex="Score"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																	<ext:Container ID="Container3" runat="Server" Layout="Form">
																		<Items>
																			<ext:DisplayField ID="DisplayField2" runat="Server" Width="80" FieldLabel="<%$ Resources:StringDef, RideExp %>" DataIndex="Exp"></ext:DisplayField>
																		</Items>
																	</ext:Container>
																</Items>
															</ext:Container>
														</Items>
													</ext:FormPanel>
												</North>
												<Center>
													<ext:Panel ID="Panel1" runat="Server">
														<Items>
															<ext:BorderLayout ID="BorderLayout4" runat="Server" StyleSpec="background-color:#FFF;">
																<Center>
																	<ext:Panel ID="Panel2" runat="Server" Border="false" Width="400">
																		<Items>
																			<ext:BorderLayout ID="BorderLayout5" runat="Server" StyleSpec="background-color:#FFF;">
																				<Center>
																					<ext:FormPanel ID="FormPaneRoleRideAttribute" runat="Server" Padding="20" Height="275" Border="false" 
																						StyleSpec="solid #8DB2E3; background-color:white;">
																						<Items>
																							<ext:Container ID="Container4" runat="Server" Height="25" Layout="Column">
																								<Items>
																									<ext:Container ID="Container5" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField3" runat="Server" FieldLabel="<%$ Resources:StringDef, RideLifeGrowVal%>" DataIndex="LifeGrowVal"/>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container6" runat="Server" Height="25" Layout="Column">
																								<Items>
																									<ext:Container ID="Container7" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField4" runat="Server" FieldLabel="<%$ Resources:StringDef, RideFrostDamageGrowVal %>" DataIndex="FrostDamageGrowVal" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container8" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container9" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField5" runat="Server" FieldLabel="<%$ Resources:StringDef, RideFireDamageGrowVal %>" DataIndex="FireDamageGrowVal"/>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container10" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container11" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField6" runat="Server" FieldLabel="<%$ Resources:StringDef, RideThunderDamageGrowVal %>" DataIndex="ThunderDamageGrowVal" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container12" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container13" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField7" runat="Server" FieldLabel="<%$ Resources:StringDef,RideDarkDamageGrowVal %>" DataIndex="DarkDamageGrowVal" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container14" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container15" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField8" runat="Server" FieldLabel="<%$ Resources:StringDef, RideLightDamageGrowVal %>" DataIndex="LightDamageGrowVal" />
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
																	<ext:Panel ID="Panel3" runat="Server" Width="450" Border="false">
																		<Items>
																			<ext:BorderLayout ID="BorderLayout6"  runat="Server" StyleSpec="background-color:#FFF;">
																				<Center>
																					<ext:FormPanel ID="FormPaneRoleRideAttributeAddVal" runat="Server" Padding="20" Height="275" Border="false" Margins="0px 0px 0px 0px"
																						StyleSpec="margin-left:0px; border-left:1px solid #8DB2E3; background-color:white;">
																						<Items>
																							<ext:Container ID="Container16" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container17" runat="server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField9" runat="Server" FieldLabel="<%$ Resources:StringDef, RideLifeAddVal %>" DataIndex="LifeAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container18" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container19" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField10" runat="Server" FieldLabel="<%$ Resources:StringDef,RideFrostDamageAddVal %>" DataIndex="FrostDamageAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container20" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container21" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField11" runat="Server" FieldLabel="<%$ Resources:StringDef, RideFireDamageAddVal %>" DataIndex="FireDamageAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container22" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container23" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField12" runat="Server" FieldLabel="<%$ Resources:StringDef,RideThunderDamageAddVal %>" DataIndex="ThunderDamageAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container24" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container25" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField13" runat="Server" FieldLabel="<%$ Resources:StringDef,RideDarkDamageAddVal %>" DataIndex="DarkDamageAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container26" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container27" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField14" runat="Server" FieldLabel="<%$ Resources:StringDef,RideLightDamageAddVal %>" DataIndex="LightDamageAddVal"></ext:DisplayField>
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Contain28" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container29" runat="server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField15" runat="Server" FieldLabel="<%$ Resources:StringDef, RideFeedLevel %>" DataIndex="FeedLevel" />
																										</Items>
																									</ext:Container>
																								</Items>
																							</ext:Container>
																							<ext:Container ID="Container30" runat="Server" Layout="Column" Height="25">
																								<Items>
																									<ext:Container ID="Container31" runat="Server" Layout="Form">
																										<Items>
																											<ext:DisplayField ID="DisplayField16" runat="Server" FieldLabel="<%$ Resources:StringDef, RideAllAttrAddVal %>" DataIndex="AllAttrAddVal" />
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
					<ext:Panel ID="PanelRoleRideSkillInfo" runat="Server" Cls="Items-view" Layout="fit" Border="false" Height="100" AutoScroll="false" >
						<Items>
							<ext:DataView ID="RoleCreatureSkillView" runat="Server" StoreID="StoreRoleRideSkills" MultiSelect="true" OverClass="x-view-over" ItemSelector="div.skill-wrap" AutoScroll="false">
								<Template ID="Template1" runat="server">
									<Html>
										<tpl for=".">
											<div id="{RideSkillId}" class="skill-wrap">
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
											<Show Fn="showRoleRideSkillTip" />
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
	<sat:Tip ID="Tip1" runat="Server" />
</asp:Content>
<asp:Content ContentPlaceHolderID="TailHolder" Runat="server">
</asp:Content>
