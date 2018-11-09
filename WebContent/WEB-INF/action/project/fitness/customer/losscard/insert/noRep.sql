select 1 from cc_card
where org_id = ${def:org} and isgoon != 1 and code = ${fld:cardcode}
and status not in (1, 2)