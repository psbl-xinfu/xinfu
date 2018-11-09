select 1 from cc_card
where code = ${fld:cardcode} and org_id = ${fld:unionorgid}
and nowcount<${fld:nowcount}
and exists(
	select 1 from cc_cardtype where org_id = ${fld:unionorgid}
	and code = cardtype
	and type = 1
)
