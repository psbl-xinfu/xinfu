insert into cc_message
(
    tuid,
    issystem,
    senduser,
    sendusername,
    recuser,
    recusername,
    content,
    sendtime,
    org_id,
    remind
)
values 
(
	${seq:nextval@seq_cc_message},
  	  0,
  	  
  	  
  	 (select code from  cc_customer where user_id=  
			(select user_id from hr_staff where userlogin='${def:user}' and org_id=${def:org} )			
	 ),
  	  
	(select fname from ${schema}s_user where userlogin=	'${def:user}'),
	${fld:code},
	(select name from hr_staff where userlogin=${fld:code} and org_id=${def:org}),
	${fld:content},
	{ts '${def:timestamp}'},
    ${def:org},
    1
)



