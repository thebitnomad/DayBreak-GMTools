<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_roledetail, App_Web_roledetail.aspx.b931aa99" theme="default" %>

<%@ Register TagPrefix="sat" TagName="FileMan2" Src="~/common/fileman2.ascx" %>
<%@ Register TagPrefix="sat" TagName="GMBaseOp" Src="~/gm/baseop.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable = '<%= Resources.StringDef.NotAvailable %>';
		var msgResumeRoleConfirmFormat	= '<%= Resources.StringDef.MsgResumeRoleConfirmFormat %>';
		var msgResuleRoleSuccess		= '<%= Resources.StringDef.MsgResuleRoleSuccess %>';
	</script>
	
	<ext:XScript runat="Server">
		<script type="text/javascript">
			var m_roleName;
			var m_ggId;
			var m_ggName;
			var m_gameId;

			var refreshInfo = function( ) {
				Ext.net.DirectMethods.LoadRoleBaseInfo( {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
						if( result.Success ) {
						}
					}
				} );
			};

			var btnExecGMCmdClick = function( ) {
				var accName = #{FieldHiddenAcc}.getValue( );
				#{WindowGMCommand}.load( {
					url: 'gmcommand.aspx?ggId=' + m_ggId + '&rname=' + encodeURI( m_roleName ) + "&acc=" + accName,
					discardUrl: false,						
					nocache: true,
					timeout: 30
				} );
				
				#{WindowGMCommand}.show( );
			};
			
			var btnExportClick = function( ) {
				window.open( "./gm.ashx?op=exroledata&ggId=" + m_ggId + "&rname=" + encodeURI( m_roleName ) );
			};
			
			var btnResumeClick = function( ) {
				fileManRefreshDir( );
				#{WindowFileMan}.show( );
			};
			
			var btnRefresh = function( ) {
				refreshInfo( );
			};
			
			var resumeRoleData = function( ) {
				var fileName = fileManGetSelFileName( );
				var filePath = fileManGetSelFile( );
				if( !filePath )
					return;
				
				var result = showConfirmMsg( msgTitle, String.format( msgResumeRoleConfirmFormat, fileName, m_ggName ), function( btn ){
					if( btn == "yes" ) {
						var accName = #{FieldHiddenAcc}.getValue( );
						
						Ext.net.DirectMethods.ResumeRoleData( filePath, accName, m_roleName, {
							eventMask: {
								showMask: true,
								minDelay: 200,
								msg: msgSubmitting
							},
							success: function( result ) {
								if( result.Success ) {
									showSuccessMsg( msgTitle, msgResuleRoleSuccess );
								}
								else if( result.ErrorMessage ) {
									showErrMsg( msgTitle, result.ErrorMessage );
								}
							}
						});
					}
				});
			};
			
			var btnImportRoleData = function( ){
				var accName = #{FieldHiddenAcc}.getValue( );
				#{WindowImportData}.load( {
					url			:'importdata.aspx?ggId=' + m_ggId + '&rname=' + encodeURI( m_roleName ) + '&acc=' + accName,
					discardUrl	: false,						
					nocache		: true,
					timeout		: 30
				} );
				
				#{WindowImportData}.show( );
			};
			
		</script>
	</ext:XScript>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server" StyleSpec="background-color:#FFF;" >
				<Center>
					<ext:TabPanel runat="Server" ID="TabPanelRoleInfo" TabPosition="Bottom" Border="false">
						<TopBar>
							<ext:Toolbar runat="Server">
								<Items>
									<ext:Button ID="RoleChatConfig" runat="server" Text="<%$ Resources:StringDef, RoleCtrl %>" Icon="GroupGo">
										<Menu>
											<ext:Menu runat="server">
												<Items>
													<ext:MenuItem ID="BtnDisableChat" runat="server" Text="<%$ Resources:StringDef, DisableChat %>" Icon="Decline" >
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpSetRoleNoChat( m_ggId, accName, m_roleName, true, function( result ) {
																	refreshInfo( );
																} )" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnEnableChat" Text="<%$ Resources:StringDef, EnableChat %>" Icon="Accept">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpSetRoleNoChat( m_ggId, accName, m_roleName, false, function( result ) {
																	refreshInfo( );
																} );" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnDisableLogin" runat="server" Text="<%$ Resources:StringDef, Freeze %>" Icon="Decline">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpSetRoleNoLogin( m_ggId, accName, m_roleName, true, function( result ) {
																	refreshInfo( );
																} );
																" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnEnableLogin" runat="server" Text="<%$ Resources:StringDef, Unfreeze %>" Icon="Accept">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpSetRoleNoLogin( m_ggId, accName, m_roleName, false, function( result ) {
																	refreshInfo( );
																} );
															" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnKickRole" runat="server" Text="<%$ Resources:StringDef, KickRole %>" Icon="Lightning">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpKickRole( m_ggId, accName, m_roleName, function( result ) {
																	refreshInfo( );
																} );
															" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnResetPwd" runat="server" Text="<%$ Resources:StringDef, ResetStorePass %>" Icon="ControlRecord">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																gmOpResetPass( m_ggId, accName, m_roleName );
															" />
														</Listeners>
													</ext:MenuItem>
												</Items>
											</ext:Menu>
										</Menu>
									</ext:Button>
									<ext:Button ID="BtnAccountManagement" runat="server" Text="<%$ Resources:StringDef, AccountManagement %>" Icon="ApplicationCascade">
										<Menu>
											<ext:Menu runat="server">
												<Items>
													<ext:MenuItem ID="BtnFreezeAcc" runat="server" Text="<%$ Resources:StringDef, FreezeAccount %>" Icon="UserDelete">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																var accId	= #{FieldHiddenAccId}.getValue( );
																gmOpSetAccountNoLogin( m_ggId, accName, m_roleName, accId, true, m_gameId, function( result ) {
																} );
															" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnUnfreezeAcc" runat="server" Text="<%$ Resources:StringDef, UnfreezeAccount %>" Icon="UserTick">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																var accId	= #{FieldHiddenAccId}.getValue( );
																gmOpSetAccountNoLogin( m_ggId, accName, m_roleName, accId, false, m_gameId, function( result ) {
																} );
															" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnTrusteeAcc" runat="server" Text="<%$ Resources:StringDef, TrusteeAccount %>" Icon="ControllerAdd">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																var accId	= #{FieldHiddenAccId}.getValue( );
																gmOpTrusteeAccount( m_ggId, accName, m_roleName, accId, true, m_gameId, function( result ){
																} );
															" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnUnTrusteeAcc" runat="server" Text="<%$ Resources:StringDef, UnTrusteeAccount %>" Icon="ControllerDelete">
														<Listeners>
															<Click Handler="
																var accName = #{FieldHiddenAcc}.getValue( );
																var accId	= #{FieldHiddenAccId}.getValue( );
																gmOpTrusteeAccount( m_ggId, accName, m_roleName, accId, false, m_gameId, function( result ){
																} );
															"/>
														</Listeners>
													</ext:MenuItem>
												</Items>
											</ext:Menu>
										</Menu>
									</ext:Button>
									<ext:Button ID="DataManagement" runat="server" Text="<%$ Resources:StringDef, DataManagement %>" Icon="Database">
										<Menu>
											<ext:Menu runat="server">
												<Items>
													<ext:MenuItem ID="BtnExport" runat="server" Text="<%$ Resources:StringDef, Export %>" Icon="ArrowOut">
														<Listeners>
															<Click Fn="btnExportClick" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnResume" runat="server" Text="<%$ Resources:StringDef, Resume %>" Icon="DriveKey">
														<Listeners>
															<Click Fn="btnResumeClick" />
														</Listeners>
													</ext:MenuItem>
													<ext:MenuItem ID="BtnImport" runat="Server" Text="<%$ Resources:StringDef, Import %>" Icon="DatabaseGo">
														<Listeners>
															<Click Fn="btnImportRoleData" />
														</Listeners>
													</ext:MenuItem>
												</Items>
											</ext:Menu>
										</Menu>
									</ext:Button>
									<ext:Button ID="BtnFreezeIP" runat="server" Text="<%$ Resources:StringDef, FreezeIPAddress %>" Icon="DoorError" >
										<Listeners>
											<Click Handler="
												var accName = #{FieldHiddenAcc}.getValue( );
												var ipAddr	= #{FieldHiddenIP}.getValue( );
												
												gmOpFreezeIP( m_ggId, accName, m_roleName, true, ipAddr, function( result ) {
												} );
											" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnUnfreezeIP" runat="server" Text="<%$ Resources:StringDef, UnfreezeIPAddress %>" Icon="DoorOpen" >
										<Listeners>
											<Click Handler="
												var accName = #{FieldHiddenAcc}.getValue( );
												var ipAddr	= #{FieldHiddenIP}.getValue( );
												
												gmOpFreezeIP( m_ggId, accName, m_roleName, false, ipAddr, function( result ) {
												} );
											" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnClearMoney" runat="server" Text="<%$ Resources:StringDef, ClearMoney %>" Icon="CdrStop" ToolTip="<%$ Resources:StringDef, MsgClearMoneyTip %>">
										<Listeners>
											<Click Handler="
												var accName = #{FieldHiddenAcc}.getValue( );
												var roleGUID = #{FieldRoleGUID}.getValue( );
												gmOpClearMoney( m_ggId, accName, m_roleName, roleGUID );
											" />
										</Listeners>
									</ext:Button>
									<ext:Button ID="BtnExecGMCmd" runat="server" Text="<%$ Resources:StringDef, ExecGMCommand %>" Icon="ApplicationOsxKey">
										<Listeners>
											<Click Fn="btnExecGMCmdClick" />
										</Listeners>
									</ext:Button>
									<ext:ToolbarFill />
									<ext:Button ID="BtnRefresh" runat="server" Text="<%$ Resources:StringDef, Refresh %>" Icon="ArrowRefresh">
										<Listeners>
											<Click Fn="btnRefresh" />
										</Listeners>
									</ext:Button>
								</Items>
							</ext:Toolbar>
						</TopBar>
						<Items>
							<ext:Panel ID="PanelBaseInfo" runat="server" AutoHeight="true" Title="<%$ Resources:StringDef, BaseInfo %>" Border="false" Padding="10" LabelWidth="120" Layout="form">
								<Content>
									<table>
										<tr>
											<td>
												<ext:DisplayField ID="FieldRoleName" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, RoleName %>" />
											</td>
											<td>
												<ext:Hidden ID="FieldHiddenAcc" runat="Server" />
												<ext:Hidden ID="FieldHiddenAccId" runat="Server" />
												<ext:DisplayField ID="FieldAccount" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, Account %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldGameID" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, GameID %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldRoleGUID" runat="server" Width="500" FieldLabel="GUID" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldCreateInfo" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, CreateInfo %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:Hidden ID="FieldHiddenIP" runat="Server" />
												<ext:DisplayField ID="FieldLastPlayingInfo" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, LastPlayingInfo %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldBalance" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, Balance %>" Text="<%$ Resources:StringDef, Unknown %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldBindBalance" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, BindBalance %>" Text="<%$ Resources:StringDef, Unknown %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldTotalCharge" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, TotalCharge %>" Text="<%$ Resources:StringDef, Unknown %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldVIPPoint" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, VIPPoint %>" Text="<%$ Resources:StringDef, Unknown %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldMoney" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, Money %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldBindMoney" runat="server" Width="500" FieldLabel="<%$ Resources:StringDef, BindMoney %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldBindIb" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, Voucher %>" />
											</td>
											<td>
												<ext:DisplayField ID="FieldPlayedTime" runat="server" Width="400" FieldLabel="<%$ Resources:StringDef, PlayedTime %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldFatigueGiven" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, Fatigue %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldNoChatDate" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, NoChatDate %>" />
											</td>
											<td>
												<ext:DisplayField ID="FieldNoLoginDate" runat="server" Width="400" FieldLabel="<%$ Resources:StringDef, NoLoginDate %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldOnlineState" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, OnlineState %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField ID="FieldExp" runat="server" Width="200" FieldLabel="<%$ Resources:StringDef, Exp %>" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" Width="500" Text="" />
											</td>
										</tr>
										<tr>
											<td>
												<ext:DisplayField runat="server" LabelSeparator="" LabelStyle="font-weight:bold;color:blue;width:800px;" FieldLabel="<%$ Resources:StringDef, MsgRoleInfoDetailNote %>" />
											</td>
										</tr>
									</table>
								</Content>
							</ext:Panel>
							<ext:Panel ID="PanelItemInfo" runat="server" Title="<%$ Resources:StringDef, ItemInfo %>" Border="false">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelSkillInfo" runat="server" Title="<%$ Resources:StringDef, SkillInfo %>" Border="false">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelTaskInfo" runat="server" Title="<%$ Resources:StringDef, TaskInfo %>" Border="false">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelCreatureInfo" runat="server" Title="<%$ Resources:StringDef, CreatureInfo %>" Border="false">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelRideInfo" runat="Server" Title="<%$ Resources:StringDef, RideInfo %>" Border="false">
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true"/>
							</ext:Panel>
						</Items>
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
	
	<sat:GMBaseOp runat="Server" />
	
	<ext:Window ID="WindowGMCommand" runat="server" Resizable="true" Maximizable="false" BodyBorder="false"
		Width="880" Height="460" Padding="0" CloseAction="Hide" Collapsible="false" Title="<%$ Resources:StringDef, ExecGMCommand %>"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowImportData" runat="server" Resizable="true" Maximizable="false" BodyBorder="false"
		Width="700" Height="400" Padding="0" CloseAction="Hide" Collapsible="false" Title="<%$ Resources:StringDef, QuickImportData %>"
		Hidden="true" Modal="true">
		<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" >
		</AutoLoad>
	</ext:Window>
	
	<ext:Window ID="WindowFileMan" runat="Server" Width="900" Height="450" CloseAction="Hide"
		Hidden="true" Modal="true" Title="<%$ Resources:StringDef, RoleDataFile %>">
		<Items>
			<ext:BorderLayout ID="BorderLayout2" runat="Server">
				<Center>
					<ext:Container ID="Container1" runat="server" Height="250">
						<Content>
							<sat:FileMan2 runat="Server" ID="FileManSvr" Border="false">
							</sat:FileMan2>
						</Content>
					</ext:Container>
				</Center>
			</ext:BorderLayout>
		</Items>
		<Buttons>
			<ext:Button ID="BtnWinFileMan" runat="server" Text="<%$ Resources:StringDef, OK %>" >
				<Listeners>
					<Click Fn="resumeRoleData" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="Button1" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
				<Listeners>
					<Click Handler="
						#{WindowFileMan}.hide( );
					" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:Window>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>

