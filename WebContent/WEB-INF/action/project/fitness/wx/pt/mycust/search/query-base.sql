SELECT c.code
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,(select m.created from  cc_comm m
       where m.operatortype=1 and m.customercode=c.code
        and m.createdby='${def:user}' and m.org_id = ${def:org}
       order by m.created desc 
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

AND EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE   c.code = t.customercode and t.ptleftcount > 0  
	and  (case when
		(select count(code) from cc_ptdef where reatetype=1 and org_id=t.org_id) >0
		then t.ptlevelcode !=(select code from cc_ptdef where reatetype=1 and org_id=t.org_id)
		else  t.ptlevelcode is not null
	end) and t.pttype != 5
	AND t.org_id = c.org_id AND t.ptid='${def:user}' 
) 

AND c.org_id = ${def:org}
AND c.status != 0
AND--按时间跟进情况
 	 (case when ${fld:s_stime} is null or ${fld:s_etime} is null then 1=1 
   else
 		not exists(
 		select 1 from cc_comm m where m.customercode = c.code and m.org_id = ${def:org} 
 			and m.created::date>=${fld:s_stime} and m.created::date<=${fld:s_etime} 
 		)
	 end)
${filter}

    
    
	