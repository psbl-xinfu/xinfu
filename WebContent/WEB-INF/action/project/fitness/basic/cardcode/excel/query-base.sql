SELECT 
	incode,
	cardcode,
	remark
FROM cc_cardcode 
WHERE org_id = ${def:org} AND status = 1 
${filter} 
order by tuid desc