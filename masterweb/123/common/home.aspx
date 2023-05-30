<%@ page title="" language="C#" autoeventwireup="true" inherits="common_home, App_Web_home.aspx.38131f0b" theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="Server">
	<title><%= Resources.StringDef.SystemName %> - <%= Resources.StringDef.SystemDesc %></title>
	<style type="text/css">
		.x-tree-node div.menu-node
		{
			background:#eee url(../images/menu/cmp-bg.gif) repeat-x;
			margin-top:1px;
			border-top:1px solid #ddd;
			border-bottom:1px solid #ccc;
			padding-top:2px;
			padding-bottom:1px;
		}
		
		.menu-node .x-tree-node-icon
		{
			display:none;
		}
		
		.menu-leaf
		{
			border:1px solid #fff;
			margin:2px;
		}
		
		.menu-leaf .x-tree-ec-icon
		{
			display:none;
		}
		
		.x-tree-selected
		{
			border:1px dotted #a3bae9;
			background:#DFE8F6;
		}
		
		.menu-leaf a span
		{
			vertical-align: middle;
		}
		
		.ext-ie8 .menu-leaf a span
		{
			padding-top:7px;
			display: inline-block;
		}
		
		.x-tree-selected a span
		{
			background:transparent;
			color:#15428b;
			font-weight:bold;
		}
		
		.x-grid3-td-Msg .x-grid3-cell-inner
		{
			white-space:normal;
			margin:3px 3px 3px 3px !important;
			line-height:15px;
		}
		
		.old-msg
		{
			color:Gray;
		}
		
		.new-msg
		{
			font-weight: bold;
		}
		
		.copyright
		{
			text-align:center;
			padding:3px;
		}
		
	</style>
