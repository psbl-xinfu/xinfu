(select
	g.mobile,
	g.name,
	1 as num,
	g.code,
	(case when g.sex=0 then '女' else '男' end) as sex,
	(select comm.created from  cc_comm comm
       where  comm.operatortype=0  and cust_type=0   and comm.guestcode=g.code and comm.createdby='${def:user}'
       and comm.org_id = ${def:org} order by comm.created desc limit 1 ) as lasttime
from cc_guest g 
WHERE 
g.mc='${def:user}'
and
 g.org_id = ${def:org}
 --过滤会员
 and 
g.status!=99	and g.status!=0
 and--关注度
 g.level=(case when ${fld:s_level} is null then level else  ${fld:s_level} end)
 
and--收集开始日期
 g.created::date>=(case when ${fld:s_stime} is null then g.created::date else  ${fld:s_stime} end)
 
 and--收集结束日期
 g.created::date<=(case when ${fld:s_etime} is null then g.created::date else  ${fld:s_etime} end)
 
and --生日类型
  (case when ${fld:s_status} is null then 1=1 
 		    when ${fld:s_status}=1 then
 			 exists(
 			 	select 1 from cc_guest where  to_char(g.created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM') and org_id = ${def:org} 
 			 	)
 		    when ${fld:s_status}=2 then
 			 exists(
 			 	select 1 from cc_mcchange m where  m.guestcode=g.code and 	to_char(m.created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM') and org_id = ${def:org} 
 			 	)			 	
   			 when ${fld:s_status}=3 then
 			 not exists(
 			 	select 1 from cc_comm m where  m.guestcode=g.code and 	to_char(m.created, 'YYYY-MM') =to_char({ts '${def:timestamp}'}, 'YYYY-MM') and org_id = ${def:org} 
 			 	)			 
    		when ${fld:s_status}=4 then
 			 exists(
 			 	select 1 from cc_guest where birth::int =(select to_char( {ts '${def:timestamp}'}, 'MM')::int from dual) and org_id = ${def:org} 
 			 	)		
 			when ${fld:s_status}=5 then
 			 exists(
 			 	select 1 from cc_guest where concat(birth,'-',birthday)  <=to_char( {ts '${def:timestamp}'}+'7 day'::interval, 'MM-dd') and concat(birth,'-',birthday)  >=to_char( {ts '${def:timestamp}'}, 'MM-dd') and org_id = ${def:org} 
 			 	)	
 end)
 
  and--跟进情况
 	(case
 	when ${fld:s_genjin} is null then 1=1
   	when ${fld:s_genjin} = 0 then 
 		not exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	when ${fld:s_genjin} = 1 then 
	 exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	 end)
	 
	 
 and--沟通阶段
 case when  ${fld:s_type} is null then 1=1 else
 	exists(
 		select 1 from cc_comm comm where comm.stage = ${fld:s_type}
 		and comm.guestcode = g.code and comm.org_id = g.org_id
 		order by comm.created desc limit 1
 	)
	and exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)end 
 	${filter}
  )
 
--union
--(
--select
--g.mobile,
--	g.name,
--	0 as num,
--	g.code,
--	(case when g.sex=0 then '女' else '男' end) as sex,
--	(select comm.created from  cc_comm comm
 -- 		 where  comm.operatortype=0  and cust_type=0   and comm.guestcode=g.code and comm.createdby='${def:user}' 
 -- 		 and comm.org_id = p.org_id  
 -- 		 order by comm.created desc limit 1 ) as lasttime
--FROM cc_public p
--inner join cc_guest g on p.guestcode = g.code and p.org_id = g.org_id
--where p.org_id = ${def:org} and p.status = 0
--)
order by num,code desc