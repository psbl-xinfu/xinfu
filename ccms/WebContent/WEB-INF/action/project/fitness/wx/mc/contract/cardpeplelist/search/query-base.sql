(SELECT
		c.code 
		,c.created
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,1 as num
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=0 and cust_type=1  and comm.customercode=c.code and comm.createdby='${def:user}'
       and org_id=${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
      
      (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id limit 1
		 )as headpic
FROM cc_customer c 
where c.org_id=${def:org}
and c.mc='${def:user}'
and c.status=1
--性别
and c.sex=(case when ${fld:s_sex} is null then c.sex else ${fld:s_sex} end)
and--收集开始日期
 c.created::date>=(case when ${fld:s_stime} is null then c.created::date else  ${fld:s_stime} end)
 and--收集结束日期
 c.created::date<=(case when ${fld:s_etime} is null then c.created::date else  ${fld:s_etime} end)
--关注度
and (case when ${fld:s_level} is null then 1=1 
 		    else 
 			 exists(
 			 	select 1 from cc_comm m  where  m.customercode=c.code and m.level=${fld:s_level} and m.org_id=${def:org} 
 			 	and cust_type=1
 			 	order by created desc limit 1
 			 	)
		end)
		
and--来源
c.type = (case when ${fld:s_type} is null then c.type else  ${fld:s_type} end)		  
and--年龄
c.age = (case when ${fld:s_age} is null then c.age else  ${fld:s_age} end)	
--姓名
and (case when ${fld:s_name} is null then 1=1 
   else 
 		 exists(
 			 	select 1 from cc_customer cus where
 		 	cus.name like CONCAT('%',${fld:s_name},'%') or cus.mobile like CONCAT('%',${fld:s_name},'%')
 			 	and cus.org_id=${def:org}  and cus.code=c.code
 			)
		end)
)

union

(select
	g.code,
	g.created,
	g.name,
	(case when g.sex=0 then '女' else '男' end) as sex,
	  g.mobile,
	   0 as num,
	(select comm.created from  cc_comm comm
       where  comm.operatortype=0  and cust_type=0   and comm.guestcode=g.code and comm.createdby='${def:user}'
       and org_id=${def:org}
       order by comm.created desc limit 1 ) as lasttime,
       '/images/icon_head.png' as headpic
from cc_guest g 
WHERE 
 g.org_id = ${def:org}
 and
 g.mc='${def:user}'
 --性别
 and g.sex=(case when ${fld:s_sex} is null then g.sex else ${fld:s_sex} end)
and--收集开始日期
 g.created::date>=(case when ${fld:s_stime} is null then g.created::date else  ${fld:s_stime} end)
 and--收集结束日期
 g.created::date<=(case when ${fld:s_etime} is null then g.created::date else  ${fld:s_etime} end)
 and
 --关注度
 g.level=(case when ${fld:s_level} is null then g.level else  ${fld:s_level} end)
 and
 --来源
g.type = (case when ${fld:s_type} is null then g.type else  ${fld:s_type} end)	
and--年龄
g.age = (case when ${fld:s_age} is null then g.age else  ${fld:s_age} end)	
 --过滤会员
and 
g.status!=99	and g.status!=0




${filter}
 )
 order by created desc


  