 and
	(select count(1) from cc_mcchange m 
	where m.guestcode = g.code and m.org_id = g.org_id)<${fld:f_distributioncount}::int
