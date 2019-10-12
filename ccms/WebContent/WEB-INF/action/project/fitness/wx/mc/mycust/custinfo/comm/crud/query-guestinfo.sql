SELECT
name,
(case sex when '0' then '女' when '1' then '男'  else '未填' end) as sex,
mobile,
(select comm.created from  cc_comm comm
   where  comm.operatortype=0  and cust_type=1   and comm.customercode=cc_customer.code and comm.createdby='${def:user}' 
   and comm.org_id = ${def:org}
   order by comm.created desc limit 1 ) as lasttime,
   
   (select  enddate  from cc_card  where cc_card.customercode = cc_customer.code and cc_card.isgoon = 0 
   and cc_card.org_id = ${def:org}
   order by enddate desc limit 1 )as enddate,
(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =cc_customer.user_id
		 )as headpic
   
FROM cc_customer 
where code=${fld:customercode}
and org_id=${def:org}