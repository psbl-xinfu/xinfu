$("#guesttypeDiv").html("");
var seriesArr = [];
var count = 0;
<rows>
	if(count==0){
		seriesArr[count]={value:"${fld:num}",name:"${fld:param_text}", selected: true};
	}else{
		seriesArr[count]={value:"${fld:num}",name:"${fld:param_text}"};
	}
	count++;
</rows>
if(seriesArr.length>0){
	guesttypeendPic.createCharts(seriesArr);
	//列表
	pielist("guesttype", seriesArr);
}else{
	$("#guesttypeDiv,#guesttypeDivlist").html("<img  style='margin-left:110px'    src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}