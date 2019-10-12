SELECT c.code
	   ,c.name 
     ,(case c.sex when 1 then'男' else '女' end) as sex
		 ,(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id limit 1
		 )as headpic
		 ,(select ptlevelname from cc_ptdef where code=pt.ptlevelcode and org_id=pt.org_id) as ptlevelname
		 ,pt.ptleftcount::int
		 ,pt.pttotalcount::int
		 
FROM
 cc_customer c
inner join cc_ptrest pt  on pt.customercode=c.code	 and pt.org_id=c.org_id
WHERE EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.isgoon = 0 AND d.org_id = c.org_id AND d.status != 0 AND d.status != 6
) 
and pt.org_id=${def:org}   AND pt.ptleftcount > 0  
AND  (pt.ptid='${def:user}'  or 
	c.pt='${def:user}' )

${filter}

    
	