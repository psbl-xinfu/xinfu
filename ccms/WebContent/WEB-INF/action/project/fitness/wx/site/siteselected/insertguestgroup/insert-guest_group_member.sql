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
	1,
	(case when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		when (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id}) is not null
		then (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	end),
	1,
	(case when (select userlogin from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select userlogin from hr_staff where weixin_lastlogin = ${fld:weixin_userid})
		else null
	end),
	{ts '${def:timestamp}'},
	${fld:org_id}
)
