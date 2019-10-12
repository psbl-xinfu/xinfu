select 1 from dual
where (select status from cc_trainplan where code = ${fld:code} and org_id = ${def:org})=2
