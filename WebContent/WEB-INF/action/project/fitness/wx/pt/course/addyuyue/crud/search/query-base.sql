SELECT  
		c.code
	   ,c.name 
	   ,c.mobile
FROM cc_customer c 
WHERE EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.isgoon = 0 AND d.org_id = c.org_id AND d.status != 0 AND d.status != 6
) 

AND EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE t.customercode = c.code AND t.ptleftcount > 0  
	and t.ptlevelcode !=(select code from cc_ptdef where reatetype=1 and org_id=t.org_id) 
	AND t.org_id = c.org_id AND t.ptid='${def:user}'
)
AND c.org_id = ${def:org}
AND c.status != 0
${filter}

    
    
	