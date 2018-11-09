var ptnum = parseInt("${fld:ptnum}");
var onenum = parseInt("${fld:onenum}");
var twonum = parseInt("${fld:twonum}");
var threenum = parseInt("${fld:threenum}");
var seriesArr = [{value:(ptnum-onenum-twonum-threenum),name:"0次"},
                 {value:onenum,name:"1-4次"},
                 {value:twonum,name:"5-12次"},
                 {value:threenum,name:"12次以上"}];

if(seriesArr.length>0){
	ptactivePic.createCharts(seriesArr);
	//列表
	pielist("ptactive", seriesArr);
}else{
	$("#ptactiveDiv,#ptactiveDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}