SELECT  c.code
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,(select comm.created from  cc_comm comm
       where  comm.operatortype=1 and comm.customercode=c.code
        and comm.createdby='${def:user}' and comm.org_id = ${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
      
      (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id limit 1
		 )as headpic
FROM cc_customer c 
WHERE EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.isgoon = 0 AND d.org_id = c.org_id AND d.status != 0 AND d.status != 6
) 

and not EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE t.customercode = c.code AND t.ptleftcount > 0  
	and (case when
		(select count(code) from cc_ptdef where reatetype=1 and org_id=t.org_id) >0
		then t.ptlevelcode !=(select code from cc_ptdef where reatetype=1 and org_id=t.org_id)
		else  t.ptlevelcode is not null
	end) and t.pttype != 5
	AND t.org_id = c.org_id AND t.ptid='${def:user}' 
) 
and EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE t.customercode = c.code AND t.ptleftcount > 0  
	 and t.pttype = 5
	AND t.org_id = c.org_id AND (t.ptid='${def:user}' or c.pt='${def:user}')
)
AND c.org_id = ${def:org}
AND c.status != 0
${filter}

    
    
	