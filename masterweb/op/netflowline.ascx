<%@ control language="C#" autoeventwireup="true" inherits="op_netflowline, App_Web_netflowline.ascx.b81705c1" %>

<script type="text/javascript">
	var netFlowLineMachineID;
	var netFlowLineInterval;
	var netFlowLineChart;
	var netFlowLineChartHandle;
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initNetFlowLine = function( width, height, machineID, interval, initInterval ) {
			#{DirectMethods}.InitNetFlowLine(
				width,
				height,
				machineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						var ctrlCnt = result.Result.length - 1;
						if( ctrlCnt < 1 ) {
							return;
						}
						netFlowLineChart = new Array( ctrlCnt );
						netFlowLineChartHandle = new Array( ctrlCnt );
						var iCtrl = 0;
						
						netFlowLineChart[iCtrl] = new Visifire( "../resources/SL.Visifire.Charts.xap", "NetFlowLineChart" + iCtrl, width, height );
						netFlowLineChart[iCtrl].setWindowlessState( true );
						netFlowLineChart[iCtrl].setDataXml( result.Result[iCtrl] );
						var onNetFlowLineChartLoaded = function( args ) {
							netFlowLineChartHandle[iCtrl] = args[0];
							++iCtrl;
							if( machineID && iCtrl == ctrlCnt ) {
								configureNetFlowLine( machineID, interval, initInterval );
								return;
							}
							if( iCtrl >= ctrlCnt ) {
								return;
							}
							
							netFlowLineChart[iCtrl] = new Visifire( "../resources/SL.Visifire.Charts.xap", "NetFlowLineChart" + iCtrl, width, height );
							netFlowLineChart[iCtrl].setDataXml( result.Result[iCtrl] );
							netFlowLineChart[iCtrl].loaded = onNetFlowLineChartLoaded;
							netFlowLineChart[iCtrl].render( result.Result[result.Result.length - 1] + iCtrl );
						}
						netFlowLineChart[iCtrl].loaded = onNetFlowLineChartLoaded;
						netFlowLineChart[iCtrl].render( result.Result[result.Result.length - 1] + iCtrl );
					}
				}
			);
		};
		
		var configureNetFlowLine = function( machineID, interval, initInterval ) {
			netFlowLineMachineID = machineID;
			netFlowLineInterval = interval;
											
			if( initInterval && initInterval > 0 ) {
				setTimeout( netFlowLineOnTimer, initInterval );
			}
			else {
				netFlowLineOnTimer( );
			}
		};
		
		var refreshNetFlowLine = function( ) {
			#{DirectMethods}.NetFlowLineRefresh(
				netFlowLineMachineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var validTeamCount = ( result.Result.RXRate.length > netFlowLineChartHandle.length ? netFlowLineChartHandle.length : result.Result.RXRate.length );
						for( var iCard = 0; iCard < validTeamCount; ++iCard ) {
							var series = netFlowLineChartHandle[iCard].Series[0];
							series.SetPropertyFromJs( "Enabled", "True" );
							var validCount = ( result.Result.RXRate[iCard].length > series.DataPoints.length ? series.DataPoints.length : result.Result.RXRate[iCard].length );
							for( var iPoint = 0; iPoint < validCount; ++iPoint ) {
								series.DataPoints[iPoint].SetPropertyFromJs( "YValue", result.Result.RXRate[iCard][iPoint] );
//	                            series.DataPoints[iPoint].SetPropertyFromJs( "XValue", iPoint );
								series.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "True" );
							}
							for( var iPoint = validCount; iPoint < series.DataPoints.length; ++iPoint ) {
								series.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "False" );
							}
							
							var series2 = netFlowLineChartHandle[iCard].Series[1];
							series2.SetPropertyFromJs( "Enabled", "True" );
							var validCount = ( result.Result.TXRate[iCard].length > series2.DataPoints.length ? series2.DataPoints.length : result.Result.TXRate[iCard].length );
							for( var iPoint = 0; iPoint < validCount; ++iPoint ) {
								series2.DataPoints[iPoint].SetPropertyFromJs( "YValue", result.Result.TXRate[iCard][iPoint] );
								series2.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "True" );
							}
							for( var iPoint = validCount; iPoint < series2.DataPoints.length; ++iPoint ) {
								series2.DataPoints[iPoint].SetPropertyFromJs( "Enabled", "False" );
							}
						}
					}
				}
			);
		};
		
		var netFlowLineOnTimer = function( ) {
			refreshNetFlowLine( );
			if( netFlowLineInterval > 0 ) {
				setTimeout( netFlowLineOnTimer, netFlowLineInterval );
			}
		}
	</script>
</ext:XScript>
<div>
	<div id="netFlowLineChartDiv" runat="Server">
	</div>
</div>
