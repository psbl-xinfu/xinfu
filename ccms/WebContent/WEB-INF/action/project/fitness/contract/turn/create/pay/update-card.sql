UPDATE cc_card d 
SET 
	customercode = (case when r.customercode is null 
			then concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) else 
			r.customercode
			end)
FROM cc_contract r 
WHERE r.code = ${fld:contractcode} AND d.code = get_arr_value(r.relatedetail, 1) 
AND d.org_id = r.org_id AND d.org_id = ${def:org} AND d.isgoon = 0 
