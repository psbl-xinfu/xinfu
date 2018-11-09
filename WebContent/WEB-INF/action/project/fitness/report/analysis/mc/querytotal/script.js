/** 到访量 */
var visitnum = parseInt("${fld:visitnum}");	/** 到访量 */
var yearvisitnum = parseInt("${fld:yearvisitnum}");	/** 同比 */
var monthvisitnum = parseInt("${fld:monthvisitnum}");	/** 环比 */
$("#visitnum").text(visitnum);
yearvisitnum = (yearvisitnum-visitnum)*100/(0 == visitnum ? 1 : visitnum);
monthvisitnum = (monthvisitnum-visitnum)*100/(0 == visitnum ? 1 : visitnum);
styleclass(yearvisitnum, "yearvisitnum");
styleclass(monthvisitnum, "monthvisitnum");
judgePercentage("yearvisitnum", yearvisitnum);
judgePercentage("monthvisitnum", monthvisitnum);

/** 平均量 */
var daynum = datedifference("${fld:tdate}", "${fld:fdate}")+1;
var visitnum = parseInt("${fld:visitnum}");	/** 到访量 */
var yearvisitnum = parseInt("${fld:yearvisitnum}");	/** 同比 */
var monthvisitnum = parseInt("${fld:monthvisitnum}");	/** 环比 */
$("#averagevisitnum").text(Math.ceil(visitnum/daynum));
yearvisitnum = (Math.ceil(yearvisitnum/daynum)-Math.ceil(visitnum/daynum))*100/(0 == Math.ceil(visitnum/daynum) ? 1 : Math.ceil(visitnum/daynum));
monthvisitnum = (Math.ceil(monthvisitnum/daynum)-Math.ceil(visitnum/daynum))*100/(0 == Math.ceil(visitnum/daynum) ? 1 : Math.ceil(visitnum/daynum));
styleclass(yearvisitnum, "yearaveragevisitnum");
styleclass(monthvisitnum, "monthaveragevisitnum");
judgePercentage("yearaveragevisitnum", yearvisitnum);
judgePercentage("monthaveragevisitnum", monthvisitnum);

/** 预约到访量 */
var yyvisitnum = parseInt("${fld:yynum}");	/** 到访量 */
var yearyyvisitnum = parseInt("${fld:yearyynum}");	/** 同比 */
var monthyyvisitnum = parseInt("${fld:monthyynum}");	/** 环比 */
$("#yyvisitnum").text(yyvisitnum);
yearyyvisitnum = (yearyyvisitnum-yyvisitnum)*100/(0 == yyvisitnum ? 1 : yyvisitnum);
monthyyvisitnum = (monthyyvisitnum-yyvisitnum)*100/(0 == yyvisitnum ? 1 : yyvisitnum);
styleclass(yearyyvisitnum, "yearyyvisitnum");
styleclass(monthyyvisitnum, "monthyyvisitnum");
judgePercentage("yearyyvisitnum", yearyyvisitnum);
judgePercentage("monthyyvisitnum", monthyyvisitnum);

/** 陌生到访量 */
var msvisitnum = parseInt("${fld:msnum}");	/** 到访量 */
var yearmsvisitnum = parseInt("${fld:yearmsnum}");	/** 同比 */
var monthmsvisitnum = parseInt("${fld:monthmsnum}");	/** 环比 */
$("#msvisitnum").text(msvisitnum);
yearmsvisitnum = (yearmsvisitnum-msvisitnum)*100/(0 == msvisitnum ? 1 : msvisitnum);
monthmsvisitnum = (monthmsvisitnum-msvisitnum)*100/(0 == msvisitnum ? 1 : msvisitnum);
styleclass(yearmsvisitnum, "yearmsvisitnum");
styleclass(monthmsvisitnum, "monthmsvisitnum");
judgePercentage("yearmsvisitnum", yearmsvisitnum);
judgePercentage("monthmsvisitnum", monthmsvisitnum);

/** 成交率 */
var rate = ("0" == "${fld:ratevisitnum}" ? 0 : parseFloat("${fld:ratefinishnum}")/parseFloat("${fld:ratevisitnum}")*100).toFixed(2);	/** 成交率 */
var yearrate = ("0" == "${fld:yearratevisitnum}" ? 0 : parseFloat("${fld:yearratefinishnum}")/parseFloat("${fld:yearratevisitnum}")*100).toFixed(2);	/** 同比 */
var monthrate = ("0" == "${fld:monthratevisitnum}" ? 0 : parseFloat("${fld:monthratefinishnum}")/parseFloat("${fld:monthratevisitnum}")*100).toFixed(2);	/** 环比 */
styleclass(rate, "rate");
styleclass(yearrate, "yearrate");
styleclass(monthrate, "monthrate");
judgePercentage("rate", rate);
judgePercentage("yearrate", yearrate);
judgePercentage("monthrate", monthrate);

