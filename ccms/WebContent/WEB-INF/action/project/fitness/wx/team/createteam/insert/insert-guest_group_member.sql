insert into cc_guest_group_member
(
	tuid,
	groupid,
	guesttype,
	pkvalue,
	status,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_guest_group_member},
	currval('seq_cc_guest_group'),
	(case 
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixinlogin}) is not null
		then 1
		else
		0
	end),
	(case 
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixinlogin}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixinlogin}) and org_id = ${fld:org_id})
		else
		(select code from cc_guest where weixinlogin = ${fld:weixinlogin} and org_id = ${fld:org_id})
	end),
	1,
	'${def:user}',
	{ts '${def:timestamp}'},
	${fld:org_id}
)
