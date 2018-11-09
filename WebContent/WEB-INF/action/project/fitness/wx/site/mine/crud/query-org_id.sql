select
(
		case
		when (select org_id from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid})) is not null
		then (select org_id from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}))
		else (select org_id from cc_guest where weixinlogin = ${fld:weixin_userid})
		end
	) as org_id
