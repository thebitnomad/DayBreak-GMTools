<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_roleskillinfo, App_Web_roleskillinfo.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
	</script>
	
	<style type="text/css">
		.items-view .skill-wrap{
			float: left;
			margin: 4px;
			margin-right: 0;
			padding: 5px;
			text-align:center;
			width:60px;
			height:60px;
			overflow:hidden;
			border : 1px solid transparent;
		}
		
		.items-view .skill-wrap span{
			display: block;
			overflow: hidden;
			text-align: center;
		}

		.items-view .x-view-over{
			border:1px solid #dddddd;
			background: #efefef;
		}

		.items-view .x-view-selected{
			background: #eff5fb;
			border:1px solid #99bbe8;
		}
		
		.items-view .x-view-selected .skill{
			background:transparent;
		}
		
		#items-ct {
			padding : 5px 10px 24px 10px; 
		}

		#items-ct h2 {
			border-bottom : 2px solid #99BBE8;
			margin : 8px;
		}

		#items-ct h2 div {
			padding : 4px 4px 4px 4px;
			font-size : 12px;
			color : #3764A0;
		}

		#items-ct .collapsed h2 div {
			background-position : 3px 3px; 
		}
		
		#items-ct dl {
			margin-left : 2px;
		}
		
		#items-ct .collapsed dl {
			display : none; 
		}
		
	</style>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_roleName;
			
			var showSkillTip = function( ) {
				debugger
				var tip = #{ToolTipSkill};
				
				var triggerElem = this.triggerElement;
				
				/* id represent for skill's Id */
				var skillId = triggerElem.id;
				if( triggerElem.Tip != undefined ) {
					tip.body.dom.innerHTML = triggerElem.Tip;
					
					setTimeout( "adjustTipPos( );", 200 );
				} else {
					tip.body.dom.innerHTML = "<div class='tip'>" + msgLoading + "</div>";
					Ext.net.DirectMethods.Tip.GetSkillTip( encodeURI( m_roleName ), skillId, {
						method : 'GET',
						success: function( result ) {
							if( result.Success ) {
								triggerElem.Tip			= result.Result;
								tip.body.dom.innerHTML	= triggerElem.Tip;
								
								adjustTipPos( );
							}
						}
					} );
				}
			};
			
			var adjustTipPos = function( ) {
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
	<ext:Store ID="StoreSkill" runat="server" RemotePaging="true" OnRefreshData="StoreSkillRefresh">
		<DirectEventConfig>
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="SkillSeries" />
					<ext:RecordField Name="Skills" IsComplex="true" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;">
				<Center>
					<ext:Panel ID="PanelSkill" runat="server" Cls="items-view" Layout="fit" Border="false" AutoScroll="true">
						<Items>
							<ext:DataView ID="SkillView" runat="server" MultiSelect="true"
								StoreID="StoreSkill" OverClass="x-view-over" ItemSelector="div.skill-wrap" AutoScroll="true">
								<Template ID="Template1" runat="server">
									<Html>
										<div id="items-ct">
											<tpl for=".">
												<div class="group-header">
													<h2><div>{SkillSeries}</div></h2>
													<dl>
														<tpl for="Skills">
															<div id="{Id}" class="skill-wrap">
																<div class="icon"><img src="{IconUrl}"></div>
																<span>{Name}</span>
															</div>
														</tpl>
														<div style="clear:left"></div>
													</dl>
												</div>
											</tpl>
										</div>
									</Html>
								</Template>
								<ToolTips>
									<ext:ToolTip ID="ToolTipSkill" runat="server" Delegate=".skill-wrap" TrackMouse="true" AutoHide="false">
										<CustomConfig>
											<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
										</CustomConfig>
										<Listeners>
											<Show Fn="showSkillTip" />
										</Listeners>
									</ext:ToolTip>
								</ToolTips>
							</ext:DataView>
						</Items>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<sat:Tip runat="Server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
