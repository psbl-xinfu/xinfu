$("#cardsalesDiv").html("");
var cardtypeone = 0, cardtypetwo = 0;
<cardtypecount-rows>
	/** 0时效卡  1计次卡*/
	if("${fld:type}"=="0"){
		cardtypeone = ${fld:num};
	}else if("${fld:type}"=="1"){
		cardtypetwo = ${fld:num};
	}
</cardtypecount-rows>

var typenamedata = [], typenumdata = [];
//查询每个会员卡销售数量,销售量前五显示,其次合为其他
var count = 0, othernum=0;
<cardcount-rows>
	if(count<5){
		typenamedata[count] = "${fld:name@js}";
		typenumdata[count] = {value:"${fld:num}",name:"${fld:name}"};
	}else{
		othernum += parseInt("${fld:num}");
	}
	count++;
</cardcount-rows>
if(count>0){
	var othercount = typenamedata.length;
	typenamedata[othercount++] = "其他";
	cardsalesPic.setConfig({isLegendShow: true, legendData: typenamedata});
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
	   	{value: cardtypetwo, name: '次卡'},
		{value: cardtypeone, name: '时效卡'}
	]
};

/** 会员卡类型 */
var seriesJson2 = {
	name:'会员卡类型',
	type:'pie',
	selectedMode: 'single',
	radius: ['60%', '75%'],
	data: [
	       
	]
};
seriesJson2.data = typenumdata;
if(typenamedata.length==0&&typenumdata.length==0){
	$("#cardsalesDiv,#cardsalesDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	cardsalesPic.createCharts([seriesJson1, seriesJson2]);
	//列表
	/*typenumdata[typenumdata.length++] = {value: cardtypetwo, name: '次卡'};
	typenumdata[typenumdata.length++] = {value: cardtypeone, name: '时效卡'};*/
	pielist("cardsales", typenumdata);
}
