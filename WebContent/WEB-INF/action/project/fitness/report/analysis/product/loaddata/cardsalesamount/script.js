$("#cardsalesamountDiv").html("");
var moneyone = 0, moneytwo = 0;
<cardtypefactmoney-rows>
	/** 0时效卡  1计次卡*/
	if("${fld:type}"=="0"){
		moneyone = ${fld:factmoney};
	}else if("${fld:type}"=="1"){
		moneytwo = ${fld:factmoney};
	}
</cardtypefactmoney-rows>

var typenamedata = [], typenumdata = [];
//查询每个会员卡销售金额,销售金额前五显示,其次合为其他
var count = 0, othernum=0;
<cardfactmoney-rows>
	if(count<5){
		typenamedata[count] = "${fld:name@js}";
		typenumdata[count] = {value:Number("${fld:factmoney}"),name:"${fld:name}"};
	}else{
		othernum += Number("${fld:factmoney}");
	}
	count++;
</cardfactmoney-rows>
if(count>0){
	var othercount = typenamedata.length;
	typenamedata[othercount++] = "其他";
	cardsalesamountPic.setConfig({isLegendShow: true, legendData: typenamedata});
	typenumdata[typenumdata.length++] = {value:othernum,name:"其他"};
	typenamedata[othercount++] = "次卡";
	typenamedata[othercount++] = "时效卡";
}

/** 卡类型 */
var seriesJson1 = {
	name:'卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: [0, '50%'],
	label: {
		normal: {
			position: 'inner'
		}
	},
	labelLine: {
		normal: {
			show: false
		}
	},
	data: [
	   	{value: moneytwo, name: '次卡'},
		{value: moneyone, name: '时效卡'}
	]
};
/** 会员卡类型 */
var seriesJson2 = {
	name:'会员卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: []
};
seriesJson2.data = typenumdata;

if(typenamedata.length==0&&typenumdata.length==0){
	$("#cardsalesamountDiv,#cardsalesamountDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	cardsalesamountPic.createCharts([seriesJson1, seriesJson2]);
	//列表
	/*typenumdata[typenumdata.length++] = {value: moneytwo, name: '次卡'};
	typenumdata[typenumdata.length++] = {value: moneyone, name: '时效卡'};*/
	pielist("cardsalesamount", typenumdata);
}
