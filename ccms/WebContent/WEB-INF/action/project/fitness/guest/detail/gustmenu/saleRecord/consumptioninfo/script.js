//会员消费类型
var seriesArr = [];
var count = 0, normalmoney = 0;
<rows>
	if("${fld:param_value}"=="01"){
		seriesArr[count]={value:"${fld:normalmoney}",name:"办卡"};
		$("#newcard").html("${fld:normalmoney}");
		count++;
	}else if("${fld:param_value}"=="31"){
		seriesArr[count]={value:"${fld:normalmoney}",name:"购买私教"};
		$("#pt").html("${fld:normalmoney}");
		count++;
	}else if("${fld:param_value}"=="55"){
		seriesArr[count]={value:"${fld:normalmoney}",name:"商品购买"};
		$("#goods").html("${fld:normalmoney}");
		count++;
	}else{
		normalmoney+=Number("${fld:normalmoney}");
	}
</rows>
$("#other").html(normalmoney);
if(normalmoney>0)
	seriesArr[seriesArr.length]={value:normalmoney,name:"其他消费"};

if(seriesArr.length>0){
	consumptioninfoPic.createCharts(seriesArr);
}else{
	$("#consumptioninfoDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}