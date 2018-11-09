update cc_customer
set mc = ${fld:mc}
where code = ${fld:customercode}
and org_id = ${def:org}
and (select status from cc_public where customercode = ${fld:customercode} order by grabtime desc limit 1)
=0