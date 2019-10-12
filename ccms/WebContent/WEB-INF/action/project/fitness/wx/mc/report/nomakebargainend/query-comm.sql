select 
	comm.failreason,
	dm.domain_text_cn,
	count(1) as num
from cc_comm comm
left join t_domain dm on comm.failreason = dm.domain_value
where comm.cust_type in (0, 1) and comm.commresult=0 and comm.status=1
and dm."namespace"='CommFailResaon' and comm.org_id = ${def:org}
and to_char(comm.created::date, 'yyyy-MM') = to_char('${def:date}'::date, 'yyyy-MM')
GROUP BY comm.failreason,dm.domain_text_cn