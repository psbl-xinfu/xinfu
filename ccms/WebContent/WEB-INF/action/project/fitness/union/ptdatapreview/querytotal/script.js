/** 综合成交率 = 成交人数/体验课人数 */
var rate = (parseFloat("${fld:ratefinishnum}")/parseFloat("0" == "${fld:ratevisitnum}" ? "1" : "${fld:ratevisitnum}")*100).toFixed(2);	/** 成交率 */
var yearrate = (parseFloat("${fld:yearratefinishnum}")/parseFloat("0" == "${fld:yearratevisitnum}" ? "1" : "${fld:yearratevisitnum}")*100).toFixed(2);	/** 同比 */
var monthrate = (parseFloat("${fld:monthratefinishnum}")/parseFloat("0" == "${fld:monthratevisitnum}" ? "1" : "${fld:monthratevisitnum}")*100).toFixed(2);	/** 环比 */
styleclass(rate, "rate");
styleclass(yearrate, "yearrate");
styleclass(monthrate, "monthrate");
judgePercentage("rate", rate);
judgePercentage("yearrate", yearrate);
judgePercentage("monthrate", monthrate);

/** 成交均价 */
var avgfee = parseFloat("${fld:avgfee}").toFixed(2);	/** 成交均价 */
var yearavgfee = parseFloat("${fld:yearavgfee}").toFixed(2);	/** 同比 */
var monthavgfee = parseFloat("${fld:monthavgfee}").toFixed(2);	/** 环比 */
$("#avgfee").text(Number(avgfee).toFixed(2));
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

/** POS接待率 = 成交总人数/体验课总人数 */
var pos = (parseFloat(newcust)/parseFloat(0 == experNum ? 1 : experNum)*100).toFixed(2);
var yearpos = (parseFloat(yearnewcust)/parseFloat(0 == yearexperNum ? 1 : yearexperNum)*100).toFixed(2);
var monthpos = (parseFloat(monthnewcust)/parseFloat(0 == monthexperNum ? 1 : monthexperNum)*100).toFixed(2);
styleclass(pos, "pos");
styleclass(yearpos, "yearpos");
styleclass(monthpos, "monthpos");
judgePercentage("pos", pos);
judgePercentage("yearpos", yearpos);
judgePercentage("monthpos", monthpos);

/** P1成交率 = P1成交人数/P1人数 */
var p1 = (parseFloat(p1CustNum)/parseFloat(0 == p1Num ? 1 : p1Num)*100).toFixed(2);
var yearp1 = (parseFloat(yearp1CustNum)/parseFloat(0 == yearp1Num ? 1 : yearp1Num)*100).toFixed(2);
var monthp1 = (parseFloat(monthp1CustNum)/parseFloat(0 == monthp1Num ? 1 : monthp1Num)*100).toFixed(2);
styleclass(p1, "p1");
styleclass(yearp1, "yearp1");
styleclass(monthp1, "monthp1");
judgePercentage("p1", p1);
judgePercentage("yearp1", yearp1);
judgePercentage("monthp1", monthp1);

/** P2成交率 = P2成交人数/P2人数 */
var p2 = (parseFloat(p2CustNum)/parseFloat(0 == p2Num ? 1 : p2Num)*100).toFixed(2);
var yearp2 = (parseFloat(yearp2CustNum)/parseFloat(0 == yearp2Num ? 1 : yearp2Num)*100).toFixed(2);
var monthp2 = (parseFloat(monthp2CustNum)/parseFloat(0 == monthp2Num ? 1 : monthp2Num)*100).toFixed(2);
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
var gdpos = Number((parseInt("${fld:cknum}")*100)/(0 == ckzongnum ? 1 : ckzongnum)).toFixed(2);	/** 场开成交率 */
var yeargdpos = Number((parseInt("${fld:ckyearnum}")*100)/(0 == ckyearzongnum ? 1 : ckyearzongnum)).toFixed(2);	/** 同比 */
var monthgdpos = Number((parseInt("${fld:ckmonthnum}")*100)/(0 == ckmonthzongnum ? 1 : ckmonthzongnum)).toFixed(2);	/** 环比 */
styleclass(gdpos, "gdpos");
styleclass(yeargdpos, "yeargdpos");
styleclass(monthgdpos, "monthgdpos");
judgePercentage("gdpos", gdpos);
judgePercentage("yeargdpos", yeargdpos);
judgePercentage("monthgdpos", monthgdpos);

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