</head>
<head>
	<script type="text/javascript">
		var msgTitle			= '<%= Resources.StringDef.SystemName %>';
		var msgSystemDesc		= '<%= Resources.StringDef.SystemDesc %>';
		var msgSubmitting		= '<%= Resources.StringDef.Submitting %>';
		var msgModifyPassSuccess= '<%= Resources.StringDef.MsgModifyPassSuccess %>';
		var msgLogingout		= '<%= Resources.StringDef.Logingout %>';
		var msgLogoutConfirm	= '<%= Resources.StringDef.MsgLogoutConfirm %>';
		var msgPrompt			= '<%= Resources.StringDef.Prompt %>';
		var msgView				= '<%= Resources.StringDef.View %>';
		var systemMessage		= '<%= Resources.StringDef.SystemMessage %>';
		var msgNewMessageFormat	= '<%= Resources.StringDef.MsgNewMessageFormat %>';
		var msgNewMsgTitleBlinkFill		= '<%= Resources.StringDef.MsgNewMsgTitleBlinkFill %>';
		var msgNewMsgTitleBlinkEmpty	= '<%= Resources.StringDef.MsgNewMsgTitleBlinkEmpty %>';
		var msgRevNewMsgFormat			= '<%= Resources.StringDef.MsgRevNewMsgFormat %>';
		var msgNotifyTitle				= '<%= Resources.StringDef.Title %>';
		var msgNotifyContent			= '<%= Resources.StringDef.Content %>';
		var msgCannotBeNullFormat		= '<%= Resources.StringDef.MsgCannotBeNullFormat %>';
		var machineDetail				= '<%= Resources.StringDef.MachineDetail %>'
		
		var checkUnload			= true;
		var template			= '<span class="{0}">{1}</span>';
		var blinkInterval		= 0;
		var lastMsgUpdateTime;

		var loadPage = function( tabPanel, node ) {
			var tab = tabPanel.add({

				title: node.text,
				closable: true,
				autoLoad: {
					showMask: true,
					url: node.attributes.href,
					mode: "iframe",
					maskMsg: "<%= Resources.StringDef.Loading %>"
				},
				listeners: {
					update: {
						fn: function(tab, cfg) {
							cfg.iframe.setHeight(cfg.iframe.getSize().height);
						},
						scope: this,
						single: true
					}
				}
			});

			tabPanel.setActiveTab(tab);
		};
		
		var unloadPage = function( ID ) {
			Pages.remove( ID );
		};
		
		/* Close the tab when perform mouse double click. */
		var onTitleDbClick = function( e, target, o ) {
			var t = Pages.findTargets( e );
			if( t && t.item && t.item.closable && t.item.fireEvent( 'beforeclose', t.item ) !== false ) {
				t.item.fireEvent( 'close', t.item );
				Pages.remove( t.item );
			}
		};

		var modifyPass = function( ) {
			Ext.net.DirectMethods.ModifyPass( {
				eventMask: {
					showMask: true,
					minDelay: 200,
					msg: msgSubmitting
				},
				success: function( result ){
					if( result.Success ){
						WindowModifyPass.hide( );
						Ext.Msg.show({
							title: msgTitle,
							msg: msgModifyPassSuccess,
							buttons: Ext.Msg.OK,
							minWidth: 200,
							maxWidth: 400,
							icon: Ext.MessageBox.Information
						});
					}
					else if( result.ErrorMessage ){
						Ext.Msg.show({
							title: msgTitle,
							msg: result.ErrorMessage,
							buttons: Ext.Msg.OK,
							minWidth: 200,
							maxWidth: 400,
							icon: Ext.MessageBox.Error
						});
					}
				}
			});
		};

		var pageTabChange = function( el, tab, index ) {
			TreePanelMenu.selectPath( tab.nodePath );
		};

		var setCookie = function( cname, value ) {
			var exdate = new Date( );
			exdate.setDate( exdate.getDate( ) + 30 );
			document.cookie = cname + "=" + escape( value ) + ";expires="+exdate.toGMTString( ) + "; path=/";
		};

		var getCookie = function( cname ) {
			if( document.cookie.length > 0 ) {
				var cstart = document.cookie.indexOf( cname + "=" )
				if( cstart != -1 ) {
					cstart = cstart + cname.length + 1;
					
					var cend = document.cookie.indexOf( ";", cstart );
					if( cend == -1 )
						cend = document.cookie.length;
					
					return unescape( document.cookie.substring( cstart, cend ) );
				}
			}
			
			return "";
		};

		var delCookie = function( name ) {
			var exp = new Date( );
			exp.setTime( exp.getTime( ) - 1 );
			document.cookie = name + "=;expires=" + exp.toGMTString( ) + "; path=/";
		};
		
		var disableFuncKeys = function( ) {
			/* 屏蔽退格键 */
			Ext.fly( document ).addKeyMap({
				key: Ext.EventObject.BACKSPACE,
				handler: function( source, e ){
					var target = Ext.fly( e.target );
					if ( ( target.is( 'input' ) || target.is( 'input' ) || target.is( 'textarea' ) ) && !target.dom.readOnly )
						return;
					
					e.stopEvent( );
				}
			});
		};

		var logout = function() {
			Ext.Msg.confirm(msgTitle, msgLogoutConfirm, function(btn) {
				if (btn == "yes") {
					Ext.net.DirectMethods.Logout({
						eventMask: {
							showMask: true,
							minDelay: 200,
							msg: msgLogingout
						},
						success: function(result) {
							delCookie('mstusername');
							delCookie('mstuserpass');
							checkUnload = false;
							window.location.href = './login.aspx';
						}
					});
				}
			});
		};
		
		var showUserMsg = function( ) {
			var notifyEl = Ext.get( 'notifyMsg' );
			if( notifyEl )
				notifyEl.hide( );
				
			WindowUserMsg.show( );
			queryUserMsg( true );
		};
		
		var queryUserMsg = function( reset ) {
			var paramStart = 0;
			var paramLimit = PagingToolbarUserMsg.pageSize;
			
			/* If lastOptions is not null, use the start and limit parameters. */
			if( !reset && StoreUserMsg.lastOptions ) {
				paramStart = StoreUserMsg.lastOptions.params.start;
			}
			
			StoreUserMsg.load( { params: { start: paramStart, limit: paramLimit } } );
		};

		var renderMsg = function( value, metadata, record, rowIndex, colIndex, store ) {
			var cls = userMsgGetRowClass( record );
			return String.format( template, cls, value );
		};

		var renderTime = function( value, metadata, record, rowIndex, colIndex, store ) {
			var timeStr = record.get( 'RecordTime' );
			var timeIndex = timeStr.indexOf( ' ' );
			if( timeIndex != -1 )
				return renderMsg( timeStr.substr( 0, timeIndex ) + '<br />' + timeStr.substr( timeIndex ), metadata, record, rowIndex, colIndex, store );
			else
				return renderMsg( value, metadata, record, rowIndex, colIndex, store );
		};

		var userMsgGetRowClass = function( record ) {
			var msgDate = Date.parseDate( record.get( 'RecordTime' ), "Y-m-d H:i:s", true );
			var lastMsgCheckTime = new Date( getCookie( "lastMsgCheckTime" ) );

			if( lastMsgCheckTime > msgDate )
				return "old-msg";
			else
				return 'new-msg';
		};

		var getQueryParams = function( store, options ) {
			lastMsgUpdateTime = new Date( );
			options.params.endTime = lastMsgUpdateTime;
		};
		
		var userMsgWinHide = function( ) {
			setCookie( "lastMsgCheckTime", lastMsgUpdateTime );
			LinkUserMsg.setText( systemMessage );
			clearInterval( blinkInterval );
			blinkInterval = 0;
			document.title = msgTitle + ' - ' + msgSystemDesc;
			LinkUserMsg.show( );
		};

		var setUserMsgTimer = function( ) {
			setInterval( updateUserMsg, 60 * 1000 );
			setTimeout( updateUserMsg, 5000 );
		};

		var updateUserMsg = function( ) {
			if( WindowUserMsg.hidden ) {
				queryUserMsg( true );
			}
		};

		var storeUserMsgLoad = function( store, records, options ) {
			var newMsgCount = 0;
			for( var nLoopCount = 0; nLoopCount < records.length; ++nLoopCount ) {
				var msgDate = Date.parseDate( records[nLoopCount].get( 'RecordTime' ), "Y-m-d H:i:s", true );
				var lastMsgCheckTimeCookie = getCookie( "lastMsgCheckTime" );
				if( !lastMsgCheckTimeCookie ) {
					++newMsgCount;
					continue;
				}
				var lastMsgCheckTime = new Date( lastMsgCheckTimeCookie );
				if( lastMsgCheckTime <= msgDate )
					++newMsgCount;
			}
			
			if( newMsgCount > 0 ) {
				LinkUserMsg.setText( systemMessage + "(" + String.format( msgNewMessageFormat, newMsgCount ) + ")" );
				if( !blinkInterval ) {
					blinkInterval = setInterval( blinkTitle, 1000 );
					Ext.net.Notification.show( {
						id       : 'notifyMsg',
						html     : '<span class="usermsg" style="width:64px;height:64px;"></span><span>' + String.format( msgRevNewMsgFormat, newMsgCount ) + '<br /><a href=# onclick="showUserMsg( );">' + msgView + '</a>' + '</span>',
						autoHide : false,
						height   : 100,
						title    : msgPrompt
					} );
				}
			}
			else {
				LinkUserMsg.setText( systemMessage );
			}
		};
		
		var blinkTitle = function( ) {
			var today = new Date( );
			var seconds = today.getSeconds();

			if( seconds % 2 == 0 ) {
				document.title = msgNewMsgTitleBlinkFill + msgTitle + ' - ' + msgSystemDesc;
				LinkUserMsg.show( );
			} else {
				document.title = msgNewMsgTitleBlinkEmpty + msgTitle + ' - ' + msgSystemDesc;
				LinkUserMsg.hide( );
			}
		};

		var appendTabPrefixText = function(prefixText) {
			var activeTab = Pages.getActiveTab();
			if (activeTab.title.indexOf(prefixText) != 0) {
				activeTab.setTitle(prefixText + activeTab.title);
			}
		};

		var btnLinkSystemConfig = function( ) {
			WindowSystemConfig.show();
		};
		
	</script>
