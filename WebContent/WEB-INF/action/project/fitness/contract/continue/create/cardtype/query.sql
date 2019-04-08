select 
	ct.code as tcode
FROM cc_cardtype ct 
where ct.code = ${fld:ctcode}  and ct.org_id = ${def:org} 


