insert into cc_message
(
   tuid,
   senduser,
   recuser,
   recusername,
   content,
   sendtime,
   org_id
)
(
	select 
		${seq:nextval@seq_cc_message},
	    '${def:user}',
	    customercode,
	    (select name from cc_customer where code = cc_savestopcard.customercode and org_id = ${def:org}),
	    '停卡到期，前台刷卡时候开卡，会员卡有效期延长'||'${def:date}'::date-startdate::date||'天',
	    {ts'${def:timestamp}'},
	    ${def:org}
	from cc_savestopcard
	where code = ${fld:code} and org_id = ${def:org}
)
