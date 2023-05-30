<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="op_cltupdate, App_Web_cltupdate.aspx.b81705c1" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanel1" runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelFull" runat="Server" Title="<%$ Resources:StringDef, CltUpdateFull %>" >
								<AutoLoad Mode="IFrame" Url="cltupdateunit.aspx?ult=1" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelTiny" runat="Server" Title="<%$ Resources:StringDef, CltUpdateTiny %>" >
								<AutoLoad Mode="IFrame" Url="cltupdateunit.aspx?ult=3" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelWeb" runat="Server" Title="<%$ Resources:StringDef, CltUpdateWeb %>" >
								<AutoLoad Mode="IFrame" Url="cltupdateunit.aspx?ult=4" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelSvrList" runat="Server" Title="<%$ Resources:StringDef, CltUpdateSvrList %>" >
								<AutoLoad Mode="IFrame" Url="cltupdateunit.aspx?ult=5" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
						</Items>
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
