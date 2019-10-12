select
	card.code as vc_code,
	cust.name as vc_name,
	cust.org_id as vc_club,
	cust.code as in_bianhao,
	card.cardtype as in_vc_cardtype,
	card.totalday   as in_i_totalday,
	card.giveday  as in_i_giveday,
	card.factmoney  as in_f_factmoney,
	card.savestartdate as in_c_savestartdate,
	card.count as in_i_count,
	card.passwd as in_vc_passwd,
	card.remark as in_vc_remark,
	--card.comabr as in_vc_comabr,
	card.nowcount as in_i_nowcount,
	--card.continuecardfee as in_f_continuecardfee,
	card.contractcode as in_vc_contractcode,
	--card.liliaomoney as in_f_liliaomoney,
	card.startdate as in_c_startdate,
	card.enddate as in_c_enddate,
	card.enddate as c_enddate,
	card.enddate-'${def:date}' as shengyutianshu,
	card.remark as vc_remark,
	card.count as i_count,
	ct.type 
from cc_card card 
left join cc_cardtype ct on ct.code = card.cardtype 
left join cc_customer cust on cust.code=card.customercode
where card.org_id = ${def:org} and
(card.code=${fld:vc_code} or cust.name=${fld:vc_code} 
	or exists (
		select 1 from cc_cardcode cc where card.code = cc.cardcode 
		and cc.incode = ${fld:vc_code} and cc.status = 1
		and cc.org_id = card.org_id
	)
)
and
	card.isgoon = 0
