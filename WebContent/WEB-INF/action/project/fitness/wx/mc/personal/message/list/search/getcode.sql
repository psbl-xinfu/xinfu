select
c.sendtime,
c.content,
(case when  c.senduser='${def:user}'  then 0 else 1 end)  as num,

    (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin ='${def:user}' 
		 )as headpic,
		 
	 (SELECT 
		case when headpic is null then '/images/icon_head.png' else headpic end
	 FROM hr_staff WHERE user_id=(select user_id from cc_customer where code=${fld:recuser} and org_id = ${def:org})
	 )as headpic1


from 
cc_message c
where org_id=${def:org}
and(
(
recuser='${def:user}'
and 
senduser= ${fld:recuser} 
)


or 
(
recuser=${fld:recuser} 
and 
senduser='${def:user}'
)
)
  and c.issystem=0
order by  c.sendtime 