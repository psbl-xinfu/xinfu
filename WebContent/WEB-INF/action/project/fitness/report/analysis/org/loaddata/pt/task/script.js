/** 员工任务达标率 */
var staffnum = parseInt("${fld:staffnum}"), tasklist = [];

taskCharts.total = 0;
taskCharts.legendData = [], taskCharts.seriesDataArr = [];

taskCharts.seriesDataArr[taskCharts.total] = parseInt("${fld:finishnum}");
taskCharts.legendData[taskCharts.total] = "达标人数";
tasklist[taskCharts.total] = {value: parseInt("${fld:finishnum}"), name: '达标人数'};
taskCharts.total++;
taskCharts.seriesDataArr[taskCharts.total] = staffnum - parseInt("${fld:finishnum}");
taskCharts.legendData[taskCharts.total] = "未达标人数";
tasklist[taskCharts.total] = {value: staffnum - parseInt("${fld:finishnum}"), name: '未达标人数'};

taskCharts.seriesDataArrOther = [], taskCharts.legendDataOther = [];
if( "H" == "${fld:compareflag}" ){	/** 环比 */
	taskCharts.othertitlename = "员工任务达标率[环]";
	taskCharts.seriesDataArrOther[0] = parseInt("${fld:finishnumhb}");
	taskCharts.legendDataOther[0] = "达标人数[环]";
	tasklist[tasklist.length] = {value: parseInt("${fld:finishnumhb}"), name: '达标人数[环]'};
	
	taskCharts.seriesDataArrOther[1] = staffnum - parseInt("${fld:finishnumhb}");
	taskCharts.legendDataOther[1] = "未达标人数[环]";
	tasklist[tasklist.length] = {value: staffnum - parseInt("${fld:finishnumhb}"), name: '未达标人数[环]'};
}else if( "T" == "${fld:compareflag}" ){	/** 同比 */
	taskCharts.othertitlename = "员工任务达标率[同]";
	taskCharts.seriesDataArrOther[0] = parseInt("${fld:finishnumtb}");
	taskCharts.legendDataOther[0] = "达标人数[同]";
	tasklist[tasklist.length] = {value: parseInt("${fld:finishnumtb}"), name: '达标人数[同]'};
	
	taskCharts.seriesDataArrOther[1] = staffnum - parseInt("${fld:finishnumtb}");
	taskCharts.legendDataOther[1] = "未达标人数[同]";
	tasklist[tasklist.length] = {value: staffnum - parseInt("${fld:finishnumtb}"), name: '未达标人数[同]'};
}

if( taskCharts.total > 0 ){
	initPieCharts("taskDiv", taskCharts);
	//列表
	pielist("task", tasklist);
}else{
	$("#taskDiv,#taskDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
