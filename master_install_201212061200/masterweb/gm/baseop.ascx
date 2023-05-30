<%@ control language="C#" autoeventwireup="true" inherits="gm_baseop, App_Web_baseop.ascx.b931aa99" %>

<script type="text/javascript">
	var msgDisableChat			= '<%= Resources.StringDef.DisableChat %>';
	var msgEnableChat			= '<%= Resources.StringDef.EnableChat %>';
	var msgFreeze				= '<%= Resources.StringDef.Freeze %>';
	var msgUnfreeze				= '<%= Resources.StringDef.Unfreeze %>';
	var msgOpSuc				= '<%= Resources.StringDef.OpSuc %>';
	var msgFreezeIPAddress		= '<%= Resources.StringDef.FreezeIPAddress %>';
	var msgUnfreezeIPAddress	= '<%= Resources.StringDef.UnfreezeIPAddress %>';
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var m_op;						//0-Chat 1-Login
		var m_ggId;
		var m_accName;
		var m_roleName;
		var m_accId;
		var m_nochat;
		var m_nologin;
		var m_callback;
		var m_newPass;
		var m_ipAddress;

		var gmOpSetRoleNoChat = function( ggId, accName, roleName, nochat, callback ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			m_nochat	= nochat;
			m_callback	= callback;
			
			m_op		= 0;
			
			#{WindowConfirm}.setTitle( m_nochat ? msgDisableChat : msgEnableChat );
			#{FieldNewPass}.setVisible( false );
			#{RadioGroupTime}.setVisible( m_nochat );
			#{WindowConfirm}.show( );
		};
		
		var gmOpSetRoleNoLogin = function( ggId, accName, roleName, nologin, callback ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			m_nologin	= nologin;
			m_callback	= callback;
			
			m_op		= 1;
			
			#{WindowConfirm}.setTitle( m_nologin ? msgFreeze : msgUnfreeze );
			#{FieldNewPass}.setVisible( false );
			#{RadioGroupTime}.setVisible( m_nologin );
			#{WindowConfirm}.show( );
		};
		
		var gmOpKickRole = function( ggId, accName, roleName, callback ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			m_callback	= callback;
			
			m_op		= 2;
			
			#{FieldNewPass}.setVisible( false );
			#{RadioGroupTime}.setVisible( false );
			#{WindowConfirm}.show( );
		};
		
		var gmOpResetPass = function( ggId, accName, roleName ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			
			m_op		= 3;
			
			#{FieldNewPass}.reset( );
			#{FieldNewPass}.setVisible( true );
			#{RadioGroupTime}.setVisible( false );
			#{WindowConfirm}.show( );
		};
		
		var gmOpSetAccountNoLogin = function( ggId, accName, roleName, accId, nologin, callback ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			m_accId		= accId;
			m_nologin	= nologin;
			m_callback	= callback;
			
			m_op		= 4;
			
			#{WindowConfirm}.setTitle( m_nologin ? msgFreeze : msgUnfreeze );
			#{FieldNewPass}.setVisible( false );
			#{RadioGroupTime}.setVisible( false );
			#{WindowConfirm}.show( );
		};
		
		var gmOpFreezeIP = function( ggId, accName, roleName, nologin, ipAddress, callback ) {
			m_ggId		= ggId;
			m_accName	= accName;
			m_roleName	= roleName;
			m_nologin	= nologin;
			m_ipAddress	= ipAddress;
			m_callback	= callback;
			
			m_op		= 5;
			
			#{WindowConfirm}.setTitle( nologin ? msgFreezeIPAddress : msgUnfreezeIPAddress );
			#{FieldNewPass}.setVisible( false );
			#{RadioGroupTime}.setVisible( false );
			#{WindowConfirm}.show( );
		};
		
		var gmOpBtnConfirmClick = function( ) {
			var timeSeconds = eval( #{RadioGroupTime}.getValue( ).tag );
			var reason		= #{FieldReason}.getValue( );

			if( m_op == 0 ) {
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/SetRoleChat",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						reason		: reason,
						timeSeconds	: timeSeconds,
						enable		: !m_nochat
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			}
			else if( m_op == 1 ) {
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/SetRoleLogin",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						reason		: reason,
						timeSeconds	: timeSeconds,
						enable		: !m_nologin
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			} else if ( m_op == 2 ) {
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/KickRole",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						reason		: reason
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			} else if ( m_op == 3 ) {
				var newPass = #{FieldNewPass}.getValue( );
				
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/ResetPassword",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						reason		: reason,
						newPass		: newPass
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			} else if( m_op == 4 ) {
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/SetAccountLogin",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						accId		: m_accId,
						reason		: reason,
						timeSeconds	: timeSeconds,
						enable		: !m_nologin
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			} else if( m_op == 5 ) {
				Ext.net.DirectMethod.request( {
					url				: "gmservice.asmx/SetIPAddressLogin",
					cleanRequest	: true,
					json			: true,
					params			: {
						ggId		: m_ggId,
						account		: m_accName,
						roleName	: m_roleName,
						reason		: reason,
						timeSeconds	: timeSeconds,
						enable		: !m_nologin,
						ipAddress	: m_ipAddress
					},
					eventMask: {
						showMask : true,
						minDelay : 200,
						msg      : msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							#{WindowConfirm}.hide( );
							showSuccessMsg( msgTitle, msgOpSuc );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
						
						if( m_callback )
							m_callback( result.Success );
					}
				} );
			}
		};
		
		var gmOpResetBoxPwd = function( ggId, roleName, callback ) {
			m_ggId		= ggId;
			m_roleName	= roleName;
			
			#{WindowConfirm}.setTitle( m_nologin ? msgFreeze : msgUnfreeze );
			#{RadioGroupTime}.setVisible( m_nologin );
			#{WindowConfirm}.show( );
		};
		
	</script>
</ext:XScript>

<ext:Window ID="WindowConfirm" runat="server" Resizable="false" Maximizable="false"
	Width="500" Height="135" CloseAction="Hide" Collapsible="false" BodyStyle="background-color:#FFF;"
	Hidden="true" Modal="true" PaddingSummary="5px 5px 5px 5px">
	<Items>
		<ext:BorderLayout ID="BorderLayout2" runat="server">
			<Center>
				<ext:FormPanel ID="PanelConfirm" runat="Server" LabelAlign="Right" LabelWidth="100"
					ButtonAlign="Right" Border="false" Padding="10" AutoHeight="true" AnchorHorizontal="100%">
					<Items>
						<ext:RadioGroup ID="RadioGroupTime" runat="server" FieldLabel="<%$ Resources:StringDef, Time %>" AnchorHorizontal="90%">
							<Items>
								<ext:Radio runat="server" BoxLabel="<%$ Resources:StringDef, Forever %>" Checked="true" Tag="-1" />
								<ext:Radio runat="server" BoxLabel="<%$ Resources:StringDef, HalfHour %>" Tag="1800" />
								<ext:Radio runat="server" BoxLabel="<%$ Resources:StringDef, AHour %>" Tag="3600" />
								<ext:Radio runat="server" BoxLabel="<%$ Resources:StringDef, ADay %>" Tag="86400" />
								<ext:Radio runat="server" BoxLabel="<%$ Resources:StringDef, AWeek %>" Tag="604800" />
							</Items>
						</ext:RadioGroup>
						<ext:TextField ID="FieldNewPass" AnchorHorizontal="90%" runat="Server" FieldLabel="<%$ Resources:StringDef, NewPass %>" Hidden="true">
						</ext:TextField>
						<ext:ComboBox ID="FieldReason" AnchorHorizontal="90%" runat="Server" FieldLabel="<%$ Resources:StringDef, Reason %>" Editable="true" ForceSelection="false">
							<Items>
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason1 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason2 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason3 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason4 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason5 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason6 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason7 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason8 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason9 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason10 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason11 %>" />
								<ext:ListItem Text="<%$ Resources:StringDef, MsgGMOpReason12 %>" />
							</Items>
						</ext:ComboBox>
					</Items>
				</ext:FormPanel>
			</Center>
		</ext:BorderLayout>
	</Items>
	<Buttons>
		<ext:Button ID="BtnConfirm" runat="Server" Text="<%$ Resources:StringDef, Ok %>">
			<Listeners>
				<Click Fn="gmOpBtnConfirmClick" />
			</Listeners>
		</ext:Button>
		<ext:Button ID="BtnConfirmCancel" runat="Server" Text="<%$ Resources:StringDef, Cancel %>">
			<Listeners>
				<Click Handler="
					#{WindowConfirm}.hide( );
				" />
			</Listeners>
		</ext:Button>
	</Buttons>
</ext:Window>
