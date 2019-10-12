 AND to_char(con.createdate, 'yyyyMM')::integer < replace(${fld:daochu_month_date},'-','')::integer 
AND to_char(con.createdate + concat(con.stage_times-1, ' month')::interval,'yyyy-MM-01')::date >= concat(${fld:daochu_month_date}, '-01')::date 
AND NOT EXISTS (
 	SELECT 1 FROM cc_contract e1 
	WHERE e1.relatecode = con.code 
	AND to_char(con.createdate + concat(e1.stage_times_pay-1,' month')::interval, 'yyyy-MM') = ${fld:daochu_month_date} 
	and org_id = ${def:org}
) 
