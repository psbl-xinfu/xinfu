var seriesArr = [{value:"${fld:renewalnum}",name:"已续会量"},
                 {value:"${fld:notrenewalnum}",name:"未续会量"}];

if(seriesArr.length>0){
	custrenewalPic.createCharts(seriesArr);
	//列表
	pielist("custrenewal", seriesArr);
}else{
	$("#custrenewalDiv,#custrenewalDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}