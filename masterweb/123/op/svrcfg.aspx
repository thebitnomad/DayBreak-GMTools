<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_svrcfg, App_Web_svrcfg.aspx.b81705c1" theme="default" %>

<%@ Register TagPrefix="sat" TagName="MachineCombo" Src="~/common/machinecombo.ascx" %>
<%@ Register TagPrefix="sat" TagName="MachineCombo2" Src="~/common/machinecombo2.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
	<style type="text/css">
		.noteimportant
		{
			color:red !important;
			font-weight:bold;
		}
	</style>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgSaveSuc		= '<%= Resources.StringDef.SaveSuc %>';

		var msgSetAsTemplateSuc = '<%= Resources.StringDef.MsgSetAsTemplateSuc %>';
		var msgSvrConfigNote	= '<%= Resources.StringDef.MsgSvrConfigNote %>';
	</script>
	
	<ext:XScript ID="XScript1" runat="server">
		<script type="text/javascript">
			var checkBoxLogDbChecked = function( ) {
				var useCustom = #{CheckboxCustom}.getValue( );
				
				#{FieldMachineCombo2}.setDisabled( !useCustom );
				#{TextFieldLogDbHostName}.setDisabled( !useCustom );
				#{TextFieldLogDbInnerIP}.setDisabled( !useCustom );
				#{TextFieldLogDbUser}.setDisabled( !useCustom );
				#{TextFieldLogDbPwd}.setDisabled( !useCustom );
				#{TextFieldLogDbName}.setDisabled( !useCustom );
				#{NumFieldLogDbPort}.setDisabled( !useCustom );
				#{NumFieldLogDbConNum}.setDisabled( !useCustom );
			};
		
			var btnSaveCfgClick = function( ) {
				saveCfg( false );
			};
			
			var btnSaveDefCfgClick = function( ) {
				saveCfg( true );
			};
			
			var btnLoadDefCfgClick = function( ) {
				Ext.net.DirectMethods.LoadSvrCfg( true, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgLoading
					},
					success: function( result ) {
					}
				} );
			};
			
			var saveCfg = function( tpl ) {
				Ext.net.DirectMethods.SetConfig( tpl, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							if( tpl ) {
								showSuccessMsg( msgTitle, msgSetAsTemplateSuc );
							} else {
								showSuccessMsg( msgTitle, msgSaveSuc, function( ) {
									if( parent && parent.closeCfgWin ) {
										parent.closeCfgWin( );
									}
									
								} );
							}
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				} );
			};
			
			var dbMachineSelect = function( ) {
				var selMachine = machineComboGetSelectedRecord( );
				
				#{TextFieldDbHostName}.setValue( selMachine.data.IpAddress );
				#{TextFieldDbInnerIP}.setValue( selMachine.data.IpAddressInner );
				#{TextFieldDbMachineId}.setValue( selMachine.data.Id );
			};
			
			var logDbMachineSelect = function( ) {
				var selMachine = machineCombo2GetSelectedRecord( );
				
				#{TextFieldLogDbHostName}.setValue( selMachine.data.IpAddress );
				#{TextFieldLogDbInnerIP}.setValue( selMachine.data.IpAddressInner );
				#{TextFieldLogDbMachineId}.setValue( selMachine.data.Id );
			};
			
			var setWarSvrId = function( warSvrId ) {
				#{StoreWarSvr}.load( { 
					callback : function( ) {
						if( warSvrId ) {
							#{ComboBoxWarSvr}.setValue( warSvrId );
						} else {
							#{ComboBoxWarSvr}.reset( );
						}
					}
				} );
			};
			
			var comboTypeSelect = function( ) {
				var type = #{ComboBoxType}.getValue( );
				
				switch( eval( type ) ) {
					case 1:
						{
							#{ComboBoxWarOn}.setVisible( false );
							#{ComboBoxWarSvr}.setVisible( false );
							#{NumFieldWarGatePort}.setVisible( true );
						}
						break;
					case 0:
					default:
						{
							#{ComboBoxWarOn}.setVisible( true );
							#{ComboBoxWarSvr}.setVisible( true );
							#{NumFieldWarGatePort}.setVisible( false );
						}
						break;
				}
			};
		
		var selectSvrCfgWarOnChange = function( ) {
			var svrWarType = #{ComboBoxWarOn}.getValue( );
			var id = parseInt( this.getValue( ) );
			if( svrWarType == 1 && id== 0 ) {
				showErrMsg( msgTitle, msgSvrConfigNote );
			}
		}
		
		</script>
	</ext:XScript>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Store ID="StoreWarSvr" runat="server" RemotePaging="false" RemoteSort="false" AutoLoad="false" OnRefreshData="StoreWarSvrRefresh" >
		<DirectEventConfig Type="Load">
			<EventMask ShowMask="true" Msg="<%$ Resources:StringDef, Loading %>" Target="CustomTarget" CustomTarget="#{FormPanel1}.body" />
		</DirectEventConfig>
		<Proxy>
			<ext:PageProxy />
		</Proxy>
		<Reader>
			<ext:JsonReader>
				<Fields>
					<ext:RecordField Name="Id" Mapping="Id" Type="Int" />
					<ext:RecordField Name="Name" Mapping="Name" Type="String" />
				</Fields>
			</ext:JsonReader>
		</Reader>
	</ext:Store>

	<ext:FormPanel ID="FormPanel1" runat="server" PaddingSummary="10px 20px 10px 5px" DefaultAnchor="0" LabelAlign="Right" Border="false" LabelWidth="130" ButtonAlign="Center">
		<Items>
			<ext:FieldSet ID="FieldSet1" runat="server" Title="<%$ Resources:StringDef, SvrCfgBasesetting %>" Collapsible="true" Layout="form">
				<Items>
					<ext:NumberField runat="Server" ID="NumFieldWorldNum" FieldLabel="<%$ Resources:StringDef, SvrCfgBSWorldNum %>" Text="-1" AnchorHorizontal="90%" />
					<ext:ComboBox runat="Server" ID="ComboNoEnter" FieldLabel="<%$ Resources:StringDef, SvrCfgNoEnter %>" AnchorHorizontal="90%" Editable="false" SelectedIndex="0" NoteAlign="Down" Note="<%$ Resources:StringDef, MsgSvrCfgNoEnterNote %>">
						<Items>
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, No %>" Value="0" />
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, Yes %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:ComboBox runat="Server" ID="ComboBoxType" FieldLabel="<%$ Resources:StringDef, Type %>" AnchorHorizontal="90%" Editable="false" SelectedIndex="0" NoteAlign="Down">
						<Items>
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, SvrTypeGame %>" Value="0" />
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, SvrTypeWar %>" Value="1" />
						</Items>
						<Listeners>
							<Select Fn="comboTypeSelect" />
						</Listeners>
					</ext:ComboBox>
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet2" runat="server" Title="<%$ Resources:StringDef, SvrCfgNet %>" Collapsible="true" Layout="form">
				<Items>
					<ext:NumberField runat="server" ID="NumFieldNetMaxCon" FieldLabel="<%$ Resources:StringDef, SvrCfgNetMaxCon %>" Text="2000" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgSvrCfgNetMaxConNote %>" NoteAlign="Down" />
					<ext:NumberField runat="server" ID="NumFieldNetPort" FieldLabel="<%$ Resources:StringDef, SvrCfgNetPort %>" Text="18008" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldNetThreadNum" FieldLabel="<%$ Resources:StringDef, SvrCfgNetThreadNum %>" Text="-1" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldNetSendBuff" FieldLabel="<%$ Resources:StringDef, SvrCfgNetSendBuff %>" Text="32768" AnchorHorizontal="90%" Hidden="true" />
					<ext:NumberField runat="server" ID="NumFieldNetRecvBuff" FieldLabel="<%$ Resources:StringDef, SvrCfgNetRecvBuff %>" Text="32768" AnchorHorizontal="90%" Hidden="true" />
					<ext:NumberField runat="server" ID="NumFieldNetMaxQueue" FieldLabel="<%$ Resources:StringDef, SvrCfgNetMaxQueue %>" Text="2500" AnchorHorizontal="90%" />
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet7" runat="server" Title="<%$ Resources:StringDef, WarCfg %>" Collapsible="true" Layout="form">
				<Items>
					<ext:ComboBox runat="Server" ID="ComboBoxWarOn" FieldLabel="<%$ Resources:StringDef, SvrCfgWarOn %>" AnchorHorizontal="90%" Editable="false" SelectedIndex="0" NoteAlign="Down">
						<Items>
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, WarSvrOff %>" Value="0" />
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, WarSvrOn %>" Value="1" />
						</Items>
					</ext:ComboBox>
					<ext:NumberField runat="server" ID="NumFieldWarGatePort" FieldLabel="<%$ Resources:StringDef, SvrCfgWarPort %>" Text="8899" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgSvrCfgWarPortNote %>">
					</ext:NumberField>
					<ext:ComboBox ID="ComboBoxWarSvr" runat="server" StoreID="StoreWarSvr" AnchorHorizontal="90%" Editable="false" FieldLabel="<%$ Resources:StringDef, SvrCfgWarSvr %>" 
						 ValueField="Id" DisplayField="Name" Mode="Local" >
						 <Listeners>
							<Select Fn="selectSvrCfgWarOnChange" />
						 </Listeners>
					</ext:ComboBox>
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet3" runat="server" Title="<%$ Resources:StringDef, SvrCfgDb %>" Collapsible="true" Layout="form">
				<Items>
					<ext:CompositeField ID="FieldMachineCombo1" runat="Server" FieldLabel="<%$ Resources:StringDef, Machine %>" Width="600">
						<Items>
							<ext:Container ID="Container1" runat="Server">
								<Content>
									<sat:MachineCombo runat="Server" ID="machineDbCombo" SelectFn="dbMachineSelect" />
								</Content>
							</ext:Container>
						</Items>
					</ext:CompositeField>
					<ext:TextField runat="server" ID="TextFieldDbMachineId" AnchorHorizontal="90%" Hidden="true" />
					<ext:TextField runat="server" ID="TextFieldDbInnerIP" FieldLabel="<%$ Resources:StringDef, SvrCfgDbInnerIP %>" AnchorHorizontal="90%" NoteAlign="Down" Note="<%$ Resources:StringDef, SvrCfgDbInnerIPNote %>" />
					<ext:TextField runat="server" ID="TextFieldDbHostName" FieldLabel="<%$ Resources:StringDef, SvrCfgDbHostName %>" AnchorHorizontal="90%" NoteAlign="Down" Note="<%$ Resources:StringDef, SvrCfgDbHostNameNote %>" />
					<ext:TextField runat="server" ID="TextFieldDbUser" FieldLabel="<%$ Resources:StringDef, SvrCfgDbUser %>" AnchorHorizontal="90%" />
					<ext:TextField runat="server" ID="TextFieldDbPwd" FieldLabel="<%$ Resources:StringDef, SvrCfgDbPwd %>" AnchorHorizontal="90%" InputType="Password" Note="<%$ Resources:StringDef, MsgEmptyUseOriPwd %>" />
					<ext:TextField runat="server" ID="TextFieldDbPwdConfirm" FieldLabel="<%$ Resources:StringDef, PasswordConfirm %>" AnchorHorizontal="90%" InputType="Password" />
					<ext:TextField runat="server" ID="TextFieldDbName" FieldLabel="<%$ Resources:StringDef, SvrCfgDbDBName %>" AnchorHorizontal="90%" NoteAlign="Down" Note="<%$ Resources:StringDef, MsgSvrCfgDBNameNote %>" NoteCls="noteimportant" />
					<ext:NumberField runat="server" ID="NumFieldDbPort" FieldLabel="<%$ Resources:StringDef, SvrCfgDbPort %>" AnchorHorizontal="90%" Hidden="true" />
					<ext:NumberField runat="server" ID="NumFieldDbConNum" FieldLabel="<%$ Resources:StringDef, SvrCfgDbConNum %>" AnchorHorizontal="90%" Hidden="true" />
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet6" runat="server" Title="<%$ Resources:StringDef, SvrCfgLogDb %>" Collapsible="true" Layout="form">
				<Items>
					<ext:Checkbox runat="Server" ID="CheckboxCustom" BoxLabel="<%$ Resources:StringDef, SvrCfgUseCustomLogDb %>">
						<Listeners>
							<Check Fn="checkBoxLogDbChecked" />
						</Listeners>
					</ext:Checkbox>
					<ext:CompositeField ID="FieldMachineCombo2" runat="Server" FieldLabel="<%$ Resources:StringDef, Machine %>" Width="600" Disabled="true">
						<Items>
							<ext:Container ID="Container2" runat="Server">
								<Content>
									<sat:MachineCombo2 runat="Server" ID="machineLogDbCombo" SelectFn="logDbMachineSelect" />
								</Content>
							</ext:Container>
						</Items>
					</ext:CompositeField>
					<ext:TextField runat="server" ID="TextFieldLogDbMachineId" AnchorHorizontal="90%" Hidden="true" />
					<ext:TextField runat="server" ID="TextFieldLogDbInnerIP" FieldLabel="<%$ Resources:StringDef, SvrCfgDbInnerIP %>" AnchorHorizontal="90%" Disabled="true" NoteAlign="Down" Note="<%$ Resources:StringDef, SvrCfgDbInnerIPNote %>" />
					<ext:TextField runat="server" ID="TextFieldLogDbHostName" FieldLabel="<%$ Resources:StringDef, SvrCfgDbHostName %>" AnchorHorizontal="90%" Disabled="true" NoteAlign="Down" Note="<%$ Resources:StringDef, SvrCfgDbHostNameNote %>" />
					<ext:TextField runat="server" ID="TextFieldLogDbUser" FieldLabel="<%$ Resources:StringDef, SvrCfgDbUser %>" AnchorHorizontal="90%" Disabled="true" />
					<ext:TextField runat="server" ID="TextFieldLogDbPwd" FieldLabel="<%$ Resources:StringDef, SvrCfgDbPwd %>" AnchorHorizontal="90%" Disabled="true" InputType="Password" Note="<%$ Resources:StringDef, MsgEmptyUseOriPwd %>" />
					<ext:TextField runat="server" ID="TextFieldLogDbPwdConfirm" FieldLabel="<%$ Resources:StringDef, PasswordConfirm %>" AnchorHorizontal="90%" InputType="Password" />
					<ext:TextField runat="server" ID="TextFieldLogDbName" FieldLabel="<%$ Resources:StringDef, SvrCfgDbDBName %>" AnchorHorizontal="90%" Disabled="true" NoteAlign="Down" Note="<%$ Resources:StringDef, MsgSvrCfgLogDBNameNote %>" NoteCls="noteimportant" />
					<ext:NumberField runat="server" ID="NumFieldLogDbPort" FieldLabel="<%$ Resources:StringDef, SvrCfgDbPort %>" AnchorHorizontal="90%" Disabled="true" />
					<ext:NumberField runat="server" ID="NumFieldLogDbConNum" FieldLabel="<%$ Resources:StringDef, SvrCfgDbConNum %>" AnchorHorizontal="90%" Disabled="true" Hidden="true" />
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet4" runat="server" Title="eRating" Collapsible="true" Layout="form">
				<Items>
					<ext:TextField runat="server" ID="TextFieldPayHostName" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentHostName %>" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldPayPort" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentPort %>" AnchorHorizontal="90%" />
					<ext:TextField runat="server" ID="TextFieldRechargeHost" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentRechargeHost %>" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldRechargePort" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentRechargePort %>" AnchorHorizontal="90%" />
					<ext:TextField runat="server" ID="TextFieldGatewayAcc" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentGatewayAcc %>" AnchorHorizontal="90%" />
					<ext:TextField runat="server" ID="TextFieldGatewayPwd" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentGatewayPwd %>" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgEmptyUseOriPwd %>" />
					<ext:TextField runat="server" ID="TextFieldGatewayPwdConfirm" FieldLabel="<%$ Resources:StringDef, PasswordConfirm %>" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldGateId" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentGateId %>" AnchorHorizontal="90%" />
					<ext:NumberField runat="server" ID="NumFieldGameId" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentGameId %>" Text="19" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgSvrCfgPaymentGameIdNote %>" NoteCls="noteimportant" />
					<ext:NumberField runat="server" ID="NumFieldJoinOver" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentJoinOver %>" Text="600" AnchorHorizontal="90%" />
					<ext:TextField runat="server" ID="TextFieldJoinKey" FieldLabel="<%$ Resources:StringDef, SvrCfgPaymentJoinKey %>" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgEmptyUseOriKey %>" />
					<ext:ComboBox runat="Server" ID="ComboPaymentOn" FieldLabel="<%$ Resources:StringDef, PaymentOn %>" AnchorHorizontal="90%" Editable="false" SelectedIndex="0">
						<Items>
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, On %>" Value="1" />
							<ext:ListItem runat="Server" Text="<%$ Resources:StringDef, Off %>" Value="0" />
						</Items>
					</ext:ComboBox>
				</Items>
			</ext:FieldSet>
			<ext:FieldSet ID="FieldSet5" runat="server" Title="<%$ Resources:StringDef, SvrCfgLang %>" Collapsible="true" Layout="form">
				<Items>
					<ext:TextField runat="server" ID="TextFieldCharSet" FieldLabel="<%$ Resources:StringDef, SvrCfgLangCharSet %>" Text="gbk" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgSvrCfgLangCharSetNote %>" />
					<ext:TextField runat="server" ID="TextFieldDBCharSet" FieldLabel="<%$ Resources:StringDef, SvrCfgDBCharSet %>" Text="gbk" AnchorHorizontal="90%" Note="<%$ Resources:StringDef, MsgSvrCfgDBCharSetNote %>" />
				</Items>
			</ext:FieldSet>
		</Items>
		<Buttons>
			<ext:Button ID="BtnLoadDefCfg" runat="server" Text="<%$ Resources:StringDef, UseTemplate %>">
				<Listeners>
					<Click Fn="btnLoadDefCfgClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnSaveDefCfg" runat="server" Text="<%$ Resources:StringDef, SetAsTemplate %>">
				<Listeners>
					<Click Fn="btnSaveDefCfgClick" />
				</Listeners>
			</ext:Button>
			<ext:Button ID="BtnSaveCfg" runat="server" Text="<%$ Resources:StringDef, Save %>">
				<Listeners>
					<Click Fn="btnSaveCfgClick" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:FormPanel>
	
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
