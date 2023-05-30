<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svroverview, App_Web_svroverview.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		div.item-wrap {
			float : left;
			border : 1px solid transparent;
			margin : 5px 10px 5px 10px;
			width : 130px;
			text-align : center;
		}

		#items-ct { padding : 5px 10px 24px 10px; }

		#items-ct h2 {
			border-bottom : 2px solid #99BBE8;
			cursor : pointer;
			margin : 8px;
		}

		#items-ct h2 div {
			background : transparent url(../images/group-expand-sprite.gif) no-repeat 3px -47px;
			padding : 4px 4px 4px 17px;
			font-size : 12px;
			color : #3764A0;
		}

		#items-ct .collapsed h2 div { background-position : 3px 3px; }
		#items-ct dl { margin-left : 2px; }
		#items-ct .collapsed dl { display : none; }
		
		.bar {
			border:solid 1px #000;
			background-color:#dddddd;
			width:8px;
			height:20px;
			float:right;
			overflow:hidden;
			margin-right:1px;
		}
		
		.bar div {
			position:relative;
			width:8px;
		}
		
	</style>
	
	<ext:XScript runat="Server">
		<script type="text/javascript">
			var currGameGroupId;

			var viewClick = function( dv, e ) {
				var group = e.getTarget( "h2", 3, true );
	            
				if( group ) {
					group.up( "div" ).toggleClass( "collapsed" );
				}
			}

			var initData = function( ) {
				updateGameGroupState( );
				setInterval( updateGameGroupState, 3000 );
				setInterval( updateGameGroupTip, 1000 );
			};
			
			var updateGameGroupState = function( ) {
				#{StoreGameGroup}.reload( );
			};
			
			var showGameGroupTip = function( ) {
				/* Attribute id save GameGroupId */
				currGameGroupId = this.triggerElement.id;
			};
			
			var updateGameGroupTip = function( ) {
				var tip = #{ToolTipGameGroup};
				if( !tip.isVisible( ) ) {
					return;
				}
				
				Ext.net.DirectMethods.Tip.UpdateGameGroupTip( currGameGroupId, 0, {
					method : 'GET',
					success: function( result ) {
						if( result.Success ) {
							tip.body.dom.innerHTML = result.Result;
						}
					}
				} );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	
	<ext:Store ID="StoreGameGroup" runat="server" OnRefreshData="GameGroupRefresh">
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Region" />
					<ext:RecordField Name="Items" IsComplex="true" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;">
				<Center>
					<ext:Panel ID="PanelGameGroup" runat="server" Cls="items-view" Layout="fit" AutoHeight="true" Border="false">
						<%--<TopBar>
							<ext:Toolbar ID="Toolbar1" runat="server" Flat="true">
								<Items>
									<ext:ToolbarFill />
									<ext:Button ID="Button1" runat="server" Icon="BulletPlus" Text="Expand All">
										<Listeners>
											<Click Handler="#{Dashboard}.el.select('.group-header').removeClass('collapsed');" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="Button2" runat="server" Icon="BulletMinus" Text="Collapse All">
										<Listeners>
											<Click Handler="#{Dashboard}.el.select('.group-header').addClass('collapsed');" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="30" />
								</Items>
							</ext:Toolbar>
						</TopBar>--%>
						<Items>
							<ext:DataView ID="GameGroupView" runat="server" StoreID="StoreGameGroup" SingleSelect="true"
								OverClass="x-view-over" ItemSelector="div.item-wrap" AutoHeight="true" >
								<Template ID="Template1" runat="server">
									<Html>
										<div id="items-ct">
											<tpl for=".">
												<div class="group-header">
													<h2><div>{Region}</div></h2>
													<dl>
														<tpl for="Items">
															<div id={Id} class='{Cls} item-wrap'>
																{Name}
																<div class='bar'>
																	<div class='{NetLoadCls}' style='height:{NetHeight}px;top:{NetTop}px;'>
																	</div>
																</div>
																<div class='bar'>
																	<div class='{CpuLoadCls}' style='height:{CpuHeight}px;top:{CpuTop}px;'>
																	</div>
																</div>
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
									<ext:ToolTip ID="ToolTipGameGroup" runat="server" Delegate=".item-wrap" TrackMouse="true" AutoHide="false">
										<CustomConfig>
											<ext:ConfigItem Name="floating" Value="{shadow:false,shim:true,useDisplay:true,constrain:false}" Mode="Raw" />
										</CustomConfig>
										<Listeners>
											<Show Fn="showGameGroupTip" />
										</Listeners>
									</ext:ToolTip>
								</ToolTips>
								<Listeners>
									<ContainerClick Fn="viewClick" />
								</Listeners>
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

