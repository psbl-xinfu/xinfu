SELECT DISTINCT c.code 
	   ,c.name 
       ,(case c.sex when 0 then'男' else '女' end) as sex
       ,c.mobile
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=1 and comm.customercode=c.code
        and comm.createdby='${def:user}'
       order by comm.created desc 
      limit 1 ) as lasttime,
      
      (SELECT get_arr_value(relatedetail,3) as enddate from cc_contract where (contracttype = 0 OR contracttype = 3 )
        and customercode=${fld:customercode} and status!=0 limit 1
      ) as enddate,

(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id
		 )as headpic
   
FROM cc_customer c
where c.code=${fld:customercode}
and c.org_id=${def:org} and c.status=1