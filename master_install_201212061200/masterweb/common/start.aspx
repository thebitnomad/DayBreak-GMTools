<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="common_start, App_Web_start.aspx.38131f0b" validaterequest="false" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
	</script>
	<ext:XScript runat="server">
		<script type="text/javascript">
			var onDrag = function( e ) {
				var pel = this.proxy.getEl( );
				this.x = pel.getLeft( true );
				this.y = pel.getTop( true );

				var s = this.panel.getEl( ).shadow;
				if( s ) {
					s.realign( this.x, this.y, pel.getWidth( ), pel.getHeight( ) );
				}
			};
			
			var gridNoticeEndDrag = function( e ) {
				this.panel.setPosition( this.x, this.y );
				setCookie( "NoticeX", this.x );
				setCookie( "NoticeY", this.y );
			};
			
			var loadPanelPosition = function( ) {
				/* PanelNotice */
				var groupPanelNoticeX = getCookie( "NoticeX" );
				var groupPanelNoticeY = getCookie( "NoticeY" );
				if( groupPanelNoticeX.length > 0 ) {
					#{PanelNotice}.setPosition( groupPanelNoticeX, groupPanelNoticeY );
				}
			};
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="server" Layout="Absolute">
		<Items>
			<ext:Panel ID="PanelNotice" runat="server" Width="500" Padding="5"  StyleSpec="line-height:20px;" Title="<%$ Resources:StringDef, Attentions %>" X="80" Y="40" Collapsible="true">
				<Content>
					<li>
						<asp:Literal runat="Server" Text="<%$ Resources:StringDef, MsgNotice1 %>"></asp:Literal>
					</li>
					<li>
						<asp:Literal runat="Server" Text="<%$ Resources:StringDef, MsgNotice2 %>"></asp:Literal>
					</li>
				</Content>
				<DraggableConfig ID="DraggableConfig2" runat="server" ResizeFrame="true">
					<OnDrag Fn="onDrag" />
					<EndDrag Fn="gridNoticeEndDrag" />
					<CustomConfig>
						<ext:ConfigItem Name="insertProxy" Value="false" Mode="Raw" />
					</CustomConfig>
				</DraggableConfig>
			</ext:Panel>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
