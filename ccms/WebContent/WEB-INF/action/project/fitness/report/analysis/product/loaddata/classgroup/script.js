var seriesArr = [];
var count = 0, othernum=0;
<rows>
	if(count<5){
		seriesArr[count]={value:"${fld:num}",name:"${fld:name}"};
	}else{
		othernum += Number("${fld:num}");
	}
	count++;
</rows>
if(othernum>0)
	seriesArr[seriesArr.length++] = {value:othernum,name:"其他"};

if(seriesArr.length>0){
	classgroupPic.createCharts(seriesArr);
	//列表
	pielist("group", seriesArr);
}else{
	$("#groupDiv,#groupDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}