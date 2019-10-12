select
	g.code as vc_guestcode
	,g.name as vc_name
	,g.sex as i_sex
	,(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'GuestLevel' and t.domain_value = g.level::varchar 
		limit 1 
	) as vc_level
	,(CASE g.sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END) AS i_sexname
	,(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Age' and t.domain_value = g.age::varchar 
		limit 1 
	) as age
from cc_guest g 
where g.code = (case when ${fld:vc_guestcode} is null 
	then (select guestcode from cc_customer where code = ${fld:vc_customercode} and org_id = ${def:org}) else ${fld:vc_guestcode} end)
and g.org_id = ${def:org} 
limit 1