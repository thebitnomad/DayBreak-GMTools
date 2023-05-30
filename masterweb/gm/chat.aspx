<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_chat, App_Web_chat.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanel1" runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelHistoryInfo" runat="Server" Title="<%$ Resources:StringDef, ChatInfoHistory %>">
								<AutoLoad Mode="IFrame" Url="chathistory.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelRealTimeInfo" runat="Server" Title="<%$ Resources:StringDef, ChatInfoRealTime %>" >
								<AutoLoad Mode="IFrame" Url="chatmonitor.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
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

