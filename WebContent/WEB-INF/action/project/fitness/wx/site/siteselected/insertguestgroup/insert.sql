insert into cc_guest_group
(
	tuid,
	groupname,
	leader,
	createdby,
	created,
	org_id
)
values
(
	currval('seq_cc_guest_group'),
	${fld:groupname},
	(case when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		when (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id}) is not null
		then (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	end),
	(case when (select userlogin from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select userlogin from hr_staff where weixin_lastlogin = ${fld:weixin_userid})
		else null
	end),
	{ts '${def:timestamp}'},
	${fld:org_id}
)
