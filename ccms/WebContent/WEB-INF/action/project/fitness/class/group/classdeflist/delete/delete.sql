delete from cc_classlist
where code = ${fld:code} and org_id= ${def:org}
and status !=1

