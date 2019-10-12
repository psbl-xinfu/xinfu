var legendData = [], seriesData = [], idx = 0, feetotal = 0;
<fee-rows>
legendData[idx] = "${fld:month}月";
seriesData[idx] = parseInt("${fld:fee}");
feetotal += parseFloat("${fld:fee}");
idx++;
</fee-rows>
var lineObj = new lineCharts("feetotalDiv");
lineObj.setConfig({boundaryGap: false});
lineObj.updateOption(
	["成交额"],
	legendData,
	[{
		name: '成交额',
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
$("#feetotal").text(feetotal);
