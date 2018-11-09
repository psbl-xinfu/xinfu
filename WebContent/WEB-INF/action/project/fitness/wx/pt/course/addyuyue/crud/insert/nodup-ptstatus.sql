select 1 from cc_ptrest
where org_id = ${def:org} and code = ${fld:ptrestcode}
and ptenddate::date<'${def:date}'::date