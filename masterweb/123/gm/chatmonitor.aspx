<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_chatmonitor, App_Web_chatmonitor.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="TabRole" Src="~/gm/tabrole.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		#divChat
		{
			padding:3px;
		}
		
		#divChat a
		{
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		var msgTitle = '<%= Resources.StringDef.SystemName %>';
		var msgLoading = '<%= Resources.StringDef.Loading %>';
		var msgSaving = '<%= Resources.StringDef.Saving %>';
		var msgSubmitting = '<%= Resources.StringDef.Submitting %>';
		var msgSave = '<%= Resources.StringDef.Save %>';
		var msgOK = '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';
	</script>
	
	<ext:XScript runat="Server">
		<script type="text/javascript">
			var m_svrId			= 0;
			var m_scrollChatDiv = true;
			var m_updating		= false;
		
			var chatDivOnRender = function( ) {
				this.body.on( "scroll", chatDivOnScroll );
			};
			
			var chatDivOnScroll = function( e, t ) {
				/* 如果滚动到底部则开启自动滚动 */
				var threshold = 20;
				if( this.dom.scrollHeight - this.dom.scrollTop <= this.getHeight( ) + threshold ) {
					m_scrollChatDiv = true;
				}
				else {
					m_scrollChatDiv = false;
				}
			};

			var monitorChat = function( ) {
				m_svrId = svrComboGetSelectedSvrId( );
				Ext.net.DirectMethods.MonitorChat( m_svrId, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};

			var storeChatGetQueryParams = function( store, options ) {
				options.params.SvrId		= m_svrId;
			};
			
			var svrComboSelect = function( ) {
				monitorChat( );
				clearChatMsg( );
			};

			var updateChatInfo = function() {
				#{PanelChat}.setTitle( getDateTimeString( new Date( ) ) );
				
				if( m_updating )
					return;
				
				m_updating = true;
				#{StoreChat}.load( { callback: function( records, options, success ) {
					m_updating = false;
					
					var chatDivEl = document.getElementById( "divChat" );
					for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
						chatDivEl.innerHTML += String.format( "[{0}][<a href=# onclick='showRoleInfo( \"{1}\" );'>{1}</a>]{2}", records[nLoopCount].data.Time, records[nLoopCount].data.Sender, htmlencode( records[nLoopCount].data.Message ) ) + "<br />";
					}
					
					if( m_scrollChatDiv ) {
						chatDivEl.scrollIntoView( false );
					}
					
				} } );
			};
			
			var clearChatMsg = function( ) {
				var chatDivEl = document.getElementById( "divChat" );
				chatDivEl.innerHTML = '';
			};
			
			var showRoleInfo = function( roleName ) {
				tabRoleLoadRoleInfo( m_svrId, roleName, roleName );
			};
			
			var initData = function( ) {
				setInterval( updateChatInfo, 1000 );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreChat" runat="server" OnRefreshData="ChatInfoRefresh" AutoLoad="false">
		<DirectEventConfig Type="Load">
		</DirectEventConfig>
		<Listeners>
			<BeforeLoad Fn="storeChatGetQueryParams" />
		</Listeners>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:ArrayReader>
				<Fields>
					<ext:RecordField Name="Sender" Mapping="Sender" Type="String" />
					<ext:RecordField Name="Message" Mapping="Message" Type="String" />
					<ext:RecordField Name="Time" Mapping="Time" Type="String" />
				</Fields>
			</ext:ArrayReader>
		</Reader>
	</ext:Store>

	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<North>
					<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="200"
						Title="<%$ Resources:StringDef, ChatInfoRealTime %>" Height="70" Padding="10"
						ButtonAlign="Center" Border="true" Margins="10px 10px 0px 10px" Width="600">
						<Items>
							<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
								<Items>
									<ext:Container ID="Container1" runat="Server">
										<Content>
											<sat:SvrCombo runat="Server" ID="svrCombo" SelectFn="svrComboSelect" />
										</Content>
									</ext:Container>
								</Items>
							</ext:CompositeField>
						</Items>
					</ext:FormPanel>
				</North>
				<Center>
					<ext:Panel ID="PanelChat" runat="Server" Height="350" AutoScroll="true" Width="700" Margins="10px 10px 10px 10px" Title="<%$ Resources:StringDef, ChatInfoRealTime %>" >
						<Content>
							<div id="divChat" ></div>
						</Content>
						<Listeners>
							<Render Fn="chatDivOnRender" />
						</Listeners>
					</ext:Panel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<sat:TabRole ID="TabRole1" runat="Server" />
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

