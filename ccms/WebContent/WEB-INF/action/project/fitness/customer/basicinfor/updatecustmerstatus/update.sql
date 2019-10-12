update cc_customer c set 
    mc = null
where c.code = ${fld:vc_code} and org_id = ${def:org}
and c.status = 1 
and exists (
	select 1 from cc_card d where d.customercode = c.code 
	and d.isgoon = 0 and d.status != 0 and d.status != 6 
	and d.org_id = ${def:org}
)
