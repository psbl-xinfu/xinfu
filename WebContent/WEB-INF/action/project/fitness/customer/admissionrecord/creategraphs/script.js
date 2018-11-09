// 数据Map
var dateMap = {};
<rows>
	dateMap["${fld:year}年${fld:month}月"] = parseInt("${fld:visit_num}");
</rows>

var xArray = new Array();	// X轴：年月
var seriesArray = new Array();	// Y轴：数据列表
// 获取当前日期
var curdate = new Date();
var curyear = curdate.getFullYear();
var curmonth = curdate.getMonth() + 1;
// 获取起始日期
var fdate = new Date("${fld:fdate} 00:00:00".split("-").join("/"));
var fyear = fdate.getFullYear();
var fmonth = fdate.getMonth() + 1;
var i = 0;
while(true){
	var tyear = fyear;
	var tmonth = fmonth + i;
	if( tmonth > 12 ){
		tmonth = tmonth - 12;
		tyear += 1;
	}
	xArray[i] = tyear + "年" + tmonth + "月";
	var num = dateMap[tyear + "年" + tmonth + "月"];
	num = ( undefined != num && null != num ? num : 0 );
	seriesArray[i] = num;
	i++;
	if( tyear == curyear && tmonth == curmonth ){
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
		var myChart = ec.init(document.getElementById('chartDiv'));
		var option = {
			title : {
				text : '入场记录',
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
					name : '入场数',
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