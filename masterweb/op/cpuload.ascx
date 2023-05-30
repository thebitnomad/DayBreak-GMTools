<%@ control language="C#" autoeventwireup="true" inherits="op_cpuload, App_Web_cpuload.ascx.b81705c1" %>

<script type="text/javascript">
	var cpuLoadMachineID;
	var cpuLoadInterval;
	var cpuLoadChart;
	var cpuLoadChartHandle;
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initCPULoad = function( width, height, machineID, interval, initInterval ) {
			#{DirectMethods}.CPULoadInit(
				width,
				height, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						cpuLoadChart = new Visifire( "../resources/SL.Visifire.Charts.xap", "CPULoadChart", width, height );
						cpuLoadChart.setDataXml( result.Result );
						cpuLoadChart.loaded = function( args ) {
							cpuLoadChartHandle = args[0];
							if( machineID ) {
								configureCPULoad( machineID, interval, initInterval );
							}
						}
						cpuLoadChart.render( "cpuLoadChartDiv" );
					}
				}
			);
		};
		
		var configureCPULoad = function( machineID, interval, initInterval ) {
			cpuLoadMachineID = machineID;
			cpuLoadInterval = interval;
			if( initInterval && initInterval > 0 ) {
				setTimeout( cpuLoadOnTimer, initInterval );
			}
			else {
				cpuLoadOnTimer( );
			}
		};
		
		var refreshCPULoad = function( ) {
			#{DirectMethods}.CPULoadRefresh(
				cpuLoadMachineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var validValue = ( result.Result > 100 ? 100 : result.Result );
						var series0 = cpuLoadChartHandle.Series[0];
						series0.DataPoints[0].SetPropertyFromJs( "YValue", validValue );
						series0.DataPoints[0].SetPropertyFromJs( "Enabled", "True" );
						var series1 = cpuLoadChartHandle.Series[1];
						series1.DataPoints[0].SetPropertyFromJs( "YValue", 100 - validValue );
						series1.DataPoints[0].SetPropertyFromJs( "Enabled", "True" );
					}
				}
			);
		};
		
		var cpuLoadOnTimer = function( ) {
			refreshCPULoad( );
			if( cpuLoadInterval > 0 ) {
				setTimeout( cpuLoadOnTimer, cpuLoadInterval );
			}
		};
	</script>
</ext:XScript>
<div>
	<div id="cpuLoadChartDiv" >
	</div>
</div>
