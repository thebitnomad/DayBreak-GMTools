<%@ page title="" language="C#" masterpagefile="~/common/main.master" autoeventwireup="true" inherits="data_moneystat, App_Web_moneystat.aspx.551d078a" validaterequest="false" theme="default" %>

<%@ Register TagPrefix="sat" TagName="SvrCombo" Src="~/common/svrcombo.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" Runat="Server">
	<script type="text/javascript" src="../resources/Visifire.js"></script>
	<script type="text/javascript">
		var msgTitle		= '<%= Resources.StringDef.SystemName %>';
		var msgLoading		= '<%= Resources.StringDef.Loading %>';
		var msgSaving		= '<%= Resources.StringDef.Saving %>';
		var msgSubmitting	= '<%= Resources.StringDef.Submitting %>';
		var msgSave			= '<%= Resources.StringDef.Save %>';
		var msgOK			= '<%= Resources.StringDef.OK %>';
		var msgNotAvailable	= '<%= Resources.StringDef.NotAvailable %>';
		
		var msgQueryConditionCanNotBeNull	= '<%= Resources.StringDef.MsgQueryConditionCanNotBeNull %>';
	
	</script>
	
	<ext:XScript ID="XScript1" runat="Server">
		<script type="text/javascript">
		
			var testData = "<vc:Chart xmlns:vc=\"clr-namespace:Visifire.Charts;assembly=SLVisifire.Charts\" AnimatedUpdate=\"true\" AnimationEnabled=\"true\" BorderThickness=\"0\" Height=\"500\" Width=\"700\" ZoomingEnabled=\"true\" Padding=\"3\" Theme=\"Theme1\"  ><vc:Chart.Titles><vc:Title Text=\"o1 - Base 2011-07-28至2012-09-27 Bug统计信息\" Padding=\"10\"  /><vc:Title Text=\"Bug总数:275\" FontSize=\"11\"  /></vc:Chart.Titles><vc:Chart.Legends><vc:Legend  /></vc:Chart.Legends><vc:Chart.AxesX><vc:Axis ValueFormatString=\"MM-dd\" IntervalType=\"Days\"  /></vc:Chart.AxesX><vc:Chart.AxesY><vc:Axis  /></vc:Chart.AxesY><vc:Chart.Series><vc:DataSeries RenderAs=\"Column\" LegendText=\"当天提交数\" XValueType=\"DateTime\"  ><vc:DataSeries.DataPoints><vc:DataPoint XValue=\"7/28/2011\" YValue=\"139\" ToolTipText=\"2011-07-28 提交数:#YValue\"  /><vc:DataPoint XValue=\"7/29/2011\" YValue=\"49\" ToolTipText=\"2011-07-29 提交数:#YValue\"  /><vc:DataPoint XValue=\"7/30/2011\" YValue=\"24\" ToolTipText=\"2011-07-30 提交数:#YValue\"  /><vc:DataPoint XValue=\"7/31/2011\" YValue=\"20\" ToolTipText=\"2011-07-31 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/1/2011\" YValue=\"24\" ToolTipText=\"2011-08-01 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/2/2011\" YValue=\"15\" ToolTipText=\"2011-08-02 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/3/2011\" ToolTipText=\"2011-08-03 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/4/2011\" ToolTipText=\"2011-08-04 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/5/2011\" ToolTipText=\"2011-08-05 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/6/2011\" ToolTipText=\"2011-08-06 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/8/2011\" ToolTipText=\"2011-08-08 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/9/2011\" ToolTipText=\"2011-08-09 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/10/2011\" ToolTipText=\"2011-08-10 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/11/2011\" ToolTipText=\"2011-08-11 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/15/2011\" ToolTipText=\"2011-08-15 提交数:#YValue\"  /><vc:DataPoint XValue=\"3/21/2012\" YValue=\"1\" ToolTipText=\"2012-03-21 提交数:#YValue\"  /><vc:DataPoint XValue=\"8/23/2012\" YValue=\"3\" ToolTipText=\"2012-08-23 提交数:#YValue\"  /><vc:DataPoint XValue=\"9/27/2012\" ToolTipText=\"2012-09-27 提交数:#YValue\"  /></vc:DataSeries.DataPoints></vc:DataSeries><vc:DataSeries RenderAs=\"Column\" LegendText=\"当天解决数\" XValueType=\"DateTime\"  ><vc:DataSeries.DataPoints><vc:DataPoint XValue=\"7/28/2011\" YValue=\"5\" ToolTipText=\"2011-07-28 解决数:#YValue\"  /><vc:DataPoint XValue=\"7/29/2011\" YValue=\"73\" ToolTipText=\"2011-07-29 解决数:#YValue\"  /><vc:DataPoint XValue=\"7/30/2011\" YValue=\"31\" ToolTipText=\"2011-07-30 解决数:#YValue\"  /><vc:DataPoint XValue=\"7/31/2011\" YValue=\"25\" ToolTipText=\"2011-07-31 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/1/2011\" YValue=\"22\" ToolTipText=\"2011-08-01 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/2/2011\" YValue=\"34\" ToolTipText=\"2011-08-02 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/3/2011\" YValue=\"22\" ToolTipText=\"2011-08-03 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/4/2011\" YValue=\"25\" ToolTipText=\"2011-08-04 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/5/2011\" YValue=\"4\" ToolTipText=\"2011-08-05 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/6/2011\" YValue=\"2\" ToolTipText=\"2011-08-06 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/8/2011\" YValue=\"7\" ToolTipText=\"2011-08-08 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/9/2011\" YValue=\"2\" ToolTipText=\"2011-08-09 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/10/2011\" YValue=\"1\" ToolTipText=\"2011-08-10 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/11/2011\" YValue=\"4\" ToolTipText=\"2011-08-11 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/15/2011\" YValue=\"5\" ToolTipText=\"2011-08-15 解决数:#YValue\"  /><vc:DataPoint XValue=\"3/21/2012\" YValue=\"1\" ToolTipText=\"2012-03-21 解决数:#YValue\"  /><vc:DataPoint XValue=\"8/23/2012\" ToolTipText=\"2012-08-23 解决数:#YValue\"  /><vc:DataPoint XValue=\"9/27/2012\" YValue=\"1\" ToolTipText=\"2012-09-27 解决数:#YValue\"  /></vc:DataSeries.DataPoints></vc:DataSeries><vc:DataSeries RenderAs=\"Line\" LineThickness=\"2\" MovingMarkerEnabled=\"true\" LegendText=\"提交总数\" XValueType=\"DateTime\"  ><vc:DataSeries.DataPoints><vc:DataPoint XValue=\"7/28/2011\" YValue=\"139\" ToolTipText=\"2011-07-28 提交总数:#YValue\"  /><vc:DataPoint XValue=\"7/29/2011\" YValue=\"188\" ToolTipText=\"2011-07-29 提交总数:#YValue\"  /><vc:DataPoint XValue=\"7/30/2011\" YValue=\"212\" ToolTipText=\"2011-07-30 提交总数:#YValue\"  /><vc:DataPoint XValue=\"7/31/2011\" YValue=\"232\" ToolTipText=\"2011-07-31 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/1/2011\" YValue=\"256\" ToolTipText=\"2011-08-01 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/2/2011\" YValue=\"271\" ToolTipText=\"2011-08-02 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/3/2011\" YValue=\"271\" ToolTipText=\"2011-08-03 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/4/2011\" YValue=\"271\" ToolTipText=\"2011-08-04 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/5/2011\" YValue=\"271\" ToolTipText=\"2011-08-05 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/6/2011\" YValue=\"271\" ToolTipText=\"2011-08-06 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/8/2011\" YValue=\"271\" ToolTipText=\"2011-08-08 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/9/2011\" YValue=\"271\" ToolTipText=\"2011-08-09 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/10/2011\" YValue=\"271\" ToolTipText=\"2011-08-10 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/11/2011\" YValue=\"271\" ToolTipText=\"2011-08-11 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/15/2011\" YValue=\"271\" ToolTipText=\"2011-08-15 提交总数:#YValue\"  /><vc:DataPoint XValue=\"3/21/2012\" YValue=\"272\" ToolTipText=\"2012-03-21 提交总数:#YValue\"  /><vc:DataPoint XValue=\"8/23/2012\" YValue=\"275\" ToolTipText=\"2012-08-23 提交总数:#YValue\"  /><vc:DataPoint XValue=\"9/27/2012\" YValue=\"275\" ToolTipText=\"2012-09-27 提交总数:#YValue\"  /></vc:DataSeries.DataPoints></vc:DataSeries><vc:DataSeries RenderAs=\"Line\" LineThickness=\"2\" MovingMarkerEnabled=\"true\" LegendText=\"解决总数\" XValueType=\"DateTime\"  ><vc:DataSeries.DataPoints><vc:DataPoint XValue=\"7/28/2011\" YValue=\"5\" ToolTipText=\"2011-07-28 解决总数:#YValue\"  /><vc:DataPoint XValue=\"7/29/2011\" YValue=\"78\" ToolTipText=\"2011-07-29 解决总数:#YValue\"  /><vc:DataPoint XValue=\"7/30/2011\" YValue=\"109\" ToolTipText=\"2011-07-30 解决总数:#YValue\"  /><vc:DataPoint XValue=\"7/31/2011\" YValue=\"134\" ToolTipText=\"2011-07-31 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/1/2011\" YValue=\"156\" ToolTipText=\"2011-08-01 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/2/2011\" YValue=\"190\" ToolTipText=\"2011-08-02 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/3/2011\" YValue=\"212\" ToolTipText=\"2011-08-03 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/4/2011\" YValue=\"237\" ToolTipText=\"2011-08-04 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/5/2011\" YValue=\"241\" ToolTipText=\"2011-08-05 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/6/2011\" YValue=\"243\" ToolTipText=\"2011-08-06 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/8/2011\" YValue=\"250\" ToolTipText=\"2011-08-08 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/9/2011\" YValue=\"252\" ToolTipText=\"2011-08-09 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/10/2011\" YValue=\"253\" ToolTipText=\"2011-08-10 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/11/2011\" YValue=\"257\" ToolTipText=\"2011-08-11 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/15/2011\" YValue=\"262\" ToolTipText=\"2011-08-15 解决总数:#YValue\"  /><vc:DataPoint XValue=\"3/21/2012\" YValue=\"263\" ToolTipText=\"2012-03-21 解决总数:#YValue\"  /><vc:DataPoint XValue=\"8/23/2012\" YValue=\"263\" ToolTipText=\"2012-08-23 解决总数:#YValue\"  /><vc:DataPoint XValue=\"9/27/2012\" YValue=\"264\" ToolTipText=\"2012-09-27 解决总数:#YValue\"  /></vc:DataSeries.DataPoints></vc:DataSeries></vc:Chart.Series></vc:Chart>";
		
			var textFieldQuerySpecialKey = function( textField, e ) {
				if( e.getKey( ) == Ext.EventObject.ENTER ) {
					queryMoneyInfo( );
					
					e.stopEvent( );
				}
			};
			
			var queryMoneyInfo = function( ) {
			debugger
				var svrId		= svrComboGetSelectedSvrId( );
				
				var startTime	= #{DateFieldStartTime}.getValue( );
				if( startTime )
					startTime	= getDateString( startTime );
					
				var endTime		= #{DateFieldEndTime}.getValue( );
				if( endTime )
					endTime		= getDateString( endTime );
				
				Ext.net.DirectMethods.QueryMoneyInfo( svrId, startTime, endTime, {
					eventMask: {
						showMask: true,
						minDelay: 200,
						msg: msgSubmitting
					},
					success: function( result ) {
						if( result.Success ) {
							//#{PanelMoneyInfo}.hide( );
							
							var goldChart = new Visifire( '../resources/SL.Visifire.Charts.xap', 1200, 450 );
							goldChart.setWindowlessState( true );
							goldChart.setDataXml( result.Result.GoldInfo );
							goldChart.render( "divGoldInfo" );
							
							var silverChart = new Visifire( '../resources/SL.Visifire.Charts.xap', 1200, 450 );
							silverChart.setWindowlessState( true );
							silverChart.setDataXml( result.Result.SilverInfo );
							silverChart.render( "divSilverInfo" );
							
							var voucherChart = new Visifire( '../resources/SL.Visifire.Charts.xap', 1200, 450 );
							voucherChart.setWindowlessState( true );
							voucherChart.setDataXml( result.Result.VoucherInfo );
							voucherChart.render( "divVoucherInfo" );
						}
						else if( result.ErrorMessage ) {
							showErrMsg( msgTitle, result.ErrorMessage );
						}
					}
				});
			};
			
			var initData = function( ) {
			};
			
		</script>
	</ext:XScript>

	<ext:FormPanel ID="QueryPanel" runat="Server" LabelAlign="Right" LabelWidth="430"
		Title="<%$ Resources:StringDef, MoneyInfo %>" Height="155" Padding="10" StyleSpec="margin:10px;"
		ButtonAlign="Center" Border="true" Margins="10px 10px 10px 10px" Width="1200">
		<Items>
			<ext:CompositeField ID="CompositeField2" runat="Server" FieldLabel="<%$ Resources:StringDef, GameServer %>" Width="500">
				<Items>
					<ext:Container ID="Container1" runat="Server">
						<Content>
							<sat:SvrCombo runat="Server" ID="svrCombo" />
						</Content>
					</ext:Container>
				</Items>
			</ext:CompositeField>
			<ext:DateField ID="DateFieldStartTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, StartTime %>" Width="276">
				<Listeners>
					<SpecialKey Fn="textFieldQuerySpecialKey" />
				</Listeners>
			</ext:DateField>
			<ext:DateField ID="DateFieldEndTime" Format="Y-n-j H:i:s" runat="Server" FieldLabel="<%$ Resources:StringDef, EndTime %>" Width="276">
				<Listeners>
					<SpecialKey Fn="textFieldQuerySpecialKey" />
				</Listeners>
			</ext:DateField>
		</Items>
		<Buttons>
			<ext:Button ID="BtnQuery" runat="Server" Text="<%$ Resources:StringDef, Query %>">
				<Listeners>
					<Click Fn="queryMoneyInfo" />
				</Listeners>
			</ext:Button>
		</Buttons>
	</ext:FormPanel>
	
	<ext:Panel ID="PanelMoneyInfo" runat="server" Border="false" AutoScroll="true" PaddingSummary="10px 10px 10px 10px" EnableViewState="false">
		<Content>
			<div>
				<div id='divGoldInfo'></div>
				<br />
				<br />
				<div id='divSilverInfo'></div>
				<br />
				<br />
				<div id='divVoucherInfo'></div>
			</div>
		</Content>
	</ext:Panel>
	
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="TailHolder" Runat="Server">
</asp:Content>
