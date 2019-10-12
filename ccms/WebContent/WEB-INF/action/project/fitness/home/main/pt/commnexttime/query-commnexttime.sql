SELECT  
	(case when cust.name is null or cust.name='' then '未知' else cust.name end) as name,
	(case when cust.mobile is null or cust.mobile='' then '未知' else cust.mobile end) as mobile,
	comm.nexttime,
	comm.remark,
	(select t.tuid from t_attachment_files t where t.pk_value = cust.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid
from cc_comm comm
left join cc_customer cust on comm.customercode = cust.code and comm.org_id = cust.org_id
where comm.cust_type = 2 and comm.commresult = 1 
and comm.nexttime::date = '${def:date}'::date
and comm.org_id = ${def:org}
order by comm.nexttime asc