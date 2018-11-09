 and
	(select count(1) from cc_ptchange m 
	where m.customercode = c.code and m.org_id = c.org_id)<${fld:f_distributioncount}::int
