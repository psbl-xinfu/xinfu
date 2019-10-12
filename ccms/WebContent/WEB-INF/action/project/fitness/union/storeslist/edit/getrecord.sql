select 
	org.org_name,
	org.short_name,
	org.memberhead,
	info.address,
	info.contacts,
	info.contact_phone,
	org.remark,
	info.business_hours,
	info.category_label,
	info.featured_products,
	info.atmosphere,
	info.features,
	(select domain_text_cn from t_domain where "namespace"='City' and domain_value=info.city) as city,
	(select domain_text_cn from t_domain where "namespace"='Province' and domain_value=info.province) as Province,
	info.district
from hr_org org
left join hr_org_info info on org.org_id = info.org_id
where org.org_id = ${fld:id}

