/** 私教授课统计 */
var zerostatusnum = 0, onestatusnum = 0, twostatusnum = 0, threestatusnum = 0;

teachingStatistical.total = 0;
teachingStatistical.xdataArr = [], teachingStatistical.seriesDataArr = [];

var zerostatusArr = [], onestatusArr = [], twostatusArr = [], threestatusArr = [];
var zerocount = 0, onecount = 0, twocount = 0, threecount = 0;

/** 已取消 **/
<zero-rows>
	teachingStatistical.xdataArr[zerocount] = "${fld:createdate}";
	zerostatusArr[zerocount] = parseInt("${fld:num}");
	zerostatusnum+=parseInt("${fld:num}");
	zerocount++;
	teachingStatistical.total++;
</zero-rows>

/** 预约中 **/
<one-rows>
	onestatusArr[onecount] = parseInt("${fld:num}");
	onestatusnum+=parseInt("${fld:num}");
	onecount++;
</one-rows>

/** 已上课 **/
<two-rows>
	twostatusArr[twocount] = parseInt("${fld:num}");
	twostatusnum+=parseInt("${fld:num}");
	twocount++;
</two-rows>

/** 爽约 **/
<three-rows>
	threestatusArr[threecount] = parseInt("${fld:num}");
	threestatusnum+=parseInt("${fld:num}");
	threecount++;
</three-rows>

$("#zerostatusnum").html(zerostatusnum);
$("#onestatusnum").html(onestatusnum);
$("#twostatusnum").html(twostatusnum);
$("#threestatusnum").html(threestatusnum);
teachingStatistical.legendData = ['已取消','预约中','已上课','爽约'];
teachingStatistical.seriesDataArr = [zerostatusArr, onestatusArr, twostatusArr, threestatusArr];


//同比
var tbzerostatusArr = [], tbonestatusArr = [], tbtwostatusArr = [], tbthreestatusArr = [];
var tbzerocount = 0, tbonecount = 0, tbtwocount = 0, tbthreecount = 0;
/** 同比 已取消 **/
<tb-zero-rows>
	tbzerostatusArr[tbzerocount] = parseInt("${fld:num}");
	tbzerocount++;
</tb-zero-rows>

/** 同比 预约中 **/
<tb-one-rows>
	tbonestatusArr[tbonecount] = parseInt("${fld:num}");
	tbonecount++;
</tb-one-rows>

/** 同比 已上课 **/
<tb-two-rows>
	tbtwostatusArr[tbtwocount] = parseInt("${fld:num}");
	tbtwocount++;
</tb-two-rows>

/** 同比 爽约 **/
<tb-three-rows>
	tbthreestatusArr[tbthreecount] = parseInt("${fld:num}");
	tbthreecount++;
</tb-three-rows>
if( tbzerocount > 0 && tbonecount > 0 && tbtwocount > 0 && tbthreecount > 0 ){
	teachingStatistical.legendData.push("已取消[同]");
	teachingStatistical.seriesDataArr.push(tbzerostatusArr);
	teachingStatistical.legendData.push("预约中[同]");
	teachingStatistical.seriesDataArr.push(tbonestatusArr);
	teachingStatistical.legendData.push("已上课[同]");
	teachingStatistical.seriesDataArr.push(tbtwostatusArr);
	teachingStatistical.legendData.push("爽约[同]");
	teachingStatistical.seriesDataArr.push(tbthreestatusArr);
}

//环比
var hbzerostatusArr = [], hbonestatusArr = [], hbtwostatusArr = [], hbthreestatusArr = [];
var hbzerocount = 0, hbonecount = 0, hbtwocount = 0, hbthreecount = 0;
/** 环比 已取消 **/
<hb-zero-rows>
	hbzerostatusArr[hbzerocount] = parseInt("${fld:num}");
	hbzerocount++;
</hb-zero-rows>

/** 环比 预约中 **/
<hb-one-rows>
	hbonestatusArr[hbonecount] = parseInt("${fld:num}");
	hbonecount++;
</hb-one-rows>

/** 环比 已上课 **/
<hb-two-rows>
	hbtwostatusArr[hbtwocount] = parseInt("${fld:num}");
	hbtwocount++;
</hb-two-rows>

/** 环比 爽约 **/
<hb-three-rows>
	hbthreestatusArr[hbthreecount] = parseInt("${fld:num}");
	hbthreecount++;
</hb-three-rows>
if( hbzerocount > 0 && hbonecount > 0 && hbtwocount > 0 && hbthreecount > 0 ){
	teachingStatistical.legendData.push("已取消[环]");
	teachingStatistical.seriesDataArr.push(hbzerostatusArr);
	teachingStatistical.legendData.push("预约中[环]");
	teachingStatistical.seriesDataArr.push(hbonestatusArr);
	teachingStatistical.legendData.push("已上课[环]");
	teachingStatistical.seriesDataArr.push(hbtwostatusArr);
	teachingStatistical.legendData.push("爽约[环]");
	teachingStatistical.seriesDataArr.push(hbthreestatusArr);
}


if( teachingStatistical.total > 0 ){
	initLineBarCharts("ptteachingstatisticalDiv", teachingStatistical);
}else{
	$("#ptteachingstatisticalDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
