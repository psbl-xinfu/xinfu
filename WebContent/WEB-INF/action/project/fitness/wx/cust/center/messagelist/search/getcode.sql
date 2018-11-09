select
c.sendtime,
c.content,
(case when  c.senduser=(select code from  cc_customer where user_id=  
			(select user_id from hr_staff where userlogin='${def:user}' and org_id=${def:org}	 ) and org_id=${def:org}			
	 ) then 1 else 0 end)  as num,

	 
	 
	(case when  c.senduser=${fld:recuser} then 
		(SELECT 
				case when headpic is null then '/images/icon_head.png' else headpic end
			 FROM hr_staff WHERE userlogin = ${fld:recuser}  and org_id=${def:org}	
			 )
	
		else
		
		(SELECT 
				case when headpic is null then '/images/icon_head.png' else headpic end
			 FROM hr_staff WHERE user_id = (select user_id from cc_customer where code=senduser  and org_id=${def:org}	) and org_id=${def:org}	
			 )
	end) as headpic
	 


from 
cc_message c
where 1=1
and(
(
recuser=${fld:recuser}
and 
senduser= (select code from  cc_customer where user_id=  
			(select user_id from hr_staff where userlogin='${def:user}' ) and org_id=${def:org}				
	 )
)

or 
(
recuser= (select code from  cc_customer where user_id=  
			(select user_id from hr_staff where userlogin='${def:user}'  )	 and org_id=${def:org}			
	 )
and 
senduser=${fld:recuser}
)
)
and org_id=${def:org} and  c.issystem=0
order by  c.sendtime  