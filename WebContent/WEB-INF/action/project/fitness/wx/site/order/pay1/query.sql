SELECT 
	code AS out_trade_no,
	normalmoney as total_price,
	(case when cust.name is not null then cust.name when guest.name is not null then guest.name else sd.customername end) as name,
	(case when cust.mobile is not null then cust.mobile when guest.mobile is not null then guest.mobile else sd.mobile end) as mobile,
	code as trade_order_code,
	CASE WHEN '${def:httpserver}' LIKE '%:80' THEN substr('${def:httpserver}', 0, length('${def:httpserver}')-2) 
		WHEN '${def:httpserver}' LIKE '%:80/' THEN substr('${def:httpserver}', 0, length('${def:httpserver}')-3) 
		ELSE '${def:httpserver}' END AS server_path 
from cc_siteusedetail sd
left join cc_sitedef sdef on sd.sitecode = sdef.code and sd.org_id = sdef.org_id
left join cc_customer cust on sd.customercode = cust.code and sd.org_id = cust.org_id
left join cc_guest guest on sd.customercode = guest.code and sd.org_id = guest.org_id
WHERE sd.code = ${fld:code} and sd.org_id = ${def:org}
