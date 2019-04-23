/** 首节课续费率 */
var fCustNum = 0;	/** 首次课总数 */
var cttnCustNum = 0;	/** 首次课续费数 */
var cttnRate = 0;	/** 首节课续费率 = 首次课续费数/首次课总数 */
var cttndataArr = [];

cttnCharts.total = 0;
cttnCharts.xdataArr = [], cttnCharts.seriesDataArr = [];

var fcustJson = {};
<cust-rows>
fcustJson["${fld:createdate}"] = parseInt("${fld:num}");
</cust-rows>

<cttn-rows>
cttnCharts.xdataArr[cttnCharts.total] = "${fld:createdate}";
fCustNum = fcustJson["${fld:createdate}"];
cttnCustNum = parseInt("${fld:num}");
cttnRate = (parseFloat(cttnCustNum)*100.00/parseFloat(fCustNum == 0 ? 1 : fCustNum)).toFixed(0);
cttndataArr[cttnCharts.total] = cttnRate;
cttnCharts.total++;
</cttn-rows>
cttnCharts.seriesDataArr = [cttndataArr];

if( feeCharts.total > 0 ){
	initLineBarCharts("cttnDiv", cttnCharts);
}
