$("#norenewalptcustDiv").html("");
var seriesArr = [];
var count = 0;
<rows>
	seriesArr[count] = {value: "${fld:num}", name: "${fld:domain_text_cn}"};
	count++;
</rows>

if(seriesArr.length>0){
	norenewalptcustendPic.createCharts(seriesArr);
	//列表
	pielist("norenewalptcust", seriesArr);
}else{
	$("#norenewalptcustDiv,#norenewalptcustDivlist").html("<img style='' src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
