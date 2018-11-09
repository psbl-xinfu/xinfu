UPDATE cc_customer c 
	set mc = COALESCE(get_arr_value(t.relatedetail,27), c.mc) 
FROM cc_contract t 
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} 
AND t.customercode = c.code AND t.org_id = c.org_id 
