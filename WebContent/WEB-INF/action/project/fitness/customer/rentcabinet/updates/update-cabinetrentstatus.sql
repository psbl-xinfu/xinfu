update cc_cabinet_rent
set status = 0
where tuid::varchar = ${fld:id} and org_id = ${def:org}
