﻿$("#maritalstatusDiv").html("");
var seriesArr = [];
var count = 0;
<rows>
	if(count==0){
		seriesArr[count]={value:"${fld:num}",name:"${fld:domain_text_cn}", selected: true};
	}else{
		seriesArr[count]={value:"${fld:num}",name:"${fld:domain_text_cn}"};
	}
	count++;
</rows>
if(seriesArr.length>0){
	maritalstatusendPic.createCharts(seriesArr);
	//列表
	pielist("maritalstatus", seriesArr);
}else{
	$("#maritalstatusDiv,#maritalstatusDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}