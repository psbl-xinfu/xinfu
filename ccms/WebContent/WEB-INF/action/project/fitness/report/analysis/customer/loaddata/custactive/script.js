﻿var notinleftnum = parseInt("${fld:notinleftnum}");
var onenum = parseInt("${fld:onenum}");
var twonum = parseInt("${fld:twonum}");
var threenum = parseInt("${fld:threenum}");
var seriesArr = [{value:(notinleftnum-onenum-twonum-threenum),name:"0次"},
                 {value:onenum,name:"1-4次"},
                 {value:twonum,name:"5-15次"},
                 {value:threenum,name:"15次以上"}];

if(seriesArr.length>0){
	custactivePic.createCharts(seriesArr);
	//列表
	pielist("custactive", seriesArr);
}else{
	$("#custactiveDiv,#custactiveDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}