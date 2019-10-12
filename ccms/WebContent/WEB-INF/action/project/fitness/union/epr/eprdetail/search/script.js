	

var sum_money = 0;	// 总收入 = 销售金额 + 私教业绩 + 营运收入 + 零售收入
if( "" != "${fld:sale_money}" && isFloat("${fld:sale_money}") ){	// 销售金额
	sum_money = parseFloat(sum_money) + parseFloat("${fld:sale_money}");
}
if( "" != "${fld:pt_money}" && isFloat("${fld:pt_money}") ){	// 私教业绩
	sum_money = parseFloat(sum_money) + parseFloat("${fld:pt_money}");
}
if( "" != "${fld:yyincome_money}" && isFloat("${fld:yyincome_money}") ){	// 营运收入
	sum_money = parseFloat(sum_money) + parseFloat("${fld:yyincome_money}");
}
if( "" != "${fld:goods_money}" && isFloat("${fld:goods_money}") ){	// 零售收入
	sum_money = parseFloat(sum_money) + parseFloat("${fld:goods_money}");
}
var str = '<tr>';
	str += '<td class="text-center" nowrap>${fld:org_name}</td>';	// 总收入
	str += '<td class="text-center" nowrap>' + sum_money + '</td>';	// 总收入
	str += '<td class="text-center" nowrap>'+conversion('${fld:sale_money}')+'</td>';	// 销售金额
	str += '<td class="text-center" nowrap>'+conversion('${fld:sale_num}')+'</td>';	// 销售总订单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:newcust_num}')+'</td>';	// 新入会单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:upgrade_num}')+'</td>';	// 升级单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:ctn_num}')+'</td>';	// 续约单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:sale_deposit_money}')+'</td>';	// 销售定金金额
	str += '<td class="text-center" nowrap>'+conversion('${fld:sale_deposit_num}')+'</td>';	// 销售定金单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:visit_num}')+'</td>';	// 访客总数
	str += '<td class="text-center" nowrap>'+conversion('${fld:prepare_visit_num}')+'</td>';	// 预约总数
	str += '<td class="text-center" nowrap>'+conversion('${fld:prepare_success_num}')+'</td>';	// 预约出现数
	str += '<td class="text-center" nowrap>'+conversion('${fld:wi}')+'</td>';	// WI 访客
	str += '<td class="text-center" nowrap>'+conversion('${fld:di}')+'</td>';	// DI
	str += '<td class="text-center" nowrap>'+conversion('${fld:br}')+'</td>';	// BR 会员介绍
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_money}')+'</td>';	// 私教业绩
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_pos_money}')+'</td>';	// POS业绩
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_pos_num}')+'</td>';	// POS单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:ptnew_money}')+'</td>';	// 新单业绩
	str += '<td class="text-center" nowrap>'+conversion('${fld:ptnew_num}')+'</td>';	// 新单单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_ctn_money}')+'</td>';	// 续课业绩
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_ctn_num}')+'</td>';	// 续课单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:pi_prepare_num}')+'</td>';	// P1预约人数
	str += '<td class="text-center" nowrap>'+conversion('${fld:pi_prepare_success_num}')+'</td>';	// P1出现人数
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_prepare_num}')+'</td>';	// 私教课预约数
	str += '<td class="text-center" nowrap>'+conversion('${fld:pt_prepare_success_num}')+'</td>';	// 私教课出现数
	str += '<td class="text-center" nowrap>'+conversion('${fld:cust_inleft_num}')+'</td>';	// 会员入场数
	str += '<td class="text-center" nowrap>'+conversion('${fld:class_num}')+'</td>';	// 团操上课人数
	str += '<td class="text-center" nowrap>'+conversion('${fld:br_num}')+'</td>';	// BR名单数
	str += '<td class="text-center" nowrap>'+conversion('${fld:yyincome_money}')+'</td>';	// 营运收入(指一些停卡，转卡，转店，補卡，等非会籍非私教非零售的收入)
	str += '<td class="text-center" nowrap>'+conversion('${fld:goods_money}')+'</td>';	// 零售收入(商品销售、单次消费、场地租用)
	str += '</tr>';

$("#datagrid").append(str);

//空字符替换为0
function conversion(val){
	if(val==""){
		return "0";
	}else{
		return val;
	}
}
