update cc_finance
set created = ${fld:datetime}::timestamp--格式为:(2018-01-01 12:12:12)
where cardcode = ${fld:cardcode} and org_id = ${def:org}