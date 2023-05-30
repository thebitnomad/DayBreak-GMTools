<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_role, App_Web_role.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanel1" runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelRoleInfo" runat="Server" Title="<%$ Resources:StringDef, RoleInfo %>" >
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelFrd" runat="Server" Title="<%$ Resources:StringDef, Frd %>" >
								<AutoLoad Mode="IFrame" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
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
