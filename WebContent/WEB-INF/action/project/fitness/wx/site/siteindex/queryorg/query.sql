select 
	org.org_id,
	org.org_name,
	oi.address,
	(select string_agg(DISTINCT cf.param_text, ';') from cc_config cf 
		where cf.category = 'sitetype' and cf.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = org.org_id and c.category=cf.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else org.org_id end)
		and cf.param_value in (select sitetype from cc_sitedef where org_id = org.org_id)
	) as sitetype,
	(select t.tuid from t_attachment_files t where t.pk_value = org.org_id::varchar 
		and t.table_code = 'hr_org' and t.org_id= org.org_id order by t.tuid desc limit 1) as imgid
from hr_org org 
left join hr_org_info oi on org.org_id = oi.org_id
where 
org.org_id in (SELECT g.org_id FROM hr_org g WHERE (case when ${fld:org_id} is null then 1=1 else g.org_id::varchar = ${fld:org_id} end) 
			UNION 
			SELECT g.org_id FROM hr_org g WHERE EXISTS(
				SELECT 1 FROM hr_staff_org so 
				INNER JOIN hr_staff f ON so.user_id = f.user_id 
				WHERE weixin_lastlogin = ${fld:weixin_userid} AND so.org_id = g.org_id))
