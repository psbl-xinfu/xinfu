SELECT
	s.name,
	case s.sex when '0' then '男' when '1' then '女' else '未知' end as sex,
	s.mobile,
	(select count(tuid) from cc_message 
	 where org_id=${def:org} and recuser='${def:user}' and status=1
 
	) as messageamount, --消息总数
	
	(select count(tuid) from cc_message 
	 where org_id=${def:org} and recuser='${def:user}' and status=1 and remind=1
	  
	) as remindmessage,  --需提醒消息数
	
	
	(select
	count(*)as count
	
	from  cc_comm
	where 1=1 
	and (commresult =1 or commresult =2)
	and nexttime::date={d '${def:date}'}

	and cc_comm.org_id = ${def:org}
	and cc_comm.createdby = '${def:user}' ) as commamount,--沟通提醒数
      (SELECT 
		case when headpic is null then '/images/icon_head.png' else headpic end
	 FROM hr_staff WHERE userlogin='${def:user}'
	 )as headpic
FROM hr_staff s  
WHERE 
    s.org_id = ${def:org} and s.userlogin='${def:user}'

