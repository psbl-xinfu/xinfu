select 1 from cc_guest where officename=${fld:company}  and org_id='${def:org}' and
not exists(select 1 from cc_guest where code = ${fld:cc_code} 
and org_id='${def:org}')
