<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_currdata, App_Web_currdata.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanelDataInfo" runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelMail" runat="Server" Title="<%$ Resources:StringDef, Mail %>" >
								<AutoLoad Mode="IFrame" Url="mail.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<%--<ext:Panel ID="PanelAuction" runat="Server" Title="111Test" >
								<AutoLoad Mode="IFrame" Url="auction.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>--%>
							<%--<ext:Panel ID="Panel1" runat="Server" Title="<%$ Resources:StringDef, ProcLog %>" >
								<AutoLoad Mode="IFrame" Url="gamedata.aspx?cfgname=AuctionInfo" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelProcError" runat="Server" Title="<%$ Resources:StringDef, ProcLog %>" >
								<AutoLoad Mode="IFrame" Url="gamedata.aspx?cfgname=ProcError" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>--%>
						</Items>
					</ext:TabPanel>
				</Center>
			</ext:BorderLayout>
		</Items>
	</ext:Viewport>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