/** 预约成交率 */
var yyrate = ("0" == "${fld:yyratevisitnum}" ? 0 : parseFloat("${fld:ratefinishnum}")/parseFloat("${fld:yyratevisitnum}")*100).toFixed(2);	/** 成交率 */
var yearyyrate = ("0" == "${fld:yearyyratevisitnum}" ? 0 : parseFloat("${fld:yearratefinishnum}")/parseFloat("${fld:yearyyratevisitnum}")*100).toFixed(2);	/** 同比 */
var monthyyrate = ("0" == "${fld:monthyyratevisitnum}" ? 0 : parseFloat("${fld:monthratefinishnum}")/parseFloat("${fld:monthyyratevisitnum}")*100).toFixed(2);	/** 环比 */
styleclass(yyrate, "yyrate");
styleclass(yearyyrate, "yearyyrate");
styleclass(monthyyrate, "monthyyrate");
judgePercentage("yyrate", yyrate);
judgePercentage("yearyyrate", yearyyrate);
judgePercentage("monthyyrate", monthyyrate);

/** 陌生成交率 */
var msrate = ("0" == "${fld:msratevisitnum}" ? 0 : parseFloat("${fld:ratefinishnum}")/parseFloat("${fld:msratevisitnum}")*100).toFixed(2);	/** 成交率 */
var yearmsrate = ("0" == "${fld:yearmsratevisitnum}" ? 0 : parseFloat("${fld:yearratefinishnum}")/parseFloat("${fld:yearmsratevisitnum}")*100).toFixed(2);	/** 同比 */
var monthmsrate = ("0" == "${fld:monthmsratevisitnum}" ? 0 : parseFloat("${fld:monthratefinishnum}")/parseFloat("${fld:monthmsratevisitnum}")*100).toFixed(2);	/** 环比 */
styleclass(msrate, "msrate");
styleclass(yearmsrate, "yearmsrate");
styleclass(monthmsrate, "monthmsrate");
judgePercentage("msrate", msrate);
judgePercentage("yearmsrate", yearmsrate);
judgePercentage("monthmsrate", monthmsrate);

/** 产品均价 */
var avgfee = parseFloat("${fld:avgfee}").toFixed(2);	/** 产品均价 */
var yearavgfee = parseFloat("${fld:yearavgfee}").toFixed(2);	/** 同比 */
var monthavgfee = parseFloat("${fld:monthavgfee}").toFixed(2);	/** 环比 */
$("#avgfee").text(avgfee);
yearavgfee = (yearavgfee-avgfee)*100/(0 == avgfee ? 1 : avgfee);
monthavgfee = (monthavgfee-avgfee)*100/(0 == avgfee ? 1 : avgfee);
styleclass(yearavgfee, "yearavgfee");
styleclass(monthavgfee, "monthavgfee");
judgePercentage("yearavgfee", yearavgfee);
judgePercentage("monthavgfee", monthavgfee);

/** 综合业绩 */
/** 业绩 = 到访量×成交率×产品均价× */
var total = 0, yeartotal = 0, monthtotal = 0;
if(visitnum==0&&rate==0&&avgfee==0){
	total = 0;
}else{
	total = (0 == avgfee ? 0 : parseFloat(visitnum)*parseFloat(rate/100)*parseFloat(avgfee)).toFixed(2);
}
if(yearvisitnum==0&&yearrate==0&&yearavgfee==0){
	yeartotal = 0;
}else{
	yeartotal = (0 == yearavgfee ? 0 : parseFloat(yearvisitnum)*parseFloat(yearrate/100)*parseFloat(yearavgfee)).toFixed(2);
}
if(monthvisitnum==0&&monthrate==0&&monthavgfee==0){
	monthtotal = 0;
}else{
	monthtotal = (0 == monthavgfee ? 0 : parseFloat(monthvisitnum)*parseFloat(monthrate/100)*parseFloat(monthavgfee)).toFixed(2);
}
$("#total").text(total);
yeartotal = 0 == total ? 0 : ((yeartotal-total)*100/total);
monthtotal = 0 == total ? 0 : ((monthtotal-total)*100/total);
styleclass(yeartotal, "yeartotal");
styleclass(monthtotal, "monthtotal");
judgePercentage("yeartotal", yeartotal);
judgePercentage("monthtotal", monthtotal);

function styleclass(val, id){
	if(val<0){
		$("#"+id).parent().attr("class", "down");
	}else{
		$("#"+id).parent().attr("class", "");
	}
}

function judgePercentage(id, percentage){
	if(percentage>100){percentage = 100;}
	if(percentage<-100){percentage = -100;}
	$("#"+id).text(Number(percentage).toFixed(2)+"%");
}