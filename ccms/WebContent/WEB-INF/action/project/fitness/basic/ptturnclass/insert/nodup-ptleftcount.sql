select 1 from cc_ptrest
where code = ${fld:ptrestcode} and ptleftcount<${fld:ptclasscount}
and org_id = ${def:org}