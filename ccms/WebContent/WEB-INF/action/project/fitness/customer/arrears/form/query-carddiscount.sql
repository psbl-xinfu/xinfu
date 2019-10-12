select 
	(select name from cc_cardtype where code = card.cardtype and org_id = card.org_id) as name,
	(case when (select discount from cc_cardtype_storage_discount where cardtype=
		(select code from cc_cardtype where code = card.cardtype and org_id = card.org_id)
		and org_id = card.org_id limit 1) is null then 1 else (select discount from cc_cardtype_storage_discount where cardtype=
		(select code from cc_cardtype where code = card.cardtype and org_id = card.org_id)
		and org_id = card.org_id limit 1) end) as discount
from
	cc_card card
where card.isgoon = 0 and status = 1 and org_id = ${def:org}
and card.customercode = ${fld:custcode} and card.code=${fld:cardcode}