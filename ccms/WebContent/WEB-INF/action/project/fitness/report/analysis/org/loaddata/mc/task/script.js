/** 员工任务达标率 */
var staffnum = parseInt("${fld:staffnum}"), mctasklist = [];

mctaskCharts.total = 0;
mctaskCharts.legendData = [], mctaskCharts.seriesDataArr = [];

mctaskCharts.seriesDataArr[mctaskCharts.total] = parseInt("${fld:finishnum}");
mctaskCharts.legendData[mctaskCharts.total] = "达标人数";
mctasklist[mctaskCharts.total] = {value: parseInt("${fld:finishnum}"), name: '达标人数'};
mctaskCharts.total++;
mctaskCharts.seriesDataArr[mctaskCharts.total] = staffnum - parseInt("${fld:finishnum}");
mctaskCharts.legendData[mctaskCharts.total] = "未达标人数";
mctasklist[mctaskCharts.total] = {value: staffnum - parseInt("${fld:finishnum}"), name: '未达标人数'};

mctaskCharts.seriesDataArrOther = [], mctaskCharts.legendDataOther = [];
if( "H" == "${fld:compareflag}" ){	/** 环比 */
	mctaskCharts.othertitlename = "员工任务达标率[环]";
	mctaskCharts.seriesDataArrOther[0] = parseInt("${fld:finishnumhb}");
	mctaskCharts.legendDataOther[0] = "达标人数[环]";
	mctasklist[mctasklist.length] = {value: parseInt("${fld:finishnumhb}"), name: '达标人数[环]'};
	
	mctaskCharts.seriesDataArrOther[1] = staffnum - parseInt("${fld:finishnumhb}");
	mctaskCharts.legendDataOther[1] = "未达标人数[环]";
	mctasklist[mctasklist.length] = {value: staffnum - parseInt("${fld:finishnumhb}"), name: '未达标人数[环]'};
}else if( "T" == "${fld:compareflag}" ){	/** 同比 */
	mctaskCharts.othertitlename = "员工任务达标率[同]";
	mctaskCharts.seriesDataArrOther[0] = parseInt("${fld:finishnumtb}");
	mctaskCharts.legendDataOther[0] = "达标人数[同]";
	mctasklist[mctasklist.length] = {value: parseInt("${fld:finishnumtb}"), name: '达标人数[同]'};
	
	mctaskCharts.seriesDataArrOther[1] = staffnum - parseInt("${fld:finishnumtb}");
	mctaskCharts.legendDataOther[1] = "未达标人数[同]";
	mctasklist[mctasklist.length] = {value: staffnum - parseInt("${fld:finishnumtb}"), name: '未达标人数[同]'};
}

if( mctaskCharts.total > 0 ){
	initPieCharts("mctaskDiv", mctaskCharts);
	//列表
	pielist("mctask", mctasklist);
}else{
	$("#mctaskDiv,#mctaskDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
