select 
	gg.tuid,
	gg.groupname,
	(case when gg.leader = (
		case
		when (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		else (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
		end
	) then 1 else 0 end) as isadmin,
	(select count(1) from cc_guest_group_member where groupid = gg.tuid and org_id = ${fld:org_id}) as num,
	gg.org_id,
	gg.remark,
	(select concat(cs.prepare_date, '，', to_char(cs.prepare_starttime, 'HH24:mm'), '~', to_char(cs.prepare_endtime, 'HH24:mm'), 
		(select org_name from hr_org where org_id = cs.org_id), (select sitename from cc_sitedef where code = cs.sitecode and org_id = cs.org_id)) from cc_siteusedetail cs 
	where cs.guestgroupid = gg.tuid and cs.org_id = gg.org_id 
	and concat(cs.prepare_date, ' ', cs.prepare_starttime)::timestamp>'${def:timestamp}'::timestamp 
	order by cs.prepare_date asc,cs.prepare_starttime asc limit 1) as notice
from cc_guest_group gg
where gg.org_id = ${fld:org_id} and gg.status = 1
and exists(
	select 1 from cc_guest_group_member cm
	where cm.groupid = gg.tuid
	and cm.pkvalue = (
		case
		when (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id}) is not null
		then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		else (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
		end
	)
	and cm.org_id = cm.org_id
)
order by gg.tuid asc
