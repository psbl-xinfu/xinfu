insert into cc_guest_group
(
	tuid,
	groupname,
	leader,
	createdby,
	created,
	remark,
	org_id
)
values
(
	currval('seq_cc_guest_group'),
	${fld:groupname},
	(case 
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixinlogin}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixinlogin}) and org_id = ${fld:org_id})
		else
		(select code from cc_guest where weixinlogin = ${fld:weixinlogin} and org_id = ${fld:org_id})
	end),
	'${def:user}',
	{ts '${def:timestamp}'},
	${fld:remark},
	${fld:org_id}
)
