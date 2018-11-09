select 1 from cc_card
where isgoon = 0 and org_id = ${def:org}
and code = ${fld:cardcode} and status!=1