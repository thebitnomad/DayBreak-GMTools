<%@ page title="" language="C#" autoeventwireup="true" inherits="common_login, App_Web_login.aspx.38131f0b" theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="Server">
	<title><%= Resources.StringDef.SystemName %> - <%= Resources.StringDef.SystemDesc %></title>
	<script type="text/javascript">
		var userInfoKeyDown = function( textField, e ) {
			if( e.getKey( ) == Ext.EventObject.ENTER ) {
				login( );
				/*
				 * Chrome下有异常，加以下代码可以解决问题。
				 * 推测和Chrome键盘事件机制有关。
				 */
				e.stopEvent( );
			}
		};
		
		var login = function( ) {
			Ext.net.DirectMethods.Login( {
				eventMask: {
					showMask: true,
					minDelay: 500,
					msg: msgLogining
				},
				success: function( result ) {
					if( result.Success ) {
						window.location.href = './home.aspx';
					}
					else if( result.ErrorMessage ) {
						Ext.Msg.show({
							title: msgTitle,
							msg: result.ErrorMessage,
							buttons: Ext.Msg.OK,
							minWidth: 200,
							maxWidth: 400,
							icon: Ext.MessageBox.ERROR,
							fn: resetPassword
						});
					}
				}
			});
		};
		
		var resetPassword = function( ) {
			TextFieldPassword.reset( );
			TextFieldPassword.focus( );
		};
	</script>
</head>
<body>
	<script type="text/javascript">
		var msgLogining = '<%= Resources.StringDef.Logining %>';
		var msgTitle = '<%= Resources.StringDef.LoginFailure %>';
	</script>
	
	<form id="form1" runat="server">
		<ext:ResourceManager ID="ResourceManager1" runat="server">
		</ext:ResourceManager>
		<div style="position:absolute; top:35%; left:36%; background-color:#DFE8F6; border-bottom: none;">
			<ext:FormPanel ID="FormPanelLogin" runat="server" BodyStyle="padding:10px 0px 0px 0px;background-color:#DFE8F6;" ButtonAlign="Center" Border="false"
				Title="<%$ Resources:StringDef, SystemName %>" Width="400" LabelAlign="Right"
				LabelWidth="120" StyleSpec="background-color:#DFE8F6; border: solid 1px #99BBE8;">
			<Items>
				<ext:TextField ID="TextFieldUserName" runat="server" AnchorHorizontal="80%" FieldLabel="<%$ Resources:StringDef, Account %>" EnableKeyEvents="true" LabelStyle="font-size:14px;" >
					<Listeners>
						<KeyDown Fn="userInfoKeyDown" />
					</Listeners>
				</ext:TextField>
				<ext:TextField ID="TextFieldPassword" runat="server" AnchorHorizontal="80%" InputType="Password" FieldLabel="<%$ Resources:StringDef, Password %>" EnableKeyEvents="true" LabelStyle="font-size:14px;">
					<Listeners>
						<KeyDown Fn="userInfoKeyDown" />
					</Listeners>
				</ext:TextField>
				<ext:Checkbox ID="CheckboxRemember" runat="Server" Checked="true" BoxLabel="<%$ Resources:StringDef, MsgRememberMyState %>" />
			</Items>
			<Buttons>
				<ext:Button ID="BtnLogin" runat="server" Text="<%$ Resources:StringDef, Login %>" >
					<Listeners>
						<Click Fn="login" /> 
					</Listeners>
				</ext:Button>
			</Buttons>
			<Listeners>
				<Render Handler="#{TextFieldUserName}.focus( );" Delay="50" />
			</Listeners>
		</ext:FormPanel>
	</div>
	</form>
	<!--[if lt IE 7]>
	<div style='border: 1px solid #F7941D; background: #FEEFDA; text-align: center; clear: both; height: 75px; position: relative;'>
		<div style='position: absolute; right: 3px; top: 3px; font-family: courier new; font-weight: bold;'><a href='#' onclick='javascript:this.parentNode.parentNode.style.display="none"; return false;'><img src='../images/ie6nomore-cornerx.jpg' style='border: none;' alt='Close this notice'/></a></div>
		<div style='width: 640px; margin: 0 auto; text-align: left; padding: 0; overflow: hidden; color: black;'>
			<div style='width: 75px; float: left;'><img src='../images/ie6nomore-warning.jpg' alt='Warning!'/></div>
			<div style='width: 275px; float: left; font-family: Arial, sans-serif;'>
				<div style='font-size: 14px; font-weight: bold; margin-top: 12px;'><asp:Literal runat="Server" Text="<%$ Resources: StringDef, MsgKillIE6Title %>" /></div>
				<div style='font-size: 12px; margin-top: 6px; line-height: 12px;'><asp:Literal runat="Server" Text="<%$ Resources: StringDef, MsgKillIE6Content %>" /></div>
			</div>
			<div style='width: 75px; float: left;'><a href='http://www.google.com/chrome' target='_blank'><img src='../images/ie6nomore-chrome.jpg' style='border: none;' alt='Google Chrome'/></a></div>
			<div style='width: 75px; float: left;'><a href='#' target='_blank'><img src='../images/ie6nomore-firefox.jpg' style='border: none;' alt='Firefox 3.5'/></a></div>
			<div style='width: 75px; float: left;'><a href='#' target='_blank'><img src='../images/ie6nomore-ie8.jpg' style='border: none;' alt='Internet Explorer 8'/></a></div>
		</div>
		</div>
	<![endif]-->
</body>
</html>