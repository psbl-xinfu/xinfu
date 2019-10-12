// 私教签课
var legendData = [], seriesData = [], idx = 0, pttotal = 0;
<pt-rows>
legendData[idx] = "${fld:createdate}";
seriesData[idx] = parseInt("${fld:num}");
pttotal += parseInt("${fld:num}");
idx++;
</pt-rows>
var lineObj = new lineCharts("ptDiv");
lineObj.setConfig({boundaryGap: false});
lineObj.updateOption(
	["私教上课记录"],
	legendData,
	[{
		name: '私教签课',
		type: 'line',
		itemStyle: {
			normal: {
				areaStyle: {
					// 区域图，纵向渐变填充
					/**color : (function (){
						var zrColor = require('zrender/tool/color');
						return zrColor.getLinearGradient(
								0, 200, 0, 400,
								[[0, 'rgba(65,182,177,1)'],[0.8, 'rgba(65,182,177,1)']]
						);
					})()*/
				}
			}
		},
		data: seriesData
	}]
);
$("#pttotal").text(pttotal);
