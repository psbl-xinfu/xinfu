SELECT  c.code
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=0 and cust_type=1  and comm.customercode=c.code and comm.org_id=${def:org}
        and comm.createdby='${def:user}'
       order by comm.created desc 
      limit 1 ) as lasttime,
      
      
      (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id limit 1
		 )as headpic
FROM cc_customer c 
where c.org_id=${def:org}
and c.mc='${def:user}'
	
and--按时间跟进情况
 	 (case when ${fld:s_stime} is null or ${fld:s_etime} is null then 1=1 
   else
 		not exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = c.code and mh.org_id = c.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org} and comm.created>=${fld:s_stime} and comm.created<=${fld:s_etime} 
 		)
	 end)
 
 and --资源状态
  (case when ${fld:s_status} is null then 1=1 
 		    when ${fld:s_status}=1 then
 			 exists(
 			 	select 1 from cc_customer  where   to_char(created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM') and org_id = ${def:org} 
 			 	)
  		    when ${fld:s_status}=2 then
 			not exists(
 			 	select 1 from cc_comm m where m.customercode=c.code  and   to_char(m.created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM') and org_id = ${def:org} 
 			 	)		
 			 	
 			when ${fld:s_status}=3 then
 			 exists(
 			 	select 1 from cc_customer where birth::int =(select to_char({ts '${def:timestamp}'}, 'MM')::int from dual) and org_id = ${def:org} 
 			 	)		
 			when ${fld:s_status}=4 then
 			 exists(
 			 	select 1 from cc_customer where concat(birth,'-',birthday)  <=to_char({ts '${def:timestamp}'}+'7 day'::interval, 'MM-dd') and concat(birth,'-',birthday)  >=to_char({ts '${def:timestamp}'}, 'MM-dd') and org_id = ${def:org} 
 			 	)	
 end)
 
  and--跟进情况
 	(case
 	when ${fld:s_genjin} is null then 1=1
   	when ${fld:s_genjin} = 1 then 
 		not exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = c.code and mh.org_id = c.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	when ${fld:s_genjin} = 2 then 
	 exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = c.code and mh.org_id = c.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	 end)
 
--关注度
and (case when ${fld:s_level} is null then 1=1 
 		    else 
 			 exists(
 			 	select 1 from cc_comm m  where  m.customercode=c.code and m.level=${fld:s_level} and m.org_id=${def:org} 
 			 	and cust_type=1
 			 	order by created desc limit 1
 			 	)
		end)
 ${filter}