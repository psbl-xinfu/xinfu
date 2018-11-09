select 
	org.org_name,
	oi.address,
	oi.contact_phone,
	oi.business_hours_begin,
	oi.business_hours_end,
	(select t.tuid from t_attachment_files t where t.pk_value = org.org_id::varchar 
		and t.table_code = 'hr_org' and t.org_id= org.org_id order by t.tuid desc limit 1) as imgid
from hr_org org
left join hr_org_info oi on org.org_id = oi.org_id
where org.org_id = ${fld:org_id}