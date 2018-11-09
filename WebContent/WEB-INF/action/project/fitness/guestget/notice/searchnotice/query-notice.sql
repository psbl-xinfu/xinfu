select
	tuid,
	title,
	level,
	(select name from hr_staff where userlogin = cc_hkb_notice.createdby and org_id = ${def:org}) as createdby,
	created,
	(case when (select count(1) from cc_hkb_notice_log 
		where notice_id = cc_hkb_notice.tuid and userlogin = '${def:user}' and org_id = ${def:org})>0 then 0 else 1 end) as unreadnotice
from cc_hkb_notice
where status = 1 and org_id = ${def:org}
