<%@ control language="C#" autoeventwireup="true" inherits="op_cpuline, App_Web_cpuline.ascx.b81705c1" %>

<script type="text/javascript">
	var cpuLineMachineID;
	var cpuLineInterval;
	var cpuLineChart;
	var cpuLineChartHandle;
	var cpuLineCPUCount;
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initCPULine = function( width, height, machineID, interval, initInterval ) {
			#{DirectMethods}.CPULineInit(
				width,
				height, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						cpuLineChart = new Visifire( "../resources/SL.Visifire.Charts.xap", "CPULineChart", width, height );
						cpuLineChart.setWindowlessState( true );
						cpuLineChart.setDataXml( result.Result );
						cpuLineChart.loaded = function( args ) {
							cpuLineChartHandle = args[0];
							if( machineID ) {
								configureCpuLine( machineID, interval, initInterval );
							}
						}
						cpuLineChart.render( "cpuLineChartDiv" );
					}
				}
			);
		};
		
		var configureCpuLine = function( machineID, interval, initInterval ) {
			cpuLineMachineID = machineID;
			cpuLineInterval = interval;
			#{DirectMethods}.CPULineConfigure(
				machineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var cpuCapacity = cpuLineChartHandle.Series.length;
						cpuLineCPUCount = ( cpuCapacity > result.Result ? result.Result : cpuCapacity );
						for( var iCPU = 0; iCPU < cpuLineCPUCount; ++iCPU ) {
							var series = cpuLineChartHandle.Series[iCPU];
							series.SetPropertyFromJs( "Enabled", "True" );
						}
						for( var iCPU = cpuLineCPUCount; iCPU < cpuCapacity; ++iCPU ) {
							var series = cpuLineChartHandle.Series[iCPU];
							series.SetPropertyFromJs( "Enabled", "False" );
						}
						
						if( initInterval && initInterval > 0 ) {
							setTimeout( cpuLineOnTimer, initInterval );
						}
						else {
							cpuLineOnTimer( );
						}
					}
				}
			);
		};
		
		var refreshCPULine = function( ) {
			#{DirectMethods}.CPULineRefresh(
				cpuLineMachineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var validTeamCount = ( result.Result.length > cpuLineCPUCount ? cpuLineCPUCount : result.Result.length );
						for( var iCPU = 0; iCPU < validTeamCount; ++iCPU ) {
							var series = cpuLineChartHandle.Series[iCPU];
							var validCount = ( result.Result[iCPU].length > series.DataPoints.length ? series.DataPoints.length : result.Result[iCPU].length );
							for( var iPoint = 0; iPoint < validCount; ++iPoint ) {
								series.DataPoints[iPoint].SetPropertyFromJs( "YValue", result.Result[iCPU][iPoint] );
//	                            series.DataPoints[iPoint].SetPropertyFromJs( "XValue", iPoint );
								series.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "True" );
							}
							for( var iPoint = validCount; iPoint < series.DataPoints.length; ++iPoint ) {
								series.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "False" );
							}
						}
					}
				}
			);
		};
		
		var cpuLineOnTimer = function( ) {
			refreshCPULine( );
			if( cpuLineInterval > 0 ) {
				setTimeout( cpuLineOnTimer, cpuLineInterval );
			}
		};
	</script>
</ext:XScript>
<div>
	<div id="cpuLineChartDiv">
	</div>
</div>
