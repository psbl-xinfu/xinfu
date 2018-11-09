select 
	(case
		when (select weixin_lastlogin from hr_staff where user_id = (select user_id from cc_customer where code = gg.leader and org_id = ${fld:org_id})) is not null
		then (select weixin_lastlogin from hr_staff where user_id = (select user_id from cc_customer where code = gg.leader and org_id = ${fld:org_id}))
		else (select weixinlogin from cc_guest where code = gg.leader and org_id = ${fld:org_id})
	end) as weixinlogin
from cc_guest_group gg
where gg.org_id = ${fld:org_id}
and tuid = ${fld:groupid}

