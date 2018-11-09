select 
	org.org_name,
	org.short_name,
	org.memberhead,
	info.address,
	info.contacts,
	info.contact_phone,
	org.remark
from hr_org org
left join hr_org_info info on org.org_id = info.org_id
where (org.org_id=${def:org} or org.pid=${def:org}) and org.is_deleted=0
${filter}
order by org.created desc
