SELECT DISTINCT
		c.code 
		,c.created
	   ,c.name 
       ,(case c.sex when 1 then'男' else '女' end) as sex
       ,c.mobile
       ,1 as num
       ,(select comm.created from  cc_comm comm
       where comm.operatortype=1 and cust_type=2  and comm.customercode=c.code 
       order by comm.created desc 
      limit 1 ) as lasttime,
      
      (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =c.user_id limit 1
		 )as headpic
FROM cc_customer c 
    
where
EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE c.code = d.customercode AND d.isgoon = 0 AND d.org_id = c.org_id AND d.status != 0 AND d.status != 6
) 

AND (
	case when ${fld:s_name} is  null  then
	EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE t.customercode = c.code AND t.ptleftcount > 0 AND t.pttype != 5 AND t.org_id = c.org_id AND t.ptid='${def:user}'
	) 
	else true end
)

and  c.org_id=${def:org}
--性别
and c.sex=(case when ${fld:s_sex} is null then c.sex else ${fld:s_sex} end)
and--收集开始日期
 c.created::date>=(case when ${fld:s_stime} is null then c.created::date else  ${fld:s_stime} end)
 and--收集结束日期
 c.created::date<=(case when ${fld:s_etime} is null then c.created::date else  ${fld:s_etime} end)
--年龄
and
c.age = (case when ${fld:s_age} is null then c.age else  ${fld:s_age} end)	
--来源
and
c.type = (case when ${fld:s_type} is null then c.type else  ${fld:s_type} end)	
${filter}
 order by created desc


  