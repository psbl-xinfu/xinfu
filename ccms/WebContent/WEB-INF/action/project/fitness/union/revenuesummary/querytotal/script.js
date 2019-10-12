
var incomeJson = {}, income = 0;
<rows>
incomeJson["${fld:descr}"] = "${fld:fee}";
income = parseFloat(income) + parseFloat("${fld:fee}");
</rows>

var incomeJsonHb = {}, monthincome = 0;
<hb-rows>
incomeJsonHb["${fld:descr}"] = "${fld:fee}";
monthincome = parseFloat(monthincome) + parseFloat("${fld:fee}");
</hb-rows>

/** 总营收 */
var monthincomerate = getIncreateRate(income, monthincome);
$("#income").text(Number(income).toFixed(2));
styleclass(monthincomerate, "monthincomerate");
$("#monthincomerate").text(monthincomerate + "%");

/** 会籍合同 */
var cardcontract = parseFloat(getJsonValue(incomeJson, "会籍合同", "0"));
var monthcardcontract = parseFloat(getJsonValue(incomeJsonHb, "会籍合同", "0"));
var monthcardcontractrate = getIncreateRate(cardcontract, monthcardcontract);
$("#cardcontract").text(Number(cardcontract).toFixed(2));
styleclass(monthcardcontractrate, "monthcardcontractrate");
$("#monthcardcontractrate").text(monthcardcontractrate + "%");

/** 私教合同 */
var ptcontract = parseFloat(getJsonValue(incomeJson, "私教合同", "0"));
var monthptcontract = parseFloat(getJsonValue(incomeJsonHb, "私教合同", "0"));
var monthptcontractrate = getIncreateRate(ptcontract, monthptcontract);
$("#ptcontract").text(Number(ptcontract).toFixed(2));
styleclass(monthptcontractrate, "monthptcontractrate");
$("#monthptcontractrate").text(monthptcontractrate + "%");

/** 租柜合同 */
var cabcontract = parseFloat(getJsonValue(incomeJson, "租柜合同", "0"));
var monthcabcontract = parseFloat(getJsonValue(incomeJsonHb, "租柜合同", "0"));
var monthcabcontractrate = getIncreateRate(cabcontract, monthcabcontract);
$("#cabcontract").text(Number(cabcontract).toFixed(2));
styleclass(monthcabcontractrate, "monthcabcontractrate");
$("#monthcabcontractrate").text(monthcabcontractrate + "%");

/** 会员储值 */
var cardmoney = parseFloat(getJsonValue(incomeJson, "会员储值", "0"));
var monthcardmoney = parseFloat(getJsonValue(incomeJsonHb, "会员储值", "0"));
var monthcardmoneyrate = getIncreateRate(cardmoney, monthcardmoney);
$("#cardmoney").text(Number(cardmoney).toFixed(2));
styleclass(monthcardmoneyrate, "monthcardmoneyrate");
$("#monthcardmoneyrate").text(monthcardmoneyrate + "%");

/** 商品销售 */
var goods = parseFloat(getJsonValue(incomeJson, "商品销售", "0"));
var monthgoods = parseFloat(getJsonValue(incomeJsonHb, "商品销售", "0"));
var monthgoodsrate = getIncreateRate(goods, monthgoods);
$("#goods").text(Number(goods).toFixed(2));
styleclass(monthgoodsrate, "monthgoodsrate");
$("#monthgoodsrate").text(monthgoodsrate + "%");

/** 单次消费 */
var singleitem = parseFloat(getJsonValue(incomeJson, "单次消费", "0"));
var monthsingleitem = parseFloat(getJsonValue(incomeJsonHb, "单次消费", "0"));
var monthsingleitemrate = getIncreateRate(singleitem, monthsingleitem);
$("#singleitem").text(Number(singleitem).toFixed(2));
styleclass(monthsingleitemrate, "monthsingleitemrate");
$("#monthsingleitemrate").text(monthsingleitemrate + "%");

/** 营运收入 */
var other = parseFloat(getJsonValue(incomeJson, "营运收入", "0"));
var monthother = parseFloat(getJsonValue(incomeJsonHb, "营运收入", "0"));
var monthotherrate = getIncreateRate(other, monthother);
$("#other").text(Number(other).toFixed(2));
styleclass(monthotherrate, "monthotherrate");
$("#monthotherrate").text(monthotherrate + "%");

function getIncreateRate(newFee, oldFee){
	var rate = 0;
	if( oldFee != 0 ){
		rate = (newFee - oldFee)*100.00/oldFee;
		rate = (rate > 100.00 ? 100.00 : rate);
		rate = (rate < -100.00 ? -100.00 : rate);
	}else if( oldFee == 0 && newFee > 0 ){
		rate = 100;
	}else if( newFee == 0 && oldFee > 0 ){
		rate = -100;
	}
	return Number(rate).toFixed(2);
}

function styleclass(val, id){
	if(val<0){
		$("#"+id).parent().attr("class", "down");
	}else{
		$("#"+id).parent().attr("class", "");
	}
}