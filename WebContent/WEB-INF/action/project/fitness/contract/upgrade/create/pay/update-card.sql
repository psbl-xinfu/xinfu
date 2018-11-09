UPDATE cc_card d 
SET 
	cardtype = get_arr_value(r.relatedetail, 3)
	,enddate = (CASE WHEN get_arr_value(r.relatedetail, 6) = '' THEN NULL ELSE get_arr_value(r.relatedetail, 6) END)::date
	,totalday = (CASE WHEN get_arr_value(r.relatedetail, 10) = '' THEN NULL ELSE get_arr_value(r.relatedetail, 10) END)::integer
	,giveday = (CASE WHEN get_arr_value(r.relatedetail, 11) = '' THEN NULL ELSE get_arr_value(r.relatedetail, 11) END)::integer
	,factmoney = COALESCE(r.normalmoney,0.00) + COALESCE((
		SELECT COALESCE(t2.normalmoney,0.00) FROM cc_contract t2 
		WHERE t2.code = get_arr_value(r.relatedetail, 24) AND t2.org_id = r.org_id
	),0.00)
	,count = (SELECT dt.count FROM cc_cardtype dt WHERE dt.code = get_arr_value(r.relatedetail, 3) AND dt.org_id = r.org_id)
	,nowcount = (
		SELECT dt.count - (d.count-d.nowcount) FROM cc_cardtype dt 
		WHERE dt.code = get_arr_value(r.relatedetail, 3) AND dt.org_id = r.org_id	
	)
FROM cc_contract r 
WHERE d.code = get_arr_value(r.relatedetail, 1) 
AND r.code = ${fld:contractcode} AND d.org_id = r.org_id AND d.org_id = ${def:org} 
AND d.isgoon = 0
