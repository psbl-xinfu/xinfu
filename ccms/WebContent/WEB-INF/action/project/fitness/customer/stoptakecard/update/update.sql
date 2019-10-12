update cc_savestopcard
set status = 1,
collectby = '${def:user}',
collecttime={ts'${def:timestamp}'}
where code = ${fld:vc_code} and org_id = ${def:org}