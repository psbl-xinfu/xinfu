$("#guesttypeDiv").html("");
var seriesArr = [], typenamedata = [];
var count = 0;
<rows>
	typenamedata[count] = "${fld:param_text@js}";
	seriesArr[count]={value:"${fld:num}",name:"${fld:param_text}"};
	count++;
</rows>
guesttypeendPic.setConfig({isLegendShow: true, legendData: typenamedata});

var seriesJson1 = {
	name:'到访量',
	type:'pie',
	selectedMode: 'single',
	radius: [0, '50%'],
	label: {
		normal: {
			position: 'inner'
		}
	},
	labelLine: {
		normal: {
			show: false
		}
	},
	data: [
	   	{value: ${fld:yynum}, name: '预约到访量'},
		{value: ${fld:msnum}, name: '陌生到访量'}
	]
};

var seriesJson2 = {
	name:'获客渠道',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: [
	       
	]
};
seriesJson2.data = seriesArr;
if(seriesArr.length>0){
	guesttypeendPic.createCharts([seriesJson1, seriesJson2]);
	//列表
	pielist("guesttype", seriesArr);
}else{
	$("#guesttypeDiv,#guesttypeDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}