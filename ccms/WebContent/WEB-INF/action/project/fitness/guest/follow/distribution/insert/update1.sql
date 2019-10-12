update cc_public
set status = 1
where customercode = ${fld:customercode}
and org_id = ${def:org}
and (select status from cc_public where customercode = ${fld:customercode} order by grabtime desc limit 1)
=0