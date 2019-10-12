SELECT DISTINCT c.code
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=1 and comm.customercode=c.code
        and comm.createdby='${def:user}' and comm.org_id = ${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
      
       (
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'GuestLevel' 
		and t.domain_value = 
			(select comm.level from  cc_comm comm
	       		where comm.cust_type=2 and comm.customercode=c.code and comm.createdby='${def:user}' 
	       		and comm.org_id = ${def:org} order by comm.created desc 
	     	 limit 1 ) 
		) as level,

      
      (select name from hr_staff where userlogin=c.mc 
       and org_id = ${def:org}) as salemember,
       
      (SELECT param_text FROM cc_config 
         WHERE category = 'GuestType' 
         and param_value::int = c.type and org_id = ${def:org}) as type,
 
      (SELECT createdate from cc_contract where (contracttype = 0 OR contracttype = 3 )
        and customercode=${fld:customercode} and status!=0 and org_id =${def:org} limit 1
      ) as startdate,
      
      (SELECT get_arr_value(relatedetail,3)  from cc_contract where (contracttype = 0 OR contracttype = 3 )
        and customercode=${fld:customercode} and org_id = ${def:org}
        and status!=0  order by  get_arr_value(relatedetail,3) desc limit 1
      ) as enddate,
      
        (SELECT 
		case when headpic is null then '/images/icon_head.png' else headpic end
	 FROM hr_staff WHERE user_id =c.user_id
	 )as headpic,
	 c.code
FROM cc_customer c 
WHERE  c.status=1 and c.code=${fld:customercode} and c.org_id = ${def:org}
     
  
     
  