</head>
<body>
	<form id="form1" runat="server">
	<ext:ResourceManager ID="ResourceManager1" runat="server">
	</ext:ResourceManager>
	<ext:Store ID="StoreUserMsg" runat="server" OnRefreshData="UserMsgDataRefresh" RemotePaging="true"
		RemoteSort="true" AutoLoad="false" ShowWarningOnFailure="false">
		<DirectEventConfig>
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{GridPanelUserMsg}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="MsgType" Mapping="MsgType" Type="Int" />
					<ext:RecordField Name="Msg" Mapping="Msg" Type="String" />
					<ext:RecordField Name="RecordTime" Mapping="RecordTime" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
		<Listeners>
			<BeforeLoad Fn="getQueryParams" />
			<Load Fn="storeUserMsgLoad" />
		</Listeners>
	</ext:Store>
	<ext:Viewport ID="Viewport1" runat="server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="server">
				<North Margins-Bottom="2">
					<ext:Panel ID="PanelNorth" runat="server" Header="false" Height="34" PreventBodyReset="true" ContentEl="headerDiv">
					</ext:Panel>
				</North>
				<West MinWidth="150" MaxWidth="400" Split="true" Collapsible="true" CollapseMode="Mini">
					<ext:TreePanel ID="TreePanelMenu" runat="server" Width="210" Title="<%$ Resources: StringDef, FunctionNavigation %>"
						RootVisible="false" TrackMouseOver="true" UseArrows="true" >
						<Listeners>
							<Click Handler="if( node.attributes.href ) { e.stopEvent( ); loadPage( #{Pages}, node ); }" />
							<BeforeClick Handler="return node.isLeaf( );" />
						</Listeners>
					</ext:TreePanel>
				</West>
				<Center>
					<ext:TabPanel ID="Pages" runat="server" EnableTabScroll="true" Plain="true" >
						<Items>
							<ext:Panel runat="server" Title="<%$ Resources:StringDef, Start %>" Icon="House">
								<AutoLoad Url="start.aspx" Mode="IFrame" ShowMask="true" MaskMsg="<%$ Resources:StringDef, Loading %>">
								</AutoLoad>
							</ext:Panel>
						</Items>
						<Listeners>
							<TabChange Fn="pageTabChange" />
						</Listeners>
					</ext:TabPanel>
				</Center>
				<South>
					<%--<ext:Panel ID="PanelSouth" runat="server" Header="false" Height="20" PreventBodyReset="true"
						ContentEl="footerDiv" Border="false" >
					</ext:Panel>--%>
					
					<ext:Panel ID="PanelSouth" runat="server" Header="false" Height="20" PreventBodyReset="true" BodyStyle="background-color:#DFE8F6;" 
						Border="false" HTML="<%$ Resources:StringDef, MsgCopyRight %>" Cls="copyright" >
					</ext:Panel>
				</South>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	<div id="headerDiv" style="border: 0 none; background: url(../images/hbg.gif) repeat-x 0 0; height: 34px;">
		<div class="logo"><%= Resources.StringDef.SystemName %></div>
		<div style="float:right; color:#FFF; margin-top:8px;margin-right:5px;">
			<ext:Label ID="LabelUserName" runat="Server" EnableViewState="false" StyleSpec="font-weight:bold;" />
			<ext:Label ID="LabelLoginTime" runat="Server" EnableViewState="false" />
			<ext:Label runat="Server" Text="|" />
			<ext:LinkButton ID="LinkUserMsg" runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, SystemMessage %>" StyleSpec="padding-top:2px;" HideMode="Visibility">
				<Listeners>
					<Click Fn="showUserMsg" />
				</Listeners>
			</ext:LinkButton>
			<ext:Label runat="Server" Text="|" />
			<ext:LinkButton ID="LinkSystemConfig" runat="Server" Cls="topbaruserinfo" Text="<%$REsources:StringDef, SystemConfig %>" StyleSpec="padding-top:2px;">
				<Listeners>
					<Click Fn="btnLinkSystemConfig" />
				</Listeners>
			</ext:LinkButton>
			<ext:Label ID="LabelSytem" runat="Server" Text="|" />
			<ext:LinkButton ID="LinkModifyPass" runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, ModifyPass %>" Visible="false" >
				<Listeners>
					<Click Handler="
						#{FormPanelModifyPass}.reset( );
						#{WindowModifyPass}.show( );
					" />
				</Listeners>
			</ext:LinkButton>
			<ext:Label runat="server" ID="LabelModifyPassAdditional" Text="|" Visible="false" />
			<ext:LinkButton runat="Server" Cls="topbaruserinfo" Text="<%$ Resources:StringDef, Logout %>" StyleSpec="padding-top:2px;">
				<Listeners>
					<Click Fn="logout" />
				</Listeners>
			</ext:LinkButton>
		</div>
	</div>
	<div id="footerDiv" style="border: 0 none; text-align:center; padding: 2px; background-color:transparent;">
		<asp:Literal runat="Server" Text="<%$ Resources:StringDef, MsgCopyRight %>" />
	</div>
	<ext:Window ID="WindowModifyPass" runat="server" Resizable="false" Width="400" AutoHeight="true"
		Title="<%$ Resources:StringDef, ModifyPass %>" CloseAction="Hide" Hidden="true"
		AnimateTarget="#{LinkModifyPass}" Modal="true">
		<Items>
			<ext:FormPanel ID="FormPanelModifyPass" runat="server" ButtonAlign="Right" Padding="10" 
				LabelWidth="120" Border="false" LabelAlign="Right">
				<Items>
					<ext:TextField ID="TextFieldOldPass" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, OldPassword %>" InputType="Password" >
					</ext:TextField>
					<ext:TextField ID="TextFieldNewPass" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, NewPassword %>" InputType="Password">
					</ext:TextField>
					<ext:TextField ID="TextFieldNewPassConfirm" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, NewPasswordConfirm %>" InputType="Password">
						<Listeners>
							<SpecialKey Handler="
								if( e.getKey( ) == Ext.EventObject.ENTER ) {
									modifyPass( );
								}
							" />
						</Listeners>
					</ext:TextField>
				</Items>
			</ext:FormPanel>
		</Items>
		<Buttons>
			<ext:Button ID="ButtonModifyPass" runat="server" Text="<%$ Resources:StringDef, OK %>">
				<Listeners>
					<Click Fn="modifyPass" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="ButtonAddCancel" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="#{WindowModifyPass}.hide( );" />
				</Listeners>
			</ext:Button>
		</Buttons>
		<Listeners>
			<Show Handler="#{TextFieldOldPass}.focus( );" Delay="50" />
		</Listeners>
	</ext:Window>
	
	<ext:Window ID="WindowUserMsg" runat="server" Resizable="false" Width="600" Height="350"
		Title="<%$ Resources:StringDef, SystemMessage %>" CloseAction="Hide" Hidden="true"
		AnimateTarget="LinkUserMsg" Modal="true">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:GridPanel ID="GridPanelUserMsg" runat="server" StoreID="StoreUserMsg" Border="false" AutoExpandColumn="Msg">
						<View>
							<ext:GridView ID="GridView1" runat="server" MarkDirty="true">
								<GetRowClass Fn="userMsgGetRowClass" />
							</ext:GridView>
						</View>
						<BottomBar>
							<ext:PagingToolbar ID="PagingToolbarUserMsg" runat="server" PageSize="10" StoreID="StoreUserMsg" />
						</BottomBar>
						<SelectionModel>
							<ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" >
							</ext:RowSelectionModel>
						</SelectionModel>
						<ColumnModel>
							<Columns>
								<ext:RowNumbererColumn>
									<Renderer Handler="return '';" />
								</ext:RowNumbererColumn>
								<ext:Column Header="<%$ Resources:StringDef, ID %>" DataIndex="Id" Width="45" Hidden="true" Sortable="false">
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Content %>" DataIndex="Msg" Sortable="false">
									<Renderer Fn="renderMsg" />
								</ext:Column>
								<ext:Column Header="<%$ Resources:StringDef, Time %>" DataIndex="RecordTime" Width="85" Align="Center" Sortable="false">
									<Renderer Fn="renderTime" />
								</ext:Column>
							</Columns>
						</ColumnModel>
					</ext:GridPanel>		
				</Center>
			</ext:BorderLayout>
		</Items>
		<Listeners>
			<Hide Fn="userMsgWinHide" />
		</Listeners>
	</ext:Window>
	
	<ext:Window ID="WindowSystemConfig" runat="server" Width="1200" Height="600" Border="false"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, SystemLog %>">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" Url="systemconfig.aspx" >
		</AutoLoad>	
	</ext:Window>
	
	</form>
</body>
</html>
