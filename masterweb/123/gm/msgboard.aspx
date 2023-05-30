<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="gm_msgboard, App_Web_msgboard.aspx.b931aa99" theme="default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<ext:Viewport ID="Viewport1" runat="Server">
		<Items>
			<ext:BorderLayout ID="BorderLayout1" runat="Server">
				<Center>
					<ext:TabPanel ID="TabPanel1" runat="Server" Border="false" TabPosition="Bottom">
						<Items>
							<ext:Panel ID="PanelQuestion" runat="Server" Title="<%$ Resources:StringDef, MessageBoard %>" >
								<AutoLoad Mode="IFrame" Url="question.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelQuesStat" runat="Server" Title="<%$ Resources:StringDef, QuestionHistory %>" >
								<AutoLoad Mode="IFrame" Url="questionhis.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
							</ext:Panel>
							<ext:Panel ID="PanelReplyStat" runat="Server" Title="<%$ Resources:StringDef, ReplyStat %>" >
								<AutoLoad Mode="IFrame" Url="questionstat.aspx" MaskMsg="<%$ Resources:StringDef, Loading %>" ShowMask="true" />
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
