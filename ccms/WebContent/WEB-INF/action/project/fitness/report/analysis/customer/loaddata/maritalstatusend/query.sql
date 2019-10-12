select 
	dm.domain_value,
	dm.domain_text_cn,
	count(1) as num
from t_domain dm
inner JOIN cc_customer cust on cust.marriage::varchar = dm.domain_value
where dm.namespace='marital_status' and cust.status=1 and cust.org_id = ${def:org}
and cust.created::date >= ${fld:fdate} AND cust.created::date <= ${fld:tdate} 
GROUP BY dm.domain_value,dm.show_order,dm.domain_text_cn ORDER BY dm.show_order,count(1) desc

