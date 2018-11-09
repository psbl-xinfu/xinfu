var pttotalcount = "${fld:pttotalcount}";
if(pttotalcount==""){
	$("#classStatisticalDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	var seriesArr = [{name:'签课率', value:Number(parseInt("${fld:num}")
			/parseInt(pttotalcount)*100).toFixed(2)}];
	classStatisticalPic.createCharts(seriesArr);
}


var ptleftcount = "${fld:ptleftcount}";
if(ptleftcount==""){
	ptleftcount = 0;
}
$("#classremaining").html(ptleftcount);

