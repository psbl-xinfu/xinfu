select
	gg.tuid as ggtuid,
	gg.groupname
from cc_guest_group gg
left join cc_guest_group_member cg on gg.tuid = cg.groupid and gg.org_id = cg.org_id
where cg.status = 1 and cg.org_id = ${fld:org_id}
and guesttype = 1 
and pkvalue = (case when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
			then (select code from cc_customer 
					where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid})
					and org_id = ${fld:org_id})
			when (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id}) is not null 
			then (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	end)

