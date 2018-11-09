select
	loss.code,
	loss.cardcode,
	loss.customercode,
	cust.name,
	cust.mobile,
	(select name from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardtype,
	(select type from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardstatus,
	loss.cardstartdate,
	loss.cardenddate,
	card.nowcount,
	loss.remark,
	cust.moneycash,
	cust.moneygift
from
	cc_losscard loss
left join cc_customer cust on cust.code = loss.customercode and loss.org_id = cust.org_id
left join cc_card card on loss.cardcode = card.code and loss.org_id = card.org_id
where
	loss.code=${fld:id} and loss.org_id = ${def:org}
