// 数据Map
var i = 0;

// console.log("${fld:vc_custcode}");
// var _vc_custcode="${fld:vc_custcode}";
var xArray = new Array();	// X轴：年月
var seriesArray = new Array();	// Y轴：数据列表
<rows>
	
	// var arr = "${fld:c_idate}".split("-");
	// xArray[i]=parseInt(arr[1]) + "月" + parseInt(arr[2]) + "日";
	xArray[i]="${fld:c_idate}";
	seriesArray[i]=parseInt("${fld:i_health}")
	i++;
</rows>
// console.log(seriesArray[0]);

// var xArray = new Array();	// X轴：年月
// var seriesArray = new Array();	// Y轴：数据列表
// // 获取当前日期
// var curdate = new Date().format("yyyy-MM-dd");
// var i = 0;
// while(true){
// 	var tdate = addDate("${fld:fdate}", i);//fdate前1个月的日期
// 	xArray[i] = (tdate.getMonth()+1) + "月" + tdate.getDate() + "日";
// 	var num = dateMap[(tdate.getMonth()+1) + "月" + tdate.getDate() + "日"];
// 	num = ( undefined != num && null != num ? num : 0 );
// 	seriesArray[i] = num;
// 	i++;
// 	if( curdate == tdate.format("yyyy-MM-dd") ){
// 		break;
// 	}
// }

// 生成曲线图
require(
	[
		'echarts', 'echarts/chart/bar' // require the specific chart type
	], 
	function(ec) {
		// Initialize after dom ready
		var myChart = ec.init(document.getElementById('testChartDiv'));
		var option = {
			title : {
				text : '体测结果',
			},
			// tooltip : {
			// 	trigger : 'axis'
			// },
			legend: {
		        data:['健康得分']
		    },
			xAxis : {
				type : 'category',
				// boundaryGap : false,
				data : xArray
			},
			yAxis : {
				type : 'value',
				max:100
			},
			series : [
				{
					name : '健康得分',
					barWidth:40,
					type : 'bar',
					// smooth : true,
					// connectNulls : true,
					itemStyle : { normal: {label : {show: true, position: 'inside'}}},
					data : seriesArray
				}
			]
		};
		// Load data into the ECharts instance 
		myChart.setOption(option);
		myChart.on('click', function eConsole(param){
		var dateSel=param.name; 
		// ${def:actionroot}
        var uri = "${def:context}${def:actionroot}/detail_table/crud?vc_custcode=${fld:vc_custcode}"+"&date="+dateSel;
        ccms.dialog.open({url:uri,width:800,height:800});
		});
	}
);