 and exists(
	select 1 from cc_mcchange m 
	where m.guestcode = g.code and m.org_id = g.org_id 
	and to_char(m.created, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM') 
	and m.status = 1
)
