select 1 from cc_savestopcard
where org_id = ${def:org}
and code = ${fld:code} and status!=1