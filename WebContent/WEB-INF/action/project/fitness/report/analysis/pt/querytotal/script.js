/** 综合成交率 = 成交人数/体验课人数 */
var rate = ("0" == "${fld:ratevisitnum}" ? 0 : parseFloat("${fld:ratefinishnum}")/parseFloat("${fld:ratevisitnum}")*100).toFixed(2);	/** 成交率 */
var yearrate = ("0" == "${fld:yearratevisitnum}" ? 0 : parseFloat("${fld:yearratefinishnum}")/parseFloat("${fld:yearratevisitnum}")*100).toFixed(2);	/** 同比 */
var monthrate = ("0" == "${fld:monthratevisitnum}" ? 0 : parseFloat("${fld:monthratefinishnum}")/parseFloat("${fld:monthratevisitnum}")*100).toFixed(2);	/** 环比 */
styleclass(rate, "rate");
styleclass(yearrate, "yearrate");
styleclass(monthrate, "monthrate");
judgePercentage("rate", rate);
judgePercentage("yearrate", yearrate);
judgePercentage("monthrate", monthrate);

/** POS接待率 = POS教练接待并成交数/办卡人数 */
var posreception = ("0" == "${fld:posnum}" ? 0 : parseFloat("${fld:cardnum}")/parseFloat("${fld:posnum}")*100).toFixed(2);	/** 成交率 */
var yearposreception = ("0" == "${fld:yearposnum}" ? 0 : parseFloat("${fld:yearcardnum}")/parseFloat("${fld:yearposnum}")*100).toFixed(2);	/** 同比 */
var monthposreception = ("0" == "${fld:monthposnum}" ? 0 : parseFloat("${fld:monthcardnum}")/parseFloat("${fld:monthposnum}")*100).toFixed(2);	/** 环比 */
styleclass(posreception, "posreception");
styleclass(yearposreception, "yearposreception");
styleclass(monthposreception, "monthposreception");
judgePercentage("posreception", posreception);
judgePercentage("yearposreception", yearposreception);
judgePercentage("monthposreception", monthposreception);

/** 成交均价 */
var avgfee = parseFloat("${fld:avgfee}").toFixed(2);	/** 成交均价 */
var yearavgfee = parseFloat("${fld:yearavgfee}").toFixed(2);	/** 同比 */
var monthavgfee = parseFloat("${fld:monthavgfee}").toFixed(2);	/** 环比 */
$("#avgfee").text(avgfee);
styleclass(yearavgfee, "yearavgfee");
styleclass(monthavgfee, "monthavgfee");
judgePercentage("yearavgfee", yearavgfee);
judgePercentage("monthavgfee", monthavgfee);

/** 新会员量 */
var newcust = parseInt("${fld:newcust}");	/** 新会员量 成交总人数 */
var yearnewcust = parseInt("${fld:yearnewcust}");	/** 同比 */
var monthnewcust = parseInt("${fld:monthnewcust}");	/** 环比 */

var p1CustNum = parseFloat("${fld:p1custnum}"), yearp1CustNum = parseFloat("${fld:yearp1custnum}"), monthp1CustNum = parseFloat("${fld:monthp1custnum}");	/** P1成交人数 */
var p2CustNum = parseFloat("${fld:p2custnum}"), yearp2CustNum = parseFloat("${fld:yearp2custnum}"), monthp2CustNum = parseFloat("${fld:monthp2custnum}");	/** P2成交人数 */
var p1Num = parseFloat("${fld:p1num}"), yearp1Num = parseFloat("${fld:yearp1num}"), monthp1Num = parseFloat("${fld:monthp1num}");	/** P1人数 */
var p2Num = parseFloat("${fld:p2num}"), yearp2Num = parseFloat("${fld:yearp2num}"), monthp2Num = parseFloat("${fld:monthp2num}");	/** P2人数 */
var experNum = parseInt("${fld:expernum}"), yearexperNum = parseInt("${fld:yearexpernum}"), monthexperNum = parseInt("${fld:monthexpernum}");	/** 体验课总人数 */

/** pos成交率=自定义时间段内当天购卡并且当天买私教人数/自定义时间段内办卡总量 */
var pos = 0 == experNum ? 0 : (parseFloat(newcust)/parseFloat(experNum)*100).toFixed(2);
var yearpos = 0 == yearexperNum ? 0 : (parseFloat(yearnewcust)/parseFloat(yearexperNum)*100).toFixed(2);
var monthpos = 0 == monthexperNum ? 0 : (parseFloat(monthnewcust)/parseFloat(monthexperNum)*100).toFixed(2);
styleclass(pos, "pos");
styleclass(yearpos, "yearpos");
styleclass(monthpos, "monthpos");
judgePercentage("pos", pos);
judgePercentage("yearpos", yearpos);
judgePercentage("monthpos", monthpos);

