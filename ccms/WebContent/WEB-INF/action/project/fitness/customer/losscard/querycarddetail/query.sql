select 
	startdate,
	enddate,
	nowcount,
	(select type from cc_cardtype where code = cc_card.cardtype and org_id = ${def:org}) as cardtype
from cc_card
where code = ${fld:code}
and org_id = ${def:org} and isgoon=0