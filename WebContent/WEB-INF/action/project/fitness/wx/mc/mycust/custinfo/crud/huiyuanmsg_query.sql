SELECT  c.code
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=0 and comm.customercode=c.code
        and comm.createdby='${def:user}' and comm.org_id=${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
       (
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'GuestLevel' 
		and t.domain_value = 
			(select comm.level from  cc_comm comm
	       		where comm.operatortype=0 and comm.customercode=c.code and comm.createdby='${def:user}'  and comm.org_id=${def:org}  order by comm.created desc 
	     	 limit 1 ) 
		) as level,
      (select name from hr_staff where userlogin=c.mc
       and org_id = ${def:org}) as salemember,
       
       (select name from hr_staff where userlogin=c.pt
       and org_id = ${def:org}) as pt,
       
      (SELECT param_text FROM cc_config 
         WHERE category = 'GuestType' 
         and param_value::int = c.type and org_id = ${def:org}) as type,
         c.created,
 	(select max(enddate) from cc_card where cc_card.org_id=${def:org} and cc_card.customercode = c.code and cc_card.isgoon = 0)as enddate,
 	(select min(startdate) from cc_card where cc_card.org_id=${def:org} and cc_card.customercode = c.code and cc_card.isgoon = 0)as startdate,
	(SELECT case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id) as headpic
	 
FROM cc_customer c 
WHERE  c.status=1 and c.code=${fld:customercode}   and c.org_id=${def:org} 
     
  
     
  