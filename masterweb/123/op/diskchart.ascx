<%@ control language="C#" autoeventwireup="true" inherits="op_diskchart, App_Web_diskchart.ascx.b81705c1" %>

<script type="text/javascript">
	var diskChartMachineID;
	var diskChartInterval;
	var diskChartCtrl;
	var diskChartCtrlHandle;
</script>

<ext:XScript ID="XScript1" runat="Server">
	<script type="text/javascript">
		var initDiskChart = function( width, height, machineID, interval, initInterval ) {
			#{DirectMethods}.InitDiskChart(
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
						diskChartCtrl = new Array( ctrlCnt );
						diskChartCtrlHandle = new Array( ctrlCnt );
						var iCtrl = 0;
						
						try {
							diskChartCtrl[iCtrl] = new Visifire( "../resources/SL.Visifire.Charts.xap", "DiskChartCtrl" + iCtrl, width, height );
							diskChartCtrl[iCtrl].setWindowlessState( true );
							diskChartCtrl[iCtrl].setDataXml( result.Result[iCtrl] );
							var onDiskChartCtrlLoaded = function( args ) {
								diskChartCtrlHandle[iCtrl] = args[0];
								++iCtrl;
								if( machineID && iCtrl == ctrlCnt ) {
									configureDiskChart( machineID, interval, initInterval );
									return;
								}
								if( iCtrl >= ctrlCnt ) {
									return;
								}
								
								diskChartCtrl[iCtrl] = new Visifire( "../resources/SL.Visifire.Charts.xap", "DiskChartCtrl" + iCtrl, width, height );
								diskChartCtrl[iCtrl].setDataXml( result.Result[iCtrl] );
								diskChartCtrl[iCtrl].loaded = onDiskChartCtrlLoaded;
								diskChartCtrl[iCtrl].render( result.Result[result.Result.length-1] + iCtrl );
							}
							diskChartCtrl[iCtrl].loaded = onDiskChartCtrlLoaded;
							diskChartCtrl[iCtrl].render( result.Result[result.Result.length-1] + iCtrl );
						}
						catch( ex ) {
						}
					}
				}
			);
		};

		var configureDiskChart = function( machineID, interval, initInterval ) {
			diskChartMachineID = machineID;
			diskChartInterval = interval;            
									
			if( initInterval && initInterval > 0 ) {
				setTimeout( diskChartOnTimer, initInterval );
			}
			else {
				diskChartOnTimer( );
			}
		};
		
		var refreshDiskChart = function( ) {
			#{DirectMethods}.DiskChartRefresh(
				diskChartMachineID, {
					success: function( result ) {
						if( !result.Success ) {
							return;
						}
						
						var validCount = ( diskChartCtrlHandle.length > result.Result.length ? result.Result.length : diskChartCtrlHandle.length );
						for( var iChart = 0; iChart < validCount; ++iChart ) {
							var series = diskChartCtrlHandle[iChart].Series[0];
							if( result.Result[iChart].length < 2 ) {
								series.SetPropertyFromJs( "Enabled", "False" );
							}
							
							series.SetPropertyFromJs( "Enabled", "True" );
							series.DataPoints[0].SetPropertyFromJs( "YValue", result.Result[iChart][0] );
							series.DataPoints[1].SetPropertyFromJs( "YValue", result.Result[iChart][1] );
						}
					}
				}
			);
		};
		
		var diskChartOnTimer = function( ) {
			refreshDiskChart( );
			if( diskChartInterval > 0 ) {
				setTimeout( diskChartOnTimer, diskChartInterval );
			}
		};
	</script>
</ext:XScript>
<div>
	<div id="diskChartCtrlDiv" runat="Server">
	</div>
</div>
