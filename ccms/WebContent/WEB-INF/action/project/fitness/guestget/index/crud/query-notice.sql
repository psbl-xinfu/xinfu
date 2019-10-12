select
	tuid,
	title,
	content,
	created,
	(case when (select count(1) from cc_hkb_notice_log 
		where notice_id = cc_hkb_notice.tuid and userlogin = '${def:user}' and org_id = ${def:org})>0 then 0 else 1 end) as unreadnotice
from cc_hkb_notice
where status = 1 and org_id = ${def:org}
order by created desc limit 1
