select 1 from cc_guest g where g.officename=${fld:company}  and g.org_id='${def:org}' and
not exists(select 1 from cc_guest where code = ${fld:cc_code} and g.code=code
and org_id='${def:org}')
