<%@ control language="C#" autoeventwireup="true" inherits="op_memchart, App_Web_memchart.ascx.b81705c1" %>

<script type="text/javascript">
	var memChartMachineID;
	var memChartCtrl;
	var memChartCtrlHandle;
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initMemChart = function( width, height, machineID, interval ) {
			memChartMachineID = machineID;
			#{DirectMethods}.MemChartInit(
				machineID,
				width,
				height, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						memChartCtrl = new Visifire( "../resources/SL.Visifire.Charts.xap", "MemChartCtrl", width, height );
						memChartCtrl.setWindowlessState( true );
						memChartCtrl.setDataXml( result.Result );
						memChartCtrl.loaded = function( args ) {
							memChartCtrlHandle = args[0];
							if( interval > 0 ) {
								setInterval( refreshMemChart, interval );
								refreshMemChart( );
							}
						}
						memChartCtrl.render( "memChartCtrlDiv" );
					}
				}
			);
		};
		
		var refreshMemChart = function( ) {
			#{DirectMethods}.MemChartRefresh(
				memChartMachineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var series0 = memChartCtrlHandle.Series[0];
						series0.DataPoints[0].SetPropertyFromJs( "YValue", result.Result[0] );
						series0.DataPoints[0].SetPropertyFromJs( "Enabled", "True" );
						var series1 = memChartCtrlHandle.Series[1];
						series1.DataPoints[0].SetPropertyFromJs( "YValue", result.Result[1] );
						series1.DataPoints[0].SetPropertyFromJs( "Enabled", "True" );
					}
				}
			);
		};
	</script>
</ext:XScript>
<div>
	<div id="memChartCtrlDiv">
	</div>
</div>
