<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_ib, App_Web_ib.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport runat="Server">
		<Items>
			<ext:BorderLayout runat="Server">
				<Center>
					<ext:TabPanel runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelCharge" runat="Server" Title="<%$ Resources:StringDef, ChargeRecord %>" >
								<AutoLoad Mode="IFrame" Url="chargerec.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelAccBalance" runat="Server" Title="<%$ Resources:StringDef, AccBalance %>" >
								<AutoLoad Mode="IFrame" Url="accbalance.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelIBPayUse" runat="Server" Title="<%$ Resources:StringDef, IBPayUseRecord %>">
								<AutoLoad Mode="IFrame" Url="ibpayuserec.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<%--<ext:Panel ID="PanelCashEx" runat="Server" Title="<%$ Resources:StringDef, CashExRecord %>">
								<AutoLoad Mode="IFrame" Url="cashexrec.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
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
