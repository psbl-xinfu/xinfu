SELECT DISTINCT
		c.code 
		,c.created
	   ,c.name 
       ,(case c.sex when 0 then'男' else '女' end) as sex
       ,c.mobile
       ,1 as num
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=0 and cust_type=1  and comm.customercode=c.code and comm.createdby='${def:user}'
       order by comm.created desc 
      limit 1 ) as lasttime
FROM cc_customer c 
where c.org_id=${def:org}
and c.mc='${def:user}'
--性别
and c.sex=(case when ${fld:s_sex} is null then c.sex else ${fld:s_sex} end)
and --资源日期
	 (case when ${fld:s_stime} is null or  ${fld:s_etime} is null then 1=1 
 		    else 
 			 exists(
 			 	select 1 from cc_customer  where   c.created>=${fld:s_stime} and  c.created<=${fld:s_etime}
 			 	)
		end)
--年龄
and
c.age = (case when ${fld:s_age} is null then c.age else  ${fld:s_age} end)	
--来源
and
c.type = (case when ${fld:s_type} is null then c.type else  ${fld:s_type} end)	
 order by created desc


  