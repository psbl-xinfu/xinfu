select 
	count,
	nowcount,
	(select type from cc_cardtype where code = cc_card.cardtype and org_id = ${def:org}) as type
from cc_card
where isgoon = 0 and org_id = ${def:org} and code = ${fld:cardcode}