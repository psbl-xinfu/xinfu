UPDATE cc_card 
SET 
	nowcount = (nowcount-${fld:nowcount}) 
WHERE code = ${fld:cardcode} AND isgoon = 0
and org_id = ${fld:unionorgid}
and exists(
	select 1 from cc_cardtype where org_id = ${fld:unionorgid}
	and code = cardtype
	and type = 1
)

