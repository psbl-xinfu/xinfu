$("#norenewalDiv").html("");
/** 未续费会籍客户 **/
var avgfee = [];

norw.total = 0;
norw.xdataArr = [], norw.seriesDataArr = [];
<rows>
	norw.xdataArr[norw.total] = "${fld:createdate}";
	avgfee[norw.total] = ${fld:num};
	norw.total++;
</rows>
norw.legendData = ['未续费会籍客户'];
norw.seriesDataArr = [avgfee];


var tbNorwdataArr = [], tbTotal = 0;
<tb-rows>
tbNorwdataArr[tbTotal] = parseInt("${fld:num}");
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	norw.legendData.push("未续费会籍客户[同]");
	norw.seriesDataArr.push(tbNorwdataArr);
}

var hbNorwdataArr = [], hbTotal = 0;
<hb-rows>
hbNorwdataArr[hbTotal] = parseInt("${fld:num}");
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	norw.legendData.push("未续费会籍客户[环]");
	norw.seriesDataArr.push(hbNorwdataArr);
}

if( norw.total > 0 ){
	initLineBarCharts("norenewalDiv", norw);
}else{
	$("#norenewalDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
