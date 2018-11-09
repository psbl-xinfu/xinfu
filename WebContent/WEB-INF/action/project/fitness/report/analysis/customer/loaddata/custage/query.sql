select 
	dm.domain_value,
	dm.domain_text_cn,
	count(1) as num
from t_domain dm
left JOIN cc_customer cust on cust.age::varchar = dm.domain_value
where dm.namespace='Age' and cust.status=1 and cust.org_id = ${def:org}
and cust.created::date >= ${fld:fdate} AND cust.created::date <= ${fld:tdate} 
GROUP BY dm.domain_value,dm.show_order,dm.domain_text_cn ORDER BY dm.show_order


