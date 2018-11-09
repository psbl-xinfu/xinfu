 and 0 = (
	select pc.status from cc_public pc 
	where pc.guestcode = g.code and pc.org_id = g.org_id 
	order by pc.entertime desc limit 1
)
