select 
	startdate,
	enddate,
	nowcount,
	(select name from cc_cardtype where code = cardtype and cc_cardtype.org_id = ${def:org}) as name,
	customercode
from cc_card
where code = ${fld:code}
and org_id = ${def:org}