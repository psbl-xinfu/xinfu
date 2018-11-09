// 数据Map
var dateMap = {};
<rows>
	var arr = "${fld:plandate}".split("-");
	dateMap[parseInt(arr[1]) + "月" + parseInt(arr[2]) + "日"] = parseInt("${fld:total_num}");
</rows>

var xArray = new Array();	// X轴：年月
var seriesArray = new Array();	// Y轴：数据列表
// 获取当前日期
var curdate = new Date().format("yyyy-MM-dd");
var i = 0;
while(true){
	var tdate = addDate("${fld:fdate}", i);
	xArray[i] = (tdate.getMonth()+1) + "月" + tdate.getDate() + "日";
	var num = dateMap[(tdate.getMonth()+1) + "月" + tdate.getDate() + "日"];
	num = ( undefined != num && null != num ? num : 0 );
	seriesArray[i] = num;
	i++;
	if( curdate == tdate.format("yyyy-MM-dd") ){
		break;
	}
}

// 生成曲线图
require(
	[
		'echarts', 'echarts/chart/line' // require the specific chart type
	], 
	function(ec) {
		// Initialize after dom ready
		var myChart = ec.init(document.getElementById('planChartDiv'));
		var option = {
			title : {
				text : '训练计划',
			},
			tooltip : {
				trigger : 'axis'
			},
			toolbox : {
				show : true,
				feature : {
					magicType : {
						show : true,
						type : [ 'stack', 'tiled' ]
					},
					saveAsImage : {
						show : true
					}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				data : xArray
			},
			yAxis : {
				type : 'value'
			},
			series : [
				{
					name : '训练计划',
					type : 'line',
					smooth : true,
					connectNulls : true,
					data : seriesArray
				}
			]
		};
		// Load data into the ECharts instance 
		myChart.setOption(option);
	}
);