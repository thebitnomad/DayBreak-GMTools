<%@ page language="C#" autoeventwireup="true" masterpagefile="~/common/main.master" inherits="gm_itemquery, App_Web_itemquery.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
			
			var initData = function( ) {
				queryItems( );
			};
			
			var getItemQueryParams = function( store, options ) {
				
				var itemId = #{ItemTemplateIdIdField}.getValue( );
				var itemName = #{ItemNameField}.getValue( );
				
				options.params.itemId = itemId;
				options.params.itemName = itemName;
				
			};
			
			var textFieldQuerySpecialKey = function( textField, e ) {
				if(e.getKey( ) == Ext.EventObject.ENTER ) {
					queryItems( true );
					
					if( Ext.isWebKit )
						e.stopEvent( );
				}
			};
			
			var queryItems = function( reset ) {
				
				var paramStart	= 0;
				var paramLimit	= #{PagingItems}.pageSize;
				
				if( !reset && #{StoreItem}.lastOptions ) {
					paramStart = #{StoreItem}.lastOptions.params.start;
				}
				
				#{StoreItem}.load( { 
					params : { start: paramStart, limit: paramLimit }
				 } );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreItem" runat="Server" RemoteSort="false" RemotePaging="true" AutoLoad="false" OnRefreshData="ItemsInfoRefresh">
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelItems}.body"/>
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="getItemQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="String" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String"/>
					<ext:RecordField Name="Desc" Mapping="Desc" Type="String"/>
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>
	
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:GridPanel ID="GridPanelItems" runat="Server" Border="false" StoreID="StoreItem" >
						<View>
							<ext:GridView ID="GridView1" runat="Server" MarkDirty="false">
								<%--<CustomConfig>
									<ext:ConfigItem Name="scrollToTop" Value="Ext.emptyFn" Mode="Raw" />
								</CustomConfig> --%>
								<HeaderRows>
									<ext:HeaderRow>
										<Columns>
											<ext:HeaderColumn>
												<Component>
													<ext:Label ID="Label1" runat="Server" />
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn Cls="x-small-editor">
												<Component>
													<ext:TextField ID="ItemTemplateIdIdField" runat="Server" EmptyText="<%$ Resources:StringDef, ItemTemplateId %>">
														<Listeners>
															<SpecialKey Fn="textFieldQuerySpecialKey" />
														</Listeners>
													</ext:TextField>
												</Component>
											</ext:HeaderColumn>
											<ext:HeaderColumn Cls="x-small-editor">
												<Component>
													<ext:TextField ID="ItemNameField" runat="Server" EmptyText="<%$ Resources:StringDef, ItemName %>">
														<Listeners>
															<SpecialKey Fn="textFieldQuerySpecialKey" />
														</Listeners>
													</ext:TextField>
												</Component>
											</ext:HeaderColumn>
										</Columns>
									</ext:HeaderRow>
								</HeaderRows>
							</ext:GridView>
						</View>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return ''; " />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, ItemTemplateId %>" DataIndex="Id" Width="200" Sortable="false"/>
								<ext:Column Header="<%$ Resources:StringDef, ItemName %>" DataIndex="Name" Width="300"/>
								<ext:Column Header="<%$ Resources:StringDef, ItemDesc %>" DataIndex="Desc" Width="500"/>
							</Columns>
						</ColumnModel>
						<BottomBar>
							<ext:PagingToolbar ID="PagingItems" runat="Server" PageSize="20" StoreID="StoreItem">
							</ext:PagingToolbar>
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="Server">
							</ext:RowSelectionModel>
						</SelectionModel>
					</ext:GridPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

