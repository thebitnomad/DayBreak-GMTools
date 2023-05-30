<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_roleiteminfo, App_Web_roleiteminfo.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="Tip" Src="~/op/tip.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.items-view .x-panel-body{
			background: white;
		}
		
		.items-view .item{
			background: #dddddd;
		}
		
		.items-view .item img{
			height: 40px;
			width: 40px;
		}
		
		.items-view .item img{
			position:relative;
		}
		
		.items-view .item-wrap{
			float: left;
			margin: 0px;
			margin-right: 0;
			padding: 5px;
			text-align:center;
			width:70px;
			height:70px;
			overflow:hidden;
		}
		
		.items-view .item-wrap span{
			display: block;
			overflow: hidden;
			text-align: center;
		}

		.items-view .x-view-over{
			border:1px solid #dddddd;
			background: #efefef;
			padding: 4px;
		}

		.items-view .x-view-selected{
			background: #eff5fb;
			border:1px solid #99bbe8;
			padding: 4px;
		}
		
		.items-view .x-view-selected .item{
			background:transparent;
		}

		.items-view .loading-indicator {
			padding-left:20px;
			margin:10px;
		}
		
		.cnt {
			overflow:hidden;
			position:absolute;
			top:2px;
			left:2px;
		}
	</style>
    <script type="text/javascript">
    	var msgTitle		= '<%= Resources.StringDef.SystemName %>';
    	var msgLoading		= '<%= Resources.StringDef.Loading %>';
    	var msgSaving		= '<%= Resources.StringDef.Saving %>';
    	var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
    	var msgSave			= '<%= Resources.StringDef.Save %>';
    	var msgOK			= '<%= Resources.StringDef.OK %>';
    	var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
	</script>
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			var m_roleName;
			
			var prepareData = function (data) {
				data.ShortName	= Ext.util.Format.ellipsis(data.Name, 10);
				data.CntText	= data.Cnt > 1 ? '[' + data.Cnt + ']' : '';

				return data;
			};
			
			var showItemTip = function( ) {
				var tip = #{ToolTipItem};
				
				var triggerElem = this.triggerElement;
				
				/* id represent for item's GUID */
				var itemGUID = this.triggerElement.id;
				if( triggerElem.Tip != undefined ) {
					tip.body.dom.innerHTML = triggerElem.Tip;
					
					setTimeout( "adjustTipPos( );", 200 );
				} else {
					tip.body.dom.innerHTML = "<div class='tip'>" + msgLoading + "</div>";
					Ext.net.DirectMethods.Tip.GetItemTip( encodeURI( m_roleName ), itemGUID, {
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
				var tip = #{ToolTipItem};
				
				var posX = tip.targetXY[0];
				var posY = tip.targetXY[1];
				
				if( posX + tip.maxWidth > document.body.clientWidth && posX > tip.maxWidth ) {
					posX = posX - tip.maxWidth;
					tip.setPosition( posX, posY );
				}
				
				debugger
//				if( posY + tip.getFrameHeight( ) > document.body.clientHeight ) {
//					posY = posY - ( document.body.clientHeight - tip.getFrameHeight( ) );
//				}
			};
			
			var textFieldKeywordsSpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					var keyword = #{TextFieldQueryName}.getValue( );
					
					if( keyword ) {
						#{StoreItem}.filter( 'Name', keyword, true );
					} else {
						#{StoreItem}.clearFilter( false );
					}
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store runat="server" ID="StoreItem" RemotePaging="true" OnRefreshData="StoreItemRefresh">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{PanelItem}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="GUID" />
					<ext:RecordField Name="Name" />
					<ext:RecordField Name="IconUrl" />
					<ext:RecordField Name="Cnt" />
					<ext:RecordField Name="Color" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:Panel runat="server" ID="PanelItem" Cls="items-view" Layout="Fit" Border="false" AutoScroll="true" PaddingSummary="5px 20px 5px 0px">
						<Items>
							<ext:DataView ID="DataView1" runat="server" AutoHeight="true" MultiSelect="true" StoreID="StoreItem"
								OverClass="x-view-over" ItemSelector="div.item-wrap">
								<Template ID="Template1" runat="server">
									<Html>
										<tpl for=".">
											<div id="{GUID}" class="item-wrap">
												<div class="icon">
													<img src="{IconUrl}"></img>
												</div>
												<span class='{Color}'>{Name}{CntText}</span>
											</div>
										</tpl>
										<div class="x-clear"></div>
									</Html>
								</Template>
								<PrepareData Fn="prepareData" />
								<ToolTips>
									<ext:ToolTip ID="ToolTipItem" runat="server" Delegate=".item-wrap" TrackMouse="false">
										<Listeners>
											<Show Fn="showItemTip" />
										</Listeners>
									</ext:ToolTip>
								</ToolTips>
							</ext:DataView>
						</Items>
						<BottomBar>
							<ext:PagingToolbar ID="PagingItem" runat="server" StoreID="StoreItem" PageSize="500" HideRefresh="true">
								<Items>
									<ext:ToolbarSpacer />
									<ext:TextField ID="TextFieldQueryName" runat="server" EmptyText="<%$ Resources:StringDef, QueryByRoleName %>" Width="200">
										<Listeners>
											<SpecialKey Fn="textFieldKeywordsSpecialKey" />
										</Listeners>
									</ext:TextField>
								</Items>
							</ext:PagingToolbar>
						</BottomBar>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<sat:Tip runat="Server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