/** P1成交率 = P1成交人数/P1人数 */
var p1 = 0 == p1Num ? 0 : (parseFloat(p1CustNum)/parseFloat(p1Num)*100).toFixed(2);
var yearp1 = 0 == yearp1Num ? 0 : (parseFloat(yearp1CustNum)/parseFloat(yearp1Num)*100).toFixed(2);
var monthp1 = 0 == monthp1Num ? 0 : (parseFloat(monthp1CustNum)/parseFloat(monthp1Num)*100).toFixed(2);
styleclass(p1, "p1");
styleclass(yearp1, "yearp1");
styleclass(monthp1, "monthp1");
judgePercentage("p1", p1);
judgePercentage("yearp1", yearp1);
judgePercentage("monthp1", monthp1);

/** P2成交率 = P2成交人数/P2人数 */
var p2 = (0 == p2Num ? 0 : parseFloat(p2CustNum)/parseFloat(p2Num)*100).toFixed(2);
var yearp2 = (0 == yearp2Num ? 0 : parseFloat(yearp2CustNum)/parseFloat(yearp2Num)*100).toFixed(2);
var monthp2 = (0 == monthp2Num ? 0 : parseFloat(monthp2CustNum)/parseFloat(monthp2Num)*100).toFixed(2);
styleclass(p2, "p2");
styleclass(yearp2, "yearp2");
styleclass(monthp2, "monthp2");
judgePercentage("p2", p2);
judgePercentage("yearp2", yearp2);
judgePercentage("monthp2", monthp2);


var ckzongnum = parseInt("${fld:ckzongnum}");
var ckyearzongnum = parseInt("${fld:ckyearzongnum}");
var ckmonthzongnum = parseInt("${fld:ckmonthzongnum}");
/** 场开成交率 */
var gdpos = Number(0 == ckzongnum ? 0 : (parseInt("${fld:cknum}")*100)/(ckzongnum)).toFixed(2);	/** 场开成交率 */
var yeargdpos = Number(0 == ckyearzongnum ? 0 : (parseInt("${fld:ckyearnum}")*100)/(ckyearzongnum)).toFixed(2);	/** 同比 */
var monthgdpos = Number(0 == ckmonthzongnum ? 0 : (parseInt("${fld:ckmonthnum}")*100)/(ckmonthzongnum)).toFixed(2);	/** 环比 */
styleclass(gdpos, "gdpos");
styleclass(yeargdpos, "yeargdpos");
styleclass(monthgdpos, "monthgdpos");
judgePercentage("gdpos", gdpos);
judgePercentage("yeargdpos", yeargdpos);
judgePercentage("monthgdpos", monthgdpos);

/** 首次课续费率 */
var cttnrate = ("0" == "${fld:cttnnum}" ? 0 : parseFloat("${fld:iscttn}")/parseFloat("${fld:cttnnum}")*100).toFixed(2);	
var yearcttnrate = ("0" == "${fld:yearcttnnum}" ? 0 : parseFloat("${fld:yeariscttn}")/parseFloat("${fld:yearcttnnum}")*100).toFixed(2);	/** 同比 */
var monthcttnrate = ("0" == "${fld:monthcttnnum}" ? 0 : parseFloat("${fld:monthiscttn}")/parseFloat("${fld:monthcttnnum}")*100).toFixed(2);	/** 环比 */
styleclass(cttnrate, "cttnrate");
styleclass(yearcttnrate, "yearcttnrate");
styleclass(monthcttnrate, "monthcttnrate");
judgePercentage("cttnrate", cttnrate);
judgePercentage("yearcttnrate", yearcttnrate);
judgePercentage("monthcttnrate", monthcttnrate);

/** 综合业绩 */
/** 业绩 = 新会员量×POS接待率×综合成交率×成交价/新会员 */
var total = (parseFloat(newcust)*parseFloat(pos/100)*parseFloat(rate/100)*parseFloat(avgfee)).toFixed(2);
var yeartotal = (parseFloat(yearnewcust)*parseFloat(yearpos/100)*parseFloat(yearrate/100)*parseFloat(yearavgfee)).toFixed(2);
var monthtotal = (parseFloat(monthnewcust)*parseFloat(monthpos/100)*parseFloat(monthrate/100)*parseFloat(monthavgfee)).toFixed(2);
$("#total").text(total);
yeartotal = 0 == total ? 0 : (yeartotal-total)*100/(total);
monthtotal = 0 == total ? 0 : (monthtotal-total)*100/(total);
styleclass(yeartotal, "yeartotal");
styleclass(monthtotal, "monthtotal");
judgePercentage("yeartotal", yeartotal);
judgePercentage("monthtotal", monthtotal);

var haokelv = Number("${fld:haokelv}");
var yearhaokelv = Number("${fld:yearhaokelv}");
var monthhaokelv = Number("${fld:monthhaokelv}");
var totalnum = Number("${fld:totalnum}");
var val = 0 == totalnum ? 0 : (haokelv*100)/(totalnum);
styleclass(val, "haokelv");
judgePercentage("haokelv", val);

var val = 0 == haokelv ? 0 : ((yearhaokelv-haokelv)*100)/(haokelv);
styleclass(val, "yearhaokelv");
judgePercentage("yearhaokelv", val);
var val1 = 0 == haokelv ? 0 : ((monthhaokelv-haokelv)*100)/(haokelv);
styleclass(val1, "monthhaokelv");
judgePercentage("monthhaokelv", val1);


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