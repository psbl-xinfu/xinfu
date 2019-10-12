update cc_card
set created = ${fld:datetime}::timestamp--格式为:(2018-01-01 12:12:12)
where code = ${fld:cardcode} and org_id = ${def:org} and isgoon=0