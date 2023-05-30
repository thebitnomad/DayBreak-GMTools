<%@ control language="C#" autoeventwireup="true" inherits="common_svrsel, App_Web_svrsel.ascx.38131f0b" %>

<%@ Register TagPrefix="sat" TagName="SvrList" Src="~/common/svrlist.ascx" %>

<ext:XScript ID="XScript1" runat="server">
	<script type="text/javascript">

		var svrselRadioChange = function( ) {
			var selRadio	= #{RadioGroupSvr}.getValue( );
			var selAll		= selRadio.svr != undefined;
			
			#{TxtSelSvr}.setDisabled( selAll );
			#{BtnSelSvr}.setDisabled( selAll );
		};
		
		var svrselGetSelSvrs = function( ) {
			var selRadio	= #{RadioGroupSvr}.getValue( );
			var selAll		= selRadio.svr != undefined;
			if( selAll ) {
				return "-1";
			} else {
				return #{TxtSelSvr}.getValue( );
			}
		};

		var svrselBtnSelSvrClick = function( ) {
			svrlistRefresh( );
			#{WindowSvrList}.show( );
		};
		
		var svrselBtnWinSvrClick = function( ) {
			#{TxtSelSvr}.setValue( svrlistGetSelectedSvrName( ) );
			#{WindowSvrList}.hide( );
		};
		
		var svrselSetSelSvrs = function( selSvr ) {
			var selAll = ( selSvr == "-1" );
			
			#{RadioAllSvr}.setValue( selAll );
			#{RadioSelSvr}.setValue( !selAll );
			
			#{TxtSelSvr}.setDisabled( selAll );
			#{BtnSelSvr}.setDisabled( selAll );
			
			if( selAll ) {
				#{TxtSelSvr}.setValue( '' );
			} else {
				#{TxtSelSvr}.setValue( selSvr );
			}
		};
		
	</script>
</ext:XScript>

<ext:CompositeField runat="Server" Width="500"> 
	<Items>
		<ext:RadioGroup ID="RadioGroupSvr" runat="server" Width="200">
			<Items>
				<ext:Radio ID="RadioAllSvr" runat="server" BoxLabel="<%$ Resources:StringDef, AllGameServer %>" Checked="true" Name="-1">
					<CustomConfig>
						<ext:ConfigItem Name="Svr" Value="-1" />
					</CustomConfig>
				</ext:Radio>
				<ext:Radio ID="RadioSelSvr" runat="server" BoxLabel="<%$ Resources:StringDef, PartGameServer %>" />
			</Items>
			<Listeners>
				<Change Fn="svrselRadioChange" />
			</Listeners>
		</ext:RadioGroup>
		<ext:TextField ID="TxtSelSvr" runat="Server" Width="250" Disabled="true">
		</ext:TextField>
		<ext:Button ID="BtnSelSvr" runat="server" Text="..." Width="40" Disabled="true">
			<Listeners>
				<Click Fn="svrselBtnSelSvrClick" />
			</Listeners>
		</ext:Button>
	</Items>		
</ext:CompositeField>

<ext:Window ID="WindowSvrList" runat="Server" Width="900" Height="450" CloseAction="Hide"
	Hidden="true" Modal="true">
	<Items>
		<ext:BorderLayout ID="BorderLayout2" runat="Server">
			<Center>
				<ext:Container ID="Container1" runat="server" Height="250">
					<Content>
						<sat:SvrList runat="Server" />
					</Content>
				</ext:Container>
			</Center>
		</ext:BorderLayout>
	</Items>
	<Buttons>
		<ext:Button ID="BtnWinSvr" runat="server" Text="<%$ Resources:StringDef, OK %>" >
			<Listeners>
				<Click Fn="svrselBtnWinSvrClick" />
			</Listeners>
		</ext:Button>
		<ext:Button ID="Button1" runat="server" Text="<%$ Resources:StringDef, Cancel %>">
			<Listeners>
				<Click Handler="
					#{WindowSvrList}.hide( );
				" />
			</Listeners>
		</ext:Button>
	</Buttons>
</ext:Window